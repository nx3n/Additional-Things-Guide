%macro set_lang 2
    lea rax, [rel %1]
    mov [rel %2], rax
%endmacro