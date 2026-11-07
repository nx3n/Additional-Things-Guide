#include "../internal.h"

void food(void) {
    int selected = 0;

    for (;;) {
        const char *messages[] = {
            lemon_message,
            fried_flesh_message,
            berry_pie_message,
            soups_message,
            shawarma_message,
            pink_gold_carrot_message,
            pink_gold_apple_message,
            enchanted_pink_gold_apple_message,
        };
        selected = gui(select_food, food_menu, 10, selected);
        if (selected < 0 || selected == 9) {
            return;
        }
        if (selected == 8) {
            drinks_menu();
        } else
            show_message(messages[selected], NULL);
    }
}
