# Сборка ATG

Нужны CMake 3.20+, Ninja и NASM. Zig ищется в PATH; на Windows x86-64 при отсутствии автоматически скачивается проверенная версия 0.17.1 в каталог сборки.
Все результаты — для x86-64. macOS ARM64 сюда не входит.

## Три платформы одной командой

Если Zig и NASM доступны в PATH:

```sh
cmake -S . -B build -G Ninja
cmake --build build --parallel 3
```

Если Zig не в PATH, передайте его путь при настройке:

```sh
cmake -S . -B build -G Ninja -DATG_ZIG_EXECUTABLE=/path/to/zig
```

CMake по умолчанию собирает три отдельных проекта:

- `build/dist/windows`: Windows.asm, PE/COFF win64;
- `build/dist/linux`: Linux.asm, ELF64, musl;
- `build/dist/macos`: Linux.asm, Mach-O64, macOS 11+.

Для кнопки Build в CLion доступна цель `ATG`, которая собирает все три платформы. Общая цель также доступна под именем `all_platforms`. Отдельные цели — `atg_windows`,
`atg_linux`, `atg_macos`. Компилятор C запускается через `zig cc`.

## Файлы и зависимости

Каждая платформа получает динамическую ATG, статический архив ATG_static,
самостоятельную программу `atg` и загрузчик `test` для динамической ATG.
На Windows у программ расширение `.exe`.

В самостоятельную программу включён код ATG, поэтому отдельная ATG ей не нужна.
На Linux в `atg` также статически включена musl libc (`-static`).
Linux `ATG.so` и загрузчик `test` используют динамическую musl;
они предназначены для системы с musl (например, Alpine).
Статический архив ATG_static содержит код ATG, а libc выбирает приложение,
которое подключает этот архив.

В Windows сборка Zig/MinGW использует системный C runtime; `-static`
не превращает системную msvcrt.dll в статическую библиотеку.
Сторонняя DLL компилятора для самостоятельного запуска не требуется.
На macOS libc предоставляется системной libSystem; она остаётся динамической.
Полностью статический вариант с libc для macOS эта сборка не создаёт.

ASM-исходники сборка не переписывает. Для Linux вызов `putchar` перенаправлен
флагом NASM на локальную C-функцию `atg_putchar`; это позволяет линковать
существующий ASM в shared library без текстовых правок.

## Одна текущая платформа

```sh
cmake -S . -B build-native -G Ninja -DATG_BUILD_ALL=OFF
cmake --build build-native
```

Для статической libc в Linux нужен компилятор с musl и
`-DATG_STATIC_EXECUTABLE=ON`. Флаг `ATG_STATIC_RUNTIME` относится к runtime
компилятора, а не обещает встраивание системной libc.

## Язык

Первый запуск предлагает русский или английский язык. Настройка сохраняется:

- Windows: `%LOCALAPPDATA%/AdditionalThingsGuide/config.ini`;
- Linux/macOS: `$HOME/AdditionalThingsGuide/config.ini`.

Переменная `ATG_CONFIG` задаёт другой путь к файлу. Формат: `language=ru`
или `language=en`. Язык можно изменить в главном меню.
