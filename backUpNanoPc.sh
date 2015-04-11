#!/bin/bash
#/dev/sda3 on / type ext4 (rw,errors=remount-ro)
#/dev/sda1 on /boot type ext4 (rw)
#/dev/sda6 on /usr type ext4 (rw)
#/dev/sda5 on /home type ext4 (rw)
BK_DIR="/mnt/sdc1/bk/WadzapiThinkPad.bk"
ROOT_BK_NAME="rootThinkPadBk.tgz"
ROOT_ORIGIN="/mnt/sda3"
BOOT_BK_NAME="bootThinkPadBk.tgz"
BOOT_ORIGIN="/mnt/sda1"
USR_BK_NAME="usrThinkPadBk.tgz"
USR_ORIGIN="/mnt/sda6"
HOME_BK_NAME="homeThinkPadBk.tgz"
HOME_ORIGIN="/mnt/sda5"
echo
echo "#################################################################"
echo
echo "Backuping from ${USR_ORIGIN} (/usr) to ${BK_DIR}/${USR_BK_NAME}"
echo "tar -zcvpf ${BK_DIR}/${USR_BK_NAME} --directory=${USR_ORIGIN} --exclude=games --exclude=src --exclude=local/games --exclude=local/src --exclude=var/cache --exclude=local/var/cache ."
tar -zcvpf ${BK_DIR}/${USR_BK_NAME} --directory=${USR_ORIGIN} --exclude=games --exclude=src --exclude=local/games --exclude=local/src --exclude=var/cache --exclude=local/var/cache .
echo "Usr dir backuped successfully!"
echo
echo "#################################################################"
echo
echo "Backuping from ${ROOT_ORIGIN} (/) to ${BK_DIR}/${ROOT_BK_NAME}"
echo "tar -zcvpf ${BK_DIR}/${ROOT_BK_NAME} --directory=${ROOT_ORIGIN} --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups ."
tar -zcvpf ${BK_DIR}/${ROOT_BK_NAME} --directory=${ROOT_ORIGIN} --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups .
echo "Root dir backuped successfully!"
echo
echo "#################################################################"
echo
################## ####################
echo "#################################################################"
echo
echo "Backuping from ${BOOT_ORIGIN} (/) to ${BK_DIR}/${BOOT_BK_NAME}"
echo "tar -zcvpf ${BK_DIR}/${BOOT_BK_NAME} --directory=${BOOT_ORIGIN} --exclude=proc --exclude=sys --exclude=dev/pts  --exclude=backups ."
tar -zcvpf ${BK_DIR}/${BOOT_BK_NAME} --directory=${BOOT_ORIGIN} --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups .
echo "Boot dir backuped successfully!"
echo
echo "#################################################################"
echo
################## ####################
echo "#################################################################"
echo
echo "Backuping from ${HOME_ORIGIN} (/) to ${BK_DIR}/${HOME_BK_NAME}"
echo "tar -zcvpf ${BK_DIR}/${HOME_BK_NAME} --directory=${HOME_ORIGIN} --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups ."
tar -zcvpf ${BK_DIR}/${HOME_BK_NAME} --directory=${HOME_ORIGIN} --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups .
echo "HOME dir backuped successfully!"
echo
echo "#################################################################"
echo "ITS SUCCESS!!!!"
################## ####################

#     -----   BACKUP NANO PC   -----     

/dev/sda1 on / type ext4 (rw,errors=remount-ro)
/dev/sda5 on /usr type ext4 (rw)
/dev/sdb1 on /home type fuseblk (rw,nosuid,nodev,allow_other,blksize=4096)
gvfsd-fuse on /run/user/1000/gvfs type fuse.gvfsd-fuse (rw,nosuid,nodev,user=usrname)

#     -----   BACKUP NANO PC   -----     

  
0a6cb56e-ee7e-46b6-8c11-04f2e9d7f6e2  ../../sda5
4A5ACA845FEE05E4  ../../sdb1
77067647-c9e8-4d8f-93df-cf1771ebaf3d  ../../sdc1
b807c0f6-a407-4be5-a995-c5cc8ae7c9fe  ../../sda6
e4c81d2d-9570-4170-8e0b-165553360e16  ../../sda1
