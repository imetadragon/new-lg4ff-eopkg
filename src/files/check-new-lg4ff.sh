#!/bin/bash
set -euo pipefail

SRC_DIR="/usr/share/new-lg4ff/src"
BUILD_DIR="/var/cache/new-lg4ff-build"

if ! modinfo -k "$(uname -r)" hid-logitech-new &>/dev/null; then
    rm -rf "$BUILD_DIR"
    cp -a "$SRC_DIR" "$BUILD_DIR"
    make -C "$BUILD_DIR"
    make -C "$BUILD_DIR" install
    depmod -a "$(uname -r)"
    rm -rf "$BUILD_DIR"
fi

if [ -d /sys/module/hid_logitech ]; then
    modprobe -r hid_logitech 2>/dev/null || true
fi

modprobe hid-logitech-new
