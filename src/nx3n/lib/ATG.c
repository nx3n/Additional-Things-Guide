#ifdef _WIN32
#include <windows.h>
#endif
#include "atg.h"
#include "internal.h"

void atg(void) {
#ifdef _WIN32
    UINT output_cp = GetConsoleOutputCP(), input_cp = GetConsoleCP();
    CONSOLE_SCREEN_BUFFER_INFO info;
    HANDLE output = GetStdHandle(STD_OUTPUT_HANDLE);
    int have_info = GetConsoleScreenBufferInfo(output, &info);
    SetConsoleOutputCP(CP_UTF8);
    SetConsoleCP(CP_UTF8);
#endif
    int language = config_read();
    if (!language) {
        language = select_language(1);
    }
    if (language) {
        lang(language == 1);
        main_menu(&language);
    }
#ifdef _WIN32
    if (have_info) {
        SetConsoleTextAttribute(output, info.wAttributes);
    }
    SetConsoleOutputCP(output_cp);
    SetConsoleCP(input_cp);
#else
    color_def();
#endif
}
