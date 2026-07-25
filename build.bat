@echo off
chcp 65001 >nul
mkdir "%~dp0.build"

:: 1. NASM код
nasm -f win64 src\nx3n\additional_thing_guide\Main.asm -o .build\Main.obj
nasm -f win64 src\nx3n\additional_thing_guide\ConsoleClear.asm -o .build\ConsoleClear.obj

nasm -f win64 src\nx3n\additional_thing_guide\color\ColoredPrint.asm -o .build\ColoredPrint.obj
nasm -f win64 src\nx3n\additional_thing_guide\color\ColorManager.asm -o .build\ColorManager.obj

nasm -f win64 src\nx3n\additional_thing_guide\module\ArmorAndTools.asm -o .build\ArmorAndTools.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\ModInfo.asm -o .build\ModInfo.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\Ore.asm -o .build\Ore.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\drinks_and_food\Drinks.asm -o .build\Drinks.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\drinks_and_food\Food.asm -o .build\Food.obj

:: 2. Линковка
gcc .build\Main.obj ^
.build\ConsoleClear.obj ^
.build\ColoredPrint.obj ^
.build\ColorManager.obj ^
.build\ArmorAndTools.obj ^
.build\Drinks.obj ^
.build\Food.obj ^
.build\ModInfo.obj ^
.build\Ore.obj ^
-o "Additional Things - Справочник.exe" ^
-lkernel32

echo.
echo BUILD FINISHED WITH ERRORLEVEL %errorlevel%
pause