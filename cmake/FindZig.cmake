# Используем указанный компилятор, PATH или локально распакованный Zig.
find_program(ATG_ZIG_EXECUTABLE NAMES zig
    HINTS "${CMAKE_SOURCE_DIR}/.tools/zig" "${CMAKE_BINARY_DIR}/_tools/zig")

if(NOT ATG_ZIG_EXECUTABLE)
    if(NOT CMAKE_HOST_WIN32 OR NOT CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(AMD64|amd64|x86_64|X86_64)$")
        message(FATAL_ERROR
            "Install Zig and add it to PATH, or set ATG_ZIG_EXECUTABLE to its absolute path")
    endif()

    # Фиксированная версия и проверка SHA256; без изменения системного PATH.
    set(zig_version "0.17.1")
    set(zig_folder "zig-x86_64-windows-${zig_version}")
    set(tools_dir "${CMAKE_BINARY_DIR}/_tools")
    set(zig_program "${tools_dir}/${zig_folder}/zig.exe")
    if(NOT EXISTS "${zig_program}")
        file(MAKE_DIRECTORY "${tools_dir}")
        message(STATUS "Downloading Zig ${zig_version} for the three-platform build")
        file(DOWNLOAD
            "https://ziglang.org/download/${zig_version}/${zig_folder}.zip"
            "${tools_dir}/zig.zip"
            EXPECTED_HASH SHA256=b03f477a1943673e02aca0f570e8030dffd536ce1f45cbc4d3326ec31159562e
            TLS_VERIFY ON
            SHOW_PROGRESS)
        file(ARCHIVE_EXTRACT INPUT "${tools_dir}/zig.zip" DESTINATION "${tools_dir}")
    endif()
    set(ATG_ZIG_EXECUTABLE "${zig_program}" CACHE FILEPATH "Zig compiler" FORCE)
endif()
