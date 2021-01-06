
**1.mysql安装：**

    1.下载位置：https://dev.mysql.com/downloads/mysql/5.7.html
    2.下载免安装：Windows (x86, 64-bit), ZIP Archive
    3.解压：
        D:\install-soft\mysql-5.7.28-winx64
    4.新建文件及文件夹：
        cd D:\install-soft\mysql-5.7.28-winx64
        mdkir data
        type nul>文件名.后缀名来创建文件：
            type nul>my.ini
                [mysqld]
                skip-grant-tables#免密登录
                port = 3306
                basedir=D:\install-soft\mysql-5.7.28-winx64
                datadir=D:\install-soft\mysql-5.7.28-winx64\data
                max_connections=200
                character-set-server=utf8
                default-storage-engine=INNODB
                sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
                [mysql]
                default-character-set=utf8
    5.配置环境变量path：
        path:D:\install-soft\mysql-5.7.28-winx64\bin
    6.运行安装：
            mysqld --initialize
            mysqld -install    
    7.启动：net start mysql
    8.连接：mysql -u root -p
        -- 修改密码
        mysql>UPDATE mysql.user SET authentication_string = PASSWORD('root'), password_expired = 'N' WHERE User = 'root' AND Host = 'localhost';
            ####################################################################
            此处可能报错：ERROR 1146 (42S02): Table 'mysql.user' doesn't exist
            原因：缺少了命令 【mysqld --initialize】
            处理：
                quit;  退出登录
                net stop mysql    停止运行mysql
                mysqld --remove   移除mysql
                mysqld --initialize
                接步骤6
            ####################################################################
        -- 刷新,及时生效
        mysql>flush privileges;      
        -- 退出
        mysql>quit;
    9.重新登录：
        mysql -u root -p 输入密码进入
        再创建一个admin账户 密码adminpwd 地址为localhost
            CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpwd';
        并且授权可以访问所有数据库表 并且授权帐号为admin 地址是 localhost
            GRANT ALL ON *.* TO 'admin'@'localhost';        
        退出即可使用此账号登录
    10.测试远程登录，需要修改为 %
        第一种（改表法）：
                修改host字段的值，将localhost修改成需要远程连接数据库的ip地址或者直接修改成%。
                修改成%表示，所有主机都可以通过root用户访问数据库。
            mysql> update user set host='%' where user='root' and host='localhost';
                运行上面语句可能会有个报错：
                ERROR 1062 (23000): Duplicate entry '%-root' for key 'PRIMARY'
                不用管，直接继续执行：
            mysql> flush privileges;
        
            或者直接创建一个新用户允许外联：
            insert into mysql.user(Host,User,Password) values("%","用户名",password("密码"));
            grant all privileges on `库名或*`.* to '用户名'@'%' identified by '密码';  
            flush privileges;
        
        第二种（授权法）:
            如使用root从任何主机连接到mysql服务器的话。
            GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '密码' WITH GRANT OPTION;
            mysql> flush privileges;
        
            如果你想允许用户myuser从ip为192.168.0.77的主机连接到mysql服务器，并使用12345作为密码
            GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.0.77' IDENTIFIED BY '12345' WITH GRANT OPTION;
            mysql> flush privileges;
        
            注：
            数据库添加用户语句：
            grant all privileges on testdb.* to 'test_user'@'localhost' identified by "密码" with grant option;
            WITH GRANT OPTION 这个选项表示该用户可以将自己拥有的权限授权给别人。
            在创建操作用户的时候不指定WITH GRANT OPTION选项将导致该用户不能使用GRANT命令创建用户或者给其它用户授权。
            如果不想这个用户有这个grant的权限，可以不加这句
