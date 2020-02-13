



  500  netstat -nltp
  501  docker search redis
  502  docker pull redis
  503  docker images

  -v 挂载目录
  redis-server --appendonly yes : 在容器执行redis-server启动命令，并打开redis持久化配置
  --requirepass 'root' 添加密码root
  505  docker run -p 6379:6379 --name myredis -v /usr/local/redis/data:/data -d docker.io/redis:lastest redis-server --appendonly yes --requirepass 'root'
  507  docker ps

  511  docker exec -it myredis -h 120.79.81.98 -p 6379 -a root
  512  netstat -nltp
  527  docker exec -it myredis /bin/bash
  531  docker stop 43
  532  docker rm 43
  535  docker ps -a

