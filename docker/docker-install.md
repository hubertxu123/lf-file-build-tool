

**1.docker安装:**
    
    **1.windows**   
        1.win10外:www.docker.com/products/docker-toolbox
        2.win10:  www.docker.com/products/docker#/windows
    **2.CentOS 6.5上安装docker**
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
            