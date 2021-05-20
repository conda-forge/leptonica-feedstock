#!/usr/bin/env bash

./autogen.sh
./configure --prefix=$PREFIX --disable-dependency-tracking
sed -i 's/TARGET_OS_OSX/TARGET_OS_MAC/g' src/utils2.c ## https://github.com/DanBloomberg/leptonica/issues/579
make -j$CPU_COUNT
make install
