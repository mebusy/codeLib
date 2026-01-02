#!/bin/bash

set -euo pipefail

RAMDISK_SIZE=8192 # Size in MB.
RAMDISK_NAME="RamDisk"
MOUNT_POINT="/Volumes/${RAMDISK_NAME}"

function create_ramdisk {
    if mount | grep -q "${MOUNT_POINT}"; then
        exit 0
    fi

    let RAMDISK_BLOCKSIZE=2048*${RAMDISK_SIZE} # Size in blocks.
    # DEV=`hdiutil attach -nomount "ram://${RAMDISK_BLOCKSIZE}"`
    # format
    # diskutil erasevolume APFSX "${RAMDISK_NAME}" `hdiutil attach -nomount "ram://${RAMDISK_BLOCKSIZE}"`
    DEV=$(hdiutil attach -nomount "ram://${RAMDISK_BLOCKSIZE}")
    diskutil erasevolume APFSX "${RAMDISK_NAME}" $DEV
    
    # mount
    if mount | grep -q "on ${MOUNT_POINT} "; then
        echo "RAMDisk already mounted at ${MOUNT_POINT}"
    else
        diskutil mount -mountPoint "${MOUNT_POINT}" $DEV
    fi
}


create_ramdisk


