#include "../internal.h"

void main_menu(int *language) {
    int selected = 0;

    for (;;) {
        selected = gui(at_guide, main_menu_message, 6, selected);
        switch (selected) {
            case 0:
                ore();
                break;
            case 1:
                food();
                break;
            case 2:
                armor_and_tools();
                break;
            case 3:
                show_message(mod_info_message, NULL);
                break;
            case 4: {
                int next = select_language(*language);
                if (next) {
                    *language = next;
                    lang(next == 1);
                }
                break;
            }
            default:
                return;
        }
    }
}
