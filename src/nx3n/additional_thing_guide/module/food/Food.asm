default rel
global food
global food_module

extern module                           ; Flag for main_menu | Флаг для main_menu
extern colored_print, printf            ; Output text | Вывод текста
extern _getch                           ; Char | Символ
extern console_clear                    ; Clear | Очистка
extern back2menu                        ; Back to menu | Вернуться в меню
extern color_green, color_red, color_def; Colors | Цвета
; Strings | Строки
extern select_food
extern food_menu
extern lemon_message, fried_flesh_message, berry_pie_message, soups_message
extern shawarma_message, pink_gold_carrot_message, pink_gold_apple_message
extern enchanted_pink_gold_apple_message
extern drinks

%include "../../macro/MacroPrint.inc"

%define itemCount 10

section .data
    selected db 1
    food_module db 1

section .text
food:
    sub rsp, 40

food_start:
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

    mov [food_module], 0

    cmp eax, 1
    je lemon
    cmp eax, 2
    je fried_flesh
    cmp eax, 3
    je berry_pie
    cmp eax, 4
    je soups
    cmp eax, 5
    je shawarma
    cmp eax, 6
    je pink_gold_carrot
    cmp eax, 7
    je pink_gold_apple
    cmp eax, 8
    je enchanted_pink_gold_apple
    cmp eax, 9
    je _drinks
    cmp eax, 10
    je exit

    jmp select_menu

; DRAW
draw_menu:
    sub rsp, 40
    call console_clear

    call color_def
    mov rcx, [select_food]
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
    lea rbx, [food_menu]
    mov rcx, [rbx + r12*8]
    call printf

    inc r12
    jmp draw_loop

draw_done:
    add rsp, 40
    ret

; CASES
lemon:
    print lemon_message

fried_flesh:
    print fried_flesh_message

berry_pie:
    print berry_pie_message

soups:
    print soups_message

shawarma:
    print shawarma_message

pink_gold_carrot:
    print pink_gold_carrot_message

pink_gold_apple:
    print pink_gold_apple_message

enchanted_pink_gold_apple:
    print enchanted_pink_gold_apple_message

_drinks:
    call console_clear
    call drinks
    cmp [food_module], 1
    je food_start
    jmp _drinks

return_back:
    call back2menu
    call _getch
    call console_clear
    call color_def
    jmp food_start

exit:
    add rsp, 40
    xor ecx, ecx
    mov [module], 1
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