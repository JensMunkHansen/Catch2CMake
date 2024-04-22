@echo off
rmdir /Q /S install
rmdir /Q /S build\library

set myArg=%1

if %myArg% == shared (
  echo "SHARED"
  cmake -B build/library -H%~dp0/Library -DCMAKE_INSTALL_PREFIX=%~dp0/install  -DBUILD_SHARED_LIBS=ON
) else (
  cmake -B build/library -H%~dp0/Library -DCMAKE_INSTALL_PREFIX=%~dp0/install
)

cmake --build build/library  --config Release --parallel 16 -- /m
cmake --build build/library  --config Debug --parallel 16 -- /m

