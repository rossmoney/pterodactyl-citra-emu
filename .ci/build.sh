#!/bin/bash -ex

TOPDIR="$(dirname "$0")"

git config user.name "github-actions"
git config user.email "github-actions[bot]@users.noreply.github.com"
git am "$TOPDIR"/../patches/*.patch

CFLAGS="-ftree-vectorize -flto"
if [[ "$(uname -m)" == "aarch64" ]]; then
    CFLAGS="$CFLAGS -march=armv8-a+crc+crypto"
fi
if [[ "$USE_CCACHE" != '0' ]]; then
    echo '[+] Enabled ccache'
    ccache -s
    export CC='/usr/lib/ccache/gcc'
    export CXX='/usr/lib/ccache/g++'
fi

export CFLAGS
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-flto -fuse-linker-plugin"

mkdir -p build && cd build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DENABLE_SDL2=OFF -DENABLE_QT=OFF -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF -DUSE_DISCORD_PRESENCE=OFF -DENABLE_FFMPEG_VIDEO_DUMPER=OFF
ninja citra-room
strip ./bin/Release/citra-room
