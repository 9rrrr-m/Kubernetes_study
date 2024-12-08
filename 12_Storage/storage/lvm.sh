#!/bin/bash

# 1) 파티션 생성
parted /dev/sdb mklabel msdos
parted /dev/sdc mklabel msdos

parted /dev/sdb mkpart primary 1M 100%
parted /dev/sdb set 1 lvm on

parted /dev/sdc mkpart primary 1M 100%
parted /dev/sdc set 1 lvm on

# 2) pv 생성
pvcreate -q /dev/sdb1 /dev/sdc1

# 3) vg 생성
vgcreate -q nasvg /dev/sdb1 /dev/sdc1

# 4) lv 생성
lvcreate nasvg -n naslv -l 50%FREE

# 5) file system 생성
mkfs.ext4 /dev/nasvg/naslv

# 6) mount 작업
mkdir -p /nas
cat << EOF >> /etc/fstab
/dev/nasvg/naslv  /nas  ext4  defaults  0 0
EOF
mount -a
