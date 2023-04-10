#创建数据卷
docker volume create data_master
docker volume create data_conf

docker run  -d --name mysql_master -p 9912:3306 -e MYSQL_ROOT_PASSWORD=//wkq1234..00 -v data_conf:/var/lib/mysql -v data_master:/etc/mysql  mysql:5.7.26

#创建软连接目录 
/root/mysql

#增量备份测试
#清除binlog记录：
purge binary logs to 'shouxin.000014';
#充值binlog读取记录：
mysqladmin -u root -p//wkq1234..00 flush-logs
#恢复binlog记录
mysqlbinlog /var/lib/mysql/shouxin.000016 | mysql -u root -p//wkq1234..00 test_root

#远程数据复制
mysqldump  3_km_test -h 101.37.158.254 -P 3306  -uroot -pwkqdmm | mysql test_root -uroot -p//wkq1234..00