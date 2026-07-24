default rel
global console_clear

extern GetStdHandle, GetConsoleScreenBufferInfo
extern FillConsoleOutputCharacterA, FillConsoleOutputAttribute
extern SetConsoleCursorPosition

STD_OUTPUT_HANDLE equ -11

section .bss
    console_info resb 22
    written      resd 1

section .text
console_clear:
    push rbx
    sub rsp, 48

    mov ecx, STD_OUTPUT_HANDLE
    call GetStdHandle

    mov rbx, rax

    mov rcx, rbx
    lea rdx, [console_info]
    call GetConsoleScreenBufferInfo

    test eax, eax
    jz exit

    movzx eax, word [console_info]
    movzx edx, word [console_info + 2]
    imul eax, edx
    mov r10d, eax

    mov rcx, rbx
    mov edx, ' '
    mov r8d, r10d
    xor r9d, r9d
    lea rax, [written]
    mov [rsp + 32], rax
    call FillConsoleOutputCharacterA

    mov rcx, rbx
    movzx edx, word [console_info + 8]
    mov r8d, r10d
    xor r9d, r9d
    lea rax, [written]
    mov [rsp + 32], rax
    call FillConsoleOutputAttribute

    mov rcx, rbx
    xor edx, edx
    call SetConsoleCursorPosition

exit:
    add rsp, 48
    pop rbx
    ret