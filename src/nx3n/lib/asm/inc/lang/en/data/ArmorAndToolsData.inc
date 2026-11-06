en_select_material db "Select a material:", 13, 10, 0
en_copper_material db "1) Copper.", 13, 10, 0
en_lapis_material db "2) Lapis Lazuli.", 13, 10, 0
en_pink_gold_material db "3) Pink Gold.", 13, 10, 0
en_amethyst_material db "4) Amethyst.", 13, 10, 0
en_redstone_material db "5) Redstone.", 13, 10, 0
en_quartz_material db "6) Quartz.", 13, 10, 0
en_emerald_material db "7) Emerald.", 13, 10, 0
en_red_diamond_material db "8) Red Diamonds.", 13, 10, 0
en_sky_crystal_material db "9) Sky Crystals.", 13, 10, 0
en_hell_crystal_material db "10) Hell Crystals.", 13, 10, 0
en_wolfram_material db "11) Wolfram.", 13, 10, 0
en_red_netherite_material db "12) Red Netherite.", 13, 10, 0
en_enderite_material db "13) Enderite.", 13, 10, 0
en_copper_material_message:
    db "$dCopper tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    - A copper sword has a 10% chance to strike the target with lightning;", 10
    db "    - A full set of copper armor protects against lightning strikes.", 10
    db "Mining level - $g2$d.", 0
en_lapis_material_message:
    db "$dLapis lazuli tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    - The sword grants the player 10 experience points on hit;", 10
    db "    - The hoe grants the player 10 experience points when tilling soil;", 10
    db "    - The sword/pickaxe/shovel/axe/hoe grants the player 10 experience points when mining a block.", 10
    db "Mining level - $g2$d.", 0
en_pink_gold_material_message:
    db "$dPink gold tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$rNo abilities.$d", 10
    db "Mining level - $g2$d.", 0
en_amethyst_material_message:
    db "$dAmethyst tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    - While wearing a full set of amethyst armor, press X to reduce all incoming damage by 50% for 15 seconds.", 10
    db "        $s*The key can be changed in the settings*$d", 10
    db "Mining level - $g2$d.", 0
en_redstone_material_message:
    db "$dRedstone tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    - While wearing a full set of redstone armor, press X to increase attack damage by 100% for 15 seconds.", 10
    db "        $s*The key can be changed in the settings*$d", 10
    db "Mining level - $g2$d.", 0
en_quartz_material_message:
    db "$dQuartz tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    - While wearing a full set of quartz armor, press X for the following 15-second bonuses:", 10
    db "            $s*The key can be changed in the settings*$d", 10
    db "        - movement speed is increased by 30%;", 10
    db "        - block mining speed is increased by 50%;", 10
    db "        - attack speed is increased by 1.", 10
    db "Mining level - $g2$d.", 0
en_emerald_material_message:
    db "$dEmerald tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    - A full set of emerald armor reduces villager prices by 50%.", 10
    db "Mining level - $g3$d.", 0
en_red_diamond_material_message:
    db "$dRed diamond tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    - The red diamond hammer breaks a 3 by 3 area of blocks.", 10
    db "        $s*The regular diamond hammer breaks a 3 by 1 area.*$d", 10
    db "Mining level - $g3$d.", 0
en_sky_crystal_material_message:
    db "$dSky tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    Sky sword:", 10
    db "        - Has a 50% chance to deal 5 additional damage and summon visual lightning;", 10
    db "        - Has a 10% chance to deal triple damage;", 10
    db "        - Always deals 10 additional damage to the Warden and summons visual lightning.", 10
    db "            $s*These abilities do not affect animals or passive creatures*$d", 10
    db "    Any sky tool or a sky crystal:", 10
    db "        - Prevents attacks against villagers, iron golems, cats, tamed animals, pandas, dolphins, ocelots, parrots, and bees;", 10
    db "        - Mining a block has a 10% chance to duplicate all drops.", 10
    db "            $s*Each level of Fortune adds 5% to the chance*", 10
    db "            *Blocks placed by players are not duplicated*$d", 10
    db "    A sky crystal in either hand or any equipped piece of sky armor blocks lightning and sky damage.", 10
    db "    Sky boots completely block fall damage.", 10
    db "    A full set of sky armor:", 10
    db "        - Blocks damage from falling, lightning, stalactites, stalagmites, flying into a wall, drowning, and sky damage;", 10
    db "        - On death, has a 40% chance to save the player, set health to 10, and remove 100 durability from every armor piece.", 10
    db "Mining level - $g4$d.", 0
en_hell_crystal_material_message:
    db "$dHell tools and armor.", 10
    db "Crafting: Standard.", 10
    db "$yAbilities:$d ", 10
    db "    Hell sword:", 10
    db "        - Sets the target on fire for 10 seconds;", 10
    db "        - Has a 10% chance to deal triple damage;", 10
    db "        - Always deals 10 additional damage to the Warden;", 10
    db "        - Emits fire particles from the target.", 10
    db "    Any hell tool or a hell crystal:", 10
    db "        - Sets the target on fire for 5 seconds on hit;", 10
    db "        - Mining a block has a 10% chance to duplicate all drops.", 10
    db "            $s*Each level of Fortune adds 5% to the chance*", 10
    db "            *Blocks placed by players are not duplicated*$d", 10
    db "    A hell crystal in either hand blocks lava, fire, and hell damage.", 10
    db "    Hell boots completely block fall damage.", 10
    db "    A full set of hell armor:", 10
    db "        - Blocks damage from fire, lava, falling, stalactites, stalagmites, flying into a wall, and hell damage;", 10
    db "        - On death, has a 30% chance to save the player, set health to 8, and remove 100 durability from every armor piece.", 10
    db "Mining level - $g4$d.", 0
en_wolfram_material_message:
    db "$dWolfram tools and armor.", 10
    db "Crafting: Standard.", 10
    db "    Tools: Standard crafting.", 10
    db "    Ingot: 8 wolfram nuggets + 1 diamond.", 10
    db "$yAbilities:$d ", 10
    db "    Wolfram sword:", 10
    db "        - Has a 50% chance on hit to inflict Bleeding on the target for 5 seconds;", 10
    db "            $s*If the target already has Bleeding, its level is increased up to level 5 inclusive*$d", 10
    db "    The wolfram pickaxe automatically smelts blocks it is effective against.", 10
    db "    The wolfram shovel automatically smelts blocks it is effective against.", 10
    db "    The wolfram hoe automatically smelts food harvested from crops.", 10
    db "    A full set of wolfram armor:", 10
    db "        - Completely blocks damage from lava, fire, falling, flying into a wall with elytra, stalagmites, and stalactites;", 10
    db "        - Removes Bleeding;", 10
    db "        - Reduces all damage by 30%.", 10
    db "Mining level - $g5$d.", 0
en_red_netherite_material_message_1:
    db "$dRed netherite tools and armor.", 10
    db "Crafting:", 10
    db "    Items are crafted at a smithing table: ''Red Netherite'' smithing template + red diamond item + red netherite ingot.", 10
    db "    A red netherite ingot is crafted from 4 red netherite scraps + 4 pink gold ingots.", 10
    db "    The ''Red Netherite'' smithing template is crafted from 7 red diamonds + 2 pieces of netherrack.", 10
    db "$yAbilities:$d ", 10
    db "    Red netherite helmet:", 10
    db "        - Adds 15 seconds of Night Vision every tick;", 10
    db "        - Removes the need to eat.", 10
    db "    Red netherite boots:", 10
    db "        - Increase player movement speed by 70% without changing FOV;", 10
    db "        - Increase the player's step height;", 10
    db "            $s*From 0.6 to 1*$d", 10
    db "        - Remove fall damage.", 0
en_red_netherite_material_message_2:
    db "$d  Full armor set:", 10
    db "        - Blocks damage from fire, lava, falling, stalactites, stalagmites, flying into a wall, hell and sky damage, drowning, being stuck inside blocks, and cramming;", 10
    db "        - Reduces all damage by 50%;", 10
    db "        - Doubles natural regeneration speed.", 10
    db "    Red netherite sword:", 10
    db "        - Sets the target on fire for 10 seconds;", 10
    db "        - Has a 30% chance to deal double damage;", 10
    db "        - Drops cooked food after a kill.", 10
    db "    Red netherite pickaxe/shovel/hoe:", 10
    db "        - Automatic smelting can be toggled with Shift + mouse wheel;", 10
    db "        - Has a 15% chance to duplicate drops.", 10
    db "            $s*Each level of Fortune adds 5% to the chance*", 10
    db "            *Blocks placed by players are not duplicated*$d", 10
    db "Mining level - $g6$d.", 0
en_enderite_material_message_1:
    db "$dEnderite tools and armor.", 10
    db "Crafting:", 10
    db "    Items are crafted at a smithing table: ''Enderite'' smithing template + red netherite item + enderite ingot.", 10
    db "    An enderite ingot is crafted from 1 red netherite ingot + 4 ender pearls + 1 Warden Heart.", 10
    db "    The ''Enderite'' smithing template is crafted from 2 red netherite ingots, 5 red diamonds, and 2 pieces of end stone.", 10
    db "$yAbilities:$d ", 10
    db "    Enderite helmet:", 10
    db "        - Adds 15 seconds of Night Vision every tick;", 10
    db "        - Removes the need to eat.", 10
    db "    Enderite boots:", 10
    db "        - Increase player movement speed by 100% without changing FOV;", 10
    db "        - Increase the player's step height;", 10
    db "            $s*From 0.6 to 1*$d", 10
    db "        - Remove the slowdown caused by blocks that reduce movement speed;", 10
    db "        - Remove fall damage.", 0
en_enderite_material_message_2:
    db "$d  Full armor set:", 10
    db "        - Blocks damage from fire, lava, falling, stalactites, stalagmites, flying into a wall, hell and sky damage, drowning, being stuck inside blocks, and cramming;", 10
    db "        - Reduces all damage by 80%;", 10
    db "        - Triples natural regeneration speed.", 10
    db "    Enderite sword:", 10
    db "        - Has a 50% chance to deal double damage;", 10
    db "        - Has a 20% chance to heal the player for the damage dealt to the target;", 10
    db "        - Drops cooked food after a kill.", 10
    db "    Enderite pickaxe/shovel/hoe:", 10
    db "        - Automatic smelting can be toggled with Shift + mouse wheel;", 10
    db "        - Has a 25% chance to duplicate drops.", 10
    db "            $s*Each level of Fortune adds 5% to the chance*", 10
    db "            *Blocks placed by players are not duplicated*$d", 10
    db "Mining level - $g7$d.", 0