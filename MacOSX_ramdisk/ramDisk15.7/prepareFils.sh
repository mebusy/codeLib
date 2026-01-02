#!/bin/sh

set -e

sudo mkdir -p /usr/local/sbin
sudo cp -f ramdisk-boot.sh /usr/local/sbin/ramdisk-boot.sh
# sudo chown root:wheel /usr/local/sbin/ramdisk-boot.sh
sudo chmod 755 /usr/local/sbin/ramdisk-boot.sh

ls -l /usr/local/sbin/ramdisk-boot.sh


sudo cp -f  com.mebusy.ramdisk-boot.plist /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist

sudo chown root:wheel /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist
sudo chmod 644 /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist

ls -l /Library/LaunchDaemons/com.mebusy.ramdisk-boot.plist


cp -f ramdisk-mount-user.sh ~/ramdisk-mount-user.sh
chmod 755 ~/ramdisk-mount-user.sh
ls -l  ~/ramdisk-mount-user.sh


cp -f com.mebusy.ramdisk-mount-user.plist  ~/Library/LaunchAgents/com.mebusy.ramdisk-mount-user.plist
# replace `/Users/mebusy` with $HOME in the script
sed -i '' "s|/Users/mebusy|$HOME|g"  ~/Library/LaunchAgents/com.mebusy.ramdisk-mount-user.plist

cat ~/Library/LaunchAgents/com.mebusy.ramdisk-mount-user.plist | grep Users
ls -l ~/Library/LaunchAgents/com.mebusy.ramdisk-mount-user.plist 

echo create a file 
echo \t ~/my_ramDiskJob.sh
echo \t to add you own Jobs
