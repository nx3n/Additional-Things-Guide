default rel
global config_write

extern selected_lang

extern fopen
extern fprintf
extern fclose
extern file_name
extern config_error
extern error_code

%macro fwrite 1
    mov rcx, rbx
    lea rdx, [fmt]
    mov r8, %1
    call fprintf
%endmacro
section .data
    openmode db "w", 0
    fmt db "%d", 0

section .text
config_write:
    sub rsp, 40

    lea rcx, [file_name]
    lea rdx, [openmode]
    call fopen

    test rax, rax
    jz error

    mov rbx, rax

    cmp byte [selected_lang], 1
    je rus
    cmp byte [selected_lang], 2
    je eng

    jmp close

rus:
    fwrite 1
    jmp close

eng:
    fwrite 2

close:
    mov rcx, rbx
    call fclose

exit:
    add rsp, 40
    ret

error:
    mov [error_code], 1
    call config_error
    add rsp, 40
    ret