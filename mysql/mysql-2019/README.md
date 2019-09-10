
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
        
**6.mysql数据类型介绍：**

    1.整数类型:
        tinyint(4)
        smallint(6)
        mediumint(9)
        int(11)
        bigint(20)
    2.浮点和定点数类型: (m,n) m为精度表示总共位数 n为标度表示小数位数，超出小数位数会进行四舍五入
        浮点：不指定精度则默认会根据计算机自己处理 可能会有精度问题
            float(5,1)  
            double(5,1)
        定点：不指定时候默认为(10,0)，在mysql中以字符串形式存在，精度较高，计算也不影响
            decimal(5,1)
    3.日期和时间类型:
        datetime：可插入('1998-08-08 00:00:00'),('19980908000000')
        date：可插入('1998-08-08'),('19980908')
        timestamp：时间戳 与datetime相同
            不同点：-> 根据时区的不同 ，所查到的内容也会不同
                插入当前时间，查看插入值 date1
                更改时区，重新查看插入数据，则查出数据已被改变
                sql:
                    insert into values (now());原为东八区，
                    set time_zone = '+10:00' ;更改为东十区，时间相差两小时
        time：'10:00:00' 时分秒  
        year：占一个字节，可插入4位的字符串或数字 取值范围为1901-2155，不在此范围则默认插入 0000 
    4.字符串类型:可存储字符串，图片，声音的二进制
        char:0-255字符，char(4) 定长为4 如插入【ab  】 ，则实际为 (ab),尾部空格被自动删除
        varchar:0-65535,varchar(4)，变长为4，如插入【ab  】，则实际为(ab  ),两个空格会被保留
        binary:
        varbinary:
        blob:
        text:文本类型
        enum:枚举类型，字符串对象
        set:

**6.mysql数据类型选择：选用合适且精确的类型**
    
    1.货币等精度较高的类型:选择定点数 decimal
    2.datetime 和 timestamp的区别：
        ·存储方式不同：跨时区业务timestamp更合适
            TIMESTAMP:把客户端插入的时间从当前时区转化为UTC（世界标准时间）进行存储。查询时，将其又转化为客户端当前时区进行返回。
            DATETIME，不做任何改变，基本上是原样输入和输出
        · 两者所能存储的时间范围不一样：
            TIMESTAMP：'1970-01-01 00:00:01.000000' 到 '2038-01-19 03:14:07.999999'。
            DATETIME：'1000-01-01 00:00:00.000000' 到 '9999-12-31 23:59:59.999999'。
        ·TIMESTAMP和DATETIME的自动初始化和更新：
            MySQL 5.6.5版本之前，Automatic Initialization and Updating只适用于TIMESTAMP，而且一张表中，最多允许一个TIMESTAMP字段采用该特性
            MySQL 5.6.5开始，Automatic Initialization and Updating同时适用于TIMESTAMP和DATETIME，且不限制数量。
                自动初始化指的是如果对该字段（譬如上例中的hiredate字段）没有显性赋值，则自动设置为当前系统时间。
                自动更新指的是如果修改了其它字段，则该字段的值将自动更新为当前系统时间。
            由于自动更新和初始化不是我们想要的，所以可以关闭此功能：
                1.show variables like '%explicit_defaults_for_timestamp%'; 设置为 on
                2.建表时指定默认值：
                      `hiredate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
                      `hiredate` timestamp NULL DEFAULT NULL
    3.char和varchar的区别：
        char：固定长度字符，自动删除尾部空格，处理速度快于varchar
        varchar：可变长度字符，保留原来内容
            对于myIsam表引擎：最好使用char可以使表结构静态化 ，使检索速度更快
            对于INNOdb引擎，char跟varchar不一定哪个更好，因为innodb不分固定长度和可变长度
    4.BLOB和text：
        BLOB:存储二进制类型文件
        TEXT:存储文本文件

**7.运算符介绍：**
    
    1.算术运算符：+ - * / %
        /:除法会保留四位小数，四舍五入，如果分母为0，则值为null
        %:求余数，如果分母为0，则值为null select 1/0;
    2.比较运算符：结果总为 1,0 ，NULL
        =:等于，不可以判断空值
            select 1=0,1='1',null=null;         0 1 null
        <=>:安全等于，可以判断空值
            select 1<=>0,1<=>'1',null<=>null    0 1 1
        !=(<>):不等于，不可以判断空值
            select 1!=0,null!=null;             1 null
        >,<,<=,>=:不可以判断空值
        is null,is not null,isNUll():
        between and值区间含端点值判断：
            select 4 between 2 and 5; 4是否在2-5之间
            select 'b' between 'a' and 'c' ;判断字符b是否在a-c之间
        least最小值：select least(2,0.1);返回0.1   不可判断空值
        greatest最大值：select greatest(2,0.1);返回2   不可判断空值
        in/not in:
        like:模糊查询 % 和 _  下划线只能表示一个任意字符，%则不限数量
        regexp：正则表达式匹配
    3.逻辑运算符：结果true false null
        not 
        ！
        and 
        &&
        or
        ||
        xor
    4.位操作运算符：
    

            