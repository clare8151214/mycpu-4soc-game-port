#include <stdint.h>
#include <stdbool.h>

void* tui_stdscr = (void*)0x1234;

// 補齊 main.c 用到的函式
void tui_init(void) {}
void tui_cleanup(void) {}
void tui_raw(void) {}
void tui_noraw(void) {}
void tui_noecho(void) {}
void tui_echo(void) {}
void tui_cbreak(void) {}
void tui_start_color(void) {}
void tui_set_cursor(int state) {}
void tui_clear_screen(void) {}
bool tui_check_shutdown(void) { return false; }
bool tui_check_resize(void) { return false; }
bool tui_has_input(void) { return false; }

// 補齊 state.c 用到的函式 (給出固定解析度)
int tui_get_max_x(void* win) { return 64; }
int tui_get_max_y(void* win) { return 64; }

// 原有的
void tui_refresh(void* win) {}
void tui_clear_window(void* win) {}
void tui_set_nodelay(void* win, bool bf) {}
void tui_set_keypad(void* win, bool bf) {}
void tui_print_at(void* win, int y, int x, const char* fmt, ...) {}
void tui_wattron(void* win, int attrs) {}
void tui_wattroff(void* win, int attrs) {}
void tui_init_pair(int16_t pair, int16_t f, int16_t b) {}
void tui_init_color(int16_t color, int16_t r, int16_t g, int16_t b) {}
int tui_getch(void* win) { return -1; }















