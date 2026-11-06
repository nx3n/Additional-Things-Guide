#include "../internal.h"

void ore(void) {
    int selected = 0;

    for (;;) {
        const char *messages[] = {
            red_diamond_message,
            sky_crystal_message,
            hell_crystal_message,
            wolfram_message,
            red_netherite_message,
        };
        selected = gui(select_ore, ore_menu, 6, selected);
        if (selected < 0 || selected == 5) {
            return;
        }
        show_message(messages[selected], NULL);
    }
}
