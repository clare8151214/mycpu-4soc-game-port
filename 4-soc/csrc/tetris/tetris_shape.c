/**
 * tetris_shape.c - 方塊形狀定義與操作
 *
 * 定義俄羅斯方塊的 7 種形狀 (O, T, I, J, L, S, Z) 及其旋轉狀態。
 * 實作 7-bag 隨機演算法，確保方塊分布均勻。
 */

#include "tetris.h"

/*============================================================================
 * 形狀資料表
 *============================================================================*/

/**
 * SHAPES - 所有形狀的格子座標定義
 *
 * 四維陣列: [形狀][旋轉狀態][格子編號][xy座標]
 * - 形狀: 0=O, 1=T, 2=I, 3=J, 4=L, 5=S, 6=Z
 * - 旋轉狀態: 0-3 (順時針旋轉)
 * - 格子編號: 0-3 (每個方塊由 4 個格子組成)
 * - xy座標: [0]=x, [1]=y (相對於方塊原點)
 *
 * 座標系統: 原點在左下角，x 向右增加，y 向上增加
 *
 * 形狀示意圖:
 *
 * O (黃色):    T (紫色):    I (青色):    J (藍色):
 *   ##           #            ####         #
 *   ##          ###                        ###
 *
 * L (橘色):    S (綠色):    Z (紅色):
 *     #          ##           ##
 *   ###         ##             ##
 */
/* 移除 static 使其可被其他模組訪問 */
const int8_t SHAPES[NUM_SHAPES][4][4][2] = {
    /* O - 方形，不旋轉 */
    {
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},  /* rot 0 */
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},  /* rot 1 (同 0) */
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},  /* rot 2 (同 0) */
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},  /* rot 3 (同 0) */
    },
    /* T - T 形 */
    {
        {{0, 1}, {1, 1}, {2, 1}, {1, 0}},  /* rot 0: 凸朝下 */
        {{1, 0}, {1, 1}, {1, 2}, {0, 1}},  /* rot 1: 凸朝右 */
        {{0, 0}, {1, 0}, {2, 0}, {1, 1}},  /* rot 2: 凸朝上 */
        {{0, 0}, {0, 1}, {0, 2}, {1, 1}},  /* rot 3: 凸朝左 */
    },
    /* I - 長條形 */
    {
        {{0, 0}, {1, 0}, {2, 0}, {3, 0}},  /* rot 0: 水平 */
        {{0, 0}, {0, 1}, {0, 2}, {0, 3}},  /* rot 1: 垂直 */
        {{0, 0}, {1, 0}, {2, 0}, {3, 0}},  /* rot 2: 水平 (同 0) */
        {{0, 0}, {0, 1}, {0, 2}, {0, 3}},  /* rot 3: 垂直 (同 1) */
    },
    /* J - J 形 */
    {
        {{0, 0}, {0, 1}, {1, 0}, {2, 0}},  /* rot 0 */
        {{0, 0}, {1, 0}, {1, 1}, {1, 2}},  /* rot 1 */
        {{0, 1}, {1, 1}, {2, 1}, {2, 0}},  /* rot 2 */
        {{0, 0}, {0, 1}, {0, 2}, {1, 2}},  /* rot 3 */
    },
    /* L - L 形 */
    {
        {{0, 0}, {1, 0}, {2, 0}, {2, 1}},  /* rot 0 */
        {{0, 2}, {1, 0}, {1, 1}, {1, 2}},  /* rot 1 */
        {{0, 0}, {0, 1}, {1, 1}, {2, 1}},  /* rot 2 */
        {{0, 0}, {0, 1}, {0, 2}, {1, 0}},  /* rot 3 */
    },
    /* S - S 形 */
    {
        {{0, 0}, {1, 0}, {1, 1}, {2, 1}},  /* rot 0: 水平 */
        {{0, 1}, {0, 2}, {1, 0}, {1, 1}},  /* rot 1: 垂直 */
        {{0, 0}, {1, 0}, {1, 1}, {2, 1}},  /* rot 2: 水平 (同 0) */
        {{0, 1}, {0, 2}, {1, 0}, {1, 1}},  /* rot 3: 垂直 (同 1) */
    },
    /* Z - Z 形 */
    {
        {{0, 1}, {1, 1}, {1, 0}, {2, 0}},  /* rot 0: 水平 */
        {{0, 0}, {0, 1}, {1, 1}, {1, 2}},  /* rot 1: 垂直 */
        {{0, 1}, {1, 1}, {1, 0}, {2, 0}},  /* rot 2: 水平 (同 0) */
        {{0, 0}, {0, 1}, {1, 1}, {1, 2}},  /* rot 3: 垂直 (同 1) */
    },
};

/**
 * SHAPE_NUM_ROTATIONS - 每種形狀的旋轉狀態數量
 *
 * - O: 1 種 (不旋轉)
 * - I, S, Z: 2 種 (水平/垂直)
 * - T, J, L: 4 種
 */
static const uint8_t SHAPE_NUM_ROTATIONS[NUM_SHAPES] = {
    1,  /* O */
    4,  /* T */
    2,  /* I */
    4,  /* J */
    4,  /* L */
    2,  /* S */
    2,  /* Z */
};

/**
 * SHAPE_DIMENSIONS - 每種形狀在每種旋轉狀態下的寬高
 *
 * [形狀][旋轉狀態][0=寬度, 1=高度]
 */
static const uint8_t SHAPE_DIMENSIONS[NUM_SHAPES][4][2] = {
    {{2, 2}, {2, 2}, {2, 2}, {2, 2}},  /* O: 永遠 2x2 */
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},  /* T: 水平 3x2, 垂直 2x3 */
    {{4, 1}, {1, 4}, {4, 1}, {1, 4}},  /* I: 水平 4x1, 垂直 1x4 */
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},  /* J: 水平 3x2, 垂直 2x3 */
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},  /* L: 水平 3x2, 垂直 2x3 */
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},  /* S: 水平 3x2, 垂直 2x3 */
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},  /* Z: 水平 3x2, 垂直 2x3 */
};

/*============================================================================
 * 隨機數產生器 (Xorshift 演算法)
 *============================================================================*/

/**
 * rand_state - 隨機數產生器的內部狀態
 */
static uint32_t rand_state = 12345;

/**
 * my_rand - 產生隨機數
 *
 * @return 32-bit 隨機數
 *
 * 使用 Xorshift 演算法，這是一種快速且品質不錯的偽隨機數產生器。
 * 適合嵌入式系統，不需要浮點運算。
 */
uint32_t my_rand(void)
{
    rand_state ^= rand_state << 13;  /* 左移並 XOR */
    rand_state ^= rand_state >> 17;  /* 右移並 XOR */
    rand_state ^= rand_state << 5;   /* 左移並 XOR */
    return rand_state;
}

/**
 * my_srand - 設定隨機數種子
 *
 * @param seed: 隨機數種子，0 會被替換成預設值
 */
void my_srand(uint32_t seed)
{
    rand_state = seed ? seed : 12345;
}

/*============================================================================
 * 7-Bag 隨機演算法
 *
 * 標準俄羅斯方塊使用的方塊生成方式：
 * 1. 將 7 種方塊放入「袋子」
 * 2. 隨機打亂順序
 * 3. 依序取出，取完後重新打亂
 *
 * 優點：確保每 7 個方塊中，每種都會出現一次，
 *       避免連續出現同一種或長時間不出現某種。
 *============================================================================*/

/** bag - 7-bag 袋子，存放 0-6 的形狀索引 */
static uint8_t bag[7];

/** bag_pos - 目前取到袋子中的第幾個，0-6 有效，其他值表示需要重新打亂 */
static uint8_t bag_pos;

/* my_mod 函式已移至 tetris.h 作為 inline 函式 */

/**
 * shuffle_bag - 打亂袋子中的方塊順序
 *
 * 使用 Fisher-Yates 洗牌演算法，確保每種排列出現機率相等。
 */
/* 內部 UART 輸出 */
static void sb_putc(char c)
{
    volatile uint32_t *uart_status = (volatile uint32_t *)0x40000000;
    volatile uint32_t *uart_send = (volatile uint32_t *)0x40000010;
    while (!(*uart_status & 0x01)) ;
    *uart_send = (uint32_t)c;
}

static void shuffle_bag(void)
{
    /* 初始化袋子：0, 1, 2, 3, 4, 5, 6 */
    for (int i = 0; i < 7; i++) {
        bag[i] = (uint8_t)i;
        sb_putc('.');  /* 同步點 - 必要，避免 CPU 掛起 */
    }

    /* Fisher-Yates 洗牌：手動展開循環避免 CPU/編譯器問題 */
    uint32_t rnd;
    uint8_t j, tmp;

    /* i=6: swap with random 0-6 */
    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 7);
    if (j != 6) { tmp = bag[6]; bag[6] = bag[j]; bag[j] = tmp; }

    /* i=5: swap with random 0-5 */
    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 6);
    if (j != 5) { tmp = bag[5]; bag[5] = bag[j]; bag[j] = tmp; }

    /* i=4: swap with random 0-4 */
    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 5);
    if (j != 4) { tmp = bag[4]; bag[4] = bag[j]; bag[j] = tmp; }

    /* i=3: swap with random 0-3 */
    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 4);
    if (j != 3) { tmp = bag[3]; bag[3] = bag[j]; bag[j] = tmp; }

    /* i=2: swap with random 0-2 */
    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 3);
    if (j != 2) { tmp = bag[2]; bag[2] = bag[j]; bag[j] = tmp; }

    /* i=1: swap with random 0-1 */
    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 2);
    if (j != 1) { tmp = bag[1]; bag[1] = bag[j]; bag[j] = tmp; }

    bag_pos = 0;
}

/*============================================================================
 * 形狀查詢函式
 *============================================================================*/

/* Debug helper for shape_get_cells */
static void sgc_putc(char c)
{
    volatile uint32_t *uart_status = (volatile uint32_t *)0x40000000;
    volatile uint32_t *uart_send = (volatile uint32_t *)0x40000010;
    while (!(*uart_status & 0x01)) ;
    *uart_send = (uint32_t)c;
}

static void sgc_put_int(int v)
{
    char buf[12];
    int i = 0;
    int neg = 0;
    if (v < 0) { neg = 1; v = -v; }
    if (v == 0) { sgc_putc('0'); return; }
    while (v > 0) { buf[i++] = '0' + (v % 10); v = v / 10; }
    if (neg) sgc_putc('-');
    while (i > 0) sgc_putc(buf[--i]);
}

/**
 * shape_get_cells - 取得形狀的 4 個格子座標
 *
 * @param shape: 形狀索引 (0-6)
 * @param rot: 旋轉狀態 (0-3)
 * @param cells: 輸出陣列，[4][2] 格式，每個元素是 [x, y] 座標
 *
 * 座標是相對於方塊原點的偏移量。
 */
void shape_get_cells(uint8_t shape, uint8_t rot, int8_t cells[4][2])
{
    /* 防止越界 */
    if (shape >= NUM_SHAPES) {
        shape = 0;
    }
    rot = rot & 0x03;  /* 等效於 rot % 4，但更快 */

    /* 複製座標資料 - 不要用迴圈，手動展開以避免編譯器優化問題 */
    cells[0][0] = SHAPES[shape][rot][0][0];
    cells[0][1] = SHAPES[shape][rot][0][1];
    cells[1][0] = SHAPES[shape][rot][1][0];
    cells[1][1] = SHAPES[shape][rot][1][1];
    cells[2][0] = SHAPES[shape][rot][2][0];
    cells[2][1] = SHAPES[shape][rot][2][1];
    cells[3][0] = SHAPES[shape][rot][3][0];
    cells[3][1] = SHAPES[shape][rot][3][1];
}

/**
 * shape_get_width - 取得形狀的寬度
 *
 * @param shape: 形狀索引
 * @param rot: 旋轉狀態
 * @return 寬度 (格數)
 */
uint8_t shape_get_width(uint8_t shape, uint8_t rot)
{
    if (shape >= NUM_SHAPES) {
        return 2;  /* 預設值 */
    }
    return SHAPE_DIMENSIONS[shape][rot & 0x03][0];
}

/**
 * shape_get_height - 取得形狀的高度
 *
 * @param shape: 形狀索引
 * @param rot: 旋轉狀態
 * @return 高度 (格數)
 */
uint8_t shape_get_height(uint8_t shape, uint8_t rot)
{
    if (shape >= NUM_SHAPES) {
        return 2;  /* 預設值 */
    }
    return SHAPE_DIMENSIONS[shape][rot & 0x03][1];
}

/**
 * shape_num_rotations - 取得形狀的旋轉狀態數量
 *
 * @param shape: 形狀索引
 * @return 旋轉狀態數量 (1, 2 或 4)
 */
uint8_t shape_num_rotations(uint8_t shape)
{
    if (shape >= NUM_SHAPES) {
        return 1;
    }
    return SHAPE_NUM_ROTATIONS[shape];
}

/**
 * shape_random - 隨機取得下一個形狀
 *
 * @return 形狀索引 (0-6)
 *
 * 使用 7-bag 演算法：袋子空了就重新打亂。
 */
/**
 * shape_init - 初始化形狀系統
 *
 * 必須在 my_srand() 之後、shape_random() 之前呼叫。
 */
void shape_init(void)
{
    shuffle_bag();  /* 初始化並洗牌 */
}

uint8_t shape_random(void)
{
    /* 袋子空了，重新打亂 */
    if (bag_pos >= 7) {
        shuffle_bag();
    }

    /* 取出並返回下一個形狀 */
    return bag[bag_pos++];
}
