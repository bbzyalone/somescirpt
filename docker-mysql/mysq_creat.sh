#采用docker 部署方式

#服务器信息如下：
#公网：47.103.96.70  内网：172.19.94.108    master
#公网：47.116.49.206 内网：172.19.94.110    salve1
#公网：101.133.228.196  内网：172.19.94.111   salve2

scp ~/.ssh/id_rsa.pub 172.19.94.108:/root/.ssh/authorized_keys

#第一步
#分别创建数据卷
#_c 数据库配置文件
#_d 数据落盘文件
【1】
docker volume create v1_c
docker volume create v1_d
#docker 启动脚本
docker run  -d --name mysql_master -p 3306:3306 -e MYSQL_ROOT_PASSWORD=wkq1234..00 -v v1_d:/var/lib/mysql -v v1_c:/etc/mysql  mysql:5.7.26
#数据库配置文件
symbolic-links=0
#以下为手动配置项
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
server-id=1
log_bin=shouxin
character_set_server=utf8
#在默认情况下mysql会阻止主从同步的数据库function的创建,这会导致我们在导入sql文件时如果有创建function或者使用function的语句将会报错
log-bin-trust-function-creators=1
expire_logs_days=5
【2】
docker volume create v2_c
docker volume create v2_d
docker run  -d --name mysql_2 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=wkq1234..00 -v v2_d:/var/lib/mysql -v v2_c:/etc/mysql  mysql:5.7.26
#以下为手动配置项
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
server-id=2
log_bin=shouxin
character_set_server=utf8
#在默认情况下mysql会阻止主从同步的数据库function的创建,这会导致我们在导入sql文件时如果有创建function或者使用function的语句将会报错
log-bin-trust-function-creators=1
expire_logs_days=5
【3】
docker volume create v3_c
docker volume create v3_d
docker run  -d --name mysql_3 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=wkq1234..00 -v v3_d:/var/lib/mysql -v v3_c:/etc/mysql  mysql:5.7.26
#以下为手动配置项
sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
server-id=3
log_bin=shouxin
character_set_server=utf8
#在默认情况下mysql会阻止主从同步的数据库function的创建,这会导致我们在导入sql文件时如果有创建function或者使用function的语句将会报错
log-bin-trust-function-creators=1
expire_logs_days=5
#第二部，开启主从同步

change master to master_host='172.19.94.108',master_port=3306,master_user='root',master_password='wkq1234..00',master_log_file='shouxin.000001',master_log_pos=154;
#启用同步
start slave;
#查看同步状态
show slave status;

#更新库最大连接数据配置
#配置最大连接数
max_connections=1000

docker restart mysql_master

#创建数据库软连接
ln -s /var/lib/docker/volumes/v1_c/_data /root/mysq_conf
ln -s /var/lib/docker/volumes/v1_d/_data /root/mysq_data

ln -s /var/lib/docker/volumes/v2_c/_data /root/mysq_conf
ln -s /var/lib/docker/volumes/v2_d/_data /root/mysq_data

ln -s /var/lib/docker/volumes/v3_c/_data /root/mysq_conf
ln -s /var/lib/docker/volumes/v3_d/_data /root/mysq_data

rm -rf mysq_conf
rm -rf mysq_data


#远程数据复制
备份历史库：
mysqldump -uroot -pHOhPjc57tw1K --databases shouxin_main > /home/shouxin_main.sql
mysql -uroot -pwkq1234..00 <shouxin_main.sql
#远程数据复制
mysqldump  3_km_test -h 101.37.158.254 -P 3306  -uroot -pwkqdmm | mysql test_root -uroot -pwkq1234..00

