
###参考：https://www.w3cschool.cn/sqlserver/

**1.sqlserver简介：**
    
    SQL Server是由Microsoft开发和推广的关系数据库管理系统(DBMS)；
    SQL Server使用方便，伸缩性好与相关软件集成程度高；
    SQL Server 数据库引擎为关系型数据和结构化数据提供了更安全可靠的存储功能

**2.sqlserver服务作用简介：**

    1.SQL Server(MSSQLSERVER)是必须要开启的，这个是数据库引擎服务，它就像汽车的发动机一样，缺它不可
    2.SQL Server代理(MSSQLSERVER)是代理服务，比如你有一些自动运行的，定时作业，或者是一些维护计划，比如定时备份数据库等操作，那么就要打开，否则，就不会备份数据库了
    3.SQL Server Analysis Services (MSSQLSERVER)是分析服务，一般不用开启，除非你做多位分析，和数据挖掘，才需要开启
    4.SQL Full-text Filter Daemon Launcher (MSSQLSERVER)是全文检索服务，如果你没有使用全文检索技术，那么也不需要开启
    5.SQL Server VSS Writer MicrosoftSQLServer的SQL编写器服务，允许备份和还原应用程序以便在VolumeShadowCopyService(VSS)框架中进行操作
    6.Sql Browser 服务 一般你要进行远程访问，不需要开启sql browser开启sql browser，通过：服务器ip,端口 这种方式就可以访问远程的服务器

**3.Sql Server数据库用SQL语句查询方法如下：**
    
    select name from sysobjects where xtype='TR' --所有触发器
    select name from sysobjects where xtype='P' --所有存储过程
    select name from sysobjects where xtype='V' --所有视图
    select name from sysobjects where xtype='U' --所有表
    
    select * into 【tablename】 from 【viewName】;--将视图作为表创建
    sp_help  v_BOM_01;--查询建表数据
    sp_columns   v_BOM_01;--查询建表字段信息
    select * from information_schema.columns where table_name='v_BOM_01';--查询建表字段信息

**4.**
