
#include "trex.h"
#include "mmio.h" // 必須引入，為了存取 VGA 地址
#include <stdint.h>


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


void draw_init_buffers_main(void)
{
   for (int i = 0; i < 4096; i++) vga_framebuffer[i] = 0;

    // B. 畫地平線 (放在 y = 58 的位置)
    draw_horizon(2, 58); 
    
    // 加一點裝飾：地平線下方再畫一條虛線感
    for(int x = 0; x < 64; x += 4) {
        vga_framebuffer[59 * 64 + x] = 2; 
    }
    //render_buffer.needs_refresh = true;
    //has_dirty_region = false;
    
}
   

}
// 在畫布上畫出一隻恐龍
void place_dino(int x, int y, uint8_t color,int shap) {
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
int main()
{

    *VGA_PALETTE(0) = 0x00; // 背景黑
    *VGA_PALETTE(1) = 0x0C; // 恐龍綠 (00001100)
    *VGA_PALETTE(2) = 0x3F; // 地平線：白
     
    
    
    
    /* 1. 初始化硬體與資源 */
    const game_config_t *cfg = ensure_cfg();
    sprites_init();
    
    int dino1_x = 5; // 第一隻初始位置
    int dino1_y = 50;
    int shap = 0;
    while (1) {
        shap%=2;
        draw_init_buffers_main();
        place_dino(dino1_x, dino1_y, 1,shap); // 畫第一隻
        
        // --- 步驟 C: 上傳到 VGA ---
        *VGA_UPLOAD_ADDR = 0; // 上傳到 Frame 0
        for (int i = 0; i < 512; i++) {
            *VGA_STREAM_DATA = vga_pack8_pixels(&vga_framebuffer[i * 8]);
        }

        // --- 步驟 D: 觸發顯示 ---
        *VGA_CTRL = 0x1;

        // --- 步驟 E: 延遲 (這很重要，不然會跑太快) ---
        // 在模擬器中，我們用簡單的 loop 延遲
        for (volatile int delay = 0; delay < 20000; delay++);
        shap++;
    }
    // 關鍵：初始化你的 64x64 畫布
    
    
    

    // Initialize the game 
   // state_initialize();
/*
    uint32_t last_frame_time = state_get_time_ms();
    uint32_t accumulator = 0;

    
    while (state_is_running()) {
        uint32_t current_time = state_get_time_ms();
        uint32_t delta_time = current_time - last_frame_time;
        last_frame_time = current_time;

        accumulator += delta_time;

        // 固定幀率更新 (FPS Control) 
        if (accumulator >= cfg->timing.frame_time) {
            
            // 2. 處理輸入：從模擬器讀取最近一次的按鍵 
            // 這裡假設你的 mmio.h 有定義讀取鍵盤的位址
            int ch = vga_read32((uint32_t)UART_STATUS); 
            if (ch != 0) {
                state_handle_input(ch);
                // 讀完後記得清空，否則會一直判定按下 (取決於你的硬體設計)
                vga_write32((uint32_t)UART_STATUS, 0); 
            }

            // 3. 更新遊戲邏輯 
            state_update_frame();

            // 4. 繪製並顯示 (關鍵步驟) 
            // state_render_frame 會呼叫 draw_block_color 把東西畫進緩衝區
            state_render_frame();
            
            // 重要：把緩衝區內容推送到 VGA 硬體，這會觸發模擬器開啟 SDL 視窗
            draw_swap_buffers();

            accumulator -= cfg->timing.frame_time;
        } else {
            // 稍微等待，避免跑太快
            for(volatile int i = 0; i < 5000; i++);
        }
    }

    
    draw_cleanup_buffers();
    */
    return 0;

}