#!/bin/bash -ex

TOPDIR="$(dirname "$0")"

for i in "$TOPDIR"/../patches/*.patch; do
    echo "Applying $i ..."
    patch -Np1 -i "$i"
done

CFLAGS="-ftree-vectorize -flto"
if [[ "$(uname -m)" == "aarch64" ]]; then
    CFLAGS="$CFLAGS -march=armv8-a+crc+crypto"
fi
export CFLAGS
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-flto -fuse-linker-plugin"

mkdir -p build && cd build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DENABLE_QT=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_FFMPEG_VIDEO_DUMPER=OFF
ninja citra-room
strip ./bin/Release/citra-room
