include(ExternalProject)

include("${CMAKE_CURRENT_LIST_DIR}/FindZig.cmake")
find_program(ATG_NASM_EXECUTABLE NAMES nasm REQUIRED)
if(CMAKE_HOST_WIN32)
    find_program(ATG_WINDOWS_C_COMPILER NAMES x86_64-w64-mingw32-gcc gcc)
endif()
set(ATG_OUTPUT_DIR "${CMAKE_BINARY_DIR}/dist" CACHE PATH "Release output directory")

function(atg_platform name system triple static_libc)
    set(ATG_TARGET_SYSTEM "${system}")
    set(ATG_ZIG_TARGET "${triple}")
    set(toolchain "${CMAKE_BINARY_DIR}/toolchains/${name}.cmake")
    if(name STREQUAL "windows" AND ATG_WINDOWS_C_COMPILER)
        configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/WindowsToolchain.cmake.in" "${toolchain}" @ONLY)
    else()
        configure_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/ZigToolchain.cmake.in" "${toolchain}" @ONLY)
    endif()

    ExternalProject_Add(atg_${name}
        SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}"
        BINARY_DIR "${CMAKE_BINARY_DIR}/${name}"
        CMAKE_ARGS
            "-DCMAKE_TOOLCHAIN_FILE=${toolchain}"
            "-DCMAKE_BUILD_TYPE=Release"
            "-DCMAKE_MAKE_PROGRAM=${CMAKE_MAKE_PROGRAM}"
            "-DCMAKE_ASM_NASM_COMPILER=${ATG_NASM_EXECUTABLE}"
            "-DATG_BUILD_ALL=OFF"
            "-DATG_STATIC_RUNTIME=ON"
            "-DATG_STATIC_EXECUTABLE=${static_libc}"
            "-DATG_OUTPUT_DIR=${ATG_OUTPUT_DIR}/${name}"
        BUILD_ALWAYS TRUE
        INSTALL_COMMAND "")
endfunction()

atg_platform(windows Windows x86_64-windows-gnu OFF)
atg_platform(linux Linux x86_64-linux-musl ON)
atg_platform(macos Darwin x86_64-macos-none OFF)

add_custom_target(all_platforms DEPENDS atg_windows atg_linux atg_macos)
add_custom_target(ATG DEPENDS all_platforms)
message(STATUS "All-platform build: Windows, Linux (static musl executable), macOS")
message(STATUS "Windows system CRT and macOS libSystem cannot be bundled by this toolchain")
