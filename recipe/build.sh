#!/bin/bash -e

git submodule init
git submodule update

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

make install -j${CPU_COUNT} ${VERBOSE_CM}
