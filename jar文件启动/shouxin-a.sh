#! /bin/sh
echo "movecomplate"
cd /home/shouxin/$2
pid=`ps -ef |grep $1.jar | grep -v grep | awk '{print $2}'`
echo "打印pid  $pid"
echo "检测到端口值---"$pid
if [ -n "$pid" ];then
   kill -9 $pid
   echo "$1端口进程终止成功"
  nohup  java -jar -Xms$3m -Xmx$3m -javaagent:/root/discovery-agent/discovery-agent-starter-1.0.0.jar -Dthread.scan.packages=$4  $1.jar >/dev/null 2>&1 &
    echo "RESTART--SUCCESS"
   else 
   echo "没有检测到$1端口行为"
  nohup  java -jar -Xms$3m -Xmx$3m -javaagent:/root/discovery-agent/discovery-agent-starter-1.0.0.jar -Dthread.scan.packages=$4  $1.jar >/dev/null 2>&1 &
   echo "START--SUCCESS"
 fi
echo "END"

