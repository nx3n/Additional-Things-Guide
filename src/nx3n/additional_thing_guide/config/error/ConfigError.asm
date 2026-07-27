default rel
global config_error
global error_code

extern colored_print

%macro error_print 1
    lea rcx, [error]
    call colored_print
    lea rcx, [%1]
    call colored_print
%endmacro
section .data
    %include "ConfigErrorCode.inc"
    error db "$rConfig error!$d ", 13, 10, 0
    error_code db 0

section .text
config_error:
    sub rsp, 40

    cmp byte [error_code], 1
    je write_error
    jmp read_error

write_error:
    error_print writer
    jmp exit

read_error:
    error_print reader

exit:
    add rsp, 40
    ret