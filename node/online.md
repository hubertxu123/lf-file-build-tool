


  

  **安装docker：********************************************************************************************
    6  rpm -ivh http://dl.Fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    7  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    8  yum -y install docker-io lvm2 lvm2-devel
    9  chkconfig docker on
   13  systemctl start docker
   14  docker ps
   15  docker images


   **安装mysql5.7：********************************************************************************************
   16  docker search mysql 
   17  docker pull daocloud.io/mysql:5.7
   18  docker run --name mysql5.7 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=qwe123 -d daocloud.io/mysql:5.7
   19  docker ps

 
   **安装mongo：********************************************************************************************
   21  docker search mongo
   22  docker pull mongo
   23  docker run --name mongodb -p 27017:27017 -d mongo --auth
   24  docker ps
   26  docker exec -it 4022  mongo admin
   27  docker ps 
   36  docker stop 4022
   40  docker start 4022
   45  docker exec -it 4022 mongo admin
   46  docker ps
   47  docker stop mongodb
   48  docker ps
   49  docker ps -a
   50  docker rm mongodb 
   51  ll
   52  docker ps -a
   53  docker run --name mongodb -p 27017:27017 -d mongo --auth
   54  docker exec -it 685 mongo admin
   55  mongo

   **安装mysql5.6：********************************************************************************************
   80  docker search mysql 
   81  docker pull mysql:5.6
   82  docker images
   83  docker run --name mysql5.6 -p 3307:3306 -e MYSQL_ROOT_PASSWORD=qwe123 -d docker.io/mysql:5.6
   84  docker ps
   85  rpm -q gcc rpm -q gcc-c++
   86  yum -y install gcc gcc-c++ kernel-devel
   87  yum -y update && yum -y groupinstall "Development Tools"
   88   rpm -Va --nofiles --nodigest
   89  yum -y update && yum -y groupinstall "Development Tools"
   90  cd /usr/local/nodejs
   91  mkdir /usr/local/nodejs
   92  cd /usr/local/nodejs
   96  wget https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz 
   97  tar xvf node-v8.11.4-linux-x64.tar.xz
   98  mv node-v8.11.4-linux-x64 node-v8.11.4
  100  cd /node-v8.11.4/bin && ls
  101  rm -rf node--v8.11.4-linux-x64.tar.xz
  109  ./node -v
  153  ln -s /usr/local/nodejs/node-v8.11.4/bin/node /usr/bin/node
  154  ln -s /usr/local/nodejs/node-v8.11.4/bin/npm /usr/bin/npm
  155  node -v
  156  npm -v

  **安装angular6.0.5：********************************************************************************************

  160  npm install -g @angular/cli@6.0.5
  175  ln -s /usr/local/nodejs/node-v8.11.4/bin/ng /usr/bin/ng
  161  cd /usr/local/project/
  164  cd mss-UI/
  166  ng serve
  169  node -v
  170  npm -v
  172  ng -v
  

  **ng serve启动报错：【Error: EACCES: permission denied】********************************************************************************************
  194  npm install node-sass@latest --unsafe-perm=true --allow-root 【解决方式：命令后天添加 --unsafe-perm=true --allow-root】
  195  ng s
  

  ***本身项目出错，调整项目内容********************************************


  ***angular启动：*****************************************************************
   ng serve --host 0.0.0.0

  ***java启动：**************************************************************
  chmod 777 mss-api.jar 
  nohup java -jar mss-api.jar --server.port=8088 >> mss.log  2>& 1 &
  tail -f mss.log 

  ***node后台启动:*******************************************************************
   nohup command & node www & 







  http://192.168.31.136:4200


  部署时，需要修改数据库配置信息
