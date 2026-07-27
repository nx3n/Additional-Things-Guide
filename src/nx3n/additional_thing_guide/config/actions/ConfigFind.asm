default rel
global config_find
global file_status

extern GetFileAttributesA
extern file_name

section .data
    file_status db 0

section .text
config_find:
    sub rsp, 40

    lea rcx, [file_name]
    call GetFileAttributesA

    cmp eax, -1
    je not_found

found:
    mov byte [file_status], 1
    jmp exit

not_found:
    mov byte [file_status], 0

exit:
    add rsp, 40
    ret