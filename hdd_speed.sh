# Show a list of disks
fdisk -l
#
# Check speed of reading from the /dev/mmcblk0p1.
root@orangepi3-lts:~# hdparm -Tt /dev/mmcblk0p1
#/dev/mmcblk0p1:
# Timing cached reads:   1454 MB in  2.00 seconds = 726.38 MB/sec
# Timing buffered disk reads:  66 MB in  3.00 seconds =  21.99 MB/sec
#
#
# Check speed of writing to the /mnt/e/testfile
oot@LUCIANO-PC:/home/# dd if=/dev/zero of=/mnt/e/testfile bs=5M count=20000
#20000+0 records in
#20000+0 records out
#20971520000 bytes (21 GB, 20 GiB) copied, 47.4897 s, 442 MB/s
#Параметры:
#if: указывает на источник, т.е. на то, откуда копируем. Указывается файл, который может быть как обычным файлом, так и файлом устройства.
#of: указывает на файл назначения. То же самое, писать можем как в обычный файл, так и напрямую в устройство.
#bs: количество байт, которые будут записаны за раз. Можно представлять этот аргумент как размер куска данные, которые будут записаны или прочитаны, а количество кусков регулируется уже следующим параметром.
#count: как раз то число, которое указывает: сколько кусочков будет скопировано.
# Таким образом, описанная команда читает 5*20000 мегабайт из if и записывает в of
