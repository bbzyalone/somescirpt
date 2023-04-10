#!/bin/sh
pid=ps -ef |grep nacos | grep -v grep | awk '{print $2}'

kill -9 $pid

bash startup.sh -m standalone