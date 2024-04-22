#!/bin/bash

rm -Rf $(pwd)/build/usage

cmake -Bbuild/usage -H./Usage -DCMAKE_FIND_ROOT_PATH=$(pwd)/install
cmake --build build/usage --parallel 8

./build/usage/main
