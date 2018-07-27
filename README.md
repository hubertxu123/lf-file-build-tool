# buildTool

Jenkins是一个功能强大的应用程序，允许持续集成和持续交付项目，无论用的是什么平台。这是一个免费的源代码，可以处理任何类型的构建或持续集成。
集成Jenkins可以用于一些测试和部署技术。





**什么是持续集成？**
    
    持续集成是一个开发的实践，需要开发人员定期集成代码到共享存储库。这个概念是为了消除发现的问题，后来出现在构建生命周期的问题。
    持续集成要求开发人员有频繁的构建。最常见的做法是，每当一个代码提交时，构建应该被触发。
    
**jenkins官网：_https://jenkins.io/download/thank-you-downloading-windows-installer-stable/_**

    1.下载war包-jenkins
    2.项目启动:D:\worksp\yiibai.com>java -jar Jenkins.war
    3.链接访问 Jenkins −http://localhost:8080
    4.输入密码

**tomcat安装：**

    1.下载tomcat
    2.粘贴jenkins.war包到tomcat的webapps目录下
    3.D:\worksp\yiibai.com\tomcat7\bin>startup.bat
    4.链接访问 http://localhost:8080/jenkins
    6.插件配置并且新建用户--
    5.浏览器中执行以下命令（URL地址）重新启动 Jenkins。URL地址：http://localhost:8080/jenkins/restart
    6.新建项目在 Jenkins 的菜单选项。然后输入一个名称的工作，在以下示例中，输入的名称是“Demo”。选择“Freestyle project”作为项目类型。
    7.
    
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
    4.docker run -p 8080:80 -d nginx-hello （名称为docker images查出来的REPOSITORY的值-即路径）
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
    ****************************************************************************
    
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
                
        