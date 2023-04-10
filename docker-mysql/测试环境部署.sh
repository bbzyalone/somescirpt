#线上生产库账号：HOhPjc57tw1K
#导出数据：
mysqldump -uroot -pHOhPjc57tw1K --databases shouxin_main shouxin_pfc > /home/shouxin.sql

#生成密钥
ssh-keygen -t rsa
#建立线上库至5.0测试环境服务器授权
scp ~/.ssh/id_rsa.pub 172.19.94.112:/root/.ssh/authorized_keys
#测试服务器root密码
//wkq4978dmm

#数据文件传输
scp /home/shouxin_main_pfc.sql root@172.19.94.112:/var/lib/docker/volumes/v1_c/_data/

#数据文件导入(需要提前创建数据库)
source /etc/mysql/shouxin_main_pfc.sql

#创建测试服务器开发账号
useradd -d /var/log/shouxin-log -m shouxin-dev
passwd shouxin-dev
#密码初始化为123456
shouxin-dev
123456

#数据库配置文件整理
#1：开发日常数据库查询账户
测试库ip:101.133.227.141
name:shouxin-dev-show
pass:shouxin-dev-show

#数据库配置文件列表
data-source.yaml
data-source2.yaml	
data-source3.yaml
data-source-analysis.yaml
dual_data_sources.yaml
redis-cluster.yaml
data-source-es.yaml

#数据库列表
#shouxin_main
jdbc:mysql://172.19.94.112:3306/shouxin_main?allowMultiQueries=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2b8&useSSL=false
#shouxin_pfc
jdbc:mysql://172.19.94.112:3306/shouxin_pfc?allowMultiQueries=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2b8&useSSL=false
#shouxin_user_analysis
jdbc:mysql://172.19.94.112:3306/shouxin_user_analysis?allowMultiQueries=true&useUnicode=true&characterEncoding=utf-8&serverTimezone=GMT%2b8&useSSL=false
#测试环境，统一建立读写账号
username：rootdev
password：devpass
#建立开发账号

#jenkisn开发状态
dev
123456
