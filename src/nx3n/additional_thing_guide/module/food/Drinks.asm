default rel
global drinks

extern food_module                      ; Flag for food_menu | Флаг для food_menu
extern colored_print, printf            ; Output text | Вывод текста
extern _getch                           ; Char | Символ
extern console_clear                    ; Clear | Очистка
extern back2menu                        ; Back to menu | Вернуться в меню
extern color_green, color_red, color_def; Colors | Цвета
; Strings | Строки
extern select_drink
extern drink_menu
extern cup_of_tea_message, cup_of_cocoa_message, cup_of_coffee_message
extern cup_of_lemonade_message, rainbow_cocktail_message

%include "../../macro/MacroPrint.inc"

%define itemCount 6

section .data
    selected db 1

section .text
drinks:
    sub rsp, 40

drinks_start:
    call draw_menu

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
    je cup_of_tea
    cmp eax, 2
    je cup_of_cocoa
    cmp eax, 3
    je cup_of_coffee
    cmp eax, 4
    je cup_of_lemonade
    cmp eax, 5
    je rainbow_cocktail
    cmp eax, 6
    je exit

    jmp select_menu

; DRAW
draw_menu:
    sub rsp, 40
    call console_clear

    call color_def
    mov rcx, [select_drink]
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
    lea rbx, [drink_menu]
    mov rcx, [rbx + r12*8]
    call printf

    inc r12
    jmp draw_loop

draw_done:
    add rsp, 40
    ret

cup_of_tea:
    print cup_of_tea_message

cup_of_cocoa:
    print cup_of_cocoa_message

cup_of_coffee:
    print cup_of_coffee_message

cup_of_lemonade:
    print cup_of_lemonade_message

rainbow_cocktail:
    print rainbow_cocktail_message

return_back:
    call back2menu
    call _getch
    call console_clear
    call color_def
    jmp drinks_start

exit:
    add rsp, 40
    mov [food_module], 1
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