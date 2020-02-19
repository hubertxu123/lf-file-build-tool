#! /bin/sh


#开机启动docker服务：

docker start myredis
if [ $? -eq 0 ];then
    echo "redis-success"
else
   echo "redis-error"
fi

docker start mongodb
if [ $? -eq 0 ];then
    echo "mongo-success"
else
   echo "mongo-error"
fi

docker start wx-nginx
if [ $? -eq 0 ];then
    echo "nginx-success"
else
   echo "nginx-error"
fi

docker start rabbitmq
if [ $? -eq 0 ];then
    echo "rabbitmq-success"
else
   echo "rabbitmq-error"
fi


