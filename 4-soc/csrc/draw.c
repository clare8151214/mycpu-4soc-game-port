//#include <stdlib.h>
//#include <string.h>
#include "mmio.h"
#include <stddef.h> // 這裡可以包含，為了定義 NULL
#define VGA_WHITE  0x3F
#define VGA_BLACK  0x00
#define VGA_GREEN  0x0C  // 恐龍顏色
#define VGA_RED    0x30  // 障礙物顏色
// 定義 64x64 的畫布
uint8_t vga_framebuffer[VGA_FRAME_WIDTH * VGA_FRAME_HEIGHT];
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

/* Helper function to create and initialize a color */
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

/* Render buffer management */
void draw_init_buffers(void)
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
{}
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
