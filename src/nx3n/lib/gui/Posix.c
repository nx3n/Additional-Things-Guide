#include <stdio.h>
#include <unistd.h>
#include <termios.h>
#include <poll.h>
#include "../internal.h"

void console_clear(void) {
    if (isatty(STDOUT_FILENO)) {
        fputs("\033[2J\033[H", stdout);
    }
}

static int next_byte(int timeout_ms) {
    struct pollfd input = {STDIN_FILENO, POLLIN, 0};
    unsigned char byte;
    if (poll(&input, 1, timeout_ms) <= 0) {
        return -1;
    }
    return read(STDIN_FILENO, &byte, 1) == 1 ? byte : -1;
}

int read_key(void) {
    struct termios saved, raw;
    int restore = isatty(STDIN_FILENO) && tcgetattr(STDIN_FILENO, &saved) == 0;
    if (restore) {
        raw = saved;
        raw.c_lflag &= ~(ICANON | ECHO);
        raw.c_cc[VMIN] = 1;
        raw.c_cc[VTIME] = 0;
        if (tcsetattr(STDIN_FILENO, TCSANOW, &raw) != 0) {
            restore = 0;
        }
    }

    int key = next_byte(-1);
    if (key == 27) {
        int prefix = next_byte(40);
        if (prefix == '[' || prefix == 'O') {
            int direction = next_byte(40);
            if (direction == 'A') {
                key = 256 + 72;
            } else if (direction == 'B') {
                key = 256 + 80;
            }
        }
    }

    if (restore) {
        tcsetattr(STDIN_FILENO, TCSANOW, &saved);
    }
    return key < 0 ? 27 : key;
}
