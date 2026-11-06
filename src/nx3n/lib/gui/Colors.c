#include <stdio.h>
#ifdef _WIN32
#include <windows.h>
#else
#include <unistd.h>
#endif
void set_color(int color) {
#ifdef _WIN32
    SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), (WORD)color);
#else
    static const int ansi[] = {30, 34, 32, 36, 31, 35, 33, 37, 90, 94, 92, 96, 91, 95, 93, 97};
    if (isatty(STDOUT_FILENO) && color >= 0 && color < 16) {
        printf("\033[%dm", ansi[color]);
    }
#endif
}
void color_red(void) {
    set_color(12);
}
void color_green(void) {
    set_color(10);
}
void color_cyan(void) {
    set_color(11);
}
void color_gray(void) {
    set_color(8);
}
void color_white(void) {
    set_color(15);
}
void color_yellow(void) {
    set_color(6);
}
void color_light_yellow(void) {
    set_color(14);
}
void color_def(void) {
    set_color(7);
}
