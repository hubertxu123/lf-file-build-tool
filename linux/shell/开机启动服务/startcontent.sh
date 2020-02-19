#! /bin/sh


#开机启动docker服务：
#/usr/local/sh/startcontent.sh > /root/result.txt 2>&1/usr/local/sh/startcontent.sh > /root/result.txt 2>&1
#将以上命令加入vim /etc/rc.d/rc.local 尾部

while :
do
  sleep 2
  docker ps
  if [ $? -eq 0 ];then
      echo "docker-started"
      break
  else
     echo "docker-starting"
  fi
done

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

