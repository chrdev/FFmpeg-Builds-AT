#!/bin/bash

SCRIPT_REPO="https://github.com/chrdev/wat4ff.git"
SCRIPT_COMMIT="aef4e8f1a61c61cc8075f856f9c92f15cd24ab6c"

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
