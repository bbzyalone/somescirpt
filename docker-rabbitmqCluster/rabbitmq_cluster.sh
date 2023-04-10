第一种 普通集群模式：rabbitmq集群与其他集群有些不同，rabbitmq集群同步的指是复制队列，元数据信息的同步，即同步的是数据存储信息；消息的存放只会存储在创建该消息队列的那个节点上。并非在节点上都存储一个完整的数据。在通过非数据所在节点获取数据时，通过元数据信息，路由转发到存储数据节点上，从而得到数据 。
————————————————
第二种 镜像集群模式：与普通集群模式区别 主要是消息实体会主动在镜像节点间同步数据，而不是只存储数据元信息。 故普通集群模式 但凡数据节点挂了，容易造成数据丢失但镜像集群模式可以保证集群只要不全部挂掉，数据就不会丢失，当相对于性能来说，镜像集群模式会比普通集群模式多出消耗数据的传输。故取决于业务场景进行取舍。
————————————————
#拉去镜像
docker pull rabbitmq:3.7-management
#创建数据映射目录
mkdir rabbitmq01 rabbitmq02 rabbitmq03
#创建容器

docker run -d --hostname rabbitmq01 --name rabbitmqCluster01 -v /root/rabbitmqcluster/rabbitmq01:/var/lib/rabbitmq -p 15672:15672 -p 5672:5672 -e RABBITMQ_ERLANG_COOKIE='rabbitmqCookie' rabbitmq:3.7-management

docker run -d --hostname rabbitmq02 --name rabbitmqCluster02 -v /root/rabbitmqcluster/rabbitmq02:/var/lib/rabbitmq -p 15673:15672 -p 5673:5672 -e RABBITMQ_ERLANG_COOKIE='rabbitmqCookie'  --link rabbitmqCluster01:rabbitmq01 rabbitmq:3.7-management

docker run -d --hostname rabbitmq03 --name rabbitmqCluster03 -v /root/rabbitmqcluster/rabbitmq03:/var/lib/rabbitmq -p 15674:15672 -p 5674:5672 -e RABBITMQ_ERLANG_COOKIE='rabbitmqCookie'  --link rabbitmqCluster01:rabbitmq01 --link rabbitmqCluster02:rabbitmq02  rabbitmq:3.7-management

#查看是否正常启动成功。账号/密码：guest / guest。

#在此处需要启用延时插件
#延时插件的安装及部署

容器内插件目录：/opt/rabbitmq/plugins
#复制插件文件至容器内部
docker cp /root/rabbitmqcluster/rabbitmq_delayed_message_exchange-3.8.0.ez rabbitmqCluster01:/opt/rabbitmq/plugins
docker cp /root/rabbitmqcluster/rabbitmq_delayed_message_exchange-3.8.0.ez rabbitmqCluster02:/opt/rabbitmq/plugins
docker cp /root/rabbitmqcluster/rabbitmq_delayed_message_exchange-3.8.0.ez rabbitmqCluster03:/opt/rabbitmq/plugins
#启用插件
rabbitmq-plugins enable rabbitmq_delayed_message_exchange
#查看插件列表
rabbitmq-plugins list


#查看overview Tab页，可看到节点信息。

#容器节点加入集群
【1】
docker exec -it rabbitmqCluster01 bash
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl start_app
exit
【2】
docker exec -it rabbitmqCluster02 bash
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster --ram rabbit@rabbitmq01
rabbitmqctl start_app
exit
【3】
docker exec -it rabbitmqCluster03 bash
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl join_cluster --ram rabbit@rabbitmq01
rabbitmqctl start_app
exit

#配置负载均衡
#新建：nginx_rabbitmq.conf配置文件
#启动nginx容器
docker run -it -d --name nginxRabbitmq -v /root/rabbitmqcluster/nginx_rabbitmq/nginx_rabbitmq.conf:/etc/nginx/nginx.conf  --privileged --net=host nginx

通过 15675 进行管理 以及通过 5675 端口 进行rabbitmq通信。

http://101.133.228.196:15675/#/  web管理界面

账号：guest / guest
程序通过  5675内网通信

docker stop rabbitmqCluster01 rabbitmqCluster02 rabbitmqCluster03
docker rm rabbitmqCluster01 rabbitmqCluster02 rabbitmqCluster03
#最终版本确认
开发者账号：pro
空间；pri
开发密码：123456




