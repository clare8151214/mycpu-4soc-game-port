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

/**
 * soft_tick - 軟體計時器計數器
 *
 * 用於模擬硬體計時器，每次主迴圈執行時遞增。
 * 作為遊戲內部的「時間」單位，用來控制方塊自動下落的時機。
 * volatile 確保每次讀取都從記憶體取值，避免編譯器優化問題。
 */
static volatile uint32_t soft_tick = 0;

/**
 * get_tick - 取得當前計時器數值
 *
 * @return 當前的 soft_tick 值
 *
 * 提供統一的介面讓其他模組查詢「現在時間」。
 */
uint32_t get_tick(void)
{
    return soft_tick;
}

/**
 * delay_ms - 毫秒級延遲函式
 *
 * @param ms: 要延遲的毫秒數
 *
 * 使用忙等待 (busy-wait) 實現延遲。
 * 在沒有硬體計時器的環境中，透過空迴圈消耗 CPU 時間。
 * 注意：實際延遲時間取決於 CPU 頻率。
 */
void delay_ms(uint32_t ms)
{
    for (volatile uint32_t i = 0; i < ms * 500; i++) {
        // 忙等待
    }
}

/*============================================================================
 * UART 輸出函式 (用於調試)
 *============================================================================*/

/**
 * uart_putc - 輸出單一字元到 UART
 *
 * @param c: 要輸出的字元
 *
 * 阻塞式輸出：會等待 UART 傳輸緩衝區準備好才送出。
 * 用於調試訊息輸出。
 */
static void uart_putc(char c)
{
    while (!(*UART_STATUS & 0x01));  // 等待 TX ready
    *UART_SEND = c;
}

/**
 * uart_puts - 輸出字串到 UART
 *
 * @param s: 要輸出的字串 (null-terminated)
 *
 * 逐字元呼叫 uart_putc() 輸出整個字串。
 */
static void uart_puts(const char *s)
{
    while (*s) {
        uart_putc(*s++);
    }
}

/**
 * uart_put_hex8 - 以十六進位格式輸出 8-bit 數值
 *
 * @param v: 要輸出的 8-bit 數值
 *
 * 將數值轉換成兩位十六進位字元輸出 (例如 0x3F -> "3F")。
 * 用於調試時顯示數值。
 */
static void uart_put_hex8(uint8_t v)
{
    static const char hex[] = "0123456789ABCDEF";
    uart_putc(hex[(v >> 4) & 0xF]);
    uart_putc(hex[v & 0xF]);
}

/**
 * uart_try_putc - 嘗試輸出單一字元 (非阻塞)
 *
 * @param c: 要輸出的字元
 *
 * 非阻塞式輸出：如果 UART 忙碌就直接跳過，不會等待。
 * 適合在遊戲迴圈中使用，避免影響遊戲流暢度。
 */
static void uart_try_putc(char c)
{
    if (*UART_STATUS & 0x01) {
        *UART_SEND = c;
    }
}

/**
 * uart_try_put_hex8 - 嘗試以十六進位格式輸出 8-bit 數值 (非阻塞)
 *
 * @param v: 要輸出的 8-bit 數值
 *
 * 非阻塞版本的 uart_put_hex8()。
 */
static void uart_try_put_hex8(uint8_t v)
{
    static const char hex[] = "0123456789ABCDEF";
    uart_try_putc(hex[(v >> 4) & 0xF]);
    uart_try_putc(hex[v & 0xF]);
}

/*============================================================================
 * 輸入系統
 *============================================================================*/

/**
 * input_poll - 輪詢使用者輸入
 *
 * @return 對應的 input_t 列舉值，無輸入時返回 INPUT_NONE
 *
 * 從 UART 讀取使用者按鍵，並轉換成遊戲指令。
 * 支援 WASD 鍵和 vim 風格的 HJKL 鍵：
 *   - A/H: 左移
 *   - D/L: 右移
 *   - W/K: 旋轉
 *   - S/J: 軟落 (加速下降)
 *   - 空白鍵: 硬落 (直接落到底)
 *   - P: 暫停
 *   - Q: 結束遊戲
 */
input_t input_poll(void)
{
    // 檢查 UART 是否有資料 (bit 1 = RX 有資料)
    if (!(*UART_STATUS & 0x02)) {
        return INPUT_NONE;
    }

    // 讀取字元並回顯
    char c = (char)(*UART_RECV & 0xFF);
    uart_try_putc(c);

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

/**
 * debug_log_input - 輸出輸入事件的調試資訊
 *
 * @param input: 收到的輸入類型
 *
 * 將輸入事件以單一字元輸出到 UART，方便調試：
 *   L=左, R=右, U=旋轉, D=軟落, H=硬落, P=暫停, Q=結束
 */
static void debug_log_input(input_t input)
{
    switch (input) {
        case INPUT_LEFT:
            uart_putc('L');
            break;
        case INPUT_RIGHT:
            uart_putc('R');
            break;
        case INPUT_ROTATE:
            uart_putc('U');
            break;
        case INPUT_SOFT_DROP:
            uart_putc('D');
            break;
        case INPUT_HARD_DROP:
            uart_putc('H');
            break;
        case INPUT_PAUSE:
            uart_putc('P');
            break;
        case INPUT_QUIT:
            uart_putc('Q');
            break;
        default:
            break;
    }
}

/*============================================================================
 * 遊戲狀態
 *============================================================================*/

/**
 * grid - 遊戲網格
 *
 * 儲存整個遊戲場地的狀態，包含已放置的方塊、分數、等級等資訊。
 */
static grid_t grid;

/**
 * current_block - 當前正在操控的方塊
 *
 * 玩家目前正在移動/旋轉的方塊，包含位置、形狀、旋轉狀態和顏色。
 */
static block_t current_block;

/**
 * next_block - 下一個方塊 (預覽)
 *
 * 顯示在預覽區域，當前方塊鎖定後會變成新的 current_block。
 */
static block_t next_block;

/**
 * game_state - 遊戲狀態機
 *
 * 追蹤遊戲目前的狀態：GAME_PLAYING (進行中)、GAME_PAUSED (暫停)、GAME_OVER (結束)。
 */
static game_state_t game_state;

/**
 * last_drop_time - 上次方塊下落的時間點
 *
 * 記錄方塊最後一次自動下落的 tick 值。
 * 用於計算是否該觸發下一次自動下落。
 */
static uint32_t last_drop_time;

/**
 * drop_interval - 自動下落的時間間隔
 *
 * 以 tick 為單位，決定方塊多久自動下降一格。
 * 數值越小 = 下落越快 = 難度越高。
 */
static uint32_t drop_interval;

/**
 * LEVEL_SPEEDS - 各等級的下落速度對照表
 *
 * 索引 0~20 對應等級 1~21。
 * 數值為 tick 數，假設約 60fps：
 *   - Level 1: 48 ticks (~0.8秒)
 *   - Level 10: 6 ticks (~0.1秒)
 *   - Level 20+: 2 ticks (~0.03秒)
 */
static const uint16_t LEVEL_SPEEDS[21] = {
    48, 43, 38, 33, 28,   // Level 1-5
    23, 18, 13, 8, 6,     // Level 6-10
    5, 5, 5, 4, 4,        // Level 11-15
    4, 3, 3, 3, 2,        // Level 16-20
    2                      // Level 20+
};

/**
 * get_drop_interval - 根據等級取得下落間隔
 *
 * @param level: 遊戲等級 (1-20+)
 * @return 對應的下落間隔 (tick 數)
 *
 * 查表取得該等級的下落速度，超出範圍會被限制在有效區間。
 */
static uint32_t get_drop_interval(uint8_t level)
{
    if (level > 20) level = 20;
    if (level < 1) level = 1;
    return LEVEL_SPEEDS[level - 1];
}

/*============================================================================
 * 遊戲初始化
 *============================================================================*/

/**
 * game_init - 初始化遊戲
 *
 * 設定遊戲開始時的所有初始狀態：
 *   1. 初始化亂數產生器 (用於隨機方塊)
 *   2. 初始化遊戲網格
 *   3. 生成第一個方塊和預覽方塊
 *   4. 設定遊戲狀態為 PLAYING
 *   5. 初始化下落計時器
 *   6. 初始化繪圖系統
 */
void game_init(void)
{
    my_srand(12345);                            // 初始化亂數種子
    grid_init(&grid);                           // 初始化網格

    uint8_t first_shape = shape_random();       // 隨機選擇第一個方塊形狀
    grid_block_spawn(&grid, &current_block, first_shape);

    uint8_t next_shape = shape_random();        // 隨機選擇預覽方塊形狀
    grid_block_spawn(&grid, &next_block, next_shape);

    game_state = GAME_PLAYING;                  // 設定遊戲狀態
    last_drop_time = get_tick();                // 記錄開始時間
    drop_interval = get_drop_interval(grid.level);  // 設定下落速度

    draw_init();                                // 初始化繪圖
    uart_puts("Game ready!\r\n");
}

/*============================================================================
 * 方塊鎖定和下一個方塊
 *============================================================================*/

/**
 * lock_block_and_spawn_next - 鎖定當前方塊並生成下一個
 *
 * 當方塊落到底部或無法繼續下降時呼叫此函式：
 *   1. 將當前方塊固定到網格中
 *   2. 檢查並消除已填滿的行
 *   3. 根據新等級更新下落速度
 *   4. 將預覽方塊變成當前方塊
 *   5. 生成新的預覽方塊
 *   6. 檢查是否 Game Over (新方塊出生位置有碰撞)
 */
static void lock_block_and_spawn_next(void)
{
    // 將當前方塊固定到網格
    grid_block_add(&grid, &current_block);

    // 檢查並消除填滿的行，返回消除的行數
    int cleared = grid_clear_lines(&grid);

    // 如果有消行，可能升級，更新下落速度
    if (cleared > 0) {
        drop_interval = get_drop_interval(grid.level);
    }

    // 預覽方塊變成當前方塊
    current_block = next_block;

    // 將方塊重新定位到出生點 (網格頂部中央)
    grid_block_spawn(&grid, &current_block, current_block.shape);

    // 隨機生成新的預覽方塊
    uint8_t next_shape = shape_random();
    grid_block_spawn(&grid, &next_block, next_shape);

    // Game Over 檢查：如果新方塊出生就碰撞，遊戲結束
    if (grid_block_collides(&grid, &current_block)) {
        game_state = GAME_OVER;
    }
}

/*============================================================================
 * 遊戲更新
 *============================================================================*/

/**
 * game_update - 遊戲邏輯更新 (每幀呼叫一次)
 *
 * 處理遊戲的核心邏輯：
 *   1. 檢查遊戲狀態，非 PLAYING 時不處理
 *   2. 輪詢並處理玩家輸入
 *   3. 根據計時器觸發方塊自動下落
 */
void game_update(void)
{
    // 只在遊戲進行中才更新
    if (game_state != GAME_PLAYING) {
        return;
    }

    // 輪詢玩家輸入
    input_t input = input_poll();
    if (input != INPUT_NONE) {
        debug_log_input(input);  // 輸出調試資訊
    }

    // 根據輸入執行對應動作
    switch (input) {
        case INPUT_LEFT:
            // 左移方塊
            grid_block_move(&grid, &current_block, DIR_LEFT);
            break;

        case INPUT_RIGHT:
            // 右移方塊
            grid_block_move(&grid, &current_block, DIR_RIGHT);
            break;

        case INPUT_ROTATE:
            // 順時針旋轉方塊
            grid_block_rotate(&grid, &current_block, 1);
            break;

        case INPUT_SOFT_DROP:
            // 軟落：手動加速下降一格
            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                lock_block_and_spawn_next();  // 無法下移則鎖定
            }
            grid.score += 1;              // 軟落每格 +1 分
            last_drop_time = get_tick();  // 重置自動下落計時
            break;

        case INPUT_HARD_DROP:
            // 硬落：瞬間落到底部
            {
                int drop_dist = grid_block_drop(&grid, &current_block);
                grid.score += drop_dist * 2;  // 硬落每格 +2 分
                lock_block_and_spawn_next();
                last_drop_time = get_tick();
            }
            break;

        case INPUT_PAUSE:
            // 暫停遊戲
            game_state = GAME_PAUSED;
            break;

        case INPUT_QUIT:
            // 結束遊戲
            game_state = GAME_OVER;
            break;

        default:
            break;
    }

    // 自動下落邏輯
    uint32_t current_time = get_tick();
    if (current_time - last_drop_time >= drop_interval) {
        // 時間到，嘗試下移一格
        if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
            lock_block_and_spawn_next();  // 無法下移則鎖定並生成新方塊
        }
        last_drop_time = current_time;    // 重置計時
    }
}

/*============================================================================
 * 遊戲渲染
 *============================================================================*/

/**
 * game_render - 遊戲畫面渲染 (每幀呼叫一次)
 *
 * 繪製遊戲的所有視覺元素，使用雙緩衝技術避免畫面閃爍：
 *   1. 清空後緩衝區
 *   2. 繪製遊戲邊框
 *   3. 繪製已固定的方塊 (網格)
 *   4. 繪製落點預覽 (ghost)
 *   5. 繪製當前操控的方塊
 *   6. 繪製預覽區域 (下一個方塊)
 *   7. 繪製分數/行數/等級
 *   8. 如果 Game Over，繪製結束畫面
 *   9. 交換緩衝區，顯示到螢幕
 */
void game_render(void)
{
    draw_clear();                               // 清空畫面
    draw_border();                              // 繪製邊框
    draw_grid(&grid);                           // 繪製已固定的方塊
    draw_ghost(&grid, &current_block);          // 繪製落點預覽 (半透明)
    draw_block(&current_block);                 // 繪製當前方塊
    draw_preview(next_block.shape);             // 繪製下一個方塊預覽
    draw_score(grid.score, grid.lines_cleared, grid.level);  // 繪製分數資訊

    // Game Over 時顯示結束畫面
    if (game_state == GAME_OVER) {
        draw_game_over();
    }

    draw_swap_buffers();                        // 交換緩衝區，輸出到 VGA
}

/*============================================================================
 * 遊戲主迴圈
 *============================================================================*/

/**
 * game_loop - 遊戲主迴圈
 *
 * 遊戲的核心迴圈，持續執行直到 Game Over：
 *   - PLAYING 狀態：更新遊戲邏輯，並額外使用 loop_counter 觸發下落
 *   - PAUSED 狀態：只處理暫停/結束輸入
 *   - 每次迴圈都渲染畫面並遞增 soft_tick
 *
 * 注意：這是較舊的遊戲迴圈版本，main() 中有簡化版本。
 */
void game_loop(void)
{
    uint32_t loop_counter = 0;  // 迴圈計數器，用於額外的下落觸發

    while (game_state != GAME_OVER) {
        if (game_state == GAME_PLAYING) {
            game_update();  // 更新遊戲邏輯

            // 額外的下落機制 (每 50000 次迴圈強制下落一次)
            if ((++loop_counter % 50000) == 0) {
                if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                    lock_block_and_spawn_next();
                }
            }
        } else if (game_state == GAME_PAUSED) {
            // 暫停狀態：只處理恢復或結束
            input_t input = input_poll();
            if (input == INPUT_PAUSE) {
                game_state = GAME_PLAYING;
                last_drop_time = get_tick();  // 重置計時避免瞬間下落
            } else if (input == INPUT_QUIT) {
                game_state = GAME_OVER;
            }
        }

        game_render();   // 渲染畫面
        soft_tick++;     // 遞增軟體計時器
    }

    // Game Over 後持續顯示結束畫面一段時間
    for (int i = 0; i < 100; i++) {
        game_render();
    }
}

/*============================================================================
 * 主程式入口
 *============================================================================*/

/**
 * main - 程式進入點
 *
 * 簡化版的遊戲主程式，直接在 main() 中實作遊戲迴圈：
 *   1. 初始化繪圖系統和網格
 *   2. 生成初始方塊
 *   3. 進入主迴圈：渲染 → 處理輸入 → 自動下落 → 檢查 Game Over
 *
 * 這是調試用的簡化版本，與 game_loop() 功能類似但更直接。
 *
 * @return 正常結束返回 0 (實際上不會返回，因為是嵌入式系統)
 */
int main(void)
{
    uart_puts("\r\n=== TETRIS ===\r\n");

    /*--------------------------------------------
     * 初始化階段
     *--------------------------------------------*/
    draw_init();                    // 初始化 VGA 繪圖系統
    grid_init(&grid);               // 初始化遊戲網格
    my_srand(12345);                // 初始化亂數種子

    // 生成第一個方塊
    uint8_t shape = shape_random();
    grid_block_spawn(&grid, &current_block, shape);
    current_block.color = COLOR_RED;

    // 調試輸出：顯示方塊初始 Y 座標
    uart_puts("spawn y=");
    uart_put_hex8((uint8_t)current_block.y);
    uart_puts("\r\n");

    // 生成預覽方塊
    shape = shape_random();
    grid_block_spawn(&grid, &next_block, shape);

    // 初始化遊戲狀態和計時器
    game_state = GAME_PLAYING;
    soft_tick = 0;
    last_drop_time = 0;
    drop_interval = 10;             // 下落間隔 (tick 數)

    uart_puts("Game ready!\r\n");
    uart_puts("Starting game loop...\r\n");

    /*--------------------------------------------
     * 主遊戲迴圈
     *--------------------------------------------*/
    while (1) {
        /*--- 渲染階段 ---*/
        draw_clear();                           // 清空畫面
        draw_border();                          // 繪製邊框
        draw_grid(&grid);                       // 繪製已固定的方塊
        draw_block(&current_block);             // 繪製當前方塊
        {
            int marker_y = GRID_OFFSET_Y +
                           (GRID_HEIGHT - 1 - current_block.y) * BLOCK_SIZE;
            if (marker_y < 0) {
                marker_y = 0;
            } else if (marker_y > 63) {
                marker_y = 63;
            }
            draw_set_debug_marker((uint8_t)marker_y);
        }
        draw_swap_buffers();                    // 輸出到 VGA

        /*--- 輸入處理階段 ---*/
        input_t input = input_poll();

        if (input == INPUT_LEFT) {
            // 左移
            uart_try_putc('L');

            grid_block_move(&grid, &current_block, DIR_LEFT);

        } else if (input == INPUT_RIGHT) {
            // 右移
            grid_block_move(&grid, &current_block, DIR_RIGHT);
            uart_try_putc('R');

        } else if (input == INPUT_ROTATE) {
            // 旋轉
            grid_block_rotate(&grid, &current_block, 1);

        } else if (input == INPUT_SOFT_DROP) {
            // 軟落：下移一格，若無法下移則鎖定
            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                grid_block_add(&grid, &current_block);      // 固定方塊
                grid_clear_lines(&grid);                     // 消行
                current_block = next_block;                  // 切換到下一個方塊
                grid_block_spawn(&grid, &current_block, current_block.shape);
                shape = shape_random();
                grid_block_spawn(&grid, &next_block, shape); // 生成新預覽
            }

        } else if (input == INPUT_HARD_DROP) {
            // 硬落：直接落到底部
            grid_block_drop(&grid, &current_block);
            grid_block_add(&grid, &current_block);
            grid_clear_lines(&grid);
            current_block = next_block;
            grid_block_spawn(&grid, &current_block, current_block.shape);
            shape = shape_random();
            grid_block_spawn(&grid, &next_block, shape);
        }

        /*--- 自動下落階段 ---*/
        soft_tick++;    // 遞增軟體計時器

        // 定期輸出調試資訊 (每 16384 ticks)
        if ((soft_tick & 0x3FFF) == 0) {
            uart_try_putc('y');
            uart_try_put_hex8((uint8_t)current_block.y);
            uart_try_putc('\n');
        }

        // 檢查是否到達下落時間
        if (soft_tick - last_drop_time >= drop_interval) {
            uart_try_putc('D');  // drop
            if (!grid_block_move(&grid, &current_block, DIR_DOWN)) {
                // 無法下移，鎖定方塊
                uart_try_putc('K');  // lock
                grid_block_add(&grid, &current_block);
                uart_try_putc('A');  // add ok

                grid_clear_lines(&grid);
                uart_try_putc('C');  // clear ok

                // 切換到下一個方塊
                current_block = next_block;
                uart_try_putc('N');  // next ok
                grid_block_spawn(&grid, &current_block, current_block.shape);
                current_block.color = COLOR_RED;
                uart_try_putc('S');  // spawn ok

                // 生成新的預覽方塊
                shape = shape_random();
                grid_block_spawn(&grid, &next_block, shape);

                // Game Over 檢查
                if (grid_block_collides(&grid, &current_block)) {
                    uart_puts("Game Over!\r\n");
                    game_state = GAME_OVER;
                }
            }
            last_drop_time = soft_tick;     // 重置下落計時
        }

        // 結束條件
        if (game_state == GAME_OVER) {
            break;
        }
    }
}
