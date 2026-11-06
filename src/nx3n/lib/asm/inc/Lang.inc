%macro set_lang 2
    lea rax, [rel %1]
    mov [rel %2], rax
%endmacro

%define modVer 2.2
%define appVer 2.0
%define author 'nx3n'
%define branch 'release'

%macro lang_macro 2
global lang

%include "lang/en/LangEN.inc"
%include "lang/ru/LangRU.inc"
section .data
    %include "lang/LangLabels.inc"

    %include "lang/en/data/MainAndInfoData.inc"
    %include "lang/en/data/ArmorAndToolsData.inc"
    %include "lang/en/data/OreData.inc"
    %include "lang/en/data/DrinksData.inc"
    %include "lang/en/data/FoodData.inc"

    %include "lang/ru/data/MainAndInfoData.inc"
    %include "lang/ru/data/ArmorAndToolsData.inc"
    %include "lang/ru/data/OreData.inc"
    %include "lang/ru/data/DrinksData.inc"
    %include "lang/ru/data/FoodData.inc"

    uni_lang_pick db "5) Language | Язык.", 13, 10, 0

section .text
lang:
    sub rsp, %2
    test %1, %1
    jz en

ru:
    call lang_ru
    jmp %%exit

en:
    call lang_en

%%exit:
    add rsp, %2
    ret
%endmacro