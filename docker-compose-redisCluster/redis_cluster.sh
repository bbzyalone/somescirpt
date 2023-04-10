#docker-compose.yml 文件如下

version: '2'
services:
 redis1:
  image: publicisworldwide/redis-cluster
  network_mode: host
  restart: always
  volumes:
   - /data/redis/8001/data:/data
  environment:
   - REDIS_PORT=8001

 redis2:
  image: publicisworldwide/redis-cluster
  network_mode: host
  restart: always
  volumes:
   - /data/redis/8002/data:/data
  environment:
   - REDIS_PORT=8002

 redis3:
  image: publicisworldwide/redis-cluster
  network_mode: host
  restart: always
  volumes:
   - /data/redis/8003/data:/data
  environment:
   - REDIS_PORT=8003

 redis4:
  image: publicisworldwide/redis-cluster
  network_mode: host
  restart: always
  volumes:
   - /data/redis/8004/data:/data
  environment:
   - REDIS_PORT=8004

 redis5:
  image: publicisworldwide/redis-cluster
  network_mode: host
  restart: always
  volumes:
   - /data/redis/8005/data:/data
  environment:
   - REDIS_PORT=8005

 redis6:
  image: publicisworldwide/redis-cluster
  network_mode: host
  restart: always
  volumes:
   - /data/redis/8006/data:/data
  environment:
   - REDIS_PORT=8006
#构建集群
docker run --rm -it inem0o/redis-trib create --replicas 1 172.19.94.112:8001 172.19.94.112:8002 172.19.94.112:8003 172.19.94.112:8004 172.19.94.112:8005 172.19.94.112:8006