#安装growpart或者xfsprogs扩容格式化工具：
apt install cloud-guest-utils
apt install xfsprogs
#查看内核版本：
uname -a
#内核版本大于等于3.6.0：
#运行fdisk -l命令查看现有云盘大小

#运行df -Th命令查看云盘分区大小和文件系统类型。
#以下示例返回分区（/dev/vda1）容量是40GiB，文件系统类型为ext4。

#扩容分区

#运行growpart 命令扩容分区。
#示例命令表示扩容系统盘的第一个分区（/dev/vda1）

growpart /dev/vda 1

#扩展文件系统

resize2fs /dev/vda1

#容量确认

df -h