/* Shape tables and random selection. */
#include "tetris.h"

const int8_t SHAPES[NUM_SHAPES][4][4][2] = {
    {
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
    },

    {
        {{0, 1}, {1, 1}, {2, 1}, {1, 0}},
        {{1, 0}, {1, 1}, {1, 2}, {0, 1}},
        {{0, 0}, {1, 0}, {2, 0}, {1, 1}},
        {{0, 0}, {0, 1}, {0, 2}, {1, 1}},
    },

    {
        {{0, 0}, {1, 0}, {2, 0}, {3, 0}},
        {{0, 0}, {0, 1}, {0, 2}, {0, 3}},
        {{0, 0}, {1, 0}, {2, 0}, {3, 0}},
        {{0, 0}, {0, 1}, {0, 2}, {0, 3}},
    },

    {
        {{0, 0}, {0, 1}, {1, 0}, {2, 0}},
        {{0, 0}, {1, 0}, {1, 1}, {1, 2}},
        {{0, 1}, {1, 1}, {2, 1}, {2, 0}},
        {{0, 0}, {0, 1}, {0, 2}, {1, 2}},
    },

    {
        {{0, 0}, {1, 0}, {2, 0}, {2, 1}},
        {{0, 2}, {1, 0}, {1, 1}, {1, 2}},
        {{0, 0}, {0, 1}, {1, 1}, {2, 1}},
        {{0, 0}, {0, 1}, {0, 2}, {1, 0}},
    },

    {
        {{0, 0}, {1, 0}, {1, 1}, {2, 1}},
        {{0, 1}, {0, 2}, {1, 0}, {1, 1}},
        {{0, 0}, {1, 0}, {1, 1}, {2, 1}},
        {{0, 1}, {0, 2}, {1, 0}, {1, 1}},
    },

    {
        {{0, 1}, {1, 1}, {1, 0}, {2, 0}},
        {{0, 0}, {0, 1}, {1, 1}, {1, 2}},
        {{0, 1}, {1, 1}, {1, 0}, {2, 0}},
        {{0, 0}, {0, 1}, {1, 1}, {1, 2}},
    },
};

static const uint8_t SHAPE_NUM_ROTATIONS[NUM_SHAPES] = {
    1,
    4,
    2,
    4,
    4,
    2,
    2,
};

static const uint8_t SHAPE_DIMENSIONS[NUM_SHAPES][4][2] = {
    {{2, 2}, {2, 2}, {2, 2}, {2, 2}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{4, 1}, {1, 4}, {4, 1}, {1, 4}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
};

static uint32_t rand_state = 12345;

uint32_t my_rand(void)
{
    rand_state ^= rand_state << 13;
    rand_state ^= rand_state >> 17;
    rand_state ^= rand_state << 5;
    return rand_state;
}

void my_srand(uint32_t seed)
{
    rand_state = seed ? seed : 12345;
}

static uint8_t bag[7];

static uint8_t bag_pos;

static void sb_putc(char c)
{
    volatile uint32_t *uart_status = (volatile uint32_t *)0x40000000;
    volatile uint32_t *uart_send = (volatile uint32_t *)0x40000010;
    while (!(*uart_status & 0x01)) ;
    *uart_send = (uint32_t)c;
}

static void shuffle_bag(void)
{
    for (int i = 0; i < 7; i++) {
        bag[i] = (uint8_t)i;
        sb_putc('.');
    }

    uint32_t rnd;
    uint8_t j, tmp;

    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 7);
    if (j != 6) { tmp = bag[6]; bag[6] = bag[j]; bag[j] = tmp; }

    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 6);
    if (j != 5) { tmp = bag[5]; bag[5] = bag[j]; bag[j] = tmp; }

    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 5);
    if (j != 4) { tmp = bag[4]; bag[4] = bag[j]; bag[j] = tmp; }

    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 4);
    if (j != 3) { tmp = bag[3]; bag[3] = bag[j]; bag[j] = tmp; }

    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 3);
    if (j != 2) { tmp = bag[2]; bag[2] = bag[j]; bag[j] = tmp; }

    rnd = my_rand(); sb_putc('*');
    j = (uint8_t)my_mod(rnd, 2);
    if (j != 1) { tmp = bag[1]; bag[1] = bag[j]; bag[j] = tmp; }

    bag_pos = 0;
}

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

void shape_get_cells(uint8_t shape, uint8_t rot, int8_t cells[4][2])
{
    if (shape >= NUM_SHAPES) {
        shape = 0;
    }
    rot = rot & 0x03;

    cells[0][0] = SHAPES[shape][rot][0][0];
    cells[0][1] = SHAPES[shape][rot][0][1];
    cells[1][0] = SHAPES[shape][rot][1][0];
    cells[1][1] = SHAPES[shape][rot][1][1];
    cells[2][0] = SHAPES[shape][rot][2][0];
    cells[2][1] = SHAPES[shape][rot][2][1];
    cells[3][0] = SHAPES[shape][rot][3][0];
    cells[3][1] = SHAPES[shape][rot][3][1];
}

uint8_t shape_get_width(uint8_t shape, uint8_t rot)
{
    if (shape >= NUM_SHAPES) {
        return 2;
    }
    return SHAPE_DIMENSIONS[shape][rot & 0x03][0];
}

uint8_t shape_get_height(uint8_t shape, uint8_t rot)
{
    if (shape >= NUM_SHAPES) {
        return 2;
    }
    return SHAPE_DIMENSIONS[shape][rot & 0x03][1];
}

uint8_t shape_num_rotations(uint8_t shape)
{
    if (shape >= NUM_SHAPES) {
        return 1;
    }
    return SHAPE_NUM_ROTATIONS[shape];
}

void shape_init(void)
{
    shuffle_bag();
}

uint8_t shape_random(void)
{
    if (bag_pos >= 7) {
        shuffle_bag();
    }

    return bag[bag_pos++];
}
