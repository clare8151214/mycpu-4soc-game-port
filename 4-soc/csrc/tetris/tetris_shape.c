#include "tetris.h"

// Shape cells for each rotation: [shape][rotation][block][xy].
static const int8_t SHAPES[NUM_SHAPES][4][4][2] = {
    // O
    {
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
        {{0, 0}, {1, 0}, {0, 1}, {1, 1}},
    },
    // T
    {
        {{0, 1}, {1, 1}, {2, 1}, {1, 0}},
        {{1, 0}, {1, 1}, {1, 2}, {0, 1}},
        {{0, 0}, {1, 0}, {2, 0}, {1, 1}},
        {{0, 0}, {0, 1}, {0, 2}, {1, 1}},
    },
    // I
    {
        {{0, 0}, {1, 0}, {2, 0}, {3, 0}},
        {{0, 0}, {0, 1}, {0, 2}, {0, 3}},
        {{0, 0}, {1, 0}, {2, 0}, {3, 0}},
        {{0, 0}, {0, 1}, {0, 2}, {0, 3}},
    },
    // J
    {
        {{0, 0}, {0, 1}, {1, 0}, {2, 0}},
        {{0, 0}, {1, 0}, {1, 1}, {1, 2}},
        {{0, 1}, {1, 1}, {2, 1}, {2, 0}},
        {{0, 0}, {0, 1}, {0, 2}, {1, 2}},
    },
    // L
    {
        {{0, 0}, {1, 0}, {2, 0}, {2, 1}},
        {{0, 2}, {1, 0}, {1, 1}, {1, 2}},
        {{0, 0}, {0, 1}, {1, 1}, {2, 1}},
        {{0, 0}, {0, 1}, {0, 2}, {1, 0}},
    },
    // S
    {
        {{0, 0}, {1, 0}, {1, 1}, {2, 1}},
        {{0, 1}, {0, 2}, {1, 0}, {1, 1}},
        {{0, 0}, {1, 0}, {1, 1}, {2, 1}},
        {{0, 1}, {0, 2}, {1, 0}, {1, 1}},
    },
    // Z
    {
        {{0, 1}, {1, 1}, {1, 0}, {2, 0}},
        {{0, 0}, {0, 1}, {1, 1}, {1, 2}},
        {{0, 1}, {1, 1}, {1, 0}, {2, 0}},
        {{0, 0}, {0, 1}, {1, 1}, {1, 2}},
    },
};

// Rotation counts per shape (O=1, I/S/Z=2, others=4).
static const uint8_t SHAPE_NUM_ROTATIONS[NUM_SHAPES] = {
    1,
    4,
    2,
    4,
    4,
    2,
    2,
};

// Width/height per shape per rotation.
static const uint8_t SHAPE_DIMENSIONS[NUM_SHAPES][4][2] = {
    {{2, 2}, {2, 2}, {2, 2}, {2, 2}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{4, 1}, {1, 4}, {4, 1}, {1, 4}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
    {{3, 2}, {2, 3}, {3, 2}, {2, 3}},
};

// Xorshift RNG for shape selection.
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

// 7-bag randomizer (standard Tetris distribution).
static uint8_t bag[7];
static uint8_t bag_pos = 7;

static void shuffle_bag(void)
{
    for (int i = 0; i < 7; i++) {
        bag[i] = i;
    }

    for (int i = 6; i > 0; i--) {
        uint8_t j = my_rand() % (i + 1);
        if (i != j) {
            uint8_t tmp = bag[i];
            bag[i] = bag[j];
            bag[j] = tmp;
        }
    }

    bag_pos = 0;
}

void shape_get_cells(uint8_t shape, uint8_t rot, int8_t cells[4][2])
{
    if (shape >= NUM_SHAPES) {
        shape = 0;
    }
    rot = rot % 4;

    for (int i = 0; i < 4; i++) {
        cells[i][0] = SHAPES[shape][rot][i][0];
        cells[i][1] = SHAPES[shape][rot][i][1];
    }
}

uint8_t shape_get_width(uint8_t shape, uint8_t rot)
{
    if (shape >= NUM_SHAPES) {
        return 2;
    }
    return SHAPE_DIMENSIONS[shape][rot % 4][0];
}

uint8_t shape_get_height(uint8_t shape, uint8_t rot)
{
    if (shape >= NUM_SHAPES) {
        return 2;
    }
    return SHAPE_DIMENSIONS[shape][rot % 4][1];
}

uint8_t shape_num_rotations(uint8_t shape)
{
    if (shape >= NUM_SHAPES) {
        return 1;
    }
    return SHAPE_NUM_ROTATIONS[shape];
}

uint8_t shape_random(void)
{
    if (bag_pos >= 7) {
        shuffle_bag();
    }
    return bag[bag_pos++];
}
