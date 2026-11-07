cmake_minimum_required(VERSION 3.20)

# Обычная сборка выпускает сразу три варианта через Zig.
# Для сборки только под текущую ОС: -DATG_BUILD_ALL=OFF.
option(ATG_BUILD_ALL "Build Windows, Linux and macOS x86-64 releases" ON)

if(ATG_BUILD_ALL)
    project(additional_things_guide_console LANGUAGES NONE)
    include(cmake/AllPlatforms.cmake)
    return()
endif()

project(additional_things_guide_console LANGUAGES C)

if(NOT CMAKE_SIZEOF_VOID_P EQUAL 8 OR
   NOT CMAKE_SYSTEM_PROCESSOR MATCHES "^(AMD64|amd64|x86_64|X86_64)$")
    message(FATAL_ERROR "ATG requires x86-64")
endif()

if(WIN32)
    set(ATG_ASM_SOURCE src/nx3n/lib/asm/Windows.asm)
    set(ATG_CONSOLE_SOURCE src/nx3n/lib/gui/Windows.c)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT win64)
elseif(APPLE)
    set(ATG_ASM_SOURCE src/nx3n/lib/asm/Linux.asm)
    set(ATG_CONSOLE_SOURCE src/nx3n/lib/gui/Posix.c)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(ATG_ASM_SOURCE src/nx3n/lib/asm/Linux.asm)
    set(ATG_CONSOLE_SOURCE src/nx3n/lib/gui/Posix.c)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
else()
    message(FATAL_ERROR "Unsupported target system: ${CMAKE_SYSTEM_NAME}")
endif()

# Имена dylib задаются линкеру сразу; после сборки их не переписываем.
# Для NASM поиск install_name_tool на хосте не требуется.
if(APPLE AND CMAKE_CROSSCOMPILING)
    set(CMAKE_PLATFORM_HAS_INSTALLNAME OFF)
endif()
enable_language(ASM_NASM)
if(APPLE AND CMAKE_CROSSCOMPILING)
    set(CMAKE_PLATFORM_HAS_INSTALLNAME ON)
endif()
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

option(ATG_STATIC_RUNTIME "Use static compiler runtime where supported" ON)
option(ATG_STATIC_EXECUTABLE "Link the standalone Linux executable with static libc" OFF)
set(ATG_OUTPUT_DIR "${CMAKE_BINARY_DIR}/dist" CACHE PATH "Release output directory")

add_library(atg_objects OBJECT
    src/nx3n/lib/ATG.c
    src/nx3n/lib/config/Config.c
    src/nx3n/lib/gui/gui.c
    src/nx3n/lib/gui/Colors.c
    src/nx3n/lib/gui/Language.c
    src/nx3n/lib/gui/Print.c
    src/nx3n/lib/module/Main.c
    src/nx3n/lib/module/Ore.c
    src/nx3n/lib/module/Food.c
    src/nx3n/lib/module/Drinks.c
    src/nx3n/lib/module/Tools.c
    ${ATG_CONSOLE_SOURCE}
    ${ATG_ASM_SOURCE})

set_target_properties(atg_objects PROPERTIES POSITION_INDEPENDENT_CODE ON)
target_include_directories(atg_objects PRIVATE src/nx3n/lib)
target_compile_definitions(atg_objects PRIVATE $<$<COMPILE_LANGUAGE:C>:ATG_BUILD>)
target_compile_options(atg_objects PRIVATE
    $<$<COMPILE_LANGUAGE:C>:-O3>
    $<$<COMPILE_LANGUAGE:ASM_NASM>:-I${CMAKE_CURRENT_SOURCE_DIR}/src/nx3n/lib/asm/>
    $<$<COMPILE_LANGUAGE:ASM_NASM>:-I${CMAKE_CURRENT_SOURCE_DIR}/src/nx3n/lib/asm/inc/>
    $<$<COMPILE_LANGUAGE:ASM_NASM>:-Dputchar=atg_putchar>)

if(APPLE)
    target_compile_options(atg_objects PRIVATE $<$<COMPILE_LANGUAGE:ASM_NASM>:--prefix=_>)
endif()

add_library(ATG SHARED $<TARGET_OBJECTS:atg_objects>)
add_library(ATG_static STATIC $<TARGET_OBJECTS:atg_objects>)
set_target_properties(ATG PROPERTIES PREFIX "" OUTPUT_NAME ATG)
set_target_properties(ATG_static PROPERTIES OUTPUT_NAME ATG_static LINKER_LANGUAGE C)

# Самостоятельный запуск: библиотека ATG включена прямо в исполняемый файл.
add_executable(atg_console src/nx3n/testing/Main.c $<TARGET_OBJECTS:atg_objects>)
target_include_directories(atg_console PRIVATE src/nx3n/lib)
target_compile_definitions(atg_console PRIVATE ATG_BUILD)
set_target_properties(atg_console PROPERTIES
    OUTPUT_NAME atg
    ARCHIVE_OUTPUT_NAME ATG_console_import)

# Загрузчик для проверки именно динамической библиотеки.
add_executable(loader src/nx3n/testing/Main.c)
target_include_directories(loader PRIVATE src/nx3n/lib)
target_link_libraries(loader PRIVATE ATG)
set_target_properties(loader PROPERTIES OUTPUT_NAME test)
if(APPLE)
    # Задаём имя явно: Windows-хост иначе вставляет обратный слеш в @rpath.
    set_target_properties(ATG PROPERTIES NO_SONAME ON)
    target_link_options(ATG PRIVATE "-Wl,-install_name,@rpath/ATG.dylib")
    set_target_properties(loader PROPERTIES
        BUILD_WITH_INSTALL_RPATH ON
        INSTALL_RPATH "@loader_path")
else()
    set_target_properties(loader PROPERTIES BUILD_RPATH "$ORIGIN")
endif()

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    # ASM обращается напрямую к символам внутри библиотеки.
    target_link_options(ATG PRIVATE -Wl,-Bsymbolic -Wl,-z,noexecstack)
    target_link_options(atg_console PRIVATE -Wl,-z,noexecstack)
    if(ATG_STATIC_EXECUTABLE)
        target_link_options(atg_console PRIVATE -static)
    endif()
elseif(ATG_STATIC_EXECUTABLE)
    message(FATAL_ERROR "Static libc executable is supported only for Linux (musl recommended)")
endif()

if(ATG_STATIC_RUNTIME AND CMAKE_C_COMPILER_ID STREQUAL "GNU")
    target_link_options(ATG PRIVATE -static-libgcc)
    target_link_options(atg_console PRIVATE -static-libgcc)
    target_link_options(loader PRIVATE -static-libgcc)
endif()

# libSystem на macOS и системный CRT MinGW на Windows остаются системными.
foreach(target ATG ATG_static atg_console loader)
    set_target_properties(${target} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${ATG_OUTPUT_DIR}"
        LIBRARY_OUTPUT_DIRECTORY "${ATG_OUTPUT_DIR}"
        ARCHIVE_OUTPUT_DIRECTORY "${ATG_OUTPUT_DIR}")
    foreach(config DEBUG RELEASE RELWITHDEBINFO MINSIZEREL)
        set_target_properties(${target} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY_${config} "${ATG_OUTPUT_DIR}"
            LIBRARY_OUTPUT_DIRECTORY_${config} "${ATG_OUTPUT_DIR}"
            ARCHIVE_OUTPUT_DIRECTORY_${config} "${ATG_OUTPUT_DIR}")
    endforeach()
endforeach()
