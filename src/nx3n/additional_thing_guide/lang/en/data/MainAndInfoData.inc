en_back db 10, "$sPress any key to return back.$d", 0
en_exit db "➥ Back.", 13, 10, 0

en_at_guide db "Additional Things - Guide.", 13, 10, 0
en_ore_info db "1) Ore information.", 13, 10, 0
en_food_info db "2) Food information.", 13, 10, 0
en_tool_info db "3) Armor and tools information.", 13, 10, 0
en_app_info db "4) Mod and application information.", 13, 10, 0
en_main_exit db "6) Exit.", 13, 10, 0

en_mod_info_message:
    db "$dMod: $rAdditional Things$d.", 10
    db "Version: 2.1, $grelease$d.", 10
    db "Developer: $cnx3n$d.", 10
    db "", 10
    db "Application: $rAdditional Things Guide$d.", 10
    db "Version: 1.1, $grelease$d.", 10
    db "Developer: $cnx3n$d.", 0