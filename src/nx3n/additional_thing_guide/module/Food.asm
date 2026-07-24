default rel
global food

extern colored_print, printf            ; Вывод текста
extern _getch                           ; Символ | Char
extern console_clear                    ; Очистка
extern back                             ; Глобальные Строки
extern color_green, color_red, color_def; Цвета

%define itemCount 10

section .data
    message db "Выбери еду:", 13, 10, 0

    item1 db "1) Лимон.", 13, 10, 0
    item2 db "2) Жареная плоть.", 13, 10, 0
    item3 db "3) Ягодный пирог.", 13, 10, 0
    item4 db "4) Супы.", 13, 10, 0
    item5 db "5) Шаурма.", 13, 10, 0
    item6 db "6) Розово-золотая морковь.", 13, 10, 0
    item7 db "7) Розово-золотое яблоко.", 13, 10, 0
    item8 db "8) Зачарованное розово-золотое яблоко.", 13, 10, 0
    item9 db "9) Напитки.", 13, 10, 0
    item10 db "➥ Назад.", 13, 10, 0

    selected db 1
    menu:
        dq item1
        dq item2
        dq item3
        dq item4
        dq item5
        dq item6
        dq item7
        dq item8
        dq item9
        dq item10

    lemon_message:
        db "$dЛимон.", 10
        db "Крафт отсутствует. Выпадает с листвы лимонного дерева.", 10
        db "$rБаффы отсутствуют.$d", 10
        db "$rДебаффы$d: уменьшает насыщение на 1.", 10
        db "$cЕдиницы голода$d: +0.5.", 10
        db "$yСтак$d: 64 штуки.", 0

    fried_flesh_message:
        db "$dЖареная плоть.", 10
        db "Крафт: Пережарка гнилой плоти в печке/коптильне.", 10
        db "$rБаффы отсутствуют.$d", 10
        db "$rДебаффы отсутствуют.$d", 10
        db "$cЕдиницы голода$d: +2.5.", 10
        db "$yСтак$d: 64 штуки.", 0

    berry_pie_message:
        db "$dЯгодный пирог.", 10
        db "Крафт: 2 яйца, 1 ведро молока, 3 пшеницы, 3 сладких ягоды.", 10
        db "$rБаффы отсутствуют.$d", 10
        db "$rДебаффы отсутствуют.$d", 10
        db "$cЕдиницы голода$d: +5.", 10
        db "$yСтак$d: 64 штуки.", 0

    soups_message:
        db "$dСупы.", 10
        db "$rБаффы отсутствуют.$d", 10
        db "$rДебаффы отсутствуют.$d", 10
        db "Щи:", 10
        db "    Крафт: 3 морской травы, 1 миска, 1 ламинария, 3 морских огурца.", 10
        db "    $cЕдиницы голода$d: +3.", 10
        db "    $yСтак$d: 16 штук.", 10
        db "", 10
        db "Куриный суп:", 10
        db "    Крафт: 2 картошки, 1 морская трава, 1 морковь, 1 миска, 1 ламинария, 1 курица.", 10
        db "    $cЕдиницы голода$d: +5.", 10
        db "    $yСтак$d: 16 штук.", 10
        db "", 10
        db "Уха:", 10
        db "    Крафт: 1 картошка, 1 морская трава, 1 морковь, 1 ламинария, 1 миска, 1 морской огурец, 1 треска, 1 лосось.", 10
        db "    $cЕдиницы голода$d: +5.", 10
        db "    $yСтак$d: 16 штук.", 0

    shawarma_message:
        db "$dШаурма.", 10
        db "$rБаффы отсутствуют.$d", 10
        db "$rДебаффы отсутствуют.$d", 10
        db "Куриная:", 10
        db "    Крафт: 1 кусочек железа, 1 жареная курица, 1 запеченный картофель, 1 ламинария, 1 хлеб.", 10
        db "    $cЕдиницы голода$d: +4.", 10
        db "    $yСтак$d: 16 штук.", 10
        db "", 10
        db "С говядиной:", 10
        db "    Крафт: 1 кусочек железа, 1 стейк, 1 запеченный картофель, 1 ламинария, 1 хлеб.", 10
        db "    $cЕдиницы голода$d: +5.", 10
        db "    $yСтак$d: 16 штук.", 10
        db "", 10
        db "Со свининой:", 10
        db "    Крафт: 1 кусочек железа, 1 жареная свинина, 1 запеченный картофель, 1 ламинария, 1 хлеб.", 10
        db "    $cЕдиницы голода$d: +5.", 10
        db "    $yСтак$d: 16 штук.", 10
        db "", 10
        db "С бараниной:", 10
        db "    Крафт: 1 кусочек железа, 1 жареная баранина, 1 запеченный картофель, 1 ламинария, 1 хлеб.", 10
        db "    $cЕдиницы голода$d: +4.", 10
        db "    $yСтак$d: 16 штук.", 10
        db "", 10
        db "Обычная:", 10
        db "    Крафт: 1 кусочек железа, все жареное мясо из майнкрафта по 1, 1 запеченный картофель, 1 ламинария, 1 хлеб.", 10
        db "    $cЕдиницы голода$d: +7.", 10
        db "    $yСтак$d: 16 штук.", 0

    pink_gold_carrot_message:
        db "$dРозово-золотая морковь.", 10
        db "Крафт: 1 золотая морковь, 8 кусочков розового золота.", 10
        db "$rБаффы отсутствуют.$d", 10
        db "$rДебаффы отсутствуют.$d", 10
        db "$cЕдиницы голода$d: +4.", 10
        db "$yСтак$d: 64 штуки.", 0

    pink_gold_apple_message:
        db "$dРозово-золотое яблоко.", 10
        db "Крафт: 1 золотое яблоко, 8 слитков розового золота.", 10
        db "$rБаффы$d:", 10
        db "    Поглощение IV — 2:30;", 10
        db "    Регенерация IV — 0:15;", 10
        db "    Сопротивление I — 2:30.", 10
        db "$rДебаффы отсутствуют.$d", 10
        db "$cЕдиницы голода$d: +4.", 10
        db "$yСтак$d: 64 штуки.", 0

    enchanted_pink_gold_apple_message:
        db "$dЗачарованное розово-золотое яблоко.", 10
        db "Крафт:", 10
        db "    - 1 золтое яблоко, 8 блоков розового золота.", 10
        db "        или", 10
        db "    - 1 зачарованное золтое яблоко, 8 слитков розового золота.", 10
        db "$rБаффы$d:", 10
        db "    Сопротивление III — 5:00;", 10
        db "    Поглощение V — 5:00;", 10
        db "    Сила II — 5:00;", 10
        db "    Огнестойкость — 5:00;", 10
        db "    Регенерация VI — 0:15.", 10
        db "        $s*по окончанию Регенерация III — 4:45*$d", 10
        db "$rДебаффы отсутствуют.$d", 10
        db "$cЕдиницы голода$d: +6.", 10
        db "$yСтак$d: 64 штуки.", 0

    drinks_message:
        db "$dНапитки.", 10
        db "Чашка чая:", 10
        db "    Крафт: 2 травы, 1 любой цветок, 1 розовый лепесток, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Регенерация III — 0:15.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +1.", 10
        db "    $yСтак$d: 16 штук.", 10

        db "Чашка какао:", 10
        db "    Крафт: 3 какао боба, 3 сахара, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Регенерация — 0:15;", 10
        db "        Сопротивление — 0:05.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +2.", 10
        db "    $yСтак$d: 16 штук.", 10

        db "Чашка кофе:", 10
        db "    Крафт: 6 какао бобов, 2 сахара, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Скорость II — 0:15;", 10
        db "        Спешка — 0:15.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +2.", 10
        db "    $yСтак$d: 16 штук.", 10

        db "Чашка лимонада:", 10
        db "    Крафт: 4 лимона, 4 сахара, 1 чашка.", 10
        db "    Баффы:", 10
        db "        Ночное зрение — 0:15;", 10
        db "        Сопротивление — 0:05.", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +1.", 10
        db "    $yСтак$d: 16 штук.", 10

        db "Радужный коктейль:", 10
        db "    Крафт: 2 осколка эха, 4 сердца вардена, 2 золотых зачарованных золотых яблока, 1 бутылка.", 10
        db "    Баффы:", 10
        db "        Сопротивление II — 10:00;", 10
        db "        Поглощение V — 10:00;", 10
        db "        Огнестойкость — 10:00;", 10
        db "        Регенерация III — 10:00;", 10
        db "        Сила II — 10:00;", 10
        db "        Скорость III — 10:00;", 10
        db "        Подводное дыхание — 10:00;", 10
        db "        Ночное зрение — 10:00;", 10
        db "    $rДебаффы отсутствуют.$d", 10
        db "    $cЕдиницы голода$d: +10.", 10
        db "    $yСтак$d: 1 штука.", 0

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
    je drinks
    cmp eax, 10
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
lemon:
    call console_clear
    lea rcx, [lemon_message]
    call colored_print
    jmp return_back

fried_flesh:
    call console_clear
    lea rcx, [fried_flesh_message]
    call colored_print
    jmp return_back

berry_pie:
    call console_clear
    lea rcx, [berry_pie_message]
    call colored_print
    jmp return_back

soups:
    call console_clear
    lea rcx, [soups_message]
    call colored_print
    jmp return_back

shawarma:
    call console_clear
    lea rcx, [shawarma_message]
    call colored_print
    jmp return_back

pink_gold_carrot:
    call console_clear
    lea rcx, [pink_gold_carrot_message]
    call colored_print
    jmp return_back

pink_gold_apple:
    call console_clear
    lea rcx, [pink_gold_apple_message]
    call colored_print
    jmp return_back

enchanted_pink_gold_apple:
    call console_clear
    lea rcx, [enchanted_pink_gold_apple_message]
    call colored_print
    jmp return_back

drinks:
    call console_clear
    lea rcx, [drinks_message]
    call colored_print
    jmp return_back

return_back:
    lea rcx, [back]
    call colored_print
    call _getch
    call console_clear
    call color_def
    jmp food_start

exit:
    add rsp, 40
    xor ecx, ecx
    mov r15, 1
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