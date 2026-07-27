default rel
global armor_and_tools

extern module
extern colored_print, printf            ; Output text | Вывод текста
extern _getch                           ; Char | Символ
extern console_clear                    ; Clear | Очистка
extern back2menu                        ; Back to menu | Вернуться в меню
extern color_green, color_red, color_def; Colors | Цвета
; Strings | Строки
extern select_material
extern armor_and_tools_menu
extern copper_material_message, lapis_material_message, pink_gold_material_message, amethyst_material_message
extern redstone_material_message, quartz_material_message, emerald_material_message, red_diamond_material_message
extern sky_crystal_material_message, hell_crystal_material_message, wolfram_material_message
extern red_netherite_material_message_1, red_netherite_material_message_2
extern enderite_material_message_1, enderite_material_message_2

%include "../macro/MacroPrint.inc"
%include "../macro/MacroDoublePrint.inc"

%define itemCount 14

section .data
    selected db 1

section .text
armor_and_tools:
    sub rsp, 40

armor_and_tools_start:
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
    je copper
    cmp eax, 2
    je lapis
    cmp eax, 3
    je pink_gold
    cmp eax, 4
    je amethyst
    cmp eax, 5
    je redstone
    cmp eax, 6
    je quartz
    cmp eax, 7
    je emerald
    cmp eax, 8
    je red_diamond
    cmp eax, 9
    je sky_crystal
    cmp eax, 10
    je hell_crystal
    cmp eax, 11
    je wolfram
    cmp eax, 12
    je red_nethrite
    cmp eax, 13
    je enderite
    cmp eax, 14
    je exit

    jmp select_menu

; DRAW
draw_menu:
    sub rsp, 40
    call console_clear

    call color_def
    mov rcx, [select_material]
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
    lea rbx, [armor_and_tools_menu]
    mov rcx, [rbx + r12*8]
    call printf

    inc r12
    jmp draw_loop

draw_done:
    add rsp, 40
    ret

; CASES
copper:
    print copper_material_message

lapis:
    print lapis_material_message

pink_gold:
    print pink_gold_material_message

amethyst:
    print amethyst_material_message

redstone:
    print redstone_material_message

quartz:
    print quartz_material_message

emerald:
    print emerald_material_message

red_diamond:
    print red_diamond_material_message

sky_crystal:
    print sky_crystal_material_message

hell_crystal:
    print hell_crystal_material_message

wolfram:
    print wolfram_material_message

red_nethrite:
    double_print red_netherite_material_message_1, red_netherite_material_message_2

enderite:
    double_print enderite_material_message_1, enderite_material_message_2

return_back:
    call back2menu
    call _getch
    call console_clear
    call color_def
    jmp armor_and_tools_start

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