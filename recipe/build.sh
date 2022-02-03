#!/bin/bash -e


# Create and change to a build directory
mkdir -p .build
cd .build || exit -1

# Set the CMake build type.
if [[ ${DEBUG_C} == yes ]]; then
  CMAKE_BUILD_TYPE=Debug
else
  CMAKE_BUILD_TYPE=Release
fi

# Call CMake to generate ninja's build files.
cmake -G"Ninja"  \
    -DCMAKE_INSTALL_PREFIX=${PREFIX}/bin \
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    -DBUILD_CUSTOMER_RELEASE=1 \
    -DJINJA2CPP_STRICT_WARNINGS=0 \
    ..

# Build and "install" the files.
ninja install
