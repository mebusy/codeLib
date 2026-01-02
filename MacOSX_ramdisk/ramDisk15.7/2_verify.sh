#!/bin/sh

set -e

sudo launchctl bootstrap system /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist
sudo launchctl enable system/com.mebusy.ramdisk-boot
# sudo launchctl kickstart -k system/com.mebusy.ramdisk-boot

echo 'done'
