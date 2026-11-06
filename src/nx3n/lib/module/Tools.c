#include "../internal.h"

void armor_and_tools(void) {
    int selected = 0;

    for (;;) {
        const char *messages[] = {
            copper_material_message,
            lapis_material_message,
            pink_gold_material_message,
            amethyst_material_message,
            redstone_material_message,
            quartz_material_message,
            emerald_material_message,
            red_diamond_material_message,
            sky_crystal_material_message,
            hell_crystal_material_message,
            wolfram_material_message,
            red_netherite_material_message_1,
            enderite_material_message_1,
        };
        selected = gui(select_material, armor_and_tools_menu, 14, selected);
        if (selected < 0 || selected == 13) {
            return;
        }
        const char *second = NULL;
        if (selected == 11) {
            second = red_netherite_material_message_2;
        } else if (selected == 12) {
            second = enderite_material_message_2;
        }
        show_message(messages[selected], second);
    }
}
