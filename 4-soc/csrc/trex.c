#include "mmio.h"
#include <stdint.h>

int main() {
    // --- 1. 初始化 UART ---
    *UART_BAUDRATE = 115200;
    *UART_ENABLE = 1;

    // --- 2. 初始化 VGA 調色盤 (新加入) ---
    // 這裡我們把編號 1 設為紅色，編號 2 設為藍色
    *VGA_PALETTE(1) = 0x30; // 紅色 (RRGGBB = 110000)
    *VGA_PALETTE(2) = 0x03; // 藍色 (RRGGBB = 000011)

    // 在 MobaXterm 印出啟動訊息
    const char *msg = "T-Rex Game Loading...\nPress Space to Jump!\n";
    for (int i = 0; msg[i] != '\0'; i++) {
        while (!(*UART_STATUS & 0x01)); 
        *UART_SEND = msg[i];
    }
    uint8_t p[8];
    for(int j=0; j<8; j++) p[j] = 1; // 全部填入顏色編號 1 (紅色)
    uint32_t packed_red = vga_pack8_pixels(p);
    uint8_t p2[8] = {1, 1, 1, 1, 2, 2, 2, 2};
    uint32_t othercolor = vga_pack8_pixels(p2);
    while (1) {
        // 檢查鍵盤
        if (*UART_STATUS & 0x02) {
            char key = (char)(*UART_RECV & 0xFF);
            
            if (key == ' ') { 
                // --- UART 輸出 ---
                const char *jump_msg = "Jump!\n";
                for (int i = 0; jump_msg[i] != '\0'; i++) {
                    while (!(*UART_STATUS & 0x01));
                    *UART_SEND = jump_msg[i];
                }

                // --- VGA 輸出 (讓視窗跳出來並變色) ---
                // 我們把這 64x64 的螢幕全部塗成紅色 (調色盤編號 1)
                *VGA_UPLOAD_ADDR = 0; // 從第一個像素開始
                // 總共 64*64/8 = 512 個 word
                for (int i = 0; i < 512; i++) {
                    *VGA_STREAM_DATA = packed_red;
                }

                // 請求畫面交換，這行會讓模擬器呼叫 render()，彈出 SDL 視窗
                *VGA_CTRL = 0x1; 
            }
            if (key == 'a') { 
                // --- UART 輸出 ---
                const char *a_msg = "a!\n";
                for (int i = 0; a_msg[i] != '\0'; i++) {
                    while (!(*UART_STATUS & 0x01));
                    *UART_SEND = a_msg[i];
                }

                // --- VGA 輸出 (讓視窗跳出來並變色) ---
                // 我們把這 64x64 的螢幕全部塗成紅色 (調色盤編號 1)
                *VGA_UPLOAD_ADDR = 0; // 從第一個像素開始
                // 總共 64*64/8 = 512 個 word
                for (int i = 0; i < 512; i++) {
                    *VGA_STREAM_DATA = othercolor
                    ;
                }

                // 請求畫面交換，這行會讓模擬器呼叫 render()，彈出 SDL 視窗
                *VGA_CTRL = 0x1; 
            }
        }
    }
    return 0;
}