%macro double_print 2
    call console_clear
    mov rcx, [%1]
    call colored_print
    mov rcx, [%2]
    call colored_print
    jmp return_back
%endmacro