%macro print 1
    call console_clear
    mov rcx, [%1]
    call colored_print
    jmp return_back
%endmacro