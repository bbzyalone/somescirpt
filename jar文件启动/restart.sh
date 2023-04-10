#!/bin/bash


jarName=wizops-alarm-server-1.0-SNAPSHOT.jar
jarUrl=/data/solitasu
webUrl=https://www.baidu.com/
# grep -v grep： 在文档中过滤掉包含有grep字符的行
# awk '{print $2}'： 按空格截取第二个
pid=`ps -ef|grep $jarName |grep -v grep| awk '{print $2}'`
# wc -l： jar包进程的数量
num=`ps -ef|grep $jarName |grep -v grep| awk '{print $2}'| wc -l`
MonitorAlarm(){
    # 输出文本
    echo "[info]进入监控脚本"`date +'%Y-%m-%d %H:%M:%S'`
    # -eq: 等于
    if [[ $num -eq 0 ]]; then
        echo "[error]进程不存在，重启"`date +'%Y-%m-%d %H:%M:%S'`
		# >> /dev/null : jar包生成日志不打印到此脚本日志中
        java -jar $jarUrl/$jarName >> /dev/null &
    else
        # 获取页面访问状态
        # -m 10： 最多查询10s  --connect-timeout 10：10秒连接超时  -o /dev/null： 屏蔽原有输出信息  -s: silent  -w %{http_code}: 控制额外输出
        code=`curl -s -o /dev/null -m 10 --connect-timeout 10 $webUrl -w %{http_code}`
        # -ne: 不等于
        if [[ $code -ne 200 ]]; then
            echo "[error]页面访问失败，code=$code,重启"`date +'%Y-%m-%d %H:%M:%S'`
            kill -9 $pid
            java -jar $jarUrl/$jarName >> /dev/null & 
        else
            echo "[info]页面访问成功,code=$code,time="`date +'%Y-%m-%d %H:%M:%S'`
        fi
    fi
}

MonitorAlarm

#将monitor.sh脚本设为可执行
#chmod a+x monitor.sh
#定时执行脚本
# 查看和设置定时任务
#crontab -e
# 每一分钟执行一次并将日志打印在固定目录中，若文件不存在会自动创建
# */1 * * * * bash /data/solitasu/monitor.sh >> /data/solitasu/log.log