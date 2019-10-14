**docker镜像中心：_docker镜像地址：http://get.daocloud.io/_**
**jenkins官网：_https://jenkins.io/download/thank-you-downloading-windows-installer-stable/_**
**dubbo中文参考文档：_https://dubbo.gitbooks.io/dubbo-user-book/content/quick-start.html_**




# jenkins++
**什么是持续集成？**
    
    持续集成是一个开发的实践，需要开发人员定期集成代码到共享存储库。这个概念是为了消除发现的问题，后来出现在构建生命周期的问题。
    持续集成要求开发人员有频繁的构建。最常见的做法是，每当一个代码提交时，构建应该被触发。
    
    1.下载war包-jenkins
    2.项目启动:D:\worksp\yiibai.com>java -jar Jenkins.war
    3.链接访问 Jenkins −http://localhost:8080
    4.输入密码

# Docker +++

**1.docker简介**
    
    1.云计算基础
    2.linux命令行
    3.bash
    4.Docker 是一个开源的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的容器中，
        然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。
        容器是完全使用沙箱机制，相互之间不会有任何接口
    
**2.docker安装:www.docker.com**


**3.docker架构：**

**4.相关命令;**
    
    1.docker run ubuntu echo hello docker
      ·docker run   --运行
      ·ubuntu       --要运行的image的名字
      ·在ubuntu中运行命令 echo hello docker 输出 hello docker
    2.docker run nginx 
      ·Unable to find image 'nginx:latest' locally
      ·在运行前先去查找本地是否有image的nginx，没有的话去远端的registery去下载
    3.docker images --查看本地所有的images
      ·REPOSITORY   TAG     imageid  created                size
        nginx-hello  latest  0dac...  28 minutes ago         182.8M
    4.docker run -p 8080:80 -d nginx-hello:latest （名称为docker images查出来的REPOSITORY的值+tag  -即路径）
      ·17add7....  --启动成功后返回一个container id
      ·-p 8080:80  --端口映射：指把nginx原来的80端口映射为8080端口进行开启
      ·-d          --允许此程序直接返回
      ·使用localhost:8080进行浏览器访问，可查看启动成功
    5.docker ps  --查看当前运行中的container
      ·CONTAINERID   IMAGE          COMMAND  CREATDE  STATUS   PORT  NAMES
        17add...      nginx-hello                               443/tcp. 0.0.0:8080->80/tcp 
    5.1.docker ps -a --列出所有已运行过得容器，包含已经停止的容器（即运行容器的历史记录）
    6.docker cp index.html 17add7bbc...://usr/share/nginx/html
      ·将静态文件copy到17aa...的nginx服务器上，具体路径跟在后面
      ·此时访问：localhost:8080即可访问此文件
    7.docker stop 17add7bbc...
      ·停止17aa...的nginx服务
      ·docker run -p 8080:80 -d nginx-hello  --重新打开此服务，HTML文件丢失
      ·所以在进行文件修改后要记得提交：
    8.docker commit -m '提交注释' 17add...
      ·保存这个nginx服务（包含已修改文件）
      ·成功后返回：--一个image的id--即新建了一个image
        sha256:84ca813...
      ·docker images --此种提交方式没有指定名称，故如下
        ·REPOSITORY   TAG     imageid    created                size
          <none>       <none>  84ca813... 28 minutes ago         182.8M
    9.docker commit -m '提交注释' 17add... nginx-fun
       ·此种提交方式会有名称：
       ·docker images --此种提交方式没有指定名称，故如下
               ·REPOSITORY   TAG     imageid    created                size
                  nginx-fun   latest  84ca813... 28 minutes ago         182.8M
    10.docker rmi 84ca813...
        ·删除imageid为84ca813...的容器
        ·删除成功，返回：Deleted:sha256：...
        ·docker ps -a --列出所有已运行过得容器，包含已经停止的容器（即运行容器的历史记录）
    11.docker rm e7c.. 17a...
        ·删除以上两个id的容器，--基于此命令:docker ps -a -
    ****************************************************************************
    12.docker pull      获取远端images
    13.docker build     创建images
    14.docker images    列出images
    15.docker run       运行container
    16.docker ps        列出container
    17.docker rm        删除已结束container
    18.docker rmi       删除image
    19.docker cp        在host和container之间拷贝文件
    20.docker commit    保存改动为新的image --创建新的镜像
    21.docker top 容器名 查看当前容器正在运行的进程
    22.docker inspect 容器名   --容器的相关信息-可查看挂载信息
    23.docker logs -f 容器名   --查看web应用日志
    24.docker search tomcat    --搜索tomcat镜像
    ****************************************************************************
    docker 启动 web 示例报错如下：
        Error response from daemon: Cannot start container web: iptables failed: iptables -t nat -A DOCKER -p tcp -d 0/0 --dport 32797 -j DNAT --to-destination 172.17.0.30:5000 ! -i docker0: iptables: No chain/target/match by that name.
        1
        解决办法：重建docker0网络恢复
        
        pkill docker 
        iptables -t nat -F 
        ifconfig docker0 down 
        brctl delbr docker0 
        docker -d 
        service docker restart
**4.Dockerfile：---通过编写简单文件自创docker镜像**

    1.常用命令中使用docker commit创建新镜像
    2.创建步骤：
        ·mkdir file
        ·cd file
        ·ls
        ·touch Dockerfile --创建文件：此处可使用其他名称命名
        ·vim Dockerfile   --打开并编辑
            ·FROM alpine:latest
            ·MAINTAINER xbf             --表示是xbf创建的即提交人
            ·CMD echo "hello docker!"
        ·esc + :wq! + enter
        ·docker build -t hello_docker .
            ·-t hello_docker --一个标签名为hello_docker
            ·"."表示当前路径下所有内容都送给docker engine来构建image
        ·docker images hello_docker --查看是否构建了此image
        ·docker run hello_docker --运行此image
            ·hello docker！
    3.复杂Dockerfile创建：
        ·基本内容：
          FROM ubuntu   --基础镜像
          MAINTAINER xbf--创建人
          RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.deu.cn/g' /etc/apt/sources.list --加速构建：将镜像换为国内的
          RUN apt-get update            --运行安装nginx
          RUN apt-get install -y nginx  --运行安装nginx,-y 禁止提醒
          COPY index.html /var/www/html --拷贝本地文件到container
          ENTRYPOINT ["/usr/sbin/nginx","-g","daemon off;"]  --拷贝入口；nginx在前台执行
          EXPOSE 80                     --端口80                                   
        ·创建过程：
            ·touch Dockerfile
            ·vim Dockerfile   --打开并编辑，将基本内容拷贝
        ·启动-
        ·测试：curl http://...
    4.Dockerfile语法：
        ·FROM   base image
        ·RUN    执行命令
        ·ADD    往容器中添加文件
        ·COPY   往容器中拷贝文件
        ·CMD    执行命令
        ·EXPOSE 暴露端口
        ·WORKDIR    指定路径
        ·MAINTAINER 容器入口
        ·ENV        container中设定环境变量
        ·USER       容器里指定用户运行-通常不使用root
        ·VOLUME     指定容器所挂载的卷：mount point

**5.镜像分层**     
          
**6.Volume：提供独立于容器之外的持久化存储-可提供容器之间数据共享**        

**7.docker:去仓库把镜像拉到本地，用命令将镜像启动起来变成容器**       

    1.docker镜像：文件-存储格式-联合文件系统--分层
        --镜像是不可以被修改的
        --构建镜像的目的：
            ·在其他环境或程序中运行自己的项目
            ·所以若仅在自己本地运行是不需要构建镜像的
            ·所以要传输镜像到指定目的地，传输过程就要使用docker仓库
    2.docker容器：--本质为一个进程（可看为虚拟机）
        --容器为分层的，最上一层可写（如在容器中记录一些日志...）
        --当用命令将镜像启动起来变成容器时，实际是将此镜像复制到最上一层(即成为容器)，此时变为可读写的
        --同一个镜像可生成多个容器，且相互无干扰
    3.docker仓库：
        --1.将镜像传输到docker仓库
        --2.目的地去docker仓库将镜像拉取过去
        ————————
        --3.docker仓库的提供者：中央服务器
        --4.docker自己提供服务：服务地址-hub.docker.com
            国内之前无发访问，现在可以，但速度仍旧很慢
            国内知名仓库：c.163.com
        --5.docker支持自己搭建的镜像中心--一些私密的镜像，不对外提供
    4.docker常用于linux系统
        
**9.操作**
**_(由于docker的默认形式为bridge模式，由于没有指定映射关系，所以即使启动容器也是无法外部访问的)_**

    1.获取CentOS镜像　　--默认官网下载镜像
      # docker pull  hello-world:latest
    2.运行镜像：
      # docker run hello-world (如果没有会先去远程pull)
         1. The Docker client contacted the Docker daemon.
            //docker客户端连接docker daemon
         2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
            (amd64)
            //daemon从docker hub拉取hello-world镜像
         3. The Docker daemon created a new container from that image which runs the
            executable that produces the output you are currently reading.
            //daemon从镜像创建了一个新的容器，生成当前正在读取的输出的可执行文件。
         4. The Docker daemon streamed that output to the Docker client, which sent it
            to your terminal.
            //daemon将输出变为输出流输出到客户端，客户端将他发送给终端
    3.nginx镜像运行：
        1.nginx与hello-world镜像相比，他是一个需要持久运行的容器(hello-world只打印内容)
        2.前台挂起：使用ctrl+c即可退出运行
          后台运行：--
        3.进入nginx容器内部查看--
        -----
        docker ps           -- 查看当前运行中的docker镜像（以管理员身份运行）
        docker run nginx    -- 以前台方式运行docker，ctrl+c关闭
        docker run -d nginx -- 以后台方式运行docker，返回一个字符串代表容器id
        docker run --help   -- 帮助查看run
        docker stop 容器id  -- 停止运行某容器
        docker run -d -p 8080:80 nginx   --开放指定端口映射   
        docker run -d -P nginx           --开放随机端口映射（可用ps查看具体端口进行访问）
        docker run -d --name 名字 -p 3306:3306 -p 8080:80 镜像名
        netstat -na |grep 32769          --查看32769端口是否被启动
        +++++++++++++++++++++++++++++++++++++++
        --查看容器的挂载位置：显示所有相关配置信息
        docker inspect 0127b
        +++++++++++++++++++++++++++++++++++++++
        -----容器内部
        docker exec --help  -- 帮助查看exec
        ·docker exec -it 容器id截取部分(可唯一确定即可) bash    --进入容器内部--继续执行命令
            ·docker exec -it a11e4c6                      bash
        ·############以下为容器内部执行命令############
            which nginx         --查看nginx路径
            ps -ef              --查看当前服务的进程
            exit                --回到主机
        ·#############################################
        docker stop alle4c6
         -----docker网络-访问容器中的nginx
         1.docker网络类型：
            桥接bridge 
            主机host
            none
         2.端口映射-网络访问
         docker run -d -p 8080:80 nginx   --开放指定端口映射   
         docker run -d -P nginx           --开放随机端口映射（可用ps查看具体端口进行访问）
**10.制作自己的镜像**

    1.准备一个打包好的项目：
        --https://gitee.com/fuhai/jpress/blob/alpha/wars/jpress-web-newest.war 此处使用jpress的war包
    2.拉取tomcat镜像
        --docker镜像地址：http://get.daocloud.io/
        --docker pull tomcat:latest  
        --docker pull daocloud.io/library/tomcat:latest
        --docker pull daocloud.io/library/nginx:latest
        --cp /mnt/hgfs/谷歌下载/jpress-web-newest.war /docker_container/
        --mv jpress-web-newest.war jpress.war
     3.新建Dockerfile文件：
        --vi Dockerfile
            from daocloud.io/library/tomcat
            MAINTAINER lishengbo 982338665@qq.com
            COPY jpress.war /usr/local/tomcat/webapps
     4.构建镜像：
        --docker build -t jpress:latest .
        --docker run -d -p 8080:80 jpress
        --localhost:8888/jpress
        -------
        --docker pull hub.c.162/library/mysql:latest
        --docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=000000 hub.c.162/library/mysql:latest
            -e 指环境变量 添加mysql管理员密码000000
