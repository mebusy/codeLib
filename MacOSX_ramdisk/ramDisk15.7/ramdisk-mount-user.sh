#!/bin/bash
set -euo pipefail

RAMDISK_NAME="RamDisk"
MOUNT_POINT="/Volumes/${RAMDISK_NAME}"

log() { echo  "$(date) [ramdisk-user] $*"; }

# 如果已经挂载就退出
if /sbin/mount | /usr/bin/grep -q "on ${MOUNT_POINT} "; then
  log "Already mounted at ${MOUNT_POINT}"
  exit 0
fi

# 卷存在但没挂载：尝试挂载（按卷名）
# 这一步在用户会话里通常会触发正确的 Disk Arbitration 流程
/usr/sbin/diskutil mount "${RAMDISK_NAME}" >/dev/null 2>&1 || true

# 等一小会儿再检查
for _ in {1..30}; do
  /sbin/mount | /usr/bin/grep -q "on ${MOUNT_POINT} " && break
  /bin/sleep 0.1
done

if /sbin/mount | /usr/bin/grep -q "on ${MOUNT_POINT} "; then
  log "Mounted OK: ${MOUNT_POINT}"

    # if ./my_ramDiskJob.sh exists, run it
    if [ -f ${HOME}/my_ramDiskJob.sh ]; then
      log "Running my_ramDiskJob.sh..."
      /bin/bash ${HOME}/my_ramDiskJob.sh
    fi
  exit 0
fi

log "Mount failed (volume may not exist yet)."
exit 1


