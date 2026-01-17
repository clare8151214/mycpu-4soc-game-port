/* VGA drawing helpers. */
#include "tetris.h"
#include "mmio.h"

#define VGA_STAT_VBLANK 0x01
#define VGA_STAT_SAFE   0x01

static uint8_t framebuffer[VGA_FRAME_SIZE];

static uint8_t current_frame = 0;
static uint8_t debug_marker_y = 0;

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
        digits[count++] = (int)my_mod(num, 10);
        num = my_div(num, 10);
    }

    for (int i = count - 1; i >= 0; i--) {
        fb_digit(x, y, digits[i], color);
        x += 4;
    }
}

void draw_init(void)
{
    *VGA_PALETTE(COLOR_BLACK)  = 0x00;
    *VGA_PALETTE(COLOR_CYAN)   = 0x2F;
    *VGA_PALETTE(COLOR_YELLOW) = 0x3C;
    *VGA_PALETTE(COLOR_PURPLE) = 0x23;
    *VGA_PALETTE(COLOR_GREEN)  = 0x0C;
    *VGA_PALETTE(COLOR_RED)    = 0x30;
    *VGA_PALETTE(COLOR_BLUE)   = 0x03;
    *VGA_PALETTE(COLOR_ORANGE) = 0x34;
    *VGA_PALETTE(COLOR_GRAY)   = 0x15;
    *VGA_PALETTE(COLOR_WHITE)  = 0x3F;

    fb_clear();

    vga_write32(VGA_ADDR_UPLOAD_ADDR, 0);
    for (int i = 0; i < 512; i++) {
        vga_write32(VGA_ADDR_STREAM_DATA,
                    vga_pack8_pixels(&framebuffer[i * 8]));
    }

    vga_write32(VGA_ADDR_CTRL, 0x01);
}

void draw_clear(void)
{
    fb_clear();
}

void draw_set_debug_marker(uint8_t y)
{
    debug_marker_y = y;
}

void draw_border(void)
{
    int gx = GRID_OFFSET_X - 1;
    int gy = GRID_OFFSET_Y - 1;
    int gw = GRID_WIDTH * BLOCK_SIZE + 2;
    int gh = GRID_HEIGHT * BLOCK_SIZE + 2;

    fb_rect_outline(gx, gy, gw, gh, COLOR_RED);
}

void draw_grid(const grid_t *g)
{
    for (int y = 0; y < GRID_HEIGHT; y++) {
        for (int x = 0; x < GRID_WIDTH; x++) {
            if (g->rows[y] & (1u << x)) {
                int sx = GRID_OFFSET_X + x * BLOCK_SIZE;

                int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - y) * BLOCK_SIZE;

                fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, g->colors[y][x]);
            }
        }
    }
}

extern const int8_t SHAPES[7][4][4][2];

void draw_block(const block_t *b)
{
    uint8_t shape = b->shape;
    uint8_t rot = b->rot & 0x03;
    if (shape >= 7) shape = 0;

    int gx0 = b->x + SHAPES[shape][rot][0][0];
    int gy0 = b->y + SHAPES[shape][rot][0][1];
    int gx1 = b->x + SHAPES[shape][rot][1][0];
    int gy1 = b->y + SHAPES[shape][rot][1][1];
    int gx2 = b->x + SHAPES[shape][rot][2][0];
    int gy2 = b->y + SHAPES[shape][rot][2][1];
    int gx3 = b->x + SHAPES[shape][rot][3][0];
    int gy3 = b->y + SHAPES[shape][rot][3][1];

    if (gx0 >= 0 && gx0 < GRID_WIDTH && gy0 >= 0 && gy0 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx0 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy0) * BLOCK_SIZE;
        fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, b->color);
    }
    if (gx1 >= 0 && gx1 < GRID_WIDTH && gy1 >= 0 && gy1 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx1 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy1) * BLOCK_SIZE;
        fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, b->color);
    }
    if (gx2 >= 0 && gx2 < GRID_WIDTH && gy2 >= 0 && gy2 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx2 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy2) * BLOCK_SIZE;
        fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, b->color);
    }
    if (gx3 >= 0 && gx3 < GRID_WIDTH && gy3 >= 0 && gy3 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx3 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy3) * BLOCK_SIZE;
        fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, b->color);
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

    uint8_t shape = ghost.shape;
    uint8_t rot = ghost.rot & 0x03;
    if (shape >= 7) shape = 0;

    int gx0 = ghost.x + SHAPES[shape][rot][0][0];
    int gy0 = ghost.y + SHAPES[shape][rot][0][1];
    int gx1 = ghost.x + SHAPES[shape][rot][1][0];
    int gy1 = ghost.y + SHAPES[shape][rot][1][1];
    int gx2 = ghost.x + SHAPES[shape][rot][2][0];
    int gy2 = ghost.y + SHAPES[shape][rot][2][1];
    int gx3 = ghost.x + SHAPES[shape][rot][3][0];
    int gy3 = ghost.y + SHAPES[shape][rot][3][1];

    if (gx0 >= 0 && gx0 < GRID_WIDTH && gy0 >= 0 && gy0 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx0 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy0) * BLOCK_SIZE;
        fb_rect_outline(sx, sy, BLOCK_SIZE, BLOCK_SIZE, COLOR_GRAY);
    }
    if (gx1 >= 0 && gx1 < GRID_WIDTH && gy1 >= 0 && gy1 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx1 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy1) * BLOCK_SIZE;
        fb_rect_outline(sx, sy, BLOCK_SIZE, BLOCK_SIZE, COLOR_GRAY);
    }
    if (gx2 >= 0 && gx2 < GRID_WIDTH && gy2 >= 0 && gy2 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx2 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy2) * BLOCK_SIZE;
        fb_rect_outline(sx, sy, BLOCK_SIZE, BLOCK_SIZE, COLOR_GRAY);
    }
    if (gx3 >= 0 && gx3 < GRID_WIDTH && gy3 >= 0 && gy3 < GRID_HEIGHT) {
        int sx = GRID_OFFSET_X + gx3 * BLOCK_SIZE;
        int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy3) * BLOCK_SIZE;
        fb_rect_outline(sx, sy, BLOCK_SIZE, BLOCK_SIZE, COLOR_GRAY);
    }
}

void draw_preview(uint8_t shape)
{
    int px = PREVIEW_X;
    int py = PREVIEW_Y;

    fb_rect(px, py, 12, 12, COLOR_BLACK);

    if (shape >= 7) shape = 0;
    uint8_t color = SHAPE_COLORS[shape];

    int sx0 = px + SHAPES[shape][0][0][0] * 3;
    int sy0 = py + (3 - SHAPES[shape][0][0][1]) * 3;
    int sx1 = px + SHAPES[shape][0][1][0] * 3;
    int sy1 = py + (3 - SHAPES[shape][0][1][1]) * 3;
    int sx2 = px + SHAPES[shape][0][2][0] * 3;
    int sy2 = py + (3 - SHAPES[shape][0][2][1]) * 3;
    int sx3 = px + SHAPES[shape][0][3][0] * 3;
    int sy3 = py + (3 - SHAPES[shape][0][3][1]) * 3;

    fb_rect(sx0, sy0, 2, 2, color);
    fb_rect(sx1, sy1, 2, 2, color);
    fb_rect(sx2, sy2, 2, 2, color);
    fb_rect(sx3, sy3, 2, 2, color);
}

void draw_score(uint32_t score, uint16_t lines, uint8_t level)
{
    int sx = SCORE_X;
    int sy = SCORE_Y;

    fb_rect(sx, sy, 24, 18, COLOR_BLACK);

    if (score > 999999) {
        score = 999999;
    }

    fb_number(sx, sy,      score, COLOR_WHITE);
    fb_number(sx, sy + 6,  lines, COLOR_CYAN);
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
    for (volatile int d = 0; d < 2000; d++) {
        __asm__ volatile("nop");
    }

    if (debug_marker_y < 64) {
        fb_pixel(0, debug_marker_y, COLOR_WHITE);
    }

    vga_write32(VGA_ADDR_UPLOAD_ADDR, 0);

    for (int i = 0; i < 512; i++) {
        vga_write32(VGA_ADDR_STREAM_DATA,
                    vga_pack8_pixels(&framebuffer[i * 8]));
    }

    vga_write32(VGA_ADDR_CTRL, 0x01);
}
