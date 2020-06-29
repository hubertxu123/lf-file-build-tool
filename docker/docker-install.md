

**1.docker安装:**
    
    **1.windows**   
        1.win10外:www.docker.com/products/docker-toolbox
            //需要在快捷方式上将命令改掉
            D:\install-soft\Git\bin\bash.exe --login -i "D:\install-soft\Docker Toolbox\start.sh"
        2.win10:  www.docker.com/products/docker#/windows
            https://get.daocloud.io/docker-install/windows
    **2.CentOS 6.5上安装docker**:安装docker-compose时使用
        1. uname -r         --查看下你的系统内核是多少
        2. cat  /etc/issue  --查看系统版本
                CentOS release 6.5 （Final）
                Kernel \r on an \m
        3. rpm -ivh http://dl.Fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
        4. rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
        5. yum -y install docker-io lvm2 lvm2-devel
        6. rpm -qa | grep docker  --查看docker
        7. service docker start   --启动并设置开机自动启动
        8. chkconfig docker on   --启动并设置开机自动启动
    **3.docker安装：** 暂时弃用
        1、查看你当前的内核版本
        uname -r
        2、更新yum包
        sudo yum update
        3、卸载已安装的docker（如果安装过的话）
         yum remove docker  docker-common docker-selinux docker-engine
        4、安装需要的软件包
        sudo yum install -y yum-utils device-mapper-persistent-data lvm2
        5、设置yum源
        sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        6、可以查看所有仓库中所有docker版本，并选择特定版本安装
        yum list docker-ce --showduplicates | sort -r
        7、重新安装docker
        sudo yum install docker-ce
        8、启动docker
        sudo systemctl start docker
        9、验证安装是否成功
        docker version  //查看docker的版本
        docker ps //查看当前正在运行的容器
        10、删除原本装好的nginx容器（如果安装过）
        docker rm nginx(容器名字或者id)
        11、删除nginx镜像文件
        docker images      //查看镜像文件
        docker rmi nginx   //删除nginx镜像
        docker rmi -f nginx     强制删除nginx镜像
        12、重装并启动nginx
        docker run --name nginx -d -p 80:80 nginx
        
**2.docker-compose安装：**
    
    *推荐使用pip安装docker-compose，因为pip可以为你自动对应版本问题
    1.安装pip
        yum -y install epel-release
        yum -y install python-pip
    2.确认版本
        pip --version
    3.更新pip
        pip install --upgrade pip
    4.安装docker-compose
        pip install docker-compose 
        或者 pip install -i https://pypi.tuna.tsinghua.edu.cn/simple docker-compose
        或者 pip install docker-compose -i  https://pypi.douban.com/simple 
    5.查看版本
        docker-compose version
        
**3.镜像仓库 docker registry安装：**
    
    1.介绍：
        Docker Registry的有点如下：
        （1）Docker Registry的最大优点就是简单，只需要运行一个容器就能集中管理一个集群范围内的镜像，其他机器就能从该镜像仓库下载镜像了。
        （2）在安全性方面，Docker Registry支持TLS和基于签名的身份验证。
        （3）Docker Registry也提供了Restful API，以提供外部系统调用和管理镜像库中的镜像
    2.安装：
        # 创建存放用户信息的目录
        	mkdir /opt/registry-var/auth/ -p
        # 为{andriy}用户名生成密码为{pass@word1}的一条用户信息，存在{/opt/registry-var/auth/htpasswd}文件里面
        	docker run --entrypoint htpasswd docker.io/registry -Bbn andriy pass@word1 
        	>> /opt/registry-var/auth/htpasswd
        # 启动registry容器
        	docker run -d -p 5000:5000 --restart=always -v /opt/registry-var/auth/:/auth/ -e "REGISTRY_AUTH=htpasswd"
        	 -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd -v 
        	 /opt/registry-var/:/var/lib/registry/ --name registry docker.io/registry
        
**3.镜像仓库 VMware Harbor 安装：**

    1.介绍：
        VMware Harbor（简称Harbor）项目是由VMware中国研发团队开发的开源容器镜像仓库系统，基于Docker Registry并对其进行了许多增强，主要特性包括：
        基于角色的访问控制
        镜像复制
        Web UI管理界面
        可以集成LDAP或AD用户认证系统
        审计日志
        提供RESTful API以提供外部客户端调用
        镜像安全漏洞扫描（从v1.2版本开始集成了Clair景象扫描工具）
    2.安装：
        前提：安装docker 和 docker-compose
        wget https://storage.googleapis.com/harbor-releases/harbor-offline-installer-v1.6.1.tgz
        # 配置Harbor及Docker
        tar zxvf harbor-offline-installer-v1.6.1.tgz
        cd harbor/
           修改harbor.cfg文件中hostname为主机IP
           在docker的daemon.json中添加本机80端口的insecure-registry
           重启docker
        # 安装harbor
            ./prepare
            ./instsll.sh
        安装部署完成之后可以通过浏览器登陆UIip:80
        默认用户名密码admin/Harbor12345
        
        【docker-compose ps   --查看是否正常
        docker-compose stop    -- 停止harbor
        ./install.sh           -- 重新启动并生成配置文件 
        systemctl daemon-reload             --重新启动
        systemctl restart docker.service    --重新启动】
        # systemctl restart docker　　#重启docker的话，要留意一下，通过docker启动的容器是否正常运行，　
        harbor就启动在docker容器里的，所以需要用docker-compose ps查看harbor服务状态，如果harbor状态不全是Up状态，
        那么使用 docker-compose up -d 再次启动所有
              
        
    3.登录使用：
        1.UI登录： 默认用户名密码admin/Harbor12345
        2.另一台服务器命令行登录：
            [root@VM_0_9_centos ~]# docker login lsbmxy.top
            Username: admin
            Password: 
            Error response from daemon: Get https://lsbmxy.top/v1/users/: dial tcp 120.79.81.98:443: connect: connection refused
            解决：
                在需要登陆的docker client端修改
                    vim lib/systemd/system/docker.service
                        在里面修改ExecStart那一行，增加【--insecure-registry=lsbmxy.top \】
                        然后重启docker：
                            systemctl daemon-reload
                            systemctl restart docker
                【harbor服务端修改：
                    # vi /etc/docker/daemon.json
                    {
                        "insecure-registries":["192.168.1.30"]
                    }
                    1、配置http镜像仓库可信任（docker默认是通过https访问harbor的，但是私有仓库是在公司内网的话，没有必要配置https, 所以我们要在daemon.json配置harbor服务器地址被docker认为是可信任的站点;如果docker通过https访问harbor，就不需要进行如下设置）
                    # vi /etc/docker/daemon.json
                    {"insecure-registries":["192.168.1.30"]}
                    格式不能写错，修改该配置后，需要重启docker服务，如果写错，重启docker会有问题。
                    # systemctl restart docker　　#重启docker的话，要留意一下，通过docker启动的容器是否正常运行，　harbor就启动在docker容器里的，所以需要用docker-compose ps查看harbor服务状态，如果harbor状态不全是Up状态，那么使用 docker-compose up -d 再次启动所有
                】
        3.拉取：
            docker run -p 81:80 --name ziniuweb -d hub.mioodo.cn/ziniu/web:20191013
            docker run -p 82:80 --name ziniuweb -d hub.mioodo.cn/ziniu/web:20191013
            docker pull hub.mioodo.cn/ziniu/web:20191013
            docker push hub.mioodo.cn/ziniu/web:20191013
            docker build -t hub.mioodo.cn/ziniu/web:20191013 .
            docker ps -a
            docker stop ea270dcc5713
            docker rm ea270dcc5713
            docker run -p 82:80 --name ziniuweb -d hub.mioodo.cn/ziniu/web:20191013
            
        4.简单测试：
             docker login lsbmxy.top --先登录：登录后才可以获取私有仓库镜像，否则只能拉取公有镜像
                admin
                xxxxx
             mkdir project
             cd project/
             touch Dockerfile
             vim Dockerfile
                ·FROM alpine:latest
                ·MAINTAINER xbf             --表示是xbf创建的即提交人
                ·CMD echo "hello docker!"
             docker build -t hello_docker .  --表示当前路径下所有内容都送给docker engine来构建image
             docker images hello_docker      --验证是否生成本地镜像
             docker run hello_docker         --运行镜像查看结果
             docker tag hello_docker lsbmxy.top/ziniu/hello_docker --转换镜像格式
             docker push lsbmxy.top/ziniu/hello_docker             --推送镜像 
             docker push lsbmxy.top/ziniu/hello_docker:1.0         --报错，因为没有写版本号，默认为lastest 
             docker push lsbmxy.top/library/hello_docker           --报错，没有转换镜像格式 
             docker tag hello_docker lsbmxy.top/library/hello_docker    --转换镜像格式
             docker push lsbmxy.top/library/hello_docker            --推送镜像
             docker build -t hello_docker:1.0 .                     --构建版本为1.0的镜像
             docker tag hello_docker:1.0 lsbmxy.top/ziniu/hello_docker:1.0  --转换格式
             docker push lsbmxy.top/ziniu/hello_docker:1.0                  --推送镜像
             docker build -t hello_docker_test:1.1 .                        
             docker tag hello_docker_test:1.1 lsbmxy.top/ziniu/hello_docker_test:1.1
             docker push lsbmxy.top/ziniu/hello_docker_test:1.1
             docker pull lsbmxy.top/ziniu/hello_docker_test:1.1
        5.Harbor使用修改80端口：
            cd /usr/local/harbor    --进入安装目录
            vim docker-compose.yml  --修改文件端口号
                proxy:
                    image: nginx:1.11.5
                    container_name: nginx
                    restart: always
                    volumes:
                      - ./common/config/nginx:/etc/nginx
                    ports:
                      - 1180:80     --修改映射端口80 为 1180
                      - 1143:443    --修改https端口1143 为443
                    depends_on:
                      - mysql
                      - registry
                      - ui
                      - log 
            vim common/templates/registry/config.yml -- 添加端口1180
                auth:
                  token:
                    issuer: registry-token-issuer
                    realm: $piblic_url:1180/service/token
                    rootcertbundle: /etc/registry/root.crt
                    service: token-service
            docker-compose stop     --停止harbor
            ./install.sh           --生成配置文件
            vim /usr/lib/systemd/system/docker.service  --修改如下一行：添加端口 修改docker启动文件，设置信任的主机与端口：
                ExecStart=/usr/bin/dockerd --insecure-registry=lsbmxy.top:1180 
            systemctl daemon-reload --重启
            systemctl restart docker.service --重启
            docker-compose ps           --查看harbor启动是否正常
            docker-compose up -d        --如果harbor状态不全是Up状态，那么再次启动所有
            --验证登录：
                [root@izwz93pjjhxv6fzgl5jzbwz harbor]# docker login lsbmxy.top:1180
                Username: admin
                Password: 
                Login Succeeded

             
            
            
