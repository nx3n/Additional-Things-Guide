%macro colored_print_msys 3
global colored_print

extern putchar
extern color_red, color_green, color_def, color_cyan
extern color_gray, color_white, color_yellow
extern color_light_yellow

section .text
colored_print:
        push r12
        sub rsp, %3
        mov r12, %1

    colored_print_loop:
        mov al, [r12]
        test al, al
        jz %%exit

        cmp al, '$'
        je colored_print_tag

        movzx %2, al
        call putchar

        inc r12
        jmp colored_print_loop

    colored_print_tag:
        inc r12
        mov al, [r12]
        test al, al
        jz %%exit

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

        mov %2, '$'
        call putchar
        jmp colored_print_loop

    colored_print_red:
        call color_red
        inc r12
        jmp colored_print_loop

    colored_print_green:
        call color_green
        inc r12
        jmp colored_print_loop

    colored_print_cyan:
        call color_cyan
        inc r12
        jmp colored_print_loop

    colored_print_gray:
        call color_gray
        inc r12
        jmp colored_print_loop

    colored_print_white:
        call color_white
        inc r12
        jmp colored_print_loop

    colored_print_yellow:
        call color_yellow
        inc r12
        jmp colored_print_loop

    colored_print_light_yellow:
        call color_light_yellow
        inc r12
        jmp colored_print_loop

    colored_print_def:
        call color_def
        inc r12
        jmp colored_print_loop

    %%exit:
        add rsp, %3
        pop r12
        ret
%endmacro