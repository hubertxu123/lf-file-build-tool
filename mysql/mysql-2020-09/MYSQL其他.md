
## 数据库中INFORMATION_SCHEMA的说明及使用

    第一个查询看看库里有多少个表，表名等
    select * from INFORMATION_SCHEMA.TABLES
    information_schema这张数据表保存了MySQL服务器所有数据库的信息。如数据库名，数据库的表，表栏的数据类型与访问权限等。再简单点，这台MySQL服务器上，到底有哪些数据库、
        各个数据库有哪些表，每张表的字段类型是什么，各个数据库要什么权限才能访问，等等信息都保存在information_schema表里面。
    Mysql的INFORMATION_SCHEMA数据库包含了一些表和视图，提供了访问数据库元数据的方式。
    元数据是关于数据的数据，如数据库名或表名，列的数据类型，或访问权限等。有些时候用于表述该信息的其他术语包括“数据词典”和“系统目录”。
    
    下面对一些重要的数据字典表做一些说明：
    SCHEMATA表：提供了关于数据库的信息。
    TABLES表：给出了关于数据库中的表的信息。
    COLUMNS表：给出了表中的列信息。
    STATISTICS表：给出了关于表索引的信息。
    USER_PRIVILEGES表：给出了关于全程权限的信息。该信息源自mysql.user授权表。
    SCHEMA_PRIVILEGES表：给出了关于方案（数据库）权限的信息。该信息来自mysql.db授权表。
    TABLE_PRIVILEGES表：给出了关于表权限的信息。该信息源自mysql.tables_priv授权表。
    COLUMN_PRIVILEGES表：给出了关于列权限的信息。该信息源自mysql.columns_priv授权表。
    CHARACTER_SETS表：提供了关于可用字符集的信息。
    COLLATIONS表：提供了关于各字符集的对照信息。
    COLLATION_CHARACTER_SET_APPLICABILITY表：指明了可用于校对的字符集。
    TABLE_CONSTRAINTS表：描述了存在约束的表。
    KEY_COLUMN_USAGE表：描述了具有约束的键列。
    ROUTINES表：提供了关于存储子程序（存储程序和函数）的信息。此时，ROUTINES表不包含自定义函数（UDF）。
    VIEWS表：给出了关于数据库中的视图的信息。
    TRIGGERS表：提供了关于触发程序的信息。

## 1. 获取所有列信息(COLUMNS)
   
       SELECT  *  FROM information_schema.COLUMNS WHERE  TABLE_SCHEMA='数据库名';  COLUMNS表：提供了关于表中的列的信息。详细表述了某个列属于哪个表。各字段说明如下:
        
       字段	含义
       table_schema 	表所有者（对于schema的名称）
       table_name 	表名
       column_name 	列名
       ordinal_position 	列标识号
       column_default 	列的默认值
       is_nullable 	列的为空性。如果列允许 null，那么该列返回 yes。否则，返回 no
       data_type 	系统提供的数据类型
       character_maximum_length	以字符为单位的最大长度，适于二进制数据、字符数据，或者文本和图像数据。否则，返回 null。有关更多信息，请参见数据类型
       character_octet_length 	以字节为单位的最大长度，适于二进制数据、字符数据，或者文本和图像数据。否则，返回 nu
       numeric_precision 	近似数字数据、精确数字数据、整型数据或货币数据的精度。否则，返回 null
       numeric_precision_radix 	近似数字数据、精确数字数据、整型数据或货币数据的精度基数。否则，返回 null
       numeric_scale 	近似数字数据、精确数字数据、整数数据或货币数据的小数位数。否则，返回 null
       datetime_precision 	datetime 及 sql-92 interval 数据类型的子类型代码。对于其它数据类型，返回 null
       character_set_catalog 	如果列是字符数据或 text 数据类型，那么返回 master，指明字符集所在的数据库。否则，返回 null
       character_set_schema 	如果列是字符数据或 text 数据类型，那么返回 dbo，指明字符集的所有者名称。否则，返回 null
       character_set_name 	如果该列是字符数据或 text 数据类型，那么为字符集返回唯一的名称。否则，返回 null
       collation_catalog 	如果列是字符数据或 text 数据类型，那么返回 master，指明在其中定义排序次序的数据库。否则此列为 null
       collation_schema 	返回 dbo，为字符数据或 text 数据类型指明排序次序的所有者。否则，返回 null
       collation_name 	如果列是字符数据或 text 数据类型，那么为排序次序返回唯一的名称。否则，返回 null。
       domain_catalog 	如果列是一种用户定义数据类型，那么该列是某个数据库名称，在该数据库名中创建了这种用户定义数据类型。否则，返回 null
       domain_schema 	如果列是一种用户定义数据类型，那么该列是这种用户定义数据类型的创建者。否则，返回 null
       domain_name 	如果列是一种用户定义数据类型，那么该列是这种用户定义数据类型的名称。否则，返回 NULL

## information_schema.columns字段说明，获取数据库表所有列信息
    
    MySQL版本大于5.0时，有个默认数据库information_schema，里面存放着所有数据库的信息(比如表名、 列名、对应权限等)，通过这个数据库，我们就可以跨库查询，爆表爆列。
    
     
    
    获取所有列信息(COLUMNS)
    
    SELECT  *  FROM information_schema.COLUMNS WHERE  TABLE_SCHEMA='数据库名';  COLUMNS表：提供了关于表中的列的信息。详细表述了某个列属于哪个表。各字段说明如下:
    
     
    
    若要从这些视图中检索信息，请指定完全合格的 INFORMATION_SCHEMA view_name 名称。
    
     
    
    列名	数据类型	描述
    TABLE_CATALOG	nvarchar(128)	表限定符。
    TABLE_SCHEMA	nvarchar(128)	表所有者。
    TABLE_NAME	nvarchar(128)	表名。
    COLUMN_NAME	nvarchar(128)	列名。
    ORDINAL_POSITION	smallint	列标识号。
    COLUMN_DEFAULT	nvarchar(4000)	列的默认值。
    IS_NULLABLE	varchar(3)	列的为空性。如果列允许 NULL，那么该列返回 YES。否则，返回 NO。
    DATA_TYPE	nvarchar(128)	系统提供的数据类型。
    CHARACTER_MAXIMUM_LENGTH	smallint	以字符为单位的最大长度，适于二进制数据、字符数据，或者文本和图像数据。否则，返回 NULL。有关更多信息，请参见数据类型。
    CHARACTER_OCTET_LENGTH	smallint	以字节为单位的最大长度，适于二进制数据、字符数据，或者文本和图像数据。否则，返回 NULL。
    NUMERIC_PRECISION	tinyint	近似数字数据、精确数字数据、整型数据或货币数据的精度。否则，返回 NULL。
    NUMERIC_PRECISION_RADIX	smallint	近似数字数据、精确数字数据、整型数据或货币数据的精度基数。否则，返回 NULL。
    NUMERIC_SCALE	tinyint	近似数字数据、精确数字数据、整数数据或货币数据的小数位数。否则，返回 NULL。
    DATETIME_PRECISION	smallint	datetime 及 SQL-92 interval 数据类型的子类型代码。对于其它数据类型，返回 NULL。
    CHARACTER_SET_CATALOG	varchar(6)	如果列是字符数据或 text 数据类型，那么返回 master，指明字符集所在的数据库。否则，返回 NULL。
    CHARACTER_SET_SCHEMA	varchar(3)	如果列是字符数据或 text 数据类型，那么返回 DBO，指明字符集的所有者名称。否则，返回 NULL。
    CHARACTER_SET_NAME	nvarchar(128)	如果该列是字符数据或 text 数据类型，那么为字符集返回唯一的名称。否则，返回 NULL。
    COLLATION_CATALOG	varchar(6)	如果列是字符数据或 text 数据类型，那么返回 master，指明在其中定义排序次序的数据库。否则此列为 NULL。
    COLLATION_SCHEMA	varchar(3)	返回 DBO，为字符数据或 text 数据类型指明排序次序的所有者。否则，返回 NULL。
    COLLATION_NAME	nvarchar(128)	如果列是字符数据或 text 数据类型，那么为排序次序返回唯一的名称。否则，返回 NULL。
    DOMAIN_CATALOG	nvarchar(128)	如果列是一种用户定义数据类型，那么该列是某个数据库名称，在该数据库名中创建了这种用户定义数据类型。否则，返回 NULL。
    DOMAIN_SCHEMA	nvarchar(128)	如果列是一种用户定义数据类型，那么该列是这种用户定义数据类型的创建者。否则，返回 NULL。
    DOMAIN_NAME	nvarchar(128)	
    如果列是一种用户定义数据类型，那么该列是这种用户定义数据类型的名称。否则，返回 NULL。
    
    首先介绍一下的是爆库
    select SCHEMA_NAME from information_schema.SCHEMATA  limit 5,1/* 5,1表示从第1个开始，数到第5个
    然后就是爆表了。
    select TABLE_NAME from information_schema.TABLES  where  TABLE_SCHEMA=0×6D656D626572 limit 5,1/*TABLE_SCHEMA=后面是库名的16进制
    再来爆字段
    select COLUMN_NAME  from information_schema.COLUMNS  where TABLE_NAME=0×61646D5F75736572 limit 5,1/*
    
    所有数据都是从information_schema.columns这个表里获取，因为从information_schema这个库我们可以看到，从information_schema.columns这个表里，我们可以查到所有的信息，因为它在里面，table_schema、 table_name、column_name这个三个列都有，所以我们可以直接通过这个表，查出我们需要的所有信息，就省了换表这一步了，进一步提升速度
    
    SELECT
        TABLE_SCHEMA AS '数据库',
        TABLE_NAME AS '表名',
        column_name AS '字段名称',
        COLUMN_TYPE AS '字段类型',
        IS_NULLABLE AS '是否为空',
       COLUMN_DEFAULT AS '默认值',
       column_comment AS '字段备注'
    FROM
       information_schema. COLUMNS
    WHERE
        table_name = 'yyd_elife_city'
    OR table_name = 'yyd_elife_column_list'
    OR table_name = 'yyd_elife_coupon_list'
    OR table_name = 'yyd_elife_goods_label_list'
    OR table_name = 'yyd_elife_member_extend'
    OR table_name = 'yyd_biz_content_log'
    OR table_name = 'yyd_e_refund'
    OR table_name = 'yyd_e_statistic_goods'
    OR table_name = 'yyd_e_statistic_ip'
    OR table_name = 'yyd_e_statistic_main'

## 查看建表语句
    
    desc INFORMATION_SCHEMA.COLUMNS;
    
    table_catalog	varchar(512)
    table_schema	varchar(64)
    table_name	varchar(64)
    column_name	varchar(64)
    ordinal_position	bigint(21) unsigned
    column_default	longtext
    is_nullable	varchar(3)
    data_type	varchar(64)
    character_maximum_length	bigint(21) unsigned
    character_octet_length	bigint(21) unsigned
    numeric_precision	bigint(21) unsigned
    numeric_scale	bigint(21) unsigned
    datetime_precision	bigint(21) unsigned
    character_set_name	varchar(32)
    collation_name	varchar(32)
    column_type	longtext
    column_key	varchar(3)
    extra	varchar(30)
    privileges	varchar(80)
    column_comment	varchar(1024)
    generation_expression	longtext
