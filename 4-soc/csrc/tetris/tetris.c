/**
 * Tetris for MyCPU - 主程式
 * 
 * 遊戲主迴圈和狀態管理
 */

#include "tetris.h"
#include "mmio.h"

/*============================================================================
 * 計時器和時間函式
 *============================================================================*/

// 使用軟體計數器代替硬體計時器
static volatile uint32_t soft_tick = 0;

uint32_t get_tick(void)
{
    return soft_tick;  // 只讀取，不增加
}

void delay_ms(uint32_t ms)
{
    // 簡單的忙等待延遲 (與 trex 一致的做法)
    for (volatile uint32_t i = 0; i < ms * 500; i++) {
        // 忙等待
    }
}

/*============================================================================
 * UART 輸出函式 (用於調試)
 *============================================================================*/

static void uart_putc(char c)
{
    while (!(*UART_STATUS & 0x01));  // 等待 TX ready
    *UART_SEND = c;
}

static void uart_puts(const char *s)
{
    while (*s) {
        uart_putc(*s++);
    }
}

/*============================================================================
 * 輸入系統
 *============================================================================*/

input_t input_poll(void)
{
    // 檢查 UART 是否有資料
    if (!(*UART_STATUS & 0x02)) {
        return INPUT_NONE;
    }
    
    // 讀取字元
    char c = (char)(*UART_RECV & 0xFF);
    
    switch (c) {
        case 'a':
        case 'A':
        case 'h':  // vim 風格
            return INPUT_LEFT;
            
        case 'd':
        case 'D':
        case 'l':  // vim 風格
            return INPUT_RIGHT;
            
        case 'w':
        case 'W':
        case 'k':  // vim 風格
            return INPUT_ROTATE;
            
        case 's':
        case 'S':
        case 'j':  // vim 風格
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

/*============================================================================
 * 遊戲狀態
 *============================================================================*/

static grid_t grid;
static block_t current_block;
static block_t next_block;
static game_state_t game_state;

// 下落計時
static uint32_t last_drop_time;
static uint32_t drop_interval;

// 下落速度 (以 frame 數為單位，假設約 60fps)
// Level 1: 約 48 frames (~0.8秒), Level 10: 約 6 frames (~0.1秒)
static const uint16_t LEVEL_SPEEDS[21] = {
    48, 43, 38, 33, 28,   // 1-5
    23, 18, 13, 8, 6,     // 6-10
    5, 5, 5, 4, 4,        // 11-15
    4, 3, 3, 3, 2,        // 16-20
    2                      // 20+
};

static uint32_t get_drop_interval(uint8_t level)
{
    if (level > 20) level = 20;
    if (level < 1) level = 1;
    return LEVEL_SPEEDS[level - 1];
}

/*============================================================================
 * 遊戲初始化
 *============================================================================*/

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
    uart_puts("Game ready!\r\n");
}

/*============================================================================
 * 方塊鎖定和下一個方塊
 *============================================================================*/

static void lock_block_and_spawn_next(void)
{
    // 將當前方塊加入 grid
    grid_block_add(&grid, &current_block);
    
    // 消行
    int cleared = grid_clear_lines(&grid);
    
    // 更新下落速度
    if (cleared > 0) {
        drop_interval = get_drop_interval(grid.level);
    }
    
    // 當前方塊變成預覽的方塊
    current_block = next_block;
    
    // 重新定位到出生點
    grid_block_spawn(&grid, &current_block, current_block.shape);
    
    // 生成新的預覽方塊
    uint8_t next_shape = shape_random();
    grid_block_spawn(&grid, &next_block, next_shape);
    
    // 檢查是否 Game Over
    if (grid_block_collides(&grid, &current_block)) {
        game_state = GAME_OVER;
    }
}

/*============================================================================
 * 遊戲更新
 *============================================================================*/

void game_update(void)
{
    if (game_state != GAME_PLAYING) {
        return;
    }
    
    // 處理輸入
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
            // 軟落：加速下降
            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                lock_block_and_spawn_next();
            }
            grid.score += 1;  // 軟落加分
            last_drop_time = get_tick();  // 重置計時
            break;
            
        case INPUT_HARD_DROP:
            // 硬落：直接落到底
            {
                int drop_dist = grid_block_drop(&grid, &current_block);
                grid.score += drop_dist * 2;  // 硬落加分
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
    
    // 自動下落
    uint32_t current_time = get_tick();
    if (current_time - last_drop_time >= drop_interval) {
        if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
            lock_block_and_spawn_next();
        }
        last_drop_time = current_time;
    }
}

/*============================================================================
 * 遊戲渲染
 *============================================================================*/

void game_render(void)
{
    // 清空畫面
    draw_clear();
    
    // 畫邊框
    draw_border();
    
    // 畫已放置的方塊
    draw_grid(&grid);
    
    // 畫 ghost (落點預覽)
    draw_ghost(&grid, &current_block);
    
    // 畫當前方塊
    draw_block(&current_block);
    
    // 畫預覽
    draw_preview(next_block.shape);
    
    // 畫分數
    draw_score(grid.score, grid.lines_cleared, grid.level);
    
    // 如果 Game Over，畫結束畫面
    if (game_state == GAME_OVER) {
        draw_game_over();
    }
    
    // 輸出到 VGA
    draw_swap_buffers();
}

/*============================================================================
 * 遊戲主迴圈
 *============================================================================*/

void game_loop(void)
{
    while (game_state != GAME_OVER) {
        if (game_state == GAME_PLAYING) {
            game_update();
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
        soft_tick++;  // 增加 tick 計數
    }

    // Game Over 顯示
    for (int i = 0; i < 100; i++) {
        game_render();
    }
}

/*============================================================================
 * 主程式入口
 *============================================================================*/

int main(void)
{
    uart_puts("\r\n=== TETRIS ===\r\n");

    // 只初始化一次
    draw_init();
    grid_init(&grid);
    my_srand(12345);
    
    uint8_t shape = shape_random();
    grid_block_spawn(&grid, &current_block, shape);
    
    shape = shape_random();
    grid_block_spawn(&grid, &next_block, shape);
    
    game_state = GAME_PLAYING;
    soft_tick = 0;
    last_drop_time = 0;
    drop_interval = 48;  // 固定速度
    
    uart_puts("Game ready!\r\n");
    uart_puts("Starting game loop...\r\n");

    // 簡化的主迴圈
    while (1) {
        // 畫面
        draw_clear();
        draw_border();
        draw_grid(&grid);
        draw_block(&current_block);
        draw_preview(next_block.shape);
        draw_score(grid.score, grid.lines_cleared, grid.level);
        draw_swap_buffers();
        
        // 輸入處理
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
                current_block = next_block;
                grid_block_spawn(&grid, &current_block, current_block.shape);
                shape = shape_random();
                grid_block_spawn(&grid, &next_block, shape);
            }
        } else if (input == INPUT_HARD_DROP) {
            grid_block_drop(&grid, &current_block);
            grid_block_add(&grid, &current_block);
            grid_clear_lines(&grid);
            current_block = next_block;
            grid_block_spawn(&grid, &current_block, current_block.shape);
            shape = shape_random();
            grid_block_spawn(&grid, &next_block, shape);
        } else if (input == INPUT_QUIT) {
            break;
        }
        
        // 自動下落
        soft_tick++;
        if (soft_tick - last_drop_time >= drop_interval) {
            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                grid_block_add(&grid, &current_block);
                grid_clear_lines(&grid);
                current_block = next_block;
                grid_block_spawn(&grid, &current_block, current_block.shape);
                shape = shape_random();
                grid_block_spawn(&grid, &next_block, shape);
                
                // Game over check
                if (grid_block_collides(&grid, &current_block)) {
                    uart_puts("Game Over!\r\n");
                    break;
                }
            }
            last_drop_time = soft_tick;
        }
    }
    
    uart_puts("Exiting...\r\n");
    return 0;
}