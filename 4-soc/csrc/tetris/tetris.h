/* Tetris core interfaces and constants. */
#ifndef TETRIS_H
#define TETRIS_H

#include <stdbool.h>
#include <stdint.h>

#define GRID_WIDTH 10
#define GRID_HEIGHT 18
#define BLOCK_SIZE 3

#define GRID_OFFSET_X 2
#define GRID_OFFSET_Y 5

#define PREVIEW_X 38
#define PREVIEW_Y 8

#define SCORE_X 38
#define SCORE_Y 30

#define NUM_SHAPES 7
#define MAX_BLOCK_LEN 4

#define COLOR_BLACK 0
#define COLOR_CYAN 1
#define COLOR_YELLOW 2
#define COLOR_PURPLE 3
#define COLOR_GREEN 4
#define COLOR_RED 5
#define COLOR_BLUE 6
#define COLOR_ORANGE 7
#define COLOR_GRAY 8
#define COLOR_WHITE 9

static const uint8_t SHAPE_COLORS[NUM_SHAPES] = {
    COLOR_YELLOW,
    COLOR_PURPLE,
    COLOR_CYAN,
    COLOR_BLUE,
    COLOR_ORANGE,
    COLOR_GREEN,
    COLOR_RED,
};

typedef enum {
    DIR_DOWN = 0,
    DIR_LEFT = 1,
    DIR_UP = 2,
    DIR_RIGHT = 3
} direction_t;

typedef enum {
    GAME_PLAYING,
    GAME_PAUSED,
    GAME_OVER
} game_state_t;

typedef enum {
    INPUT_NONE,
    INPUT_LEFT,
    INPUT_RIGHT,
    INPUT_ROTATE,
    INPUT_SOFT_DROP,
    INPUT_HARD_DROP,
    INPUT_PAUSE,
    INPUT_QUIT
} input_t;

typedef uint16_t row_t;

typedef struct {
    row_t rows[GRID_HEIGHT];
    uint8_t colors[GRID_HEIGHT][GRID_WIDTH];
    int8_t relief[GRID_WIDTH];
    uint8_t width;
    uint8_t height;
    uint16_t lines_cleared;
    uint32_t score;
    uint8_t level;
} grid_t;

typedef struct {
    int8_t x;
    int8_t y;
    uint8_t shape;
    uint8_t rot;
    uint8_t color;
} block_t;

void grid_init(grid_t *g);

void grid_clear(grid_t *g);

bool grid_cell_occupied(const grid_t *g, int x, int y);

void grid_set_cell(grid_t *g, int x, int y, uint8_t color);

void grid_clear_cell(grid_t *g, int x, int y);

int grid_clear_lines(grid_t *g);

bool grid_row_full(const grid_t *g, int y);

bool grid_block_collides(const grid_t *g, const block_t *b);

void grid_block_add(grid_t *g, const block_t *b);

int grid_block_drop(const grid_t *g, block_t *b);

bool grid_block_move(const grid_t *g, block_t *b, direction_t dir);

bool grid_block_rotate(const grid_t *g, block_t *b, int amount);

void grid_block_spawn(const grid_t *g, block_t *b, uint8_t shape);

void shape_get_cells(uint8_t shape, uint8_t rot, int8_t cells[4][2]);

uint8_t shape_get_width(uint8_t shape, uint8_t rot);

uint8_t shape_get_height(uint8_t shape, uint8_t rot);

uint8_t shape_num_rotations(uint8_t shape);

void shape_init(void);

uint8_t shape_random(void);

void draw_init(void);

void draw_grid(const grid_t *g);

void draw_block(const block_t *b);

void draw_ghost(const grid_t *g, const block_t *b);

void draw_preview(uint8_t shape);

void draw_score(uint32_t score, uint16_t lines, uint8_t level);

void draw_border(void);

void draw_game_over(void);

void draw_clear(void);

void draw_swap_buffers(void);

input_t input_poll(void);

void game_init(void);

void game_loop(void);

void game_update(void);

void game_render(void);

void *my_memset(void *s, int c, uint32_t n);

void *my_memcpy(void *dest, const void *src, uint32_t n);

uint32_t my_rand(void);

void my_srand(uint32_t seed);

uint32_t get_tick(void);

void delay_ms(uint32_t ms);

static inline uint32_t my_mod(uint32_t val, uint32_t divisor)
{
    return val % divisor;
}

static inline uint32_t my_div(uint32_t val, uint32_t divisor)
{
    return val / divisor;
}

#endif
