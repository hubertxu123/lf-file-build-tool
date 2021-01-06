
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
        -- 刷新账户信息
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
