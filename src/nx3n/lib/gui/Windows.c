#include <stdio.h>
#include <conio.h>
#include <windows.h>
#include "../internal.h"

void console_clear(void) {
    HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_SCREEN_BUFFER_INFO info;
    DWORD written;
    COORD origin = {0, 0};
    if (!GetConsoleScreenBufferInfo(h, &info)) {
        return;
    }
    DWORD size = (DWORD)info.dwSize.X * info.dwSize.Y;
    FillConsoleOutputCharacterW(h, L' ', size, origin, &written);
    FillConsoleOutputAttribute(h, info.wAttributes, size, origin, &written);
    SetConsoleCursorPosition(h, origin);
}

int read_key(void) {
    int console = GetFileType(GetStdHandle(STD_INPUT_HANDLE)) == FILE_TYPE_CHAR;
    int c = console ? _getch() : getchar();
    if (c == EOF) {
        return 27;
    }
    if (c == 0 || c == 224) {
        int extended = console ? _getch() : getchar();
        return extended == EOF ? 27 : 256 + extended;
    }
    return c;
}
