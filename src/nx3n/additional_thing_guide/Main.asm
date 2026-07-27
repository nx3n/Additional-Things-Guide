default rel
global main
global selected_lang
global select_language
global lang_config

extern colored_print, printf                ; Output text | Вывод текста
extern SetConsoleOutputCP, SetConsoleCP     ; Localisation | Локализация
extern _getch                               ; Char | Символ
extern main_menu, lang                      ; Modules | Модули
extern color_green, color_red, color_def    ; Colors | Цвета
extern console_clear                        ; Clear | Очистка
extern config, config_write                 ; Config | Конфиг
extern module                               ; Flag for main_menu | Флаг для main_menu

%define itemCount 2

section .data
    selected_lang db 0
    select_lang db "Select language | Выбери язык:", 13, 10, 0
    ru db "Русский.", 13, 10, 0
    en db "English.", 13, 10, 0

    selected db 1
    menu:
        dq ru
        dq en

section .text
main:
    sub rsp, 40

	mov rcx, 65001
	call SetConsoleOutputCP
	mov rcx, 65001
	call SetConsoleCP

cfg_check:
    call config
    cmp byte [selected_lang], 1
    je case_1
    cmp byte [selected_lang], 2
    je case_2

select_language:
    call draw_menu

; SELECT
select_menu:
    call _getch
    cmp al, 224
    jne checkEnter
    call _getch

    cmp al, 72
    je up

    cmp al, 80
    je down

up:
    dec byte [selected]
    call check_selected
    call draw_menu
    jmp select_menu

down:
    inc byte [selected]
    call check_selected
    call draw_menu
    jmp select_menu

checkEnter:
    cmp al, 13
    jne select_menu

    movzx eax, byte [selected]

    cmp eax, 1
    je case_1
    cmp eax, 2
    je case_2

    jmp select_menu

; DRAW
draw_menu:
    sub rsp, 40
    call console_clear

    call color_def
    lea rcx, [select_lang]
    call printf

    xor r12, r12

draw_loop:
    cmp r12, itemCount
    je draw_done

    movzx eax, byte [selected]
    dec eax

    cmp r12d, eax
    je draw_selected

draw_normal:
    call color_red
    jmp draw_print

draw_selected:
    call color_green

draw_print:
    lea rbx, [menu]
    mov rcx, [rbx + r12*8]
    call printf

    inc r12
    jmp draw_loop

draw_done:
    add rsp, 40
    ret

; CASES
case_1:
    mov [selected_lang], 1
    call config_write
    jmp call_main_menu

case_2:
    mov [selected_lang], 2
    call config_write

call_main_menu:
    call lang
    mov [module], 1
    call main_menu
    jmp call_main_menu

; UTILS
exit:
    add rsp, 40
    ret

check_selected:
    cmp byte [selected], 1
    jl selected_low
    cmp byte [selected], itemCount
    jg selected_high
    ret

selected_low:
    mov byte [selected], itemCount
    ret

selected_high:
    mov byte [selected], 1
    ret