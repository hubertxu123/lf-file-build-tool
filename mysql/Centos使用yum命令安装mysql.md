
**1. 查看服务器中有没有安装过MySQL**

    1. 查看有没有安装包:
        yum list mysql*
        #移除已经安装的mysql
        yum remove mysql mysql-server mysql-libs compat-mysql51
        rm -rf /var/lib/mysql
        rm /etc/my.cnf
    2. 查看是否还有mysql软件:
        rpm -qa|grep mysql
        #如果有的话,继续删除
    3.  安装mysql客户端
        yum install mysql-server 
        yum install mysql-devel

**2. 启动&&停止 数据库字符集设置**

    1. 配置mysql文件:
        > cd /etc/my.cnf 
        # 加入配置参数
        > character-set-server=utf8 
    2. 启动mysql服务
        > service mysqld start
        #或者下面这个
        >/etc/init.d/mysqld start
    3. 设置开机启动
        >chkconfig --add mysqld
        >chkconfig mysqld on
    4. 查看开机启动设置是否成功
        >chkconfig --list | grep mysql* 
        # mysqld 0:关闭 1:关闭 2:启用 3:启用 4:启用 5:启用 6:关闭停止

**3. 登录 mysql**

    >mysql -u root -p
    #如果忘记密码解决,查看下面的问题

**4. 远程访问 开放防火墙的端口号mysql**

    1.增加权限
    # mysql库中的user表新增一条记录host为“%”，user为“root”

**5. Linux MySQL 几个重要 的目录**

    数据库目录 /var/lib/mysql/
    配置文件 /usr/share /mysql（mysql.server命令及配置文件）
    相关命令 /usr/bin（mysqladmin mysqldump等命令）
    启动脚本 /etc/rc.d/init.d/（启动脚本文件mysql的目录）

**6.删除mysql数据库**

    #如果使用的是yum安装的mysql,需要删除的话,就是用如下命令:
    > yum -y remove mysql*
    # 然后将/var/lib/mysql文件夹下的所有文件都删除干净
    # 然后在重新执行上面的安装步骤

**7.授权用户从远程登录**

    注意:下面两个步骤都需要执行.步骤一,只是修改了用户的密码.但是并没有对用户进行授权;步骤二的作用就是授权,让用户可以指定权限(连接诶数据库,查询数据库...)
    1. 改表法。可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%"
        mysql -u root -pvmware;
        mysql>use mysql;
        mysql>update user set host = '%' where user = 'root';   --若报错,则执行set sql_safe_updates=0; 
            ERROR 1175 (HY000): You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column
            mysql>  set sql_safe_updates=0; 
                ——————————————
                mysql有个叫SQL_SAFE_UPDATES的变量，为了数据库更新操作的安全性，此值默认为1，所以才会出现更新失败的情况:
                查看设置：
                mysql> show variables like 'sql_safe%';
                解决：
                mysql> set sql_safe_updates=0; 
                mysql> set sql_safe_updates=off;   
                ——————————————
        mysql>select host, user from user;
    2. 授权法。例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。
        GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;
        如果你想允许用户myuser从ip为192.168.1.3的主机连接到mysql服务器，并使用mypassword作为密码  
        GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

**8.注意**

    注意:
        1.【下面这一句一定要执行，否则还是无法登陆】  
        mysql>flush privileges ;
        2.如果用户无法从本地登陆，这个时候就执行如下
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost.localdomain' IDENTIFIED BY '123456' WITH GRANT OPTION;
        # flush privileges ;