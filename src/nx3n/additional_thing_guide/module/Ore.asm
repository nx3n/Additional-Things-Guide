default rel
global ore

extern colored_print, printf            ; Вывод текста
extern _getch                           ; Символ | Char
extern console_clear                    ; Очистка
extern back2menu                        ; Вернуться в меню, текст
extern color_green, color_red, color_def; Цвета

%define itemCount 6

section .data
    message db "Выбери руду:", 13, 10, 0
    item1 db "1) Красные алмазы.", 13, 10, 0
    item2 db "2) Небесные кристаллы.", 13, 10, 0
    item3 db "3) Адские кристаллы.", 13, 10, 0
    item4 db "4) Вольфрам.", 13, 10, 0
    item5 db "5) Красный незерит.", 13, 10, 0
    item6 db "➥ Назад.", 13, 10, 0

    selected db 1
    menu:
        dq item1
        dq item2
        dq item3
        dq item4
        dq item5
        dq item6

    red_diamond_message:
        db "$dКрасные алмазы.", 10
        db "Спавн: $gОбычный мир$d, от $r-64$d до $g30$d по Y.", 10
        db "Добыча: $cАлмазная$d кирка и выше.", 0

    sky_crystal_message:
        db "$dНебесные кристаллы.", 10
        db "Спавн: $gОбычный мир$d, от $r-60$d до $g60$d по Y.", 10
        db "Добыча: $cАлмазная$d кирка и выше.", 0

    hell_crystal_message:
        db "$dАдские кристаллы.", 10
        db "Спавн: $rНезер$d, от $r20$d до $g60$d по Y.", 10
        db "Добыча: $cАлмазная кирка$d и выше.", 0

    wolfram_message:
        db "$dВольфрам.", 10
        db "Спавн: $rНезер$d, от $r40$d до $g120$d по Y.", 10
        db "Добыча: $sНезеритовая$d кирка и выше.", 0

    red_nethrite_message:
        db "$dКрасный незерит.", 10
        db "Спавн: $rНезер$d, от $r0$d до $g30$d по Y.", 10
        db "Добыча: Кирка $r5 уровня добычи$d и выше.", 0

section .text
ore:
    sub rsp, 40

ore_start:
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
    je red_diamond
    cmp eax, 2
    je sky_crystal
    cmp eax, 3
    je hell_crystal
    cmp eax, 4
    je wolfram
    cmp eax, 5
    je red_nethrite
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

; CASES
red_diamond:
    call console_clear
    lea rcx, [red_diamond_message]
    call colored_print
    jmp return_back

sky_crystal:
    call console_clear
    lea rcx, [sky_crystal_message]
    call colored_print
    jmp return_back

hell_crystal:
    call console_clear
    lea rcx, [hell_crystal_message]
    call colored_print
    jmp return_back

wolfram:
    call console_clear
    lea rcx, [wolfram_message]
    call colored_print
    jmp return_back

red_nethrite:
    call console_clear
    lea rcx, [red_nethrite_message]
    call colored_print
    jmp return_back

return_back:
    call back2menu
    call _getch
    call console_clear
    call color_def
    jmp ore_start

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