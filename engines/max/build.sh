#!/bin/bash

export LDFLAGS=-L"$VCPKG_INSTALLED_PATH/lib"
export LIBRARY_PATH="$VCPKG_INSTALLED_PATH/lib"
export CFLAGS="$CFLAGS -std=c++20"
export CXXFLAGS="$CXXFLAGS -std=c++20"

# CLONE PHASE
git clone https://github.com/klei1984/max.git source
pushd source
git checkout 0317272
popd

# BUILD PHASE
pushd "source"
mkdir -p build
cd build
cmake -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchain-linux-x86_64.cmake -DCMAKE_BUILD_TYPE=Debug -DBUILD_SHARED_LIBS=ON -DCMAKE_PREFIX_PATH="$VCPKG_INSTALLED_PATH" ..
cmake --build . --parallel
popd

# COPY PHASE
cp -rfv source/build/max "$diststart/615250/dist/"
cp -rfv source/build/max.debug "$diststart/615250/dist/"
cp -rfv source/assets/* "$diststart/615250/dist/"
cp -rfv assets/* "$diststart/615250/dist/"
