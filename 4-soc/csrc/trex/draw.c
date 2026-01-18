//#include <stdlib.h>
//#include <string.h>
#include "mmio.h"
#include <stddef.h> 
#define VGA_WHITE  0x3F
#define VGA_BLACK  0x00
#define VGA_GREEN  0x0C  // 恐龍顏色
// 定義 64x64 的畫布
uint8_t vga_framebuffer[VGA_FRAME_SIZE];
#include "trex.h"

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
static const uint8_t die_shape[8] ={
    0b00111100, //    ####  
    0b01111110, //   ###### 
    0b11011011, //  ## ## ## (眼窩)
    0b11011011, //  ## ## ##
    0b11111111, //  ########
    0b00111100, //    ####  
    0b00100100, //    #  #   (牙齒/下顎)
    0b00111100  //    ####
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
void place_dino(int x, int y, uint8_t color,int body_picture ) {
    for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
            if ((dino_shape[body_picture][row] >> (7 - col)) & 1) {
                int px = x + col;
                int py = y + row;
                if (px >= 0 && px < 64 && py >= 0 && py < 64) {
                    vga_framebuffer[py * 64 + px] = color;
                }
            }
        }
    }
}

void place_dino_setdown(int x, int y, uint8_t color,int body_picture) {
    for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
            if ((dino_shape_setdown[body_picture][row] >> (7 - col)) & 1) {
                int px = x + col;
                int py = y + row;
                if (px >= 0 && px < 64 && py >= 0 && py < 64) {
                    vga_framebuffer[py * 64 + px] = color;
                }
            }
        }
    }
}

void place_die() {
    for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
            if ((die_shape[row] >> (7 - col)) & 1) {
                int px = 28 + col;
                int py = 50 + row;
                if (px >= 0 && px < 64 && py >= 0 && py < 64) {
                    vga_framebuffer[py * 64 + px] = 3;
                }
            }
        }
    }
}
static inline void delay(uint32_t cycles)
{
    for (uint32_t i = 0; i < cycles; i++)
        __asm__ volatile("nop");
}

#define VGA_STAT_SAFE 0x01
void run_trex(uint32_t shap) {
    int dino_x = 5;
    int dino_y = 50;      
    int y_velocity = 0;   
    int body_picture = 0;
    int current_frame = 0;
    const int GROUND_Y = 50; 
    const int JUMP_IMPULSE = -6; 
    const int GRAVITY = 1;      
    int setdown_times=0;
    int cactus_x = 64; 
    const int cactus_y = 54; 
    uint32_t offset=0;
    int score=0;
    char *score_msg = "score:";
    
    draw_init_buffers(); 
    while (1) {
        // 鍵盤輸入偵測 (UART) 
        // 檢查 UART 狀態暫存器，看是否有按鍵按下
        handle_input(&dino_y, &y_velocity, GROUND_Y, JUMP_IMPULSE,&setdown_times);
        
       
        update_physics(&dino_y, &y_velocity, GROUND_Y, GRAVITY);
        
        if ( cactus_x > 5 && 13 > cactus_x + 4 && dino_y + 8 > cactus_y) {
            score =0;
            cactus_x = 64;
            draw_die(); 
        }

        cactus_x -= 1;         
        if (cactus_x < -8) {
            //my_rand(&shap);
            //offset = (shap ) % 10;
            cactus_x = 64 ;
            //- offset;
            score+=1; 
            print_score(score);
        }
        
        draw_cleanup_buffers();
        place_cactus(cactus_x, cactus_y, 1);
        
        if(setdown_times>0){
            place_dino_setdown(dino_x, dino_y, 1, (body_picture % 2));
            setdown_times--;
        }else{
            place_dino(dino_x, dino_y, 1, (body_picture % 2));
        }
         


        // VGA 上傳
        *VGA_UPLOAD_ADDR = (current_frame << 16)|1792;
        for (int i = 224; i < 464; i++) {
            *VGA_STREAM_DATA = vga_pack8_pixels(&vga_framebuffer[i * 8]);
        }
        while (!((*VGA_STATUS) & VGA_STAT_SAFE));
        *VGA_CTRL = (current_frame << 4) | 0x01;
       
        body_picture++;
        
    }
}

void print_score(int s) {
    
    char *msg_s = "score:";
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = msg_s[0];
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = msg_s[1];
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = msg_s[2];
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = msg_s[3];
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = msg_s[4];
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = msg_s[5];
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = s + '0';
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = '\r';  
    while (!(*UART_STATUS & 0x01));
    *UART_SEND = '\n';
}
void draw_die(){
    draw_cleanup_buffers();
    place_die();
    draw_swap_buffers();
    char *msg2 = "you die!\r\n";
    char *msg = "Press any key to continue the game\r\n";
    for (int i = 0; i <10; i++) {
        while (!(*UART_STATUS & 0x01));
        *UART_SEND = msg2[i];
    }
    for (int i = 0; i <36; i++) {
        while (!(*UART_STATUS & 0x01));
        *UART_SEND = msg[i];
    }
    while(!(*UART_STATUS & 0x02));
}




void draw_init_buffers()
{
   for (int i = 0; i < 4096; i++) vga_framebuffer[i] = 0;

   
    draw_horizon(2, 58); 
    for (int i = 0; i < 512; i++) {
        *VGA_STREAM_DATA = vga_pack8_pixels(&vga_framebuffer[i * 8]);
        
    }
    
    
}

void draw_horizon(uint8_t color, int y_position) {
    for (int x = 0; x < 64; x++) {
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
    for (int i = 28 * 64; i < 58*64; i++) {
        vga_framebuffer[i] = 0;
        delay(10); 
    }
    

}
void draw_swap_buffers(void)
{
    vga_write32(VGA_ADDR_UPLOAD_ADDR, 0);

    for (int i = 0; i < 64 * 64; i += 8) {
        uint32_t packed = vga_pack8_pixels(&vga_framebuffer[i]);
        vga_write32(VGA_ADDR_STREAM_DATA, packed);
    }

    vga_write32(VGA_ADDR_CTRL, 0x01);
    
}
