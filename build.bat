@echo off
chcp 65001 >nul
mkdir "%~dp0.build" 2>nul

:: 1. NASM код
nasm -f win64 src\nx3n\additional_thing_guide\Main.asm -o .build\Main.obj
nasm -f win64 src\nx3n\additional_thing_guide\MainMenu.asm -o .build\MainMenu.obj
nasm -f win64 src\nx3n\additional_thing_guide\ConsoleClear.asm -o .build\ConsoleClear.obj

nasm -f win64 src\nx3n\additional_thing_guide\color\ColoredPrint.asm -o .build\ColoredPrint.obj
nasm -f win64 src\nx3n\additional_thing_guide\color\ColorManager.asm -o .build\ColorManager.obj

nasm -f win64 -I src\nx3n\additional_thing_guide\config\error\ ^
  src\nx3n\additional_thing_guide\config\error\ConfigError.asm -o .build\ConfigError.obj
nasm -f win64 src\nx3n\additional_thing_guide\config\Config.asm -o .build\Config.obj
nasm -f win64 src\nx3n\additional_thing_guide\config\actions\ConfigFind.asm -o .build\ConfigFind.obj
nasm -f win64 src\nx3n\additional_thing_guide\config\actions\ConfigReader.asm -o .build\ConfigReader.obj
nasm -f win64 src\nx3n\additional_thing_guide\config\actions\ConfigWrite.asm -o .build\ConfigWrite.obj

nasm -f win64 -I src\nx3n\additional_thing_guide\lang\ ^
  src\nx3n\additional_thing_guide\lang\Lang.asm -o .build\Lang.obj

nasm -f win64 -I src\nx3n\additional_thing_guide\module\ ^
  src\nx3n\additional_thing_guide\module\ArmorAndTools.asm -o .build\ArmorAndTools.obj
nasm -f win64 -I src\nx3n\additional_thing_guide\module\ ^
  src\nx3n\additional_thing_guide\module\Ore.asm -o .build\Ore.obj
nasm -f win64 -I src\nx3n\additional_thing_guide\module\drinks_and_food\ ^
  src\nx3n\additional_thing_guide\module\food\Drinks.asm -o .build\Drinks.obj
nasm -f win64 -I src\nx3n\additional_thing_guide\module\drinks_and_food\ ^
  src\nx3n\additional_thing_guide\module\food\Food.asm -o .build\Food.obj
nasm -f win64 src\nx3n\additional_thing_guide\module\ModInfo.asm -o .build\ModInfo.obj

:: 2. Линковка
gcc .build\Main.obj ^
.build\MainMenu.obj ^
.build\ConfigError.obj ^
.build\Config.obj ^
.build\ConfigFind.obj ^
.build\ConfigReader.obj ^
.build\ConfigWrite.obj ^
.build\ConsoleClear.obj ^
.build\ColoredPrint.obj ^
.build\ColorManager.obj ^
.build\Lang.obj ^
.build\ArmorAndTools.obj ^
.build\Drinks.obj ^
.build\Food.obj ^
.build\ModInfo.obj ^
.build\Ore.obj ^
-o "Additional Things - Guide.exe" ^
-lkernel32

echo.
echo BUILD FINISHED WITH ERRORLEVEL %errorlevel%
pause