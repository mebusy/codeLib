#!/bin/bash

set -euo pipefail

RAMDISK_SIZE=8192 # Size in MB.
RAMDISK_NAME="RamDisk"
MOUNT_POINT="/Volumes/${RAMDISK_NAME}"

function create_ramdisk {
    if /sbin/mount | grep -q "${MOUNT_POINT}"; then
        exit 0
    fi

    let RAMDISK_BLOCKSIZE=2048*${RAMDISK_SIZE} # Size in blocks.
    # format, HFS+ 在开机期间更稳定
    # diskutil erasevolume APFSX "${RAMDISK_NAME}" `hdiutil attach -nomount "ram://${RAMDISK_BLOCKSIZE}"`
    DEV=$(hdiutil attach -nomount "ram://${RAMDISK_BLOCKSIZE}")
    diskutil erasevolume APFSX "${RAMDISK_NAME}" $DEV
}


create_ramdisk


