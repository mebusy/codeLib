#!/bin/sh

set -e

sudo mkdir -p /usr/local/sbin
sudo cp -f ramdisk-boot.sh /usr/local/sbin/ramdisk-boot.sh
sudo chown root:wheel /usr/local/sbin/ramdisk-boot.sh
sudo chmod 755 /usr/local/sbin/ramdisk-boot.sh

ls -l /usr/local/sbin/ramdisk-boot.sh


sudo cp -f  com.mebusy.ramdisk-boot.plist /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist

sudo chown root:wheel /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist
sudo chmod 644 /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist

ls -l /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist


