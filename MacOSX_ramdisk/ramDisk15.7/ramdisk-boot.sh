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
    # format, HFS+ 在开机期间更稳定
    # diskutil erasevolume APFSX "${RAMDISK_NAME}" `hdiutil attach -nomount "ram://${RAMDISK_BLOCKSIZE}"`
    DEV=$(hdiutil attach -nomount "ram://${RAMDISK_BLOCKSIZE}")
    diskutil erasevolume APFSX "${RAMDISK_NAME}" $DEV
    
    # # 找到 APFS Volume identifier（如 disk8s1）
    VOL_DEV=$(diskutil list | awk '/APFS Volume.*'"${RAMDISK_NAME}"'/ {print $NF}')

    if [ -z "${VOL_DEV}" ]; then
        echo "ERROR: APFS Volume not found"
        exit 1
    fi

    diskutil mount "${VOL_DEV}"

    # 等待 mount
    for _ in {1..10}; do
        mount | grep -q "on ${MOUNT_POINT} " && break
        sleep 0.1
    done

    # 校验
    if ! mount | grep -q "on ${MOUNT_POINT} "; then
        echo "ERROR: RamDisk mount failed"
        exit 1
    fi
}


create_ramdisk


