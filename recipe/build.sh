#!/bin/bash -e


# Dirty fix
#git submodule update --init Jinja2Cpp
#sed -i 's@jinja2cpp.pc.in jinja2cpp.pc@jinja2cpp.pc.in ${CMAKE_BINARY_DIR}/jinja2cpp.pc@g' Jinja2Cpp/CMakeLists.txt

mkdir -p .build
cd .build || exit -1

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

ninja install
