default rel
global mod_info

extern module           ; Flag for main_menu | Флаг для main_menu
extern _getch           ; Char | Символ
extern colored_print    ; Output text | Вывод текста
extern back2menu        ; Back to menu | Вернуться в меню
extern mod_info_message ; Strings | Строки

section .text
mod_info:
    sub rsp, 40

    mov rcx,[mod_info_message]
    call colored_print

    call back2menu

    call _getch

    mov [module], 1
    add rsp, 40
    ret