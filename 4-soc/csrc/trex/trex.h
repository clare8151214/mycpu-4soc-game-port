#pragma once

/*
 * T-Rex Game Public API
 *
 * This header provides the public interface for the T-Rex game,
 * including game logic, rendering infrastructure, and configuration.
 */

#include <stdbool.h>
#include <stdint.h>


/* Render buffer management functions */
void draw_init_buffers();
void draw_cleanup_buffers(void);
void draw_swap_buffers(void);
void draw_clear_back_buffer(void);

/* Color management cleanup */
void draw_cleanup_colors(void);
void handle_input(int *y, int *velocity, int ground_y, int jump_impulse,int *sit);
void my_rand(uint32_t *rand_state);
void update_physics(int *y, int *velocity, int ground_y, int gravity);
void run_trex(uint32_t shap);
void place_dino(int x, int y, uint8_t color, int frame);
void place_dino_setdown(int x, int y, uint8_t color, int frame);
void place_cactus(int x, int y, uint8_t color);