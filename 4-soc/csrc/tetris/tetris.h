/**
 * tetris.h - 俄羅斯方塊遊戲標頭檔
 *
 * 定義遊戲的所有常數、資料結構和函式原型。
 * 這是整個俄羅斯方塊遊戲的核心介面定義。
 */

#ifndef TETRIS_H
#define TETRIS_H

#include <stdbool.h>
#include <stdint.h>

/*============================================================================
 * 遊戲場地配置
 *============================================================================*/

/**
 * 網格尺寸定義
 * - GRID_WIDTH: 網格寬度 (標準俄羅斯方塊為 10 格)
 * - GRID_HEIGHT: 網格高度 (18 格，比標準 20 格略小以適應 64x64 螢幕)
 * - BLOCK_SIZE: 每個方格在螢幕上的像素大小 (3x3 像素)
 */
#define GRID_WIDTH 10
#define GRID_HEIGHT 18
#define BLOCK_SIZE 3

/**
 * 網格在螢幕上的起始位置 (像素座標)
 * - GRID_OFFSET_X: 網格左邊界的 X 座標
 * - GRID_OFFSET_Y: 網格上邊界的 Y 座標
 */
#define GRID_OFFSET_X 2
#define GRID_OFFSET_Y 5

/**
 * 預覽區域位置 (顯示下一個方塊)
 */
#define PREVIEW_X 38
#define PREVIEW_Y 8

/**
 * 分數顯示區域位置
 */
#define SCORE_X 38
#define SCORE_Y 30

/*============================================================================
 * 方塊形狀常數
 *============================================================================*/

/**
 * NUM_SHAPES: 方塊種類數量 (O, T, I, J, L, S, Z 共 7 種)
 * MAX_BLOCK_LEN: 每個方塊由 4 個格子組成
 */
#define NUM_SHAPES 7
#define MAX_BLOCK_LEN 4

/*============================================================================
 * 調色盤顏色索引 (0-15)
 *
 * VGA 使用 4-bit 調色盤模式，這些是顏色索引值。
 * 實際的 6-bit RGB 顏色在 draw_init() 中設定。
 *============================================================================*/

/* 顏色定義 - 調色盤索引 */
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

/**
 * SHAPE_COLORS - 暫時全部用紅色，先處理其他問題
 */
static const uint8_t SHAPE_COLORS[NUM_SHAPES] = {
    COLOR_RED, COLOR_RED, COLOR_RED, COLOR_RED,
    COLOR_RED, COLOR_RED, COLOR_RED,
};

/*============================================================================
 * 列舉型別定義
 *============================================================================*/

/**
 * direction_t - 移動方向
 *
 * 用於 grid_block_move() 函式，指定方塊移動的方向。
 */
typedef enum {
    DIR_DOWN = 0,   /* 向下 (重力方向) */
    DIR_LEFT = 1,   /* 向左 */
    DIR_UP = 2,     /* 向上 (通常不用) */
    DIR_RIGHT = 3   /* 向右 */
} direction_t;

/**
 * game_state_t - 遊戲狀態
 *
 * 遊戲狀態機的三種狀態。
 */
typedef enum {
    GAME_PLAYING,   /* 遊戲進行中 */
    GAME_PAUSED,    /* 遊戲暫停 */
    GAME_OVER       /* 遊戲結束 */
} game_state_t;

/**
 * input_t - 輸入事件類型
 *
 * 玩家可能的輸入動作。
 */
typedef enum {
    INPUT_NONE,       /* 無輸入 */
    INPUT_LEFT,       /* 左移 */
    INPUT_RIGHT,      /* 右移 */
    INPUT_ROTATE,     /* 旋轉 */
    INPUT_SOFT_DROP,  /* 軟落 (加速下降) */
    INPUT_HARD_DROP,  /* 硬落 (直接落到底) */
    INPUT_PAUSE,      /* 暫停 */
    INPUT_QUIT        /* 結束遊戲 */
} input_t;

/*============================================================================
 * 資料結構定義
 *============================================================================*/

/**
 * row_t - 單一行的位元表示
 *
 * 使用 16-bit 整數，每個 bit 代表一格是否被佔用。
 * 支援最多 16 格寬的網格 (目前只用 10 格)。
 * 例如: 0b0000001111000000 表示中間 4 格被佔用。
 */
typedef uint16_t row_t;

/**
 * grid_t - 遊戲網格結構
 *
 * 儲存整個遊戲場地的狀態。
 */
typedef struct {
    row_t rows[GRID_HEIGHT];                /* 每行的佔用狀態 (位元陣列) */
    uint8_t colors[GRID_HEIGHT][GRID_WIDTH]; /* 每格的顏色 */
    int8_t relief[GRID_WIDTH];              /* 每列最高的方塊 Y 座標 (用於快速碰撞檢測) */
    uint8_t width;                          /* 網格寬度 */
    uint8_t height;                         /* 網格高度 */
    uint16_t lines_cleared;                 /* 已消除的總行數 */
    uint32_t score;                         /* 遊戲分數 */
    uint8_t level;                          /* 目前等級 (影響下落速度) */
} grid_t;

/**
 * block_t - 方塊結構
 *
 * 表示一個正在移動或已放置的俄羅斯方塊。
 */
typedef struct {
    int8_t x;       /* 方塊左下角的 X 座標 (網格座標) */
    int8_t y;       /* 方塊左下角的 Y 座標 (網格座標) */
    uint8_t shape;  /* 方塊形狀 (0-6: O, T, I, J, L, S, Z) */
    uint8_t rot;    /* 旋轉狀態 (0-3，某些形狀只有 1-2 種) */
    uint8_t color;  /* 方塊顏色 (調色盤索引) */
} block_t;

/*============================================================================
 * 網格操作 API (tetris_grid.c)
 *============================================================================*/

/** 初始化網格，重設所有狀態 */
void grid_init(grid_t *g);

/** 清空網格中的所有方塊 */
void grid_clear(grid_t *g);

/** 檢查指定格子是否被佔用 */
bool grid_cell_occupied(const grid_t *g, int x, int y);

/** 設定指定格子的顏色 (並標記為佔用) */
void grid_set_cell(grid_t *g, int x, int y, uint8_t color);

/** 清除指定格子 */
void grid_clear_cell(grid_t *g, int x, int y);

/** 檢查並消除已填滿的行，返回消除的行數 */
int grid_clear_lines(grid_t *g);

/** 檢查指定行是否已填滿 */
bool grid_row_full(const grid_t *g, int y);

/** 檢查方塊是否與網格或邊界碰撞 */
bool grid_block_collides(const grid_t *g, const block_t *b);

/** 將方塊固定到網格中 */
void grid_block_add(grid_t *g, const block_t *b);

/** 讓方塊直接落到底部，返回下落的格數 */
int grid_block_drop(const grid_t *g, block_t *b);

/** 嘗試移動方塊，成功返回 true */
bool grid_block_move(const grid_t *g, block_t *b, direction_t dir);

/** 嘗試旋轉方塊，成功返回 true (包含 wall kick 邏輯) */
bool grid_block_rotate(const grid_t *g, block_t *b, int amount);

/** 在網格頂部生成新方塊 */
void grid_block_spawn(const grid_t *g, block_t *b, uint8_t shape);

/*============================================================================
 * 形狀操作 API (tetris_shape.c)
 *============================================================================*/

/** 取得指定形狀和旋轉狀態的 4 個格子相對座標 */
void shape_get_cells(uint8_t shape, uint8_t rot, int8_t cells[4][2]);

/** 取得形狀的寬度 */
uint8_t shape_get_width(uint8_t shape, uint8_t rot);

/** 取得形狀的高度 */
uint8_t shape_get_height(uint8_t shape, uint8_t rot);

/** 取得形狀的旋轉狀態數量 */
uint8_t shape_num_rotations(uint8_t shape);

/** 初始化形狀系統，必須在 my_srand() 後呼叫 */
void shape_init(void);

/** 隨機取得下一個形狀 (使用 7-bag 演算法) */
uint8_t shape_random(void);

/*============================================================================
 * 繪圖 API (tetris_draw.c)
 *============================================================================*/

/** 初始化 VGA 繪圖系統，設定調色盤 */
void draw_init(void);

/** 繪製網格中已固定的方塊 */
void draw_grid(const grid_t *g);

/** 繪製當前正在操控的方塊 */
void draw_block(const block_t *b);

/** 繪製落點預覽 (Ghost piece) */
void draw_ghost(const grid_t *g, const block_t *b);

/** 繪製下一個方塊的預覽 */
void draw_preview(uint8_t shape);

/** 繪製分數、行數和等級 */
void draw_score(uint32_t score, uint16_t lines, uint8_t level);

/** 繪製遊戲邊框 */
void draw_border(void);

/** 繪製 Game Over 畫面 */
void draw_game_over(void);

/** 清空畫面緩衝區 */
void draw_clear(void);

/** 將畫面緩衝區輸出到 VGA */
void draw_swap_buffers(void);
void draw_set_debug_marker(uint8_t y);

/*============================================================================
 * 遊戲控制 API (tetris.c)
 *============================================================================*/

/** 輪詢使用者輸入 */
input_t input_poll(void);

/** 初始化遊戲 */
void game_init(void);

/** 遊戲主迴圈 */
void game_loop(void);

/** 更新遊戲邏輯 (每幀呼叫) */
void game_update(void);

/** 渲染遊戲畫面 (每幀呼叫) */
void game_render(void);

/*============================================================================
 * 執行時期輔助函式 (無 libc 環境)
 *============================================================================*/

/** 記憶體填充 (類似 memset) */
void *my_memset(void *s, int c, uint32_t n);

/** 記憶體複製 (類似 memcpy) */
void *my_memcpy(void *dest, const void *src, uint32_t n);

/** 產生隨機數 (Xorshift 演算法) */
uint32_t my_rand(void);

/** 設定隨機數種子 */
void my_srand(uint32_t seed);

/** 取得當前計時器數值 */
uint32_t get_tick(void);

/** 毫秒級延遲 */
void delay_ms(uint32_t ms);

/**
 * my_mod - 取模運算
 *
 * @param val: 被除數
 * @param divisor: 除數 (必須 > 0)
 * @return val % divisor
 *
 * 直接使用 % 運算子，編譯器會呼叫 libgcc 中的 __umodsi3。
 * libgcc 使用高效的二進制除法算法 (O(log n))。
 */
static inline uint32_t my_mod(uint32_t val, uint32_t divisor)
{
    return val % divisor;
}

/**
 * my_div - 整數除法
 *
 * @param val: 被除數
 * @param divisor: 除數 (必須 > 0)
 * @return val / divisor
 *
 * 直接使用 / 運算子，編譯器會呼叫 libgcc 中的 __udivsi3。
 */
static inline uint32_t my_div(uint32_t val, uint32_t divisor)
{
    return val / divisor;
}

#endif
