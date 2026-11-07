#include <stdio.h>
#include "../internal.h"

int select_language(int current) {
    static const char *const choices[] = {"Русский.\n", "English.\n"};
    int selected = gui("Select language | Выбери язык:\n", choices, 2, current == 2 ? 1 : 0);

    if (selected < 0) {

        return 0;
    }
    int language = selected + 1;

    if (!config_write(language)) {
        color_def();
        fputs(language == 1 ? "Не удалось сохранить язык. Нажмите любую клавишу.\n"
                            : "Could not save language. Press any key.\n",
              stdout);
        fflush(stdout);
        read_key();
    }
    return language;
}
