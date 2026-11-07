global back
; Main
global at_guide
global main_menu_message
; Ore
global select_ore
global ore_menu
global red_diamond_message, sky_crystal_message, hell_crystal_message, wolfram_message, red_netherite_message
; Food
global select_food
global food_menu
global lemon_message, fried_flesh_message, berry_pie_message, soups_message
global shawarma_message, pink_gold_carrot_message, pink_gold_apple_message
global enchanted_pink_gold_apple_message
; Drinks
global select_drink
global drink_menu
global cup_of_tea_message, cup_of_cocoa_message
global cup_of_coffee_message, cup_of_lemonade_message
global rainbow_cocktail_message
; Armor
global select_material
global armor_and_tools_menu
global copper_material_message, lapis_material_message, emerald_material_message
global amethyst_material_message, redstone_material_message, quartz_material_message
global pink_gold_material_message, red_diamond_material_message, wolfram_material_message
global sky_crystal_material_message,hell_crystal_material_message
global red_netherite_material_message_1, red_netherite_material_message_2
global enderite_material_message_1, enderite_material_message_2
; Mod Info
global mod_info_message

section .data

    back           dq 0
    at_guide       dq 0
    main_menu_message:
        ore_info   dq 0
        food_info  dq 0
        tool_info  dq 0
        app_info   dq 0
        pick_lang  dq 0
        main_exit  dq 0

    select_ore dq 0
    ore_menu:
        red_diamonds_ore    dq 0
        sky_crystals_ore    dq 0
        hell_crystals_ore   dq 0
        wolfram_ore         dq 0
        red_netherite_ore   dq 0
        ore_exit            dq 0
    ore_message:
        red_diamond_message   dq 0
        sky_crystal_message   dq 0
        hell_crystal_message  dq 0
        wolfram_message       dq 0
        red_netherite_message dq 0

    select_food dq 0
    food_menu:
        lemon_food                      dq 0
        fried_flesh_food                dq 0
        berry_pie_food                  dq 0
        soups_food                      dq 0
        shawarma_food                   dq 0
        pink_gold_carrot_food           dq 0
        pink_gold_apple_food            dq 0
        enchanted_pink_gold_apple_food  dq 0
        drinks                          dq 0
        food_exit                       dq 0
    food_message:
        lemon_message                      dq 0
        fried_flesh_message                dq 0
        berry_pie_message                  dq 0
        soups_message                      dq 0
        shawarma_message                   dq 0
        pink_gold_carrot_message           dq 0
        pink_gold_apple_message            dq 0
        enchanted_pink_gold_apple_message  dq 0
    select_drink dq 0
    drink_menu:
        cup_of_tea_drink        dq 0
        cup_of_cocoa_drink      dq 0
        cup_of_coffee_drink     dq 0
        cup_of_lemonade_drink   dq 0
        rainbow_cocktail_drink  dq 0
        drink_exit              dq 0
    drink_message:
        cup_of_tea_message          dq 0
        cup_of_cocoa_message        dq 0
        cup_of_coffee_message       dq 0
        cup_of_lemonade_message     dq 0
        rainbow_cocktail_message    dq 0

    select_material dq 0
    armor_and_tools_menu:
        copper_material         dq 0
        lapis_material          dq 0
        pink_gold_material      dq 0
        amethyst_material       dq 0
        redstone_material       dq 0
        quartz_material         dq 0
        emerald_material        dq 0
        red_diamond_material    dq 0
        sky_crystal_material    dq 0
        hell_crystal_material   dq 0
        wolfram_material        dq 0
        red_netherite_material  dq 0
        enderite_material       dq 0
        armor_exit              dq 0

    armor_and_tools_message:
        copper_material_message            dq 0
        lapis_material_message             dq 0
        pink_gold_material_message         dq 0
        amethyst_material_message          dq 0
        redstone_material_message          dq 0
        quartz_material_message            dq 0
        emerald_material_message           dq 0
        red_diamond_material_message       dq 0
        sky_crystal_material_message       dq 0
        hell_crystal_material_message      dq 0
        wolfram_material_message           dq 0
        red_netherite_material_message_1   dq 0
        red_netherite_material_message_2   dq 0
        enderite_material_message_1        dq 0
        enderite_material_message_2        dq 0

    mod_info_message dq 0