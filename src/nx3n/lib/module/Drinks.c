#include "../internal.h"

void drinks_menu(void) {
    int selected = 0;

    for (;;) {
        const char *messages[] = {
            cup_of_tea_message,
            cup_of_cocoa_message,
            cup_of_coffee_message,
            cup_of_lemonade_message,
            rainbow_cocktail_message,
        };
        selected = gui(select_drink, drink_menu, 6, selected);
        if (selected < 0 || selected == 5) {
            return;
        }
        show_message(messages[selected], NULL);
    }
}
