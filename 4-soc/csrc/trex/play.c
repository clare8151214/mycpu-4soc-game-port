//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
//#include <time.h>
#include <stdint.h>      // 加入這個
#include <stdbool.h>     // 為了 bool, true, false
#include "mmio.h"        // 為了你的硬體位址
#include "trex.h"
#include <stddef.h> // 這裡可以包含，為了定義 NULL


// 1. 手寫 memset (原本在 string.h)
static void *memset(void *s, int c, uint32_t n) {
    unsigned char *p = s;
    while (n--) *p++ = (unsigned char)c;
    return s;
}

// 2. 偽造一個 calloc (原本在 stdlib.h)
// 警告：這是一個極簡做法。我們直接給它一塊固定的靜態記憶體。
static void *calloc(uint32_t nmemb, uint32_t size) {
    static uint8_t memory_pool[2048]; // 預留 2KB 給空間雜湊使用
    static uint32_t pool_ptr = 0;
    void *ret = &memory_pool[pool_ptr];
    pool_ptr += (nmemb * size);
    return ret;
}



void handle_input(int *y, int *velocity, int ground_y, int jump_impulse,int *sit) {
    if (*UART_STATUS & 0x02) { 
        char key = (char)(*UART_RECV & 0xFF);
        
        // 向上鍵或空白鍵：跳躍
        if ((key == 'w' || key == ' ') && *y == ground_y) {
            *velocity = jump_impulse;
            *sit=0;
        }
        
        // 向下鍵：如果在空中，加速下墜；如果在地面，觸發蹲下邏輯
        if (key == 's') {
            if (*y < ground_y) {
                *velocity = 4; // 給一個向下的正速度，讓它快速落地
            } else {
                *sit=2;
            }
        }
    }
}


void my_rand(uint32_t *rand_state)
{
    if (*rand_state == 0) *rand_state = 100;
    *rand_state ^= *rand_state << 13;
    *rand_state ^= *rand_state >> 17;
    *rand_state ^= *rand_state << 5;
}
void update_physics(int *y, int *velocity, int ground_y, int gravity) {
    *y += *velocity;

    if (*y < ground_y) {
        // 在空中，受重力影響
        *velocity += gravity;
    } else {
        // 落地
        *y = ground_y;
        *velocity = 0;
    }
}



