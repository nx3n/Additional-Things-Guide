#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#ifdef _WIN32
#include <windows.h>
#else
#include <errno.h>
#include <sys/stat.h>
#include <unistd.h>
#endif
#include "../internal.h"

/* Per-user storage; ATG_CONFIG can select a portable configuration file. */
static int config_path(char *path, size_t size) {
    const char *override = getenv("ATG_CONFIG");
    if (override && *override) {
        int n = snprintf(path, size, "%s", override);
        return n > 0 && (size_t)n < size;
    }
#ifdef _WIN32
    const char *base = getenv("LOCALAPPDATA");
    const char *separator = "\\";
#else
    const char *base = getenv("HOME");
    const char *separator = "/";
#endif
    if (!base || !*base) {
        return 0;
    }
    int n = snprintf(path, size, "%s%sAdditionalThingsGuide", base, separator);
    if (n < 0 || (size_t)n >= size) {
        return 0;
    }
#ifdef _WIN32
    if (!CreateDirectoryA(path, NULL) && GetLastError() != ERROR_ALREADY_EXISTS) {
        return 0;
    }
#else
    if (mkdir(path, 0700) != 0 && errno != EEXIST) {
        return 0;
    }
#endif
    n = snprintf(path, size, "%s%sAdditionalThingsGuide%sconfig.ini", base, separator, separator);
    return n > 0 && (size_t)n < size;
}

int config_read(void) {
    char path[32768], line[128];
    if (!config_path(path, sizeof path)) {
        return 0;
    }
    FILE *file = fopen(path, "r");
    if (!file) {
        return 0;
    }
    int language = 0;
    while (fgets(line, sizeof line, file)) {
        char *text = line;
        while (isspace((unsigned char)*text))
            ++text;
        if (!strncmp(text, "language=", 9)) {
            text += 9;
        } else if (*text != '1' && *text != '2')
            continue;
        char *end = text + strlen(text);
        while (end > text && isspace((unsigned char)end[-1]))
            --end;
        *end = 0;
        if (!strcmp(text, "ru") || !strcmp(text, "1")) {
            language = 1;
        } else if (!strcmp(text, "en") || !strcmp(text, "2"))
            language = 2;
        else
            language = 0;
    }
    if (ferror(file)) {
        language = 0;
    }
    fclose(file);
    return language;
}

int config_write(int language) {
    char path[32768], temporary[32768];
    if ((language != 1 && language != 2) || !config_path(path, sizeof path)) {
        return 0;
    }
#ifdef _WIN32
    unsigned long process_id = GetCurrentProcessId();
#else
    unsigned long process_id = (unsigned long)getpid();
#endif
    int n = snprintf(temporary, sizeof temporary, "%s.%lu.tmp", path, process_id);

    if (n < 0 || (size_t)n >= sizeof temporary) {
        return 0;
    }

    FILE *file = fopen(temporary, "w");
    if (!file) {
        return 0;
    }

    int ok = fprintf(file, "language=%s\n", language == 1 ? "ru" : "en") >= 0;

    if (fclose(file)) {
        ok = 0;
    }

    if (ok) {
#ifdef _WIN32
        ok = MoveFileExA(temporary, path, MOVEFILE_REPLACE_EXISTING | MOVEFILE_WRITE_THROUGH) != 0;
#else
        ok = rename(temporary, path) == 0;
#endif
    }
    if (!ok) {
        remove(temporary);
    }

    return ok;
}
