ru_back db 10, "$sНажми на любую клавишу, что бы вернуться обратно.$d", 0
ru_exit db "➥ Назад.", 13, 10, 0

ru_at_guide db "Additional Things - Справочник.", 13, 10, 0
ru_ore_info db "1) Информация о рудах.", 13, 10, 0
ru_food_info db "2) Информация о еде.", 13, 10, 0
ru_tool_info db "3) Информация о броне и инструментах.", 13, 10, 0
ru_app_info db "4) Информация о моде и приложении.", 13, 10, 0
ru_main_exit db "6) Выйти.", 13, 10, 0

ru_mod_info_message:
    db "$dМод: $rAdditional Things$d.", 10
    db "Версия: 2.0, $grelease$d.", 10
    db "Разработчик: $cnx3n$d.", 10
    db "", 10
    db "Приложение: $rСправочник по моду Additional Things$d.", 10
    db "Версия: 1.0.1, $grelease$d.", 10
    db "Разработчик: $cnx3n$d.", 0