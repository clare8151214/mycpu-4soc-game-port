#include "tetris.h"
#include "mmio.h"

#define VGA_STAT_SAFE 0x01
#define VGA_STAT_BUSY 0x02

// Single back buffer; VGA controller uses double buffering on upload.
static uint8_t framebuffer[VGA_FRAME_SIZE];
static uint8_t current_frame = 0;

static void fb_clear(void)
{
    for (int i = 0; i < VGA_FRAME_SIZE; i++) {
        framebuffer[i] = COLOR_BLACK;
    }
}

static inline void fb_pixel(int x, int y, uint8_t color)
{
    if (x >= 0 && x < 64 && y >= 0 && y < 64) {
        framebuffer[y * 64 + x] = color;
    }
}

static void fb_rect(int x, int y, int w, int h, uint8_t color)
{
    for (int dy = 0; dy < h; dy++) {
        for (int dx = 0; dx < w; dx++) {
            fb_pixel(x + dx, y + dy, color);
        }
    }
}

static void fb_rect_outline(int x, int y, int w, int h, uint8_t color)
{
    for (int dx = 0; dx < w; dx++) {
        fb_pixel(x + dx, y, color);
        fb_pixel(x + dx, y + h - 1, color);
    }
    for (int dy = 0; dy < h; dy++) {
        fb_pixel(x, y + dy, color);
        fb_pixel(x + w - 1, y + dy, color);
    }
}

// 3x5 digit font used by score rendering.
static const uint8_t DIGIT_FONT[10][5] = {
    {0b111, 0b101, 0b101, 0b101, 0b111},
    {0b010, 0b110, 0b010, 0b010, 0b111},
    {0b111, 0b001, 0b111, 0b100, 0b111},
    {0b111, 0b001, 0b111, 0b001, 0b111},
    {0b101, 0b101, 0b111, 0b001, 0b001},
    {0b111, 0b100, 0b111, 0b001, 0b111},
    {0b111, 0b100, 0b111, 0b101, 0b111},
    {0b111, 0b001, 0b001, 0b001, 0b001},
    {0b111, 0b101, 0b111, 0b101, 0b111},
    {0b111, 0b101, 0b111, 0b001, 0b111},
};

static void fb_digit(int x, int y, int digit, uint8_t color)
{
    if (digit < 0 || digit > 9) {
        return;
    }

    for (int row = 0; row < 5; row++) {
        uint8_t bits = DIGIT_FONT[digit][row];
        for (int col = 0; col < 3; col++) {
            if (bits & (1 << (2 - col))) {
                fb_pixel(x + col, y + row, color);
            }
        }
    }
}

static void fb_number(int x, int y, uint32_t num, uint8_t color)
{
    int digits[10];
    int count = 0;

    if (num == 0) {
        fb_digit(x, y, 0, color);
        return;
    }

    while (num > 0 && count < 10) {
        digits[count++] = num % 10;
        num /= 10;
    }

    for (int i = count - 1; i >= 0; i--) {
        fb_digit(x, y, digits[i], color);
        x += 4;
    }
}

void draw_init(void)
{
    vga_write32(VGA_ADDR_PALETTE(COLOR_BLACK), 0x00);
    vga_write32(VGA_ADDR_PALETTE(COLOR_CYAN), 0x2F);
    vga_write32(VGA_ADDR_PALETTE(COLOR_YELLOW), 0x3C);
    vga_write32(VGA_ADDR_PALETTE(COLOR_PURPLE), 0x32);
    vga_write32(VGA_ADDR_PALETTE(COLOR_GREEN), 0x0C);
    vga_write32(VGA_ADDR_PALETTE(COLOR_RED), 0x30);
    vga_write32(VGA_ADDR_PALETTE(COLOR_BLUE), 0x03);
    vga_write32(VGA_ADDR_PALETTE(COLOR_ORANGE), 0x34);
    vga_write32(VGA_ADDR_PALETTE(COLOR_GRAY), 0x15);
    vga_write32(VGA_ADDR_PALETTE(COLOR_WHITE), 0x3F);
    vga_write32(VGA_ADDR_CTRL, 0x01);
    fb_clear();
    current_frame = 0;
}

void draw_clear(void)
{
    fb_clear();
}

void draw_border(void)
{
    int gx = GRID_OFFSET_X - 1;
    int gy = GRID_OFFSET_Y - 1;
    int gw = GRID_WIDTH * BLOCK_SIZE + 2;
    int gh = GRID_HEIGHT * BLOCK_SIZE + 2;

    fb_rect_outline(gx, gy, gw, gh, COLOR_GRAY);
}

void draw_grid(const grid_t *g)
{
    for (int y = 0; y < g->height; y++) {
        for (int x = 0; x < g->width; x++) {
            if (g->rows[y] & (1u << x)) {
                int sx = GRID_OFFSET_X + x * BLOCK_SIZE;
                int sy = GRID_OFFSET_Y + (g->height - 1 - y) * BLOCK_SIZE;
                fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, g->colors[y][x]);
            }
        }
    }
}

void draw_block(const block_t *b)
{
    int8_t cells[4][2];
    shape_get_cells(b->shape, b->rot, cells);

    for (int i = 0; i < MAX_BLOCK_LEN; i++) {
        int gx = b->x + cells[i][0];
        int gy = b->y + cells[i][1];

        if (gx >= 0 && gx < GRID_WIDTH && gy >= 0 && gy < GRID_HEIGHT) {
            int sx = GRID_OFFSET_X + gx * BLOCK_SIZE;
            int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy) * BLOCK_SIZE;
            fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, b->color);
        }
    }
}

void draw_ghost(const grid_t *g, const block_t *b)
{
    block_t ghost = *b;

    while (!grid_block_collides(g, &ghost)) {
        ghost.y--;
    }
    ghost.y++;

    if (ghost.y == b->y) {
        return;
    }

    int8_t cells[4][2];
    shape_get_cells(ghost.shape, ghost.rot, cells);

    for (int i = 0; i < MAX_BLOCK_LEN; i++) {
        int gx = ghost.x + cells[i][0];
        int gy = ghost.y + cells[i][1];

        if (gx >= 0 && gx < GRID_WIDTH && gy >= 0 && gy < GRID_HEIGHT) {
            int sx = GRID_OFFSET_X + gx * BLOCK_SIZE;
            int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy) * BLOCK_SIZE;
            fb_rect_outline(sx, sy, BLOCK_SIZE, BLOCK_SIZE, COLOR_GRAY);
        }
    }
}

void draw_preview(uint8_t shape)
{
    int px = PREVIEW_X;
    int py = PREVIEW_Y;

    fb_rect(px, py, 12, 12, COLOR_BLACK);

    int8_t cells[4][2];
    shape_get_cells(shape, 0, cells);
    uint8_t color = SHAPE_COLORS[shape];

    for (int i = 0; i < MAX_BLOCK_LEN; i++) {
        int sx = px + cells[i][0] * 3;
        int sy = py + (3 - cells[i][1]) * 3;
        fb_rect(sx, sy, 2, 2, color);
    }
}

void draw_score(uint32_t score, uint16_t lines, uint8_t level)
{
    int sx = SCORE_X;
    int sy = SCORE_Y;

    fb_rect(sx, sy, 24, 18, COLOR_BLACK);

    if (score > 999999) {
        score = 999999;
    }
    fb_number(sx, sy, score, COLOR_WHITE);
    fb_number(sx, sy + 6, lines, COLOR_CYAN);
    fb_number(sx, sy + 12, level, COLOR_YELLOW);
}

void draw_game_over(void)
{
    fb_rect(20, 25, 24, 14, COLOR_BLACK);
    fb_rect_outline(20, 25, 24, 14, COLOR_RED);

    for (int i = 0; i < 8; i++) {
        fb_pixel(26 + i, 28 + i, COLOR_RED);
        fb_pixel(26 + i, 35 - i, COLOR_RED);
    }
}

void draw_swap_buffers(void)
{
    // Match trex: upload frame 0 and request a display swap.
    vga_write32(VGA_ADDR_UPLOAD_ADDR, 0);
    for (int i = 0; i < VGA_FRAME_SIZE / 8; i++) {
        vga_write32(VGA_ADDR_STREAM_DATA,
                    vga_pack8_pixels(&framebuffer[i * 8]));
    }
    vga_write32(VGA_ADDR_CTRL, 0x05); // Enable display AND request swap
}
