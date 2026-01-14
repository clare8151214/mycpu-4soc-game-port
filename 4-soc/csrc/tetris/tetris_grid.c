#include "tetris.h"

// Minimal libc replacements used by the game.
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
    if (x < 0 || x >= g->width || y < 0 || y >= g->height) {
        return true;
    }
    return (g->rows[y] & (1u << x)) != 0;
}

void grid_set_cell(grid_t *g, int x, int y, uint8_t color)
{
    if (x < 0 || x >= g->width || y < 0 || y >= g->height) {
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
    if (x < 0 || x >= g->width || y < 0 || y >= g->height) {
        return;
    }
    g->rows[y] &= ~(1u << x);
    g->colors[y][x] = COLOR_BLACK;
}

bool grid_row_full(const grid_t *g, int y)
{
    if (y < 0 || y >= g->height) {
        return false;
    }

    uint16_t full_mask = (1u << g->width) - 1;
    return (g->rows[y] & full_mask) == full_mask;
}

static void remove_row(grid_t *g, int row)
{
    for (int y = row; y < g->height - 1; y++) {
        g->rows[y] = g->rows[y + 1];
        for (int x = 0; x < g->width; x++) {
            g->colors[y][x] = g->colors[y + 1][x];
        }
    }

    g->rows[g->height - 1] = 0;
    for (int x = 0; x < g->width; x++) {
        g->colors[g->height - 1][x] = COLOR_BLACK;
    }
}

static void recalc_relief(grid_t *g)
{
    for (int x = 0; x < g->width; x++) {
        g->relief[x] = -1;
        for (int y = g->height - 1; y >= 0; y--) {
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

    while (y < g->height) {
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

bool grid_block_collides(const grid_t *g, const block_t *b)
{
    int8_t cells[4][2];
    shape_get_cells(b->shape, b->rot, cells);

    for (int i = 0; i < MAX_BLOCK_LEN; i++) {
        int gx = b->x + cells[i][0];
        int gy = b->y + cells[i][1];

        if (gx < 0 || gx >= g->width || gy < 0) {
            return true;
        }
        if (gy >= g->height) {
            continue;
        }
        if (g->rows[gy] & (1u << gx)) {
            return true;
        }
    }

    return false;
}

void grid_block_add(grid_t *g, const block_t *b)
{
    int8_t cells[4][2];
    shape_get_cells(b->shape, b->rot, cells);

    for (int i = 0; i < MAX_BLOCK_LEN; i++) {
        int gx = b->x + cells[i][0];
        int gy = b->y + cells[i][1];

        if (gx >= 0 && gx < g->width && gy >= 0 && gy < g->height) {
            grid_set_cell(g, gx, gy, b->color);
        }
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

    b->rot = (b->rot + amount + num_rots) % num_rots;

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
    b->x = (g->width - width) / 2;
    b->y = g->height - shape_get_height(shape, 0);
}
