#!/usr/bin/env bash

./autogen.sh
./configure --prefix=$PREFIX --disable-dependency-tracking
make -j$CPU_COUNT
make install
