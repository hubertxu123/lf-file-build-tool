### 来源：https://www.cnblogs.com/xinysu/p/6992415.html?utm_source=itdadao&utm_medium=referral

**1.前言：**

    SQL SERVER的表结构及索引转换为MySQL的表结构及索引，其实在很多第三方工具中有提供，比如navicat、sqlyog等，但是，在处理某些数据类型、默认值及索引转换的时候，
    总有些不尽人意并且需要安装软件，懒人开始想法子，所以基于SQL SERVER，写了一个存储过程，可以根据表名直接转换为MySQL的建表建索引的SQL脚本
    （针对 MySQL Innodb引擎）。目前不支持分区表的分区配置及区域数据类型的转换。
    
**2.数据类型转换**

    1.转换差异：
        ·数据类型转换表详见下表，这些数据类型的转换目前已测试过，均可正常使用。
            但是注意两类数据库存储数据的一些差异，看下能否接受：
        ·SQL SERVER中的datetime，保留到微秒(秒后小数点3位)，而mysql仅保留到秒，转换后是否会影响业务，如果影响，需要新增一个字段专门来存储微秒或者毫秒，
            虽然mysql中没有时间数据类型的精度到达微秒或者毫秒，但是mysql提供对微秒的相关处理函数microsecond、extract跟date_format。
        ·MySQL使用tinyint代替SQL SERVER的bit
        ·SQL SERVER的money类型使用decimal替代
        ·timestamp的转换，SQL SERVER中是一个16进制的数字，代表时间戳，每次修改都会数值都会变大。
        ·从功能考虑，转换为mysql的时候，处理为timestamp的数据类型，默认值为CURRENT_TIMESTAMP，行发生修改则定时修改这一列数据，如果这样转换，那么在SQL SERVER导入数据的时候，就要相应处理。（本文存储过程默认这么处理）
        ·从数据考虑，转换为mysql的时候，处理为bigint的数据类型（修改存储过程case when b.name = 'timestamp' then ' timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ' 为case when b.name = 'timestamp' then ' bigint ' ）
            自增处理，mysql的自增步长跟增量值是整个实例统一的，不能每个表格动态修改，所以这里在转化的过程中，为auto_increment，根据实例的设置来处理

  |ID|SQL SERVER	|MySQL	|Description|
  |----|----|----|----|
 |1	|bigint|bigint	 
 |2	|binary|binary	 
 |3	|bit   |tinyint	|SQL SERVER的bit类型，对于零，识别为False，非零值识别为True。MySQL中没有指定的bool类型，一般都使用tinyint来代替
 |4	|char  |char	 
 |5	|date  |date	 
 |6	|datetime	|datetime	|注意，mssql的保留到微秒(秒后小数点3位)，而mysql仅保留到秒
 |7	|datetime2	|datetime	|注意，mssql的保留到微秒(秒后小数点7位)，而mysql仅保留到秒
 |8	|datetimeoffset	|datetime	|注意，mssql的保留时区，这个需要程序自己转换mssql的保留到微秒(秒后小数点7位)，而mysql仅保留到秒
 |9	|decimal	|decimal	 
 |10|	float	|float	 
 |11|	int	    |int	 
 |12|	money	|float	|默认转换为decimal(19,4)
 |13|	nchar	|char	|SQL SERVER转MySQL按正常字节数转就可以
 |14|	ntext	|text	 
 |15|	numeric	|decimal	 
 |16|	nvarchar	|varchar	 
 |17|	real	|float	 
 |18|	smalldatetime	|datetime	 
 |19|	smallint	|smallint	 
 |20|	smallmoney	|float	|默认转换为decimal(10,4)
 |21|	text	|text	 
 |22|	time	|time	|注意，mssql的保留到秒后小数点8位，而mysql仅保留到秒
 |23|	timestamp	|timestamp	|注意，mssql的行时间戳，处理为mysql的 timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 。这会对后面导数据造成影响，从功能方面来看，可以按照上文转换；如果从数据来看，若需要转换16进制的文字存储到mysql中，则这里设置为bigint即可，在表格中的临时表中设置。
 |24|	tinyint	|tinyint	 
 |25|	uniqueidentifier	|varchar(40)	|对应mysql的UUID(),设置为文本类型即可。
 |26|	varbinary	|varbinary	 
 |27|	varchar	|varchar	 
 |28|	xml	|text	|mysql不支持xml，修改为text
 
 **3.主键处理：**
    
    1.MySQL不支持非主键的聚集索引，也就是聚集索引则是主键。故在转换的过程中，主键是根据SQL SERVER表格中的聚集索引来转换的。
    2.代码：
        --SQL SERVER根据聚集索引的列情况来创建mysql的主键
        SELECT
               col_name(i.object_id,ik.column_id) pk_col
        FROM sys.indexes i
        JOIN sys.index_columns ik ON i.index_id=ik.index_id and i.object_id=ik.object_id
        WHERE i.type=1
              and i.object_id=object_id('tb')
        ORDER BY key_ordinal
        
 **4.索引添加：**
    
    由于聚集索引已处理添加为主键，在建表的SQL中已判断，这里则只处理非聚集索引。
    处理过程中注意：
    MySQL不支持INCLUDE选项的包含索引，所以在处理的过程中，INCLUDE列添加到索引列中
    MySQL 不支持WHERE选项的过滤索引，所以在处理的过程中，WHERE选项去除
    索引名字处理：包含列1-2个的，直接IX_表名，超过3个列的，取每列前3个字符，整个索引名长度不超过64个字符，超过截取前64个字符
 
 
 **5.存储过程：见D:\git-20191022\buildTool\sqlserver\convert.sql**
 **6.测试：**
 
    --1.创建测试新表：
        CREATE TABLE tbtest(
        id INT IDENTITY(1,1) NOT NULL ,
        name NVARCHAR(50) NOT NULL,
        phone VARCHAR(11) NOT NULL,
        age int default 99 ,
        birthday datetime default getdate(),
        addresss text,
        monyes money default 123456789012345.1234,
        smonyes smallmoney,
        nums int default 2,
        moneys money,
        smo smallmoney,
        curversion timestamp
        )
         
        ALTER TABLE tbtest ADD CONSTRAINT PK_tbtest PRIMARY KEY (ID,phone);
        CREATE INDEX IX_NAME ON tbtest(NAME);
        CREATE INDEX IX_phone_age ON tbtest(phone,age);
        CREATE INDEX IX_nums ON tbtest(nums) WHERE nums>2;
        CREATE INDEX IX_birthday ON tbtest(birthday) include (name,phone);
    2.执行：exec p_tb_mssqltomysql 'tbtest' -- tbtest为表名

 
 
 
 
