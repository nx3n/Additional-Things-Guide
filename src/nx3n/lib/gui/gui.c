#include <stdio.h>
#include "../internal.h"

int gui(const char *title, const char *const *items, int count, int selected) {
    if (!items || count <= 0) {
        return -1;
    }
    if (selected < 0 || selected >= count) {
        selected = 0;
    }
    for (;;) {
        console_clear();
        color_def();
        fputs(title, stdout);
        for (int i = 0; i < count; ++i) {
            set_color(i == selected ? 10 : 12);
            fputs(items[i], stdout);
        }
        color_def();
        fflush(stdout);
        int key = read_key();
        if (key == 256 + 72) {
            selected = (selected + count - 1) % count;
        } else if (key == 256 + 80) {
            selected = (selected + 1) % count;
        } else if (key == 13 || key == 10) {
            return selected;
        } else if (key == 27) {
            return -1;
        }
    }
}

void show_message(const char *first, const char *second) {
    console_clear();
    color_def();
    colored_print(first);
    if (second) {
        colored_print(second);
    }
    colored_print(back);
    fflush(stdout);
    read_key();
    color_def();
}
