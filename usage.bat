@echo off
rmdir /Q /S build\usage

set myArg=%1

if %myArg% == shared (
  echo "SHARED"
  cmake -Bbuild/usage -H./Usage -DCMAKE_PREFIX_PATH="%~dp0install" -DBUILD_SHARED_LIBS=ON
else (
  cmake -Bbuild/usage -H./Usage -DCMAKE_PREFIX_PATH="%~dp0install"
)

cmake --build build/usage --config Release --parallel 8
cmake --build build/usage --config Debug --parallel 8

build\usage\Debug\main.exe
build\usage\Release\main.exe
