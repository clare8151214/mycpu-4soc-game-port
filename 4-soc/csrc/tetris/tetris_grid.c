/* Grid and block logic. */
#include "tetris.h"
#include "mmio.h"

static inline void uart_try_putc(char c)
{
    if (*UART_STATUS & 0x01) {
        *UART_SEND = c;
    }
}

void *my_memset(void *s, int c, uint32_t n)
{
    uint8_t *p = (uint8_t *)s;
    while (n--) {
        *p++ = (uint8_t)c;
    }
    return s;
}

void *my_memcpy(void *dest, const void *src, uint32_t n)
{
    uint8_t *d = (uint8_t *)dest;
    const uint8_t *s = (const uint8_t *)src;
    while (n--) {
        *d++ = *s++;
    }
    return dest;
}

void grid_init(grid_t *g)
{
    g->width = GRID_WIDTH;
    g->height = GRID_HEIGHT;
    g->lines_cleared = 0;
    g->score = 0;
    g->level = 1;
    grid_clear(g);
}

void grid_clear(grid_t *g)
{
    for (int y = 0; y < GRID_HEIGHT; y++) {
        g->rows[y] = 0;
        for (int x = 0; x < GRID_WIDTH; x++) {
            g->colors[y][x] = COLOR_BLACK;
        }
    }

    for (int x = 0; x < GRID_WIDTH; x++) {
        g->relief[x] = -1;
    }
}

bool grid_cell_occupied(const grid_t *g, int x, int y)
{
    if (x < 0 || x >= GRID_WIDTH || y < 0 || y >= GRID_HEIGHT) {
        return true;
    }

    return (g->rows[y] & (1u << x)) != 0;
}

void grid_set_cell(grid_t *g, int x, int y, uint8_t color)
{
    if (x < 0 || x >= GRID_WIDTH || y < 0 || y >= GRID_HEIGHT) {
        return;
    }

    g->rows[y] |= (1u << x);
    g->colors[y][x] = color;

    if (y > g->relief[x]) {
        g->relief[x] = y;
    }
}

void grid_clear_cell(grid_t *g, int x, int y)
{
    if (x < 0 || x >= GRID_WIDTH || y < 0 || y >= GRID_HEIGHT) {
        return;
    }
    g->rows[y] &= ~(1u << x);
    g->colors[y][x] = COLOR_BLACK;
}

bool grid_row_full(const grid_t *g, int y)
{
    if (y < 0 || y >= GRID_HEIGHT) {
        return false;
    }

    uint16_t full_mask = (1u << GRID_WIDTH) - 1;

    return (g->rows[y] & full_mask) == full_mask;
}

static void remove_row(grid_t *g, int row)
{
    for (int y = row; y < GRID_HEIGHT - 1; y++) {
        g->rows[y] = g->rows[y + 1];
        for (int x = 0; x < GRID_WIDTH; x++) {
            g->colors[y][x] = g->colors[y + 1][x];
        }
    }

    g->rows[GRID_HEIGHT - 1] = 0;
    for (int x = 0; x < GRID_WIDTH; x++) {
        g->colors[GRID_HEIGHT - 1][x] = COLOR_BLACK;
    }
}

static void recalc_relief(grid_t *g)
{
    for (int x = 0; x < GRID_WIDTH; x++) {
        g->relief[x] = -1;

        for (int y = GRID_HEIGHT - 1; y >= 0; y--) {
            if (g->rows[y] & (1u << x)) {
                g->relief[x] = y;
                break;
            }
        }
    }
}

int grid_clear_lines(grid_t *g)
{
    int cleared = 0;
    int y = 0;

    while (y < GRID_HEIGHT) {
        if (grid_row_full(g, y)) {
            remove_row(g, y);
            cleared++;
        } else {
            y++;
        }
    }

    if (cleared > 0) {
        static const uint16_t SCORE_TABLE[5] = {0, 40, 100, 300, 1200};

        g->lines_cleared += cleared;

        if (cleared > 4) {
            cleared = 4;
        }
        g->score += SCORE_TABLE[cleared] * g->level;

        g->level = 1 + (g->lines_cleared / 10);
        if (g->level > 20) {
            g->level = 20;
        }

        recalc_relief(g);
    }

    return cleared;
}

extern const int8_t SHAPES[7][4][4][2];

static inline bool check_cell_collision(const grid_t *g, int gx, int gy)
{
    if (gx < 0 || gx >= GRID_WIDTH || gy < 0) {
        return true;
    }

    if (gy >= GRID_HEIGHT) {
        return false;
    }

    if (g->rows[gy] & (1u << gx)) {
        return true;
    }
    return false;
}

bool grid_block_collides(const grid_t *g, const block_t *b)
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

    if (check_cell_collision(g, gx0, gy0)) return true;
    if (check_cell_collision(g, gx1, gy1)) return true;
    if (check_cell_collision(g, gx2, gy2)) return true;
    if (check_cell_collision(g, gx3, gy3)) return true;

    return false;
}

static void gba_putc(char c)
{
    volatile uint32_t *uart_status = (volatile uint32_t *)0x40000000;
    volatile uint32_t *uart_send = (volatile uint32_t *)0x40000010;
    while (!(*uart_status & 0x01)) ;
    *uart_send = (uint32_t)c;
}

static void gba_put_hex8(uint8_t v)
{
    static const char hex[] = "0123456789ABCDEF";
    gba_putc(hex[(v >> 4) & 0xF]);
    gba_putc(hex[v & 0xF]);
}

static void gba_put_int(int v)
{
    char buf[12];
    int i = 0;
    int neg = 0;

    if (v < 0) {
        neg = 1;
        v = -v;
    }

    if (v == 0) {
        gba_putc('0');
        return;
    }

    while (v > 0) {
        buf[i++] = '0' + (v % 10);
        v = v / 10;
    }

    if (neg) {
        gba_putc('-');
    }

    while (i > 0) {
        gba_putc(buf[--i]);
    }
}

void grid_block_add(grid_t *g, const block_t *b)
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
        grid_set_cell(g, gx0, gy0, b->color);
    }
    if (gx1 >= 0 && gx1 < GRID_WIDTH && gy1 >= 0 && gy1 < GRID_HEIGHT) {
        grid_set_cell(g, gx1, gy1, b->color);
    }
    if (gx2 >= 0 && gx2 < GRID_WIDTH && gy2 >= 0 && gy2 < GRID_HEIGHT) {
        grid_set_cell(g, gx2, gy2, b->color);
    }
    if (gx3 >= 0 && gx3 < GRID_WIDTH && gy3 >= 0 && gy3 < GRID_HEIGHT) {
        grid_set_cell(g, gx3, gy3, b->color);
    }
}

int grid_block_drop(const grid_t *g, block_t *b)
{
    int drop_amount = 0;

    while (true) {
        b->y--;
        if (grid_block_collides(g, b)) {
            b->y++;
            break;
        }
        drop_amount++;
    }

    return drop_amount;
}

bool grid_block_move(const grid_t *g, block_t *b, direction_t dir)
{
    int old_x = b->x;
    int old_y = b->y;

    switch (dir) {
        case DIR_LEFT:
            b->x--;
            break;
        case DIR_RIGHT:
            b->x++;
            break;
        case DIR_DOWN:
            b->y--;
            break;
        case DIR_UP:
            b->y++;
            break;
    }

    if (grid_block_collides(g, b)) {
        b->x = old_x;
        b->y = old_y;
        return false;
    }

    return true;
}

bool grid_block_rotate(const grid_t *g, block_t *b, int amount)
{
    uint8_t old_rot = b->rot;
    uint8_t num_rots = shape_num_rotations(b->shape);

    b->rot = (uint8_t)my_mod((uint32_t)(b->rot + amount + num_rots), (uint32_t)num_rots);

    if (grid_block_collides(g, b)) {
        b->x--;
        if (!grid_block_collides(g, b)) {
            return true;
        }

        b->x += 2;
        if (!grid_block_collides(g, b)) {
            return true;
        }

        b->x--;
        b->rot = old_rot;
        return false;
    }

    return true;
}

void grid_block_spawn(const grid_t *g, block_t *b, uint8_t shape)
{
    b->shape = shape;
    b->rot = 0;
    b->color = SHAPE_COLORS[shape];

    uint8_t width = shape_get_width(shape, 0);
    b->x = (GRID_WIDTH - width) / 2;

    b->y = GRID_HEIGHT - shape_get_height(shape, 0);
}
