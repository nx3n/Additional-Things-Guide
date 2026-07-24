default rel
global colored_print

extern printf
extern putchar
extern color_red, color_green, color_def, color_cyan
extern color_gray, color_white, color_yellow
extern color_light_yellow

section .text
colored_print:
    push rsi
    sub rsp, 32

    mov rsi, rcx

colored_print_loop:
    mov al, [rsi]
    test al, al
    jz exit

    cmp al, '$'
    je colored_print_tag

    movzx ecx, al
    call putchar

    inc rsi
    jmp colored_print_loop

colored_print_tag:
    inc rsi
    mov al, [rsi]

    cmp al, 'r'
    je colored_print_red
    cmp al, 'g'
    je colored_print_green
    cmp al, 'c'
    je colored_print_cyan
    cmp al, 's'
    je colored_print_gray
    cmp al, 'w'
    je colored_print_white
    cmp al, 'y'
    je colored_print_yellow
    cmp al, 'Y'
    je colored_print_light_yellow
    cmp al, 'd'
    je colored_print_def

    mov ecx, '$'
    call putchar
    jmp colored_print_loop

colored_print_red:
    call color_red
    inc rsi
    jmp colored_print_loop

colored_print_green:
    call color_green
    inc rsi
    jmp colored_print_loop

colored_print_cyan:
    call color_cyan
    inc rsi
    jmp colored_print_loop

colored_print_gray:
    call color_gray
    inc rsi
    jmp colored_print_loop

colored_print_white:
    call color_white
    inc rsi
    jmp colored_print_loop

colored_print_yellow:
    call color_yellow
    inc rsi
    jmp colored_print_loop

colored_print_light_yellow:
    call color_light_yellow
    inc rsi
    jmp colored_print_loop

colored_print_def:
    call color_def
    inc rsi
    jmp colored_print_loop

exit:
    add rsp, 32
    pop rsi
    ret