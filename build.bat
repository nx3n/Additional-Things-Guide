@echo off
mkdir "%~dp0.build"

:: 1. NASM код
nasm -f win64 src\nx3n\additional_thing_guide\Main.asm -o .build\Main.obj
nasm -f win64 src\nx3n\additional_thing_guide\ConsoleClear.asm -o .build\ConsoleClear.obj

nasm -f win64 src\nx3n\additional_thing_guide\color\ColoredPrint.asm -o .build\ColoredPrint.obj
nasm -f win64 src\nx3n\additional_thing_guide\color\ColorManager.asm -o .build\ColorManager.obj

nasm -f win64 src\nx3n\additional_thing_guide\module\ArmorAndTools.asm -o .build\ArmorAndTools.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\Food.asm -o .build\Food.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\ModInfo.asm -o .build\ModInfo.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\Ore.asm -o .build\Ore.obj

:: 2. Линковка
gcc .build\Main.obj ^
.build\ConsoleClear.obj ^
.build\ColoredPrint.obj ^
.build\ColorManager.obj ^
.build\ArmorAndTools.obj ^
.build\Food.obj ^
.build\ModInfo.obj ^
.build\Ore.obj ^
-o AT_Console_Guide.exe ^
-lkernel32

echo.
echo BUILD FINISHED WITH ERRORLEVEL %errorlevel%
pause