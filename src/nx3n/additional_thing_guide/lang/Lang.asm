default rel
global lang

extern selected_lang

%include "../macro/Macro.inc"
%include "en/LangEN.inc"
%include "ru/LangRU.inc"
section .data
    %include "LangLabels.inc"

    %include "en/data/MainAndInfoData.inc"
    %include "en/data/ArmorAndToolsData.inc"
    %include "en/data/OreData.inc"
    %include "en/data/DrinksData.inc"
    %include "en/data/FoodData.inc"

    %include "ru/data/MainAndInfoData.inc"
    %include "ru/data/ArmorAndToolsData.inc"
    %include "ru/data/OreData.inc"
    %include "ru/data/DrinksData.inc"
    %include "ru/data/FoodData.inc"

    uni_lang_pick db "5) Language | Язык.", 13, 10, 0

section .text
lang:
    sub rsp, 40

    cmp byte [selected_lang], 1
    je ru
    jmp en

ru:
    call lang_ru
    jmp exit

en:
    call lang_en

exit:
    add rsp, 40
    ret