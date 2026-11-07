#pragma once
#include <stddef.h>
#include "asm/Language.h"

void lang(int russian);
void colored_print(const char *text);

void set_color(int color);
void color_def(void);
void console_clear(void);
int gui(const char *title, const char *const *items, int count, int selected);
int read_key(void);
void show_message(const char *first, const char *second);

void ore(void);
void food(void);
void drinks_menu(void);
void armor_and_tools(void);
void main_menu(int *language);

int config_read(void);
int config_write(int language);
int select_language(int current);
