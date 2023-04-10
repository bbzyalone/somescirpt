#! /bin/sh
echo "movecomplate"
cd /home/shouxin/$2
pid=`ps -ef |grep $1.jar | grep -v grep | awk '{print $2}'`
echo "打印pid  $pid"
echo "检测到端口值---"$pid
if [ -n "$pid" ];then
   kill -9 $pid
   echo "$1端口进程终止成功"
  nohup  java -jar -Xms$3m -Xmx$3m  $1.jar >/dev/null 2>&1 &
    echo "RESTART--SUCCESS"
   else 
   echo "没有检测到$1端口行为"
  nohup  java -jar -Xms$3m -Xmx$3m  $1.jar >/dev/null 2>&1 &
   echo "START--SUCCESS"
 fi
echo "END"


#nohup java -Xmx$3m -Xss$3m -jar $pro --server.port=$c_port  >/dev/null 2>&1 &
#nohup  java -jar -Xms258m -Xmx258m $1.jar >/dev/null 2>&1 &
