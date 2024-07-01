cmake_minimum_required(VERSION 3.27)

project(Usage)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMake)
include(DumpVariables)

message("CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

find_package(Catch2 3.5.2 EXACT REQUIRED)
include(CTest)
include(Catch)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(main main.cxx)
target_link_libraries(main PRIVATE Catch2::Catch2WithMain)

if (EMSCRIPTEN)

set(emscripten_link_options)
set(emscripten_compile_options)
list(APPEND emscripten_link_options
  "SHELL:-s --preload-file assets"
  "-sEXCEPTION_CATCHING_ALLOWED=[..]"
  "-sENVIRONMENT=node"
  
)
endif()

add_custom_target(build-time-make-directory ALL
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/assets)

configure_file(input.txt ${CMAKE_CURRENT_BINARY_DIR}/assets/input.txt)
configure_file(input2.txt ${CMAKE_CURRENT_BINARY_DIR}/assets/input2.txt)

target_link_options(main
  PUBLIC
    ${emscripten_link_options}
    ${emscripten_optimizations}
    ${emscripten_debug_options}
)


# For dynamic linking
if (BUILD_SHARED_LIBS)
  if (MSVC)
    add_custom_command( TARGET main POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy
      $<TARGET_RUNTIME_DLLS:main>
      $<TARGET_FILE_DIR:main>
      COMMAND_EXPAND_LISTS)
  endif()
elseif(EMSCRIPTEN)
    add_custom_command( TARGET main POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/input.txt
      $<TARGET_FILE_DIR:main>/assets
      COMMAND_EXPAND_LISTS)
    add_custom_command( TARGET main POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy
      ${CMAKE_CURRENT_SOURCE_DIR}/input2.txt
      $<TARGET_FILE_DIR:main>/assets
      COMMAND_EXPAND_LISTS)
elseif(0)#EMSCRIPTEN)
  add_custom_command(TARGET main
    POST_BUILD
    COMMAND ${CMAKE_CROSSCOMPILING_EMULATOR} ${CMAKE_CURRENT_BINARY_DIR}/main.js
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  )  
endif()

catch_discover_tests(main)
