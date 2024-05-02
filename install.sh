#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 [wasm|static|shared]"
    exit 1
fi

# Convert parameter to lowercase for case-insensitive comparison
param=$(echo "$1" | tr '[:upper:]' '[:lower:]')

if [ "$param" = "shared" ]; then
    echo "Shared."
    cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON
elif [ "$param" = "static" ]; then
    echo "Static."
    cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Debug
    cmake --build build/library --parallel 16
elif [ "$param" = "wasm" ]; then (
    echo "Emscripten."
    source "$HOME/github/emsdk/emsdk_env.sh"
    emcmake cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Debug
    cmake --build build/library --parallel 16
)
else
    echo "Invalid argument. Usage: $0 [wasm|static|shared]"
    exit 1    
fi

cmake --build build/library --parallel 16
