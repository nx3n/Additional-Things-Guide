default rel
global main_menu
global back2menu
global module

extern select_language
extern colored_print, printf                ; Output text | Вывод текста
extern _getch                               ; Char | Символ
extern ore, armor_and_tools, food, mod_info ; Modules | Модули
extern color_green, color_red, color_def    ; Colors | Цвета
extern console_clear                        ; Clear |Очистка
extern ExitProcess                          ; Exit | Выход
; Strings | Строки
extern back
extern at_guide, main_menu_message

%define itemCount 6

section .data
    selected db 1
    module db 0

section .text
main_menu:
    sub rsp, 40

at_message:
    mov [module], 0
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
    cmp eax, 3
    je case_3
    cmp eax, 4
    je case_4
    cmp eax, 5
    je case_5
    cmp eax, 6
    je exit

    jmp select_menu

; DRAW
draw_menu:
    sub rsp, 40
    call console_clear

    call color_def
    mov rcx, [at_guide]
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
    lea rbx, [main_menu_message]
    mov rcx, [rbx + r12*8]
    call printf

    inc r12
    jmp draw_loop

draw_done:
    add rsp, 40
    ret

; CASES
case_1:
    call console_clear
    call color_def
    call ore
    cmp [module], 1
    je at_message
    jmp case_1

case_2:
    call console_clear
    call food
    cmp [module], 1
    je at_message
    jmp case_2

case_3:
    call console_clear
    call armor_and_tools
    cmp [module], 1
    je at_message
    jmp case_3

case_4:
    call console_clear
    call mod_info
    cmp [module], 1
    je at_message
    jmp case_4

case_5:
    call console_clear
    sub rsp, 40
    call select_language
    cmp [module], 1
    je at_message
    jmp case_5

; UTILS
exit:
    xor ecx, ecx
    add rsp, 40
    jmp ExitProcess

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

back2menu:
   sub rsp, 40
   mov rcx, [back]
   call colored_print
   add rsp, 40
   ret