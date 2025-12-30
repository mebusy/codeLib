#!/bin/sh

#  CreateRamDisk.sh
#
#
#  Created by Ryan Pang on 21/4/15.
#

# Settings
RAMDISK_SIZE=4096 # Size in MB.
RAMDISK_NAME="RamDisk"

function create_ramdisk {
    if [ ! -d "/Volumes/${RAMDISK_NAME}" ]; then
        let RAMDISK_BLOCKSIZE=2048*${RAMDISK_SIZE} # Size in blocks.
        diskutil erasevolume HFS+ "${RAMDISK_NAME}" `hdiutil attach -nomount ram://${RAMDISK_BLOCKSIZE}`

        osascript -e 'display notification "RamDisk created successfully!" with title "CreateRamDisk"'
    else
        osascript -e 'display notification "RamDisk has been created already!" with title "CreateRamDisk"'
    fi
}


create_ramdisk


