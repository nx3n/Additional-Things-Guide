default rel
global drinks

extern colored_print, printf            ; Вывод текста
extern _getch                           ; Символ | Char
extern console_clear                    ; Очистка
extern back2menu                        ; Вернуться в меню, текст
extern color_green, color_red, color_def; Цвета

%define itemCount 6

section .data
    message db "Выбери напиток:", 13, 10, 0

    item1 db "1) Чашка чая.", 13, 10, 0
    item2 db "2) Чашка какао.", 13, 10, 0
    item3 db "3) Чашка кофе.", 13, 10, 0
    item4 db "4) Чашка лимонада.", 13, 10, 0
    item5 db "5) Радужный коктейль.", 13, 10, 0
    item6 db "➥ Назад.", 13, 10, 0

    selected db 1
    menu:
        dq item1
        dq item2
        dq item3
        dq item4
        dq item5
        dq item6

    cup_of_tea_message:
        db "$dНапитки.", 10
        db "Чашка чая:", 10
        db "    Крафт: 2 травы, 1 любой цветок, 1 розовый лепесток, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Регенерация III - 0:15.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +1.", 10
        db "    $yСтак$d: 16 штук.", 0

    cup_of_cocoa_message:
        db "$dЧашка какао:", 10
        db "    Крафт: 3 какао боба, 3 сахара, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Регенерация - 0:15;", 10
        db "        Сопротивление - 0:05.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +2.", 10
        db "    $yСтак$d: 16 штук.", 0

    cup_of_coffee_message:
        db "$dЧашка кофе:", 10
        db "    Крафт: 6 какао бобов, 2 сахара, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Скорость II - 0:15;", 10
        db "        Спешка - 0:15.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +2.", 10
        db "    $yСтак$d: 16 штук.", 0

    cup_of_lemonade_message:
        db "$dЧашка лимонада:", 10
        db "    Крафт: 4 лимона, 4 сахара, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Ночное зрение - 0:15;", 10
        db "        Сопротивление - 0:05.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +1.", 10
        db "    $yСтак$d: 16 штук.", 0

    rainbow_cocktail_message:
        db "$dРадужный коктейль:", 10
        db "    Крафт: 2 осколка эха, 4 сердца вардена, 2 золотых зачарованных золотых яблока, 1 бутылка.", 10
        db "    Баффы:", 10
        db "        Сопротивление II - 10:00;", 10
        db "        Поглощение V - 10:00;", 10
        db "        Огнестойкость - 10:00;", 10
        db "        Регенерация III - 10:00;", 10
        db "        Сила II - 10:00;", 10
        db "        Скорость III - 10:00;", 10
        db "        Подводное дыхание - 10:00;", 10
        db "        Ночное зрение - 10:00;", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +10.", 10
        db "    $yСтак$d: 1 штука.", 0
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

    mov r14, 0

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

cup_of_tea:
    call console_clear
    lea rcx, [cup_of_tea_message]
    call colored_print
    jmp return_back

cup_of_cocoa:
    call console_clear
    lea rcx, [cup_of_cocoa_message]
    call colored_print
    jmp return_back

cup_of_coffee:
    call console_clear
    lea rcx, [cup_of_coffee_message]
    call colored_print
    jmp return_back

cup_of_lemonade:
    call console_clear
    lea rcx, [cup_of_lemonade_message]
    call colored_print
    jmp return_back

rainbow_cocktail:
    call console_clear
    lea rcx, [rainbow_cocktail_message]
    call colored_print
    jmp return_back

return_back:
    call back2menu
    call _getch
    call console_clear
    call color_def
    jmp drinks_start

exit:
    add rsp, 40
    mov r14, 1
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