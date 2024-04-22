#!/bin/bash

rm -Rf $(pwd)/install
rm -Rf $(pwd)/build/library

if [ $# -ne 1 ]; then
    echo "Usage: $0 shared/static"
    exit 1
fi

# Convert parameter to lowercase for case-insensitive comparison
param=$(echo "$1" | tr '[:upper:]' '[:lower:]')

if [ "$param" = "shared" ]; then
    echo "Shared."
    cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
    
else
    echo "Static."
    cmake -Bbuild/library -H./Library -DCMAKE_INSTALL_PREFIX=$(pwd)/install -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF
fi

cmake --build build/library --parallel 16
