default rel
global main
global back2menu

extern colored_print, printf                ; Вывод текста
extern SetConsoleOutputCP, SetConsoleCP     ; Локализация
extern _getch                               ; Символ | Char
extern ore, armor_and_tools, food, mod_info ; Модули
extern color_green, color_red, color_def    ; Цвета
extern console_clear                        ; Очистка
extern ExitProcess                          ; Выход

%define itemCount 5

section .data
    back db 10, "$sНажми на любую клавишу, что бы вернуться обратно.$d", 0

    message db "Additional Things - Справочник.", 13, 10, 0
    item1 db "1) Информация о рудах.", 13, 10, 0
    item2 db "2) Информация о еде.", 13, 10, 0
    item3 db "3) Информация о броне и инструментах.", 13, 10, 0
    item4 db "4) Информация о моде и приложении.", 13, 10, 0
    item5 db "5) Выйти.", 13, 10, 0

    selected db 1
    menu:
        dq item1
        dq item2
        dq item3
        dq item4
        dq item5

section .text
main:
    sub rsp, 40

	mov rcx, 65001
	call SetConsoleOutputCP
	mov rcx, 65001
	call SetConsoleCP

at_message:
    mov r15, 0
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
    je exit

    jmp select_menu

; DRAW
draw_menu:
    sub rsp, 40
    call console_clear

    call color_def
    lea rcx, [message]
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
    call console_clear
    call color_def
    call ore
    cmp r15, 1
    je at_message
    jmp case_1

case_2:
    call console_clear
    call food
    cmp r15, 1
    je at_message
    jmp case_2

case_3:
    call console_clear
    call armor_and_tools
    cmp r15, 1
    je at_message
    jmp case_3

case_4:
    call console_clear
    call mod_info
    cmp r15, 1
    je at_message
    jmp case_4

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
   lea rcx, [back]
   call colored_print
   add rsp, 40
   ret