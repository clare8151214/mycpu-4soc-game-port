/**
 * tetris_draw.c - VGA 繪圖系統
 *
 * 實作俄羅斯方塊的所有視覺渲染功能：
 * - 軟體 framebuffer 管理
 * - 基本繪圖函式 (像素、矩形、文字)
 * - 遊戲元素繪製 (網格、方塊、預覽、分數)
 * - VGA 輸出和緩衝區交換
 */

#include "tetris.h"
#include "mmio.h"

/*============================================================================
 * VGA 狀態位元定義 (來自 VGA.scala)
 *============================================================================*/

/**
 * VGA_STAT_VBLANK: 垂直消隱期間標誌 (bit 0)
 * VGA_STAT_SAFE: 安全交換緩衝區的時機 (同 bit 0)
 *
 * 在垂直消隱期間更新畫面可以避免撕裂 (tearing)。
 */
#define VGA_STAT_VBLANK 0x01
#define VGA_STAT_SAFE   0x01

/*============================================================================
 * 軟體 Framebuffer
 *============================================================================*/

/**
 * framebuffer - 軟體畫面緩衝區
 *
 * 64x64 像素，每像素 1 byte (調色盤索引)。
 * 所有繪圖操作都先寫入這個緩衝區，
 * 然後在 draw_swap_buffers() 時上傳到 VGA 硬體。
 */
static uint8_t framebuffer[VGA_FRAME_SIZE];

/**
 * current_frame - 當前顯示的幀編號
 *
 * 用於雙緩衝，但目前實作只使用 frame 0。
 */
static uint8_t current_frame = 0;
static uint8_t debug_marker_y = 0;

/*============================================================================
 * 基本繪圖函式
 *============================================================================*/

/**
 * fb_clear - 清空 framebuffer
 *
 * 將整個緩衝區填充為黑色 (COLOR_BLACK = 0)。
 */
static void fb_clear(void)
{
    for (int i = 0; i < VGA_FRAME_SIZE; i++) {
        framebuffer[i] = COLOR_BLACK;
    }
}

/**
 * fb_pixel - 繪製單一像素
 *
 * @param x: X 座標 (0-63)
 * @param y: Y 座標 (0-63)
 * @param color: 顏色 (調色盤索引)
 *
 * 包含邊界檢查，超出範圍的座標會被忽略。
 */
static inline void fb_pixel(int x, int y, uint8_t color)
{
    if (x >= 0 && x < 64 && y >= 0 && y < 64) {
        framebuffer[y * 64 + x] = color;
    }
}

/**
 * fb_rect - 繪製填滿矩形
 *
 * @param x: 左上角 X 座標
 * @param y: 左上角 Y 座標
 * @param w: 寬度
 * @param h: 高度
 * @param color: 填充顏色
 */
static void fb_rect(int x, int y, int w, int h, uint8_t color)
{
    for (int dy = 0; dy < h; dy++) {
        for (int dx = 0; dx < w; dx++) {
            fb_pixel(x + dx, y + dy, color);
        }
    }
}

/**
 * fb_rect_outline - 繪製矩形外框
 *
 * @param x: 左上角 X 座標
 * @param y: 左上角 Y 座標
 * @param w: 寬度
 * @param h: 高度
 * @param color: 邊框顏色
 *
 * 只繪製矩形的四條邊，內部不填充。
 */
static void fb_rect_outline(int x, int y, int w, int h, uint8_t color)
{
    /* 上下兩條水平線 */
    for (int dx = 0; dx < w; dx++) {
        fb_pixel(x + dx, y, color);          /* 上邊 */
        fb_pixel(x + dx, y + h - 1, color);  /* 下邊 */
    }
    /* 左右兩條垂直線 */
    for (int dy = 0; dy < h; dy++) {
        fb_pixel(x, y + dy, color);          /* 左邊 */
        fb_pixel(x + w - 1, y + dy, color);  /* 右邊 */
    }
}

/*============================================================================
 * 數字字型和文字繪製
 *============================================================================*/

/**
 * DIGIT_FONT - 3x5 像素數字字型
 *
 * 每個數字用 5 個 3-bit 值表示，從上到下。
 * 例如 '0' 的字型：
 *   111  (0b111)
 *   101  (0b101)
 *   101  (0b101)
 *   101  (0b101)
 *   111  (0b111)
 */
static const uint8_t DIGIT_FONT[10][5] = {
    {0b111, 0b101, 0b101, 0b101, 0b111},  /* 0 */
    {0b010, 0b110, 0b010, 0b010, 0b111},  /* 1 */
    {0b111, 0b001, 0b111, 0b100, 0b111},  /* 2 */
    {0b111, 0b001, 0b111, 0b001, 0b111},  /* 3 */
    {0b101, 0b101, 0b111, 0b001, 0b001},  /* 4 */
    {0b111, 0b100, 0b111, 0b001, 0b111},  /* 5 */
    {0b111, 0b100, 0b111, 0b101, 0b111},  /* 6 */
    {0b111, 0b001, 0b001, 0b001, 0b001},  /* 7 */
    {0b111, 0b101, 0b111, 0b101, 0b111},  /* 8 */
    {0b111, 0b101, 0b111, 0b001, 0b111},  /* 9 */
};

/**
 * fb_digit - 繪製單一數字
 *
 * @param x: X 座標
 * @param y: Y 座標
 * @param digit: 數字 (0-9)
 * @param color: 顏色
 *
 * 數字大小為 3x5 像素。
 */
static void fb_digit(int x, int y, int digit, uint8_t color)
{
    if (digit < 0 || digit > 9) {
        return;
    }

    for (int row = 0; row < 5; row++) {
        uint8_t bits = DIGIT_FONT[digit][row];
        for (int col = 0; col < 3; col++) {
            /* 檢查該位置是否要畫點 */
            if (bits & (1 << (2 - col))) {
                fb_pixel(x + col, y + row, color);
            }
        }
    }
}

/**
 * fb_number - 繪製多位數數字
 *
 * @param x: X 座標
 * @param y: Y 座標
 * @param num: 要顯示的數字
 * @param color: 顏色
 *
 * 數字之間間隔 4 像素 (3 像素字寬 + 1 像素間距)。
 */
static void fb_number(int x, int y, uint32_t num, uint8_t color)
{
    int digits[10];  /* 儲存各位數 */
    int count = 0;

    /* 特殊處理 0 */
    if (num == 0) {
        fb_digit(x, y, 0, color);
        return;
    }

    /* 拆解數字的各位 (從低位到高位) */
    while (num > 0 && count < 10) {
        digits[count++] = num % 10;
        num /= 10;
    }

    /* 從高位到低位繪製 */
    for (int i = count - 1; i >= 0; i--) {
        fb_digit(x, y, digits[i], color);
        x += 4;  /* 移動到下一個數字位置 */
    }
}

/*============================================================================
 * VGA 初始化
 *============================================================================*/

/**
 * draw_init - 初始化 VGA 繪圖系統
 *
 * 設定調色盤顏色，清空 framebuffer，並上傳到 VGA。
 *
 * 調色盤格式：6-bit RRGGBB (每個顏色分量 2 bits)
 * 例如：0x3F = 111111 = 白色 (R=3, G=3, B=3)
 */
void draw_init(void)
{
    /* 設定調色盤顏色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_BLACK),  0x00);  /* 黑色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_CYAN),   0x2F);  /* 青色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_YELLOW), 0x3C);  /* 黃色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_PURPLE), 0x32);  /* 紫色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_GREEN),  0x0C);  /* 綠色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_RED),    0x30);  /* 紅色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_BLUE),   0x03);  /* 藍色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_ORANGE), 0x34);  /* 橘色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_GRAY),   0x15);  /* 灰色 */
    vga_write32(VGA_ADDR_PALETTE(COLOR_WHITE),  0x3F);  /* 白色 */

    /* 清空 framebuffer */
    fb_clear();

    /* 上傳到 VGA frame 0 */
    vga_write32(VGA_ADDR_UPLOAD_ADDR, 0);
    for (int i = 0; i < 512; i++) {
        /* 每次上傳 8 個像素 (打包成 32-bit) */
        vga_write32(VGA_ADDR_STREAM_DATA,
                    vga_pack8_pixels(&framebuffer[i * 8]));
    }

    /* 啟用顯示，使用 frame 0 */
    vga_write32(VGA_ADDR_CTRL, 0x01);
}

/*============================================================================
 * 畫面清除和邊框
 *============================================================================*/

/**
 * draw_clear - 清空畫面
 *
 * 在每幀開始時呼叫，將 framebuffer 填充為黑色。
 */
void draw_clear(void)
{
    fb_clear();
}

void draw_set_debug_marker(uint8_t y)
{
    debug_marker_y = y;
}

/**
 * draw_border - 繪製遊戲邊框
 *
 * 在網格外圍繪製紅色外框。
 */
void draw_border(void)
{
    /* 計算邊框位置 (比網格大 1 像素) */
    int gx = GRID_OFFSET_X - 1;
    int gy = GRID_OFFSET_Y - 1;
    int gw = GRID_WIDTH * BLOCK_SIZE + 2;
    int gh = GRID_HEIGHT * BLOCK_SIZE + 2;

    fb_rect_outline(gx, gy, gw, gh, COLOR_RED);
}

/*============================================================================
 * 遊戲元素繪製
 *============================================================================*/

/**
 * draw_grid - 繪製已固定在網格中的方塊
 *
 * @param g: 網格結構指標
 *
 * 遍歷網格中所有被佔用的格子，繪製對應顏色的方塊。
 * 座標轉換：遊戲座標 (y=0 在底部) → 螢幕座標 (y=0 在頂部)
 */
void draw_grid(const grid_t *g)
{
    for (int y = 0; y < g->height; y++) {
        for (int x = 0; x < g->width; x++) {
            /* 檢查該格子是否被佔用 */
            if (g->rows[y] & (1u << x)) {
                /* 計算螢幕座標 */
                int sx = GRID_OFFSET_X + x * BLOCK_SIZE;
                /* Y 軸翻轉：遊戲中 y=0 在底部，螢幕 y=0 在頂部 */
                int sy = GRID_OFFSET_Y + (g->height - 1 - y) * BLOCK_SIZE;

                fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, g->colors[y][x]);
            }
        }
    }
}

/**
 * draw_block - 繪製當前正在操控的方塊
 *
 * @param b: 方塊結構指標
 *
 * 取得方塊的 4 個格子座標，並繪製在對應位置。
 */
void draw_block(const block_t *b)
{
    int8_t cells[4][2];
    shape_get_cells(b->shape, b->rot, cells);

    for (int i = 0; i < MAX_BLOCK_LEN; i++) {
        int gx = b->x + cells[i][0];  /* 遊戲座標 */
        int gy = b->y + cells[i][1];

        /* 只繪製在可見範圍內的格子 */
        if (gx >= 0 && gx < GRID_WIDTH && gy >= 0 && gy < GRID_HEIGHT) {
            int sx = GRID_OFFSET_X + gx * BLOCK_SIZE;
            int sy = GRID_OFFSET_Y + (GRID_HEIGHT - 1 - gy) * BLOCK_SIZE;

            fb_rect(sx, sy, BLOCK_SIZE, BLOCK_SIZE, b->color);
        }
    }
}

/**
 * draw_ghost - 繪製落點預覽 (Ghost piece)
 *
 * @param g: 網格結構指標
 * @param b: 方塊結構指標
 *
 * Ghost piece 是方塊直接落下後會停留的位置預覽，
 * 用灰色外框表示，幫助玩家瞄準。
 */
void draw_ghost(const grid_t *g, const block_t *b)
{
    block_t ghost = *b;  /* 複製當前方塊 */

    /* 模擬下落：一直往下直到碰撞 */
    while (!grid_block_collides(g, &ghost)) {
        ghost.y--;
    }
    ghost.y++;  /* 回退到不碰撞的位置 */

    /* 如果 ghost 和原本位置相同，不需要繪製 */
    if (ghost.y == b->y) {
        return;
    }

    /* 繪製 ghost (灰色外框) */
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

/**
 * draw_preview - 繪製下一個方塊的預覽
 *
 * @param shape: 方塊形狀 (0-6)
 *
 * 在螢幕右側顯示下一個會出現的方塊。
 */
void draw_preview(uint8_t shape)
{
    int px = PREVIEW_X;
    int py = PREVIEW_Y;

    /* 清空預覽區域 */
    fb_rect(px, py, 12, 12, COLOR_BLACK);

    /* 取得形狀座標並繪製 */
    int8_t cells[4][2];
    shape_get_cells(shape, 0, cells);
    uint8_t color = SHAPE_COLORS[shape];

    for (int i = 0; i < MAX_BLOCK_LEN; i++) {
        /* 縮小顯示 (2x2 像素而非 3x3) */
        int sx = px + cells[i][0] * 3;
        int sy = py + (3 - cells[i][1]) * 3;  /* Y 軸翻轉 */

        fb_rect(sx, sy, 2, 2, color);
    }
}

/**
 * draw_score - 繪製分數、行數和等級
 *
 * @param score: 遊戲分數
 * @param lines: 消除的總行數
 * @param level: 目前等級
 *
 * 在螢幕右側顯示三行數字：
 *   第 1 行 (白色): 分數
 *   第 2 行 (青色): 行數
 *   第 3 行 (黃色): 等級
 */
void draw_score(uint32_t score, uint16_t lines, uint8_t level)
{
    int sx = SCORE_X;
    int sy = SCORE_Y;

    /* 清空分數區域 */
    fb_rect(sx, sy, 24, 18, COLOR_BLACK);

    /* 限制分數最大值 (6 位數) */
    if (score > 999999) {
        score = 999999;
    }

    /* 繪製三行數字 */
    fb_number(sx, sy,      score, COLOR_WHITE);   /* 分數 */
    fb_number(sx, sy + 6,  lines, COLOR_CYAN);    /* 行數 */
    fb_number(sx, sy + 12, level, COLOR_YELLOW);  /* 等級 */
}

/**
 * draw_game_over - 繪製 Game Over 畫面
 *
 * 在螢幕中央顯示一個帶有 X 標誌的框框。
 */
void draw_game_over(void)
{
    /* 繪製黑色背景和紅色邊框 */
    fb_rect(20, 25, 24, 14, COLOR_BLACK);
    fb_rect_outline(20, 25, 24, 14, COLOR_RED);

    /* 繪製 X 標誌 (兩條對角線) */
    for (int i = 0; i < 8; i++) {
        fb_pixel(26 + i, 28 + i, COLOR_RED);  /* 左上到右下 */
        fb_pixel(26 + i, 35 - i, COLOR_RED);  /* 左下到右上 */
    }
}

/*============================================================================
 * VGA 輸出
 *============================================================================*/

/**
 * draw_swap_buffers - 將 framebuffer 上傳到 VGA
 *
 * 這是每幀結束時呼叫的函式：
 * 1. 等待適當的時機 (延遲)
 * 2. 將軟體 framebuffer 上傳到 VGA 硬體
 * 3. 啟用顯示
 *
 * VGA 資料格式：每個 32-bit word 包含 8 個像素 (每像素 4-bit 調色盤索引)
 */
void draw_swap_buffers(void)
{
    /* 幀率控制延遲 */
    for (volatile int d = 0; d < 2000; d++) {
        __asm__ volatile("nop");
    }

    /* Debug marker: show current block Y as a single pixel */
    if (debug_marker_y < 64) {
        fb_pixel(0, debug_marker_y, COLOR_WHITE);
    }

    /* 上傳整個 framebuffer 到 VGA frame 0 */
    /* VGA_UPLOAD_ADDR 格式: [frame << 16] | [pixel_offset] */
    /* pixel_offset = word_index * 8 (每個 word 包含 8 個像素) */
    vga_write32(VGA_ADDR_UPLOAD_ADDR, 0);

    /* 64x64 = 4096 像素, 4096/8 = 512 個 32-bit words */
    for (int i = 0; i < 512; i++) {
        vga_write32(VGA_ADDR_STREAM_DATA,
                    vga_pack8_pixels(&framebuffer[i * 8]));
    }

    /* 等待垂直消隱 (已停用，可能造成問題) */
    /* while (!((*VGA_STATUS) & VGA_STAT_SAFE)); */

    /* 啟用顯示，使用 frame 0 */
    vga_write32(VGA_ADDR_CTRL, 0x01);
}
