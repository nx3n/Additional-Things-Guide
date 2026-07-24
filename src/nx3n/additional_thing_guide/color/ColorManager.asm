default rel
global color_red
global color_gray
global color_cyan
global color_green
global color_white
global color_yellow
global color_light_yellow
global color_def

extern SetConsoleTextAttribute
extern GetStdHandle

%define red 12
%define gray 8
%define cyan 11
%define green 10
%define yellow 6
%define light_yellow 14
%define white 15
%define base 7

section .text
color_red:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, red
    call SetConsoleTextAttribute

    jmp exit

color_green:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, green
    call SetConsoleTextAttribute

    jmp exit

color_cyan:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, cyan
    call SetConsoleTextAttribute

    jmp exit

color_gray:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, gray
    call SetConsoleTextAttribute

    jmp exit

color_white:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, white
    call SetConsoleTextAttribute

    jmp exit

color_yellow:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, yellow
    call SetConsoleTextAttribute

    jmp exit

color_light_yellow:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, light_yellow
    call SetConsoleTextAttribute

    jmp exit

color_def:
    sub rsp, 40

    mov ecx, -11
    call GetStdHandle

    mov rcx, rax
    mov edx, base
    call SetConsoleTextAttribute

exit:
    add rsp, 40
    ret