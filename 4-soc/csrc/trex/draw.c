//#include <stdlib.h>
//#include <string.h>
#include "mmio.h"
#include <stddef.h> // 這裡可以包含，為了定義 NULL
#define VGA_WHITE  0x3F
#define VGA_BLACK  0x00
#define VGA_GREEN  0x0C  // 恐龍顏色
#define VGA_RED    0x30  // 障礙物顏色
// 定義 64x64 的畫布
uint8_t vga_framebuffer[VGA_FRAME_SIZE];
#include "trex.h"

/* Color management */
//static int total_text_colors = 0;
//static color_t **v_text_colors = NULL;

//static int total_block_colors = 0;
//static color_t **v_block_colors = NULL;

/* Configuration is now handled globally via ensure_cfg() in config.h */

/* Double buffering */
static render_buffer_t render_buffer = {NULL, NULL, true};

/* Dirty region tracking */
static int dirty_min_x = 0, dirty_min_y = 0;
static int dirty_max_x = 0, dirty_max_y = 0;
static bool has_dirty_region = false;
// 定義一隻 8x8 的像素恐龍 (1 是身體，0 是空)
static const uint8_t dino_shape[2][8] = {
    {
     0b00011100, //    ###
    0b00011111, //    #####
    0b00011000, //    ##
    0b10011110, // #  ####
    0b11111100, // ######
    0b01111100, //  #####
    0b00100000, //   # 
    0b00110000  //   ##    
    }

    ,{
    0b00011100, //    ###
    0b00011111, //    #####
    0b00011000, //    ##
    0b10011110, // #  ####
    0b11111100, // ######
    0b01111100, //  #####
    0b00001000, //     # 
    0b00001100  //     ## 
    }
};

// 蹲下的恐龍 (8x8 陣列，但圖案集中在下方)
static const uint8_t dino_shape_setdown[2][8] = {
    {
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,
        0b10001110, // 頭部壓低
        0b11111111, // 身體伸長
        0b11111000, // 嘴巴與眼睛
        0b01000000 // 腳 1
    },
    {
        0b00000000,
        0b00000000,
        0b00000000,
        0b00000000,
        0b10001110,
        0b11111111,
        0b11111000,
        0b00010000 // 腳 2 (跑步動畫)
    }
};
static const uint8_t cactus_shape_mini[4] = {
    0b01100000, //  ##
    0b11110000, // ####
    0b01100000, //  ##
    0b01100000  //  ##
};

void place_cactus(int x, int y, uint8_t color) {
    for (int row = 0; row < 4; row++) {
        for (int col = 0; col < 4; col++) {
            // 注意：這裡只檢查前 4 個 bit (從左邊數過來)
            if ((cactus_shape_mini[row] >> (7 - col)) & 1) {
                int px = x + col;
                int py = y + row;
                if (px >= 0 && px < 64 && py >= 0 && py < 64) {
                    vga_framebuffer[py * 64 + px] = color;
                }
            }
        }
    }
}
// 在畫布上畫出一隻恐龍
void place_dino(int x, int y, uint8_t color,int shap ) {
    for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
            if ((dino_shape[shap][row] >> (7 - col)) & 1) {
                int px = x + col;
                int py = y + row;
                if (px >= 0 && px < 64 && py >= 0 && py < 64) {
                    vga_framebuffer[py * 64 + px] = color;
                }
            }
        }
    }
}

void place_dino_setdown(int x, int y, uint8_t color,int shap) {
    for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
            if ((dino_shape_setdown[shap][row] >> (7 - col)) & 1) {
                int px = x + col;
                int py = y + row;
                if (px >= 0 && px < 64 && py >= 0 && py < 64) {
                    vga_framebuffer[py * 64 + px] = color;
                }
            }
        }
    }
}

// Simple delay function (~20Hz frame rate)
// Use inline assembly to prevent compiler optimization
static inline void delay(uint32_t cycles)
{
    for (uint32_t i = 0; i < cycles; i++)
        __asm__ volatile("nop");
}

#define VGA_STAT_SAFE 0x01
#define VGA_STAT_BUSY 0x02
void run_trex(void) {
    int dino_x = 5;
    int dino_y = 50;      // 初始高度（踩在地上）
    int y_velocity = 0;   // 初始垂直速度
    int shap = 0;
    int current_frame = 0;
    const int GROUND_Y = 50; // 地平線的基準 Y 座標
    const int JUMP_IMPULSE = -6; // 跳躍的力道（負值代表向上）
    const int GRAVITY = 1;      
    int setdown_times=0;
    int cactus_x = 64; // 從螢幕最右邊外面一點點開始
    const int cactus_y = 54; // 確保它踩在地平線上 (64x64 的底部)
    draw_init_buffers(); // 清空並畫地平線
    while (1) {
        // --- 1. 鍵盤輸入偵測 (UART) ---
        // 檢查 UART 狀態暫存器，看是否有按鍵按下
        handle_input(&dino_y, &y_velocity, GROUND_Y, JUMP_IMPULSE,&setdown_times);

        // 2. 更新物理
        update_physics(&dino_y, &y_velocity, GROUND_Y, GRAVITY);
        
        if ( cactus_x > 5 && 13 > cactus_x + 4 && dino_y + 8 > cactus_y) {
        // 撞到了！
            // 這裡可以加入碰撞後的處理邏輯，例如結束遊戲或重置位置
            cactus_x = 64; // 碰撞後讓仙人掌重新出現
        }
        
        cactus_x -= 1; // 每一幀向左移動 1 像素

        // 如果仙人掌完全走出了螢幕左邊 (-8 是因為仙人掌寬度是 8)
        if (cactus_x < -8) {
        cactus_x = 64; // 讓它從右邊重新出現
        }
        // --- 3. 繪圖與顯示 ---
        draw_cleanup_buffers();
        place_cactus(cactus_x, cactus_y, 1);
        // 使用計算出來的 dino_y 來畫恐龍
        if(setdown_times>0){
            place_dino_setdown(dino_x, dino_y, 1, (shap % 2));
            setdown_times--;
        }else{
            place_dino(dino_x, dino_y, 1, (shap % 2));
        }
        delay(2000); 


        // VGA 上傳
        //current_frame = 1 - current_frame;
        *VGA_UPLOAD_ADDR = (current_frame << 16)|1792;
        for (int i = 224; i < 464; i++) {
            *VGA_STREAM_DATA = vga_pack8_pixels(&vga_framebuffer[i * 8]);
        }
        while (!((*VGA_STATUS) & VGA_STAT_SAFE));
        *VGA_CTRL = (current_frame << 4) | 0x01;
       
        shap++;
        
    }
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

/* Render buffer management */
void draw_init_buffers()
{
   for (int i = 0; i < 4096; i++) vga_framebuffer[i] = 0;

    // B. 畫地平線 (放在 y = 58 的位置)
    draw_horizon(2, 58); 
    for (int i = 0; i < 512; i++) {
        *VGA_STREAM_DATA = vga_pack8_pixels(&vga_framebuffer[i * 8]);
        
    }
    //render_buffer.needs_refresh = true;
    //has_dirty_region = false;
    
}

void draw_horizon(uint8_t color, int y_position) {
    for (int x = 0; x < 64; x++) {
        // 確保 y 座標在螢幕範圍內
        if (y_position >= 0 && y_position < 64) {
            vga_framebuffer[y_position * 64 + x] = color;
        }
    }
    
    for(int x = 0; x < 64; x += 4) {
        vga_framebuffer[(y_position+1) * 64 + x] = 2; 
    } 
    
    
    
}

void draw_cleanup_buffers(void)
{
    for (int i = 28 * 64; i < 58*64; i++) vga_framebuffer[i] = 0;

}
void draw_swap_buffers(void)
{
    // 設定硬體上傳起始位址
    vga_write32(VGA_ADDR_UPLOAD_ADDR, 0);

    // 每 8 個像素打包成一個 32-bit Word 傳送
    for (int i = 0; i < 64 * 64; i += 8) {
        uint32_t packed = vga_pack8_pixels(&vga_framebuffer[i]);
        vga_write32(VGA_ADDR_STREAM_DATA, packed);
    }

    // 觸發 VGA 硬體更新畫面
    vga_write32(VGA_ADDR_CTRL, 0x01);
    
}
static int create_color(short r, short g, short b)
{
    return (uint8_t)((r > 128 ? 0x30 : 0) | (g > 128 ? 0x0C : 0) | (b > 128 ? 0x03 : 0));
}

int draw_get_color_id(color_t **colors,
                      short r,
                      short g,
                      short b,
                      short r2,
                      short g2,
                      short b2,
                      color_type_t type)
{
    return create_color(r, g, b);
}
static tui_window_t *get_draw_buffer(void)
{
    return render_buffer.back_buffer ? render_buffer.back_buffer : tui_stdscr;
}

static void mark_dirty(int x, int y, int width, int height)
{
    if (!has_dirty_region) {
        dirty_min_x = x;
        dirty_min_y = y;
        dirty_max_x = x + width;
        dirty_max_y = y + height;
        has_dirty_region = true;
    } else {
        /* Expand dirty region using ternary operators */
        dirty_min_x = (x < dirty_min_x) ? x : dirty_min_x;
        dirty_min_y = (y < dirty_min_y) ? y : dirty_min_y;
        dirty_max_x = (x + width > dirty_max_x) ? x + width : dirty_max_x;
        dirty_max_y = (y + height > dirty_max_y) ? y + height : dirty_max_y;
    }

    render_buffer.needs_refresh = true;
}





/* Core rendering functions with buffering */
void draw_text(int x, int y, char *text, int flags)
{
    
}

void draw_text_color(int x,
                     int y,
                     char *text,
                     int flags,
                     short r,
                     short g,
                     short b)
{
    
}

void draw_block(int x, int y, int cols, int rows, int flags)
{
    tui_window_t *buffer = get_draw_buffer();
    tui_wattron(buffer, flags);

    for (int j = 0; j < rows; ++j) {
        for (int i = 0; i < cols; ++i)
            tui_print_at(buffer, y + j, x + i, " ");
    }

    tui_wattroff(buffer, flags);

    mark_dirty(x, y, cols, rows);
}

void draw_block_color(int x,
                      int y,
                      int cols,
                      int rows,
                      short r,
                      short g,
                      short b)
{
    uint8_t color = (r > 128 ? 0x30 : 0) | (g > 128 ? 0x0C : 0) | (b > 128 ? 0x03 : 0);

    for (int j = 0; j < rows; ++j) {
        for (int i = 0; i < cols; ++i) {
            int tx = x + i;
            int ty = y + j;
            // 只有在 64x64 範圍內才畫
            if (tx >= 0 && tx < 64 && ty >= 0 && ty < 64) {
                vga_framebuffer[ty * 64 + tx] = color;
            }
        }
    }
}


void draw_text_bg(int x,
                  int y,
                  char *text,
                  int flags,
                  short r,
                  short g,
                  short b,
                  short r2,
                  short g2,
                  short b2)
{
   
}

void draw_logo(int x, int y)
{
    
}

/* Color management cleanup */
void draw_cleanup_colors(void)
{
}
