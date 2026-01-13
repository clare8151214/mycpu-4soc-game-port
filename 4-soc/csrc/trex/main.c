
#include "trex.h"
#include "mmio.h" // 必須引入，為了存取 VGA 地址
#include <stdint.h>





int main()
{

    *VGA_PALETTE(0) = 0x00; // 背景黑
    *VGA_PALETTE(1) = 0x0C; // 恐龍綠 (00001100)
    *VGA_PALETTE(2) = 0x3F; // 地平線：白
    
    
    /* 1. 初始化硬體與資源 */
    const game_config_t *cfg = ensure_cfg();
    sprites_init();
    run_trex();
    
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