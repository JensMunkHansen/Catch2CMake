#!/bin/bash

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [wasm|static|shared]"
    exit 1
fi

# Convert parameter to lowercase for case-insensitive comparison
arg=$(echo "$1" | tr '[:upper:]' '[:lower:]')

if [ "$arg" = "static" ]; then
    echo "Static library"
    cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Debug
    cmake --build build/usage --parallel 16
    ./build/usage/main
elif [ "$arg" = "shared" ]; then
    echo "Shared library"
    cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Debug
    cmake --build build/usage --parallel 16
    ./build/usage/main
elif [ "$arg" = "wasm" ]; then
(
    echo "Emscripten"
    source "/home/jmh/github/emsdk/emsdk_env.sh"
    emcmake cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Debug
    cmake --build build/usage --parallel 16
)
else
    echo "Invalid argument. Usage: $0 [wasm|static|shared]"
    exit 1
fi


