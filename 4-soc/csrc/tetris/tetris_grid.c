/**
 * tetris_grid.c - 遊戲網格操作
 *
 * 實作俄羅斯方塊的遊戲場地邏輯：
 * - 網格的初始化和清除
 * - 格子的佔用檢測和設定
 * - 行消除和計分
 * - 方塊的碰撞檢測、移動、旋轉和放置
 */

#include "tetris.h"
#include "mmio.h"

static inline void uart_try_putc(char c)
{
    if (*UART_STATUS & 0x01) {
        *UART_SEND = c;
    }
}

/*============================================================================
 * 記憶體操作輔助函式 (無 libc 環境)
 *============================================================================*/

/**
 * my_memset - 記憶體填充
 *
 * @param s: 目標記憶體起始位址
 * @param c: 要填充的值 (只使用低 8 bits)
 * @param n: 要填充的位元組數
 * @return 目標記憶體起始位址
 *
 * 類似標準庫的 memset()，用於初始化記憶體。
 */
void *my_memset(void *s, int c, uint32_t n)
{
    uint8_t *p = (uint8_t *)s;
    while (n--) {
        *p++ = (uint8_t)c;
    }
    return s;
}

/**
 * my_memcpy - 記憶體複製
 *
 * @param dest: 目標記憶體
 * @param src: 來源記憶體
 * @param n: 要複製的位元組數
 * @return 目標記憶體起始位址
 *
 * 類似標準庫的 memcpy()，用於複製資料。
 */
void *my_memcpy(void *dest, const void *src, uint32_t n)
{
    uint8_t *d = (uint8_t *)dest;
    const uint8_t *s = (const uint8_t *)src;
    while (n--) {
        *d++ = *s++;
    }
    return dest;
}

/*============================================================================
 * 網格初始化
 *============================================================================*/

/**
 * grid_init - 初始化遊戲網格
 *
 * @param g: 網格結構指標
 *
 * 設定網格的基本參數並清空所有格子。
 * 這個函式應該在遊戲開始時呼叫。
 */
void grid_init(grid_t *g)
{
    g->width = GRID_WIDTH;    /* 10 格寬 */
    g->height = GRID_HEIGHT;  /* 18 格高 */
    g->lines_cleared = 0;     /* 消除行數歸零 */
    g->score = 0;             /* 分數歸零 */
    g->level = 1;             /* 等級從 1 開始 */
    grid_clear(g);            /* 清空所有格子 */
}

/**
 * grid_clear - 清空網格
 *
 * @param g: 網格結構指標
 *
 * 將所有格子設為空，顏色設為黑色，relief 設為 -1。
 */
void grid_clear(grid_t *g)
{
    /* 清空每一行 */
    for (int y = 0; y < GRID_HEIGHT; y++) {
        g->rows[y] = 0;  /* 位元陣列全部歸零 */
        for (int x = 0; x < GRID_WIDTH; x++) {
            g->colors[y][x] = COLOR_BLACK;  /* 顏色設為黑色 */
        }
    }

    /* 重設 relief (每列最高方塊的 Y 座標) */
    for (int x = 0; x < GRID_WIDTH; x++) {
        g->relief[x] = -1;  /* -1 表示該列沒有方塊 */
    }
}

/*============================================================================
 * 格子操作
 *============================================================================*/

/**
 * grid_cell_occupied - 檢查格子是否被佔用
 *
 * @param g: 網格結構指標
 * @param x: X 座標
 * @param y: Y 座標
 * @return true 如果格子被佔用或超出邊界
 *
 * 邊界外的座標視為「已佔用」，這簡化了碰撞檢測的邏輯。
 */
bool grid_cell_occupied(const grid_t *g, int x, int y)
{
    /* 超出邊界視為已佔用 */
    if (x < 0 || x >= GRID_WIDTH || y < 0 || y >= GRID_HEIGHT) {
        return true;
    }
    /* 檢查該位置的 bit 是否被設定 */
    return (g->rows[y] & (1u << x)) != 0;
}

/**
 * grid_set_cell - 設定格子為佔用狀態
 *
 * @param g: 網格結構指標
 * @param x: X 座標
 * @param y: Y 座標
 * @param color: 格子顏色
 *
 * 設定指定格子的顏色並標記為佔用。
 * 同時更新 relief 陣列 (如果這是該列最高的方塊)。
 */
void grid_set_cell(grid_t *g, int x, int y, uint8_t color)
{
    /* 邊界檢查 */
    if (x < 0 || x >= GRID_WIDTH || y < 0 || y >= GRID_HEIGHT) {
        return;
    }

    g->rows[y] |= (1u << x);      /* 設定對應的 bit */
    g->colors[y][x] = color;      /* 設定顏色 */

    /* 更新 relief：如果這是該列最高的方塊 */
    if (y > g->relief[x]) {
        g->relief[x] = y;
    }
}

/**
 * grid_clear_cell - 清除格子
 *
 * @param g: 網格結構指標
 * @param x: X 座標
 * @param y: Y 座標
 *
 * 將指定格子設為空。
 * 注意：這不會更新 relief，如果需要準確的 relief 應該呼叫 recalc_relief()。
 */
void grid_clear_cell(grid_t *g, int x, int y)
{
    if (x < 0 || x >= GRID_WIDTH || y < 0 || y >= GRID_HEIGHT) {
        return;
    }
    g->rows[y] &= ~(1u << x);     /* 清除對應的 bit */
    g->colors[y][x] = COLOR_BLACK; /* 顏色設為黑色 */
}

/*============================================================================
 * 行消除系統
 *============================================================================*/

/**
 * grid_row_full - 檢查某行是否已填滿
 *
 * @param g: 網格結構指標
 * @param y: 行號 (0 是底部)
 * @return true 如果該行所有格子都被佔用
 */
bool grid_row_full(const grid_t *g, int y)
{
    if (y < 0 || y >= GRID_HEIGHT) {
        return false;
    }

    /* 建立一個所有位都是 1 的遮罩 (根據網格寬度) */
    uint16_t full_mask = (1u << GRID_WIDTH) - 1;  /* 例如 10 格寬 = 0b1111111111 */

    /* 檢查該行是否所有位都被設定 */
    return (g->rows[y] & full_mask) == full_mask;
}

/**
 * remove_row - 移除指定行
 *
 * @param g: 網格結構指標
 * @param row: 要移除的行號
 *
 * 將指定行以上的所有行往下移一格，頂部補空行。
 * 這是消行動畫的核心邏輯。
 */
static void remove_row(grid_t *g, int row)
{
    /* 從被刪除的行開始，每行的資料來自上一行 */
    for (int y = row; y < GRID_HEIGHT - 1; y++) {
        g->rows[y] = g->rows[y + 1];  /* 位元陣列下移 */
        for (int x = 0; x < GRID_WIDTH; x++) {
            g->colors[y][x] = g->colors[y + 1][x];  /* 顏色下移 */
        }
    }

    /* 頂部新增空行 */
    g->rows[GRID_HEIGHT - 1] = 0;
    for (int x = 0; x < GRID_WIDTH; x++) {
        g->colors[GRID_HEIGHT - 1][x] = COLOR_BLACK;
    }
}

/**
 * recalc_relief - 重新計算 relief 陣列
 *
 * @param g: 網格結構指標
 *
 * 在消行後，需要重新計算每列最高方塊的位置。
 * 這是一個 O(width * height) 的操作。
 */
static void recalc_relief(grid_t *g)
{
    for (int x = 0; x < GRID_WIDTH; x++) {
        g->relief[x] = -1;  /* 預設沒有方塊 */
        /* 從上往下找第一個有方塊的位置 */
        for (int y = GRID_HEIGHT - 1; y >= 0; y--) {
            if (g->rows[y] & (1u << x)) {
                g->relief[x] = y;
                break;
            }
        }
    }
}

/**
 * grid_clear_lines - 消除已填滿的行並計分
 *
 * @param g: 網格結構指標
 * @return 消除的行數 (0-4)
 *
 * 這是俄羅斯方塊的核心機制之一：
 * 1. 從底部開始掃描每一行
 * 2. 發現填滿的行就移除它
 * 3. 根據消除的行數計分
 * 4. 更新等級 (每 10 行升一級)
 *
 * 計分方式 (經典規則):
 *   1 行: 40 * level
 *   2 行: 100 * level
 *   3 行: 300 * level
 *   4 行 (Tetris): 1200 * level
 */
int grid_clear_lines(grid_t *g)
{
    int cleared = 0;
    int y = 0;

    /* 從底部往上掃描 */
    while (y < GRID_HEIGHT) {
        if (grid_row_full(g, y)) {
            remove_row(g, y);
            cleared++;
            /* 不增加 y，因為上面的行已經下移了 */
        } else {
            y++;
        }
    }

    /* 有消行才更新分數 */
    if (cleared > 0) {
        /* 計分表 */
        static const uint16_t SCORE_TABLE[5] = {0, 40, 100, 300, 1200};

        g->lines_cleared += cleared;  /* 累計消除行數 */

        /* 防止越界 (最多 4 行) */
        if (cleared > 4) {
            cleared = 4;
        }
        g->score += SCORE_TABLE[cleared] * g->level;  /* 計分 */

        /* 更新等級：每 10 行升一級，最高 20 級 */
        g->level = 1 + (g->lines_cleared / 10);
        if (g->level > 20) {
            g->level = 20;
        }

        recalc_relief(g);  /* 重新計算 relief */
    }

    return cleared;
}

/*============================================================================
 * 方塊碰撞檢測
 *============================================================================*/

/* 直接訪問 SHAPES 表格 */
extern const int8_t SHAPES[7][4][4][2];

/**
 * grid_block_collides - 檢查方塊是否發生碰撞
 *
 * @param g: 網格結構指標
 * @param b: 方塊結構指標
 * @return true 如果方塊與網格或邊界發生碰撞
 *
 * 碰撞條件：
 * 1. 方塊的任何部分超出左邊界 (x < 0)
 * 2. 方塊的任何部分超出右邊界 (x >= width)
 * 3. 方塊的任何部分超出下邊界 (y < 0)
 * 4. 方塊的任何部分與已放置的方塊重疊
 *
 * 注意：超出上邊界 (y >= height) 不算碰撞，這允許方塊從上方進入。
 */
/* 檢查單個格子是否碰撞 */
static inline bool check_cell_collision(const grid_t *g, int gx, int gy)
{
    /* 檢查左、右、下邊界 */
    if (gx < 0 || gx >= GRID_WIDTH || gy < 0) {
        return true;
    }
    /* 超出上邊界不算碰撞 */
    if (gy >= GRID_HEIGHT) {
        return false;
    }
    /* 檢查是否與已放置的方塊重疊 */
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

    /* 直接從 SHAPES 讀取座標 */
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

/*============================================================================
 * 方塊操作
 *============================================================================*/

/**
 * grid_block_add - 將方塊固定到網格中
 *
 * @param g: 網格結構指標
 * @param b: 方塊結構指標
 *
 * 當方塊落到底部或碰到其他方塊時，呼叫此函式將方塊「凍結」到網格中。
 */
/* UART debug helpers for grid_block_add */
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

    /* 處理 0 的特殊情況 */
    if (v == 0) {
        gba_putc('0');
        return;
    }

    /* 反向填充數字 */
    while (v > 0) {
        buf[i++] = '0' + (v % 10);
        v = v / 10;
    }

    if (neg) {
        gba_putc('-');
    }

    /* 反向輸出 */
    while (i > 0) {
        gba_putc(buf[--i]);
    }
}

void grid_block_add(grid_t *g, const block_t *b)
{
    uint8_t shape = b->shape;
    uint8_t rot = b->rot & 0x03;
    if (shape >= 7) shape = 0;

    /* 直接從 SHAPES 讀取座標並計算絕對位置 */
    int gx0 = b->x + SHAPES[shape][rot][0][0];
    int gy0 = b->y + SHAPES[shape][rot][0][1];
    int gx1 = b->x + SHAPES[shape][rot][1][0];
    int gy1 = b->y + SHAPES[shape][rot][1][1];
    int gx2 = b->x + SHAPES[shape][rot][2][0];
    int gy2 = b->y + SHAPES[shape][rot][2][1];
    int gx3 = b->x + SHAPES[shape][rot][3][0];
    int gy3 = b->y + SHAPES[shape][rot][3][1];

    /* 設定格子 */
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

/**
 * grid_block_drop - 硬落：讓方塊直接落到底部
 *
 * @param g: 網格結構指標
 * @param b: 方塊結構指標 (會被修改)
 * @return 下落的格數
 *
 * 不斷嘗試往下移動，直到發生碰撞為止。
 * 返回的格數可用於計分 (硬落每格 +2 分)。
 */
int grid_block_drop(const grid_t *g, block_t *b)
{
    int drop_amount = 0;

    while (true) {
        b->y--;  /* 嘗試下移一格 */
        if (grid_block_collides(g, b)) {
            b->y++;  /* 碰撞了，回退 */
            break;
        }
        drop_amount++;  /* 成功下移一格 */
    }

    return drop_amount;
}

/**
 * grid_block_move - 移動方塊
 *
 * @param g: 網格結構指標
 * @param b: 方塊結構指標 (會被修改)
 * @param dir: 移動方向
 * @return true 如果移動成功，false 如果發生碰撞
 *
 * 嘗試將方塊往指定方向移動一格，如果會碰撞則取消移動。
 */
bool grid_block_move(const grid_t *g, block_t *b, direction_t dir)
{
    int old_x = b->x;
    int old_y = b->y;

    /* 根據方向調整座標 */
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

    /* 檢查碰撞 */
    if (grid_block_collides(g, b)) {
        b->x = old_x;  /* 碰撞了，恢復原位 */
        b->y = old_y;
        return false;
    }

    return true;
}

/**
 * grid_block_rotate - 旋轉方塊
 *
 * @param g: 網格結構指標
 * @param b: 方塊結構指標 (會被修改)
 * @param amount: 旋轉量 (正數為順時針)
 * @return true 如果旋轉成功
 *
 * 實作簡易的 Wall Kick：
 * 如果旋轉後會碰撞，嘗試左移或右移一格來避免碰撞。
 * 這讓玩家可以在靠牆時也能旋轉方塊。
 */
bool grid_block_rotate(const grid_t *g, block_t *b, int amount)
{
    uint8_t old_rot = b->rot;
    uint8_t num_rots = shape_num_rotations(b->shape);

    /* 計算新的旋轉狀態 */
    b->rot = (uint8_t)my_mod((uint32_t)(b->rot + amount + num_rots), (uint32_t)num_rots);

    /* 檢查旋轉後是否碰撞 */
    if (grid_block_collides(g, b)) {
        /* 嘗試左移一格 (Wall Kick) */
        b->x--;
        if (!grid_block_collides(g, b)) {
            return true;  /* 左移成功 */
        }

        /* 嘗試右移一格 */
        b->x += 2;
        if (!grid_block_collides(g, b)) {
            return true;  /* 右移成功 */
        }

        /* Wall Kick 失敗，恢復原狀 */
        b->x--;
        b->rot = old_rot;
        return false;
    }

    return true;
}

/**
 * grid_block_spawn - 在網格頂部生成新方塊
 *
 * @param g: 網格結構指標
 * @param b: 方塊結構指標 (會被設定)
 * @param shape: 方塊形狀 (0-6)
 *
 * 新方塊出現在網格頂部中央位置。
 * 如果出生位置已經有方塊，表示 Game Over (需要在外部檢查)。
 */
void grid_block_spawn(const grid_t *g, block_t *b, uint8_t shape)
{
    b->shape = shape;
    b->rot = 0;                         /* 初始旋轉狀態 */
    b->color = SHAPE_COLORS[shape];     /* 根據形狀設定顏色 */

    /* 水平置中 */
    uint8_t width = shape_get_width(shape, 0);
    b->x = (GRID_WIDTH - width) / 2;

    /* 垂直位置：讓方塊剛好在網格頂部 */
    b->y = GRID_HEIGHT - shape_get_height(shape, 0);
}
