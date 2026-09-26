option(ENABLE_CLANG_TIDY "Enable clang-tidy during compilation" OFF)

if(ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY_EXECUTABLE NAMES clang-tidy-22 clang-tidy REQUIRED)
    set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXECUTABLE}")
endif()

file(GLOB_RECURSE FORMAT_FILES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/example/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/example/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/example/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/example/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/examples/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/examples/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/examples/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/examples/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/test/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/test/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/tests/*.cpp"
)

find_program(CLANG_FORMAT_EXECUTABLE NAMES clang-format-22 clang-format)
if(CLANG_FORMAT_EXECUTABLE AND FORMAT_FILES)
    add_custom_target(format
        COMMAND ${CLANG_FORMAT_EXECUTABLE} -i ${FORMAT_FILES}
        COMMAND_EXPAND_LISTS
        VERBATIM
    )
    add_custom_target(format-check
        COMMAND ${CLANG_FORMAT_EXECUTABLE} --dry-run --Werror ${FORMAT_FILES}
        COMMAND_EXPAND_LISTS
        VERBATIM
    )
elseif(NOT CLANG_FORMAT_EXECUTABLE)
    message(STATUS "clang-format was not found; format targets are disabled")
else()
    message(STATUS "No format target files were found; format targets are disabled")
endif()
