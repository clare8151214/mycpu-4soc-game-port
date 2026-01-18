/* Main game loop and input handling. */
#include "tetris.h"
#include "mmio.h"

static volatile uint32_t soft_tick = 0;

uint32_t get_tick(void)
{
    return soft_tick;
}

void delay_ms(uint32_t ms)
{
    for (volatile uint32_t i = 0; i < ms * 500; i++) {
    }
}

static void uart_putc(char c)
{
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = c;
}

static void uart_puts(const char *s)
{
    while (*s) {
        uart_putc(*s++);
    }
}


/* Print score to terminal */
static void uart_put_number(uint32_t num)
{
    char buf[12];
    int i = 0;

    if (num == 0) {
        uart_putc('0');
        return;
    }

    while (num > 0 && i < 11) {
        buf[i++] = '0' + (num % 10);
        num /= 10;
    }

    while (--i >= 0) {
        uart_putc(buf[i]);
    }
}

static uint32_t last_printed_score = 0xFFFFFFFF;
static uint16_t last_printed_lines = 0xFFFF;
static uint8_t last_printed_level = 0xFF;

static void print_score_to_terminal(uint32_t score, uint16_t lines, uint8_t level)
{
    /* Only print if score changed */
    if (score == last_printed_score && lines == last_printed_lines && level == last_printed_level) {
        return;
    }

    last_printed_score = score;
    last_printed_lines = lines;
    last_printed_level = level;

    uart_puts("\r[Score: ");
    uart_put_number(score);
    uart_puts(" Lines: ");
    uart_put_number(lines);
    uart_puts(" Lv: ");
    uart_put_number(level);
    uart_puts("]   ");
}

/* Check if UART has data available */
static inline int uart_has_data(void)
{
    return (*UART_STATUS & 0x02) != 0;
}

/* Read one character from UART (blocking) */
static inline char uart_getc_blocking(void)
{
    while (!uart_has_data());
    return (char)(*UART_RECV & 0xFF);
}

/* Try to read one character from UART (non-blocking, returns -1 if none) */
static inline int uart_getc_nonblocking(void)
{
    if (!uart_has_data()) {
        return -1;
    }
    return (int)(*UART_RECV & 0xFF);
}

input_t input_poll(void)
{
    if (!uart_has_data()) {
        return INPUT_NONE;
    }

    char c = (char)(*UART_RECV & 0xFF);

    /* Handle ANSI escape sequences for arrow keys */
    /* Arrow keys send: ESC [ A/B/C/D (0x1B 0x5B 0x41-0x44) */
    if (c == 0x1B) {  /* ESC */
        /* Wait briefly for next character */
        for (volatile int i = 0; i < 1000; i++) {
            if (uart_has_data()) break;
        }
        int c2 = uart_getc_nonblocking();
        if (c2 == '[' || c2 == 'O') {  /* CSI or SS3 */
            for (volatile int i = 0; i < 1000; i++) {
                if (uart_has_data()) break;
            }
            int c3 = uart_getc_nonblocking();
            switch (c3) {
                case 'A':  /* Up arrow */
                    return INPUT_ROTATE;
                case 'B':  /* Down arrow */
                    return INPUT_SOFT_DROP;
                case 'C':  /* Right arrow */
                    return INPUT_RIGHT;
                case 'D':  /* Left arrow */
                    return INPUT_LEFT;
            }
        }
        return INPUT_NONE;  /* Unknown escape sequence */
    }

    switch (c) {
        case 'a':
        case 'A':
        case 'h':
            return INPUT_LEFT;

        case 'd':
        case 'D':
        case 'l':
            return INPUT_RIGHT;

        case 'w':
        case 'W':
        case 'k':
            return INPUT_ROTATE;

        case 's':
        case 'S':
        case 'j':
            return INPUT_SOFT_DROP;

        case ' ':
            return INPUT_HARD_DROP;

        case 'p':
        case 'P':
            return INPUT_PAUSE;

        case 'q':
        case 'Q':
            return INPUT_QUIT;

        default:
            return INPUT_NONE;
    }
}


static grid_t grid;

static block_t current_block;

static block_t next_block;

static game_state_t game_state;

static uint32_t last_drop_time;

static uint32_t drop_interval;

static const uint16_t LEVEL_SPEEDS[21] = {
    48, 43, 38, 33, 28,
    23, 18, 13, 8, 6,
    5, 5, 5, 4, 4,
    4, 3, 3, 3, 2,
    2
};

static uint32_t get_drop_interval(uint8_t level)
{
    if (level > 20) level = 20;
    if (level < 1) level = 1;
    return LEVEL_SPEEDS[level - 1];
}

void game_init(void)
{
    my_srand(12345);
    grid_init(&grid);

    uint8_t first_shape = shape_random();
    grid_block_spawn(&grid, &current_block, first_shape);

    uint8_t next_shape = shape_random();
    grid_block_spawn(&grid, &next_block, next_shape);

    game_state = GAME_PLAYING;
    last_drop_time = get_tick();
    drop_interval = get_drop_interval(grid.level);

    draw_init();
}

static void lock_block_and_spawn_next(void)
{
    grid_block_add(&grid, &current_block);

    int cleared = grid_clear_lines(&grid);

    if (cleared > 0) {
        drop_interval = get_drop_interval(grid.level);
    }

    current_block = next_block;

    grid_block_spawn(&grid, &current_block, current_block.shape);

    uint8_t next_shape = shape_random();
    grid_block_spawn(&grid, &next_block, next_shape);

    if (grid_block_collides(&grid, &current_block)) {
        game_state = GAME_OVER;
    }
}

void game_update(void)
{
    if (game_state != GAME_PLAYING) {
        return;
    }

    input_t input = input_poll();

    switch (input) {
        case INPUT_LEFT:

            grid_block_move(&grid, &current_block, DIR_LEFT);
            break;

        case INPUT_RIGHT:

            grid_block_move(&grid, &current_block, DIR_RIGHT);
            break;

        case INPUT_ROTATE:

            grid_block_rotate(&grid, &current_block, 1);
            break;

        case INPUT_SOFT_DROP:

            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                lock_block_and_spawn_next();
            }
            grid.score += 1;
            last_drop_time = get_tick();
            break;

        case INPUT_HARD_DROP:

            {
                int drop_dist = grid_block_drop(&grid, &current_block);
                grid.score += drop_dist * 2;
                lock_block_and_spawn_next();
                last_drop_time = get_tick();
            }
            break;

        case INPUT_PAUSE:

            game_state = GAME_PAUSED;
            break;

        case INPUT_QUIT:

            game_state = GAME_OVER;
            break;

        default:
            break;
    }

    uint32_t current_time = get_tick();
    if (current_time - last_drop_time >= drop_interval) {
        if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
            lock_block_and_spawn_next();
        }
        last_drop_time = current_time;
    }
}

void game_render(void)
{
    draw_clear();
    draw_border();
    draw_grid(&grid);
    draw_ghost(&grid, &current_block);
    draw_block(&current_block);
    draw_preview(next_block.shape);
    draw_score(grid.score, grid.lines_cleared, grid.level);

    if (game_state == GAME_OVER) {
        draw_game_over();
    }

    draw_swap_buffers();
}

void game_loop(void)
{
    uint32_t loop_counter = 0;

    while (game_state != GAME_OVER) {
        if (game_state == GAME_PLAYING) {
            game_update();

            if (my_mod(++loop_counter, 50000) == 0) {
                if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                    lock_block_and_spawn_next();
                }
            }
        } else if (game_state == GAME_PAUSED) {
            input_t input = input_poll();
            if (input == INPUT_PAUSE) {
                game_state = GAME_PLAYING;
                last_drop_time = get_tick();
            } else if (input == INPUT_QUIT) {
                game_state = GAME_OVER;
            }
        }

        game_render();
        soft_tick++;
    }

    for (int i = 0; i < 100; i++) {
        game_render();
    }
}

#define TIMER_VALUE ((volatile uint32_t *) 0x80000000u)

int main(void)
{
    *UART_INTERRUPT = 1;

    uart_puts("\r\n=== TETRIS ===\r\n");

    draw_init();
    grid_init(&grid);

    uart_puts("Press any key to start...\r\n");

    uint32_t seed = 0x5A5A5A5A;

    while (!(*UART_STATUS & 0x02)) {
        seed++;
        seed ^= (seed >> 7);
        seed ^= (seed << 3);
    }

    uint32_t key = *UART_RECV & 0xFF;
    seed ^= key;
    seed ^= (key << 8);
    seed ^= (key << 16);
    seed ^= (key << 24);

    seed = (seed << 13) | (seed >> 19);
    seed ^= (seed >> 17);
    seed ^= (seed << 5);

    if (seed == 0) seed = key | 0x12345;

    my_srand(seed);
    shape_init();

    uint8_t shape = shape_random();
    grid_block_spawn(&grid, &current_block, shape);

    shape = shape_random();
    grid_block_spawn(&grid, &next_block, shape);

    game_state = GAME_PLAYING;
    soft_tick = 0;
    last_drop_time = 0;
    drop_interval = 2;

    while (1) {
        draw_clear();
        draw_border();
        draw_grid(&grid);
        draw_block(&current_block);

        draw_preview(next_block.shape);
        print_score_to_terminal(grid.score, grid.lines_cleared, grid.level);

        draw_swap_buffers();

        input_t input = input_poll();

        if (input == INPUT_LEFT) {
            grid_block_move(&grid, &current_block, DIR_LEFT);
        } else if (input == INPUT_RIGHT) {
            grid_block_move(&grid, &current_block, DIR_RIGHT);
        } else if (input == INPUT_ROTATE) {
            grid_block_rotate(&grid, &current_block, 1);
        } else if (input == INPUT_SOFT_DROP) {
            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                grid_block_add(&grid, &current_block);
                grid_clear_lines(&grid);

                shape = next_block.shape;
                grid_block_spawn(&grid, &current_block, shape);

                shape = shape_random();
                grid_block_spawn(&grid, &next_block, shape);

                if (grid_block_collides(&grid, &current_block)) {
                    game_state = GAME_OVER;
                }
            }
            grid.score += 1;  /* Soft drop bonus */
            last_drop_time = soft_tick;
        } else if (input == INPUT_HARD_DROP) {
            int drop_dist = grid_block_drop(&grid, &current_block);
            grid.score += drop_dist * 2;  /* Hard drop bonus */
            grid_block_add(&grid, &current_block);
            grid_clear_lines(&grid);

            shape = next_block.shape;
            grid_block_spawn(&grid, &current_block, shape);

            shape = shape_random();
            grid_block_spawn(&grid, &next_block, shape);
            last_drop_time = soft_tick;

            if (grid_block_collides(&grid, &current_block)) {
                game_state = GAME_OVER;
            }
        } else if (input == INPUT_PAUSE) {
            uart_puts("\r\nPAUSE\r\n");
            /* Wait for another P to resume */
            while (1) {
                draw_swap_buffers();  /* Keep display alive */
                input_t resume = input_poll();
                if (resume == INPUT_PAUSE) {
                    uart_puts("RESUME\r\n");
                    last_drop_time = soft_tick;  /* Reset drop timer */
                    break;
                } else if (resume == INPUT_QUIT) {
                    uart_puts("QUIT\r\n");
                    game_state = GAME_OVER;
                    break;
                }
            }
        } else if (input == INPUT_QUIT) {
            uart_puts("\r\nQUIT\r\n");
            game_state = GAME_OVER;
        }

        /* Check for game over immediately after input handling */
        if (game_state == GAME_OVER) {
            break;
        }

        soft_tick++;

        if (soft_tick - last_drop_time >= drop_interval) {
            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                grid_block_add(&grid, &current_block);
                grid_clear_lines(&grid);

                shape = next_block.shape;
                grid_block_spawn(&grid, &current_block, shape);

                shape = shape_random();
                grid_block_spawn(&grid, &next_block, shape);

                if (grid_block_collides(&grid, &current_block)) {
                    game_state = GAME_OVER;
                }
            }
            last_drop_time = soft_tick;
        }

        if (game_state == GAME_OVER) {
            break;
        }
    }

    uart_puts("\r\nGame Over!\r\n");

    /* Stay in game over state - halt */
    while (1) {
        draw_swap_buffers();  /* Keep display alive */
    }
}
