
#include "trex.h"
#include "mmio.h" // 必須引入，為了存取 VGA 地址
#include <stdint.h>





int main()
{

    *VGA_PALETTE(0) = 0x00; // 背景黑
    *VGA_PALETTE(1) = 0x0C; // 恐龍綠 (00001100)
    *VGA_PALETTE(2) = 0x3F; // 地平線：白
    uint32_t shap=0;
    while(!(*UART_STATUS & 0x02)){
        shap++;
    }
    run_trex(shap);
    
    return 0;

}