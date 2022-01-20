#!/bin/bash -e

git submodule update --init

# Dirty fixes.
sed -i '/-Werror/d' CMakeLists.txt
sed -i 's@jinja2cpp.pc.in jinja2cpp.pc@jinja2cpp.pc.in ${CMAKE_BINARY_DIR}/jinja2cpp.pc@g' Jinja2Cpp/CMakeLists.txt

mkdir .build && cd .build

if [[ ${DEBUG_C} == yes ]]; then
  CMAKE_BUILD_TYPE=Debug
else
  CMAKE_BUILD_TYPE=Release
fi

cmake -G"Ninja" ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    ..

ninja
ninja install
