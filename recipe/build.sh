#!/bin/bash -e

git submodule init
git submodule update

# Dirty fixes.
sed -i '/-Werror/d' CMakeLists.txt
sed -i 's@jinja2cpp.pc.in jinja2cpp.pc@jinja2cpp.pc.in ${CMAKE_BINARY_DIR}/jinja2cpp.pc@g' Jinja2Cpp/CMakeLists.txt

mkdir .build && cd .build

if [[ ${DEBUG_C} == yes ]]; then
  CMAKE_BUILD_TYPE=Debug
else
  CMAKE_BUILD_TYPE=Release
fi

cmake ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    ..

make -j${CPU_COUNT} ${VERBOSE_CM}
make install crender
