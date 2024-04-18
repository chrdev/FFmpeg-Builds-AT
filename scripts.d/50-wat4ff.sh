#!/bin/bash

SCRIPT_REPO="https://github.com/chrdev/wat4ff.git"
SCRIPT_COMMIT="1eb33b9d9bad6100d8936b983d03bf663f2d5cfe"

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
