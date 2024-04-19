#!/bin/bash

SCRIPT_REPO="https://github.com/chrdev/wat4ff.git"
SCRIPT_COMMIT="00838d2a967c30433ff70a8bcf391f7e5cbdc048"

ffbuild_enabled() {
    [[ $TARGET == win* ]]
}

ffbuild_dockerbuild() {
    mkdir build && cd build

    cmake -DCMAKE_TOOLCHAIN_FILE="$FFBUILD_CMAKE_TOOLCHAIN" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$FFBUILD_PREFIX" ..
    make
    make install
}

ffbuild_configure() {
    echo --enable-audiotoolbox
}

ffbuild_unconfigure() {
    echo --disable-audiotoolbox
}
