#!/bin/sh

#  CreateRamDisk.sh
#
#
#  Created by Ryan Pang on 21/4/15.
#

# Settings
RAMDISK_SIZE=5119 # Size in MB.
RAMDISK_NAME="RamDisk"
USER_NAME=$(/usr/bin/who am i | /usr/bin/awk '{print $1}')
SNAPSHOT_LOCATION="/Users/${USER_NAME}/Library/Snapshot_${RAMDISK_NAME}/"
RSYNC="rsync -a "

function create_ramdisk {
    if [ ! -d "/Volumes/${RAMDISK_NAME}" ]; then
        let RAMDISK_BLOCKSIZE=2048*${RAMDISK_SIZE} # Size in blocks.
        diskutil erasevolume HFS+ "${RAMDISK_NAME}" `hdiutil attach -nomount ram://${RAMDISK_BLOCKSIZE}`

        osascript -e 'display notification "RamDisk created successfully!" with title "CreateRamDisk"'
    else
        osascript -e 'display notification "RamDisk has been created already!" with title "CreateRamDisk"'
    fi
}

function create_directories {
	if [ ! -d "/Volumes/${RAMDISK_NAME}/com.apple.Safari" ]; then
        #rm -rf ~/Library/Caches/com.apple.Safari
        #mkdir /Volumes/${RAMDISK_NAME}/com.apple.Safari
        #ln -s /Volumes/${RAMDISK_NAME}/com.apple.Safari/ ~/Library/Caches/com.apple.Safari
		echo "create_directories"
    fi
}

function restore_contents_from_snapshot {
# Check if snapshot exists
    if [ -d ${SNAPSHOT_LOCATION} ]; then
        DEST="/Volumes/${RAMDISK_NAME}/"

        $RSYNC "${SNAPSHOT_LOCATION}" "${DEST}"

        osascript -e 'display notification "Restore contents from snapshot successfully!" with title "RestoreRamDiskContent"'
    else
        osascript -e 'display notification "Restore contents from snapshot failed!" with title "RestoreRamDiskContent"'
    fi
}

function store_contents_on_snapshot {
    SOURCE="/Volumes/${RAMDISK_NAME}/"

    if [ ! -d "${SOURCE}" ]; then
        exit 0
    fi

    chmod -R 770 ${SOURCE}

    $RSYNC "${SOURCE}" "${SNAPSHOT_LOCATION}"

    osascript -e 'display notification "Store contents on snapshot successfully!" with title "BackupRamDiskContent"'
}

function startup {
    create_ramdisk
    restore_contents_from_snapshot
    create_directories
}

function shutdown {
    store_contents_on_snapshot
    exit 0
}

