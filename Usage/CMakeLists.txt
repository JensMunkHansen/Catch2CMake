cmake_minimum_required(VERSION 3.27)

project(Usage)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../CMake)
include(DumpVariables)

message("CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")
message("CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")

find_package(Catch2 REQUIRED)
include(CTest)
include(Catch)
add_executable(main main.cxx)
target_link_libraries(main PRIVATE Catch2::Catch2WithMain)

cmake_dump_variables(Catch2)
# For dynamic linking
if (BUILD_SHARED_LIBS)
  if (MSVC)
    add_custom_command( TARGET main POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy
      $<TARGET_RUNTIME_DLLS:main>
      $<TARGET_FILE_DIR:main>
      COMMAND_EXPAND_LISTS)
  endif()
endif()

catch_discover_tests(main)
