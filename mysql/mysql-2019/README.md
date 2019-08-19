
**1.数据库技术构成：**

    1.数据库系统
        ·数据库：存储数据
        ·数据库管理系统：管理数据库的软件
        ·数据库应用程序：为提高数据库系统的处理能力所使用的的管理数据库的软件补充
    2.SQL语言：结构化查询语言
        ·数据定义语言：DDL 【数据表】的创建修改删除
        ·数据操作语言：DML 【表数据】插入更新删除
        ·数据查询语言：DQL 【表数据】查询
        ·数据控制语言：DCL 【用户管理语句，数据库管理语句】
    3.数据库访问技术：
        通过各种应用程序连接数据库，访问数据库，操作数据库
        
**2.mysql启动登录测试：**

    0.安装及环境变量配置
    1.服务启动：
        ·若挂载成了windows服务：
            1.cmd：services.msc 打开windows服务，找到mysql启动
            2.cmd:net start mysql
            3.cmd:net stop mysql
    2.客户端登录：
        ·cmd ：mysql -h ip -u root -p -P 3306
                -p表示使用密码登录 

**3.mysql参数配置更改:**

    ·cmd：services.msc 打开windows服务，找到mysql --> 右键属性 --> 获取到my.ini配置文件
        D:\install-soft\mysql5.6\bin\mysqld.exe" --defaults-file="C:\ProgramData\MySQL\MySQL Server 5.6\my.ini" MYSQL56_1  
   
**4.创建数据库：** 

    1.在系统磁盘上划分一块区域用于数据存储和管理：默认： datadir=C:/ProgramData/MySQL/MySQL Server 5.6/Data
    
**5.数据库存储引擎:**
    
    1.简介：mysql提供了多种存储引擎，包含处理事务安全表的引擎和处理非事务安全表的引擎，mysql5.5支持的存储引擎有：
        InnoDB，MyISAM，Memory，Merge，Archive，Federated，CSV等
    2.分类：
        ·InnoDB:是事务型数据库的首选引擎，支持事务安全表（ACID），支持行锁定和外键，mysql5.5之后成为默认存储引擎
        ·MyISAM:基于ISAM存储引擎，他常用在web，数据仓储等，有较高的插入和查询速度，但不支持事务，在mysql5.5之前为默认存储引擎   
        ·Memeory:将表数据存储在内存中，为查询和引用其他表数据时提供快速的访问速度
    3.引擎选择：--
        ·InnoDB:支持事务 崩溃回滚
        ·MyISAM:快速插入和查询
        ·Memeory:数据量不大的临时数据，不需要较高安全性，存放查询的中间结果
    4.案例分析：
        
            