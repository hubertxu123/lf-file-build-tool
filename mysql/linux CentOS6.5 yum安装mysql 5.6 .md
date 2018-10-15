
1.新开的云服务器，需要检测系统是否自带安装mysql

    # yum list installed | grep mysql
2.如果发现有系统自带mysql，果断这么干

    # yum -y remove mysql-libs.x86_64
3.随便在你存放文件的目录下执行，这里解释一下，由于这个mysql的yum源服务器在国外，所以下载速度会比较慢，还好mysql5.6只有79M大，而mysql5.7就有182M了，所以这是我不想安装mysql5.7的原因

    # wget http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
4.接着执行这句,解释一下，这个rpm还不是mysql的安装文件，只是两个yum源文件，执行后，在/etc/yum.repos.d/ 这个目录下多出mysql-community-source.repo和mysql-community.repo

    # rpm -ivh mysql-community-release-el6-5.noarch.rpm
5.这个时候，可以用yum repolist mysql这个命令查看一下是否已经有mysql可安装文件

    #yum repolist all | grep mysql
6.安装mysql 服务器命令（一路yes）：

    # yum install mysql-community-server
7.安装成功后

    # service mysqld start
8.由于mysql刚刚安装完的时候，mysql的root用户的密码默认是空的，所以我们需要及时用mysql的root用户登录（第一次回车键，不用输入密码），并修改密码

    # mysql -u root
    # use mysql;
    # update user set password=PASSWORD("这里输入root用户密码") where User='root';
    # flush privileges; 
    -------------------------
    # 使用命令行重新登录：
    # mysql -u root -p
      Enter password: 输入密码
    # 进入登录...
9.查看mysql是否自启动,并且设置开启自启动命令

 
    # chkconfig --list | grep mysqld
    # chkconfig mysqld on
10.mysql安全设置(系统会一路问你几个问题，看不懂复制之后翻译，基本上一路yes)：

    # mysql_secure_installation
    
# 关于登录方式：

**1.指定密码登录：**
    
    mysql -u root -p
    
**2.指定密码,端口登录：**

    mysql -u root -p  -P 3306
    
**3.指定密码,端口,ip登录：**

    mysql -h ip -u root -p -P 3306