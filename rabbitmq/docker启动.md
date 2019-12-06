


### 1.Docker 启动 RabbitMQ
指定主机名有利于集群

docker run -d --hostname localhost --name rabbit-management --restart=always -p 15672:15672 -p 5672:5672 rabbitmq:3.6-management-alpine
docker logs rabbit-management
访问：http://server-ip:15672  账号： guest 密码： guest


### 2.
docker run -d --hostname rabbit-host --name rabbitmq -e RABBITMQ_DEFAULT_USER=user -e RABBITMQ_DEFAULT_PASS=pwd -p 15672:15672 -p 5672:5672 rabbitmq:3-management
