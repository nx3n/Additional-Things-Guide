default rel
global config_reader
global config_value

extern fopen
extern fscanf
extern fclose
extern file_name
extern config_error
extern error_code

section .bss
    number resd 1

section .data
    config_value dd 0
    openmode db "r", 0
    fmt db "%d", 0


section .text
config_reader:
    sub rsp, 40

    lea rcx, [file_name]
    lea rdx, [openmode]
    call fopen

    test rax, rax
    jz error

    mov rbx, rax

    mov rcx, rbx
    lea rdx, [fmt]
    lea r8,  [number]
    call fscanf

    mov eax, [number]
    mov [config_value], eax

    mov rcx, rbx
    call fclose

exit:
    add rsp, 40
    ret

error:
    mov [error_code], 2
    call config_error
    add rsp, 40
    ret