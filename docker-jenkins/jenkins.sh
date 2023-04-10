#拉去官方推荐镜像
docker pull jenkinsci/blueocean
#创建docker容器网络
docker network create jenkins
#创建jenkins数据卷

#启动docker:dind容器
docker container run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind
  
 #docker:dind需要重新下载
 #启用jenkinsci/blueocean容器
 
 docker container run \
  --name jenkins-blueocean \
  --rm \
  --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 9000:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  jenkinsci/blueocean
  
#建立软连接
jenkins-data -> /var/lib/docker/volumes/jenkins-data/_data/
jenkins-docker-certs -> /var/lib/docker/volumes/jenkins-docker-certs/_data/
#jenkins管理账号
admin
798d90ed04a34abeb1831e19e1d03ae5

#插件安装
Maven Integration
 