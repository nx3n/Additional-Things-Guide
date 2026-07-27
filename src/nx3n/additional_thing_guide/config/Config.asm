default rel
global config
global file_name

extern selected_lang

extern config_find
extern file_status
extern config_reader
extern config_value
extern config_write

section .bss

section .data
    file_name db "C:\ProgramData\21fc671192598c936b742edf2c557a43fe90bea9", 0
    lang db "%d", 0

section .text
config:
    sub rsp, 40

    call config_find
    cmp byte [file_status], 0
    je not_found

found:
    call config_reader
    cmp dword [config_value], 1
    je rus
    cmp dword [config_value], 2
    je eng

rus:
    mov byte [selected_lang], 1
    jmp exit

eng:
    mov byte [selected_lang], 2
    jmp exit

not_found:
    call config_write

exit:
    add rsp, 40
    ret