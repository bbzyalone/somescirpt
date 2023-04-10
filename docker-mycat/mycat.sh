#拉取mycat 镜像
docker pull longhronshens/mycat-docker
#创建数据卷
docker volume create mycat_c
docker volume create mycat_log
#启动容器
docker run --name mycat -v mycat_c:/usr/local/mycat/conf -v mycat_log:/usr/local/mycat/logs -p 8066:8066 -p 9066:9066 -e MYSQL_ROOT_PASSWORD=wkq1234..00 -d longhronshens/mycat-docker

