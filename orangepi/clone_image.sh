#!/bin/bash
# How to clone an entire hard disk
# The syntax is as follow to make disk image with dd:
dd if=/dev/input/DEVICE-HERE of=/dev/OUTPUT/DEVICE-HERE bs=64K conv=noerror,sync status=progress

# To clone /dev/sdc (250G) to /dev/sdd (250G) in Linux, enter:
dd if=/dev/sdc of=/dev/sdd bs=64K conv=noerror,sync status=progress

# In this example, I am going to clone /dev/ada0 (250G) to /dev/adb0 (250G) in FreeBSD and make an image using dd. For example:
dd if=/dev/ada0 of=/dev/adb0 bs=64K status=progress conv=noerror,sync

# Where,

# if=/dev/file : Input device/file.
# of=/dev/file : Output device/file.
# bs=64k : Sets the block size to 64k. You can use 128k or any other value.
# conv=noerror : Tell dd to continue operation, ignoring all read errors.
# sync : Add input blocks with zeroes if there were any read errors, so data offsets stay in sync.
# How to clone a partition and make disk image with dd
# To clone /dev/sdc1 to /dev/sdd1 with dd and create an image, enter:
dd if=/dev/sdc1 of=/dev/sdd1 bs=128K status=progress conv=noerror,sync

# Sample outputs:
  # 15874+0 records in
  # 15873+0 records out
  # 1040252928 bytes transferred in 3.805977 secs (273320858 bytes/sec)
# Making disk image with dd using live CD/DVD or USB pen drive

# You can boot from a live cd or USB pen drive. Once booted, make sure no partitions are mounted from the source hard drive disk. You can store disk image on an external USB disk. The syntax is as follows
# dd if=/dev/INPUT/DEVICE-NAME-HERE conv=sync,noerror bs=64K status=progress | gzip -c > /path/to/my-disk.image.gz

# In this example, create disk image for /dev/da0 i.e. cloning /dev/da0 and save in the current directory:
dd if=/dev/da0 conv=sync,noerror bs=128K status=progress | gzip -c > centos-core-7.gz

# The above command just cloned the entire hard disk, including the MBR, bootloader, all partitions, UUIDs, and data.
# How to restore system (dd image)
# The syntax is:
gunzip -c IMAGE.HERE-GZ | dd of=/dev/OUTPUT/DEVICE-HERE status=progress

# For example:
gunzip -c centos-core-7.gz | dd of=/dev/da0 status=progress

# Tip #1: Not enough disk space locally? Use the remote box
# You can send the image through ssh and save it on the remove box called server1.cyberciti.biz:
dd if=/dev/da0 conv=sync,noerror bs=128K | gzip -c | ssh vivek@server1.cyberciti.biz dd of=centos-core-7.gz

# Tip #2: See progress while making an image with dd
# You need to use GNU/BSD dd with coreutils version 8.24 as follows (pass the status=progress to the dd):
dd if=/dev/sdc1 of=/dev/sdd1 bs=128K conv=noerror,sync status=progress
