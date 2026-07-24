default rel
global mod_info

extern colored_print, _getch, back

section .data
    mod_info_message:
        db "$dМод: $rAdditional Things$d.", 10
        db "Версия: 2.0, $grelease$d.", 10
        db "Разработчик: $cnx3n$d.", 10
        db "", 10
        db "Приложение: $rСправочник по моду Additional Things$d.", 10
        db "Версия: 1.0, $grelease$d.", 10
        db "Разработчик: $cnx3n$d.", 0

    skip db "", 13, 10, 0

section .text
mod_info:
    sub rsp, 40

    lea rcx,[mod_info_message]
    call colored_print

    lea rcx, [back]
    call colored_print

    call _getch

    mov r15, 1
    add rsp, 40
    ret