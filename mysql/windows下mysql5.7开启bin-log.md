
* [介绍](#介绍)
  * [1\.查看是否开启了binlog](#1查看是否开启了binlog)
  * [2\.开启binlog：](#2开启binlog)
  * [3\.重启MySQL服务](#3重启mysql服务)
  * [4\.验证binlog是否开启](#4验证binlog是否开启)
  * [5\.binlog文件的位置](#5binlog文件的位置)
  * [6\.清除日志](#6清除日志)
  * [7\.索性MySQL自带查看工具](#7索性mysql自带查看工具)
  * [8\.日志导出sql](#8日志导出sql)
  * [9\.恢复数据](#9恢复数据)


# 介绍

    mysql有以下几种日志
    1、错误日志：-log-err
    2、查询日志：-log
    3、慢查询日志：-log-slow-queries 记录超时查询
    3、更新日志：-log-update
    4、二进制日志：-log-bin 用于数据库的基于时间点还原。
    
## 1.查看是否开启了binlog

    show variables like ‘%log_bin%’;
    mysql安装好后默认是没有开启binlog日志功能的，需要手动开启并重启mysql服务才能生效
    
## 2.开启binlog：

     修改mysql的配置文件my.ini。添加如下配置：
         [mysqld]
         server-id = 1 #【必须要有，否则会报错-MySQL 服务无法启动。】
         log-bin=mysql-bin	#指定文件名和路径，这里是默认路径
         binlog-format=Row   #文件类型
         
     或者
        [mysqld]
        # binlog 配置
        log-bin = /usr/local/var/mysql/logs/mysql-bin.log
        expire-logs-days = 14
        max-binlog-size = 500M
        server-id = 1 #【必须要有，否则会报错-MySQL 服务无法启动。】

## 3.重启MySQL服务

     关闭MySQL指令:net stop MySQL
     开启MySQL指令：net start MySQL
     如果提示服务名无效可能是在装MySQL时无意中更改了MySQL的名称，可以再服务中找到MySQL的名称
     
## 4.验证binlog是否开启

     mysql> show variables like '%log_bin%'; 和 show binary logs;

## 5.binlog文件的位置

    如果在修改my.ini的binlog时给的是全路径，那么生成的日志文件就在指定的目录下；如果如步骤2中只给一个名字，
    那么生成的binlog日志的位置为：C:\ProgramData\MySQL\MySQL Server 5.7\Data

## 6.清除日志
     
     RESET MASTER：登录mysql, 打入命令（把之前生成的bin-log日志文件全部重置，释放控件）。
     
         Mysql数据库由于业务原因，数据量增长迅速，general日志、binlog日志也增加较多，占用大部分磁盘空间。
         出于节约空间考虑，可进行删除多余binary日志，并设置定期删除操作。
         相关参数：“expire_logs_days”、“general_log”
         binary日志（此变量值为可动态修改）
         查看当前binary日志失效、自动删除的状态：
     
     show global variables like ‘%expire_logs_days%’; 或 select @@global.expire_logs_days;
         expire_logs_days此参数为整数型，默认为0（永久不删除），且最小值为0，最大值为99。
         expire_logs_days的值可以通过配置文件修改（重启生效）
         也可以用set @@global.expire_logs_days=7;指令更改（即时生效，重启失效）
     
     先写这写以后遇到了新的内容在添加

## 7.索性MySQL自带查看工具
     
     
     一、查看最早binlog的日志：
     show binlog events;
     二、查看指定的binlog日志：
     show binlog events in 'binlog.000047';
     三、指定查看 binlog.000047 这个文件，从pos点:20开始查起：        
     show binlog events in 'binlog.000047' from 20;      
     四、指定查看 binlog.000047 这个文件，从pos点:20开始查起，查询10条        
     show binlog events in 'binlog.000047' from 20 limit 10;      
     五、指定查看 binlog.000047 这个文件，从pos点:20开始查起，偏移5行，查询10条        
     show binlog events in 'binlog.000047' from 20 limit 5,10;

    在sql后面加上“\G”，不会显示详情，便于查找操作的节点，每一小块都是一个操作，server_id 记录是在哪台机器上操作的，
    event_type 记录操作类型，

## 8.日志导出sql

     到日志所在的位置，执行以下命令，成功导出到d盘
     mysqlbinlog --nodefaults binlog.000048 > d:/my.sql 

## 9.恢复数据

     新开一个cmd窗口，然后执行以下命令
     mysql -uroot -p -v plist < my.sql // plist是数据库名，需要和脚本中操作的数据库名一致
     至此，成功恢复数据。

## 10.MySQL的log_bin和sql_log_bin 到底有什么区别？
    
    log_bin:二进制日志。
        1：数据恢复 
            如果你的数据库出问题了，而你之前有过备份，那么可以看日志文件，找出是哪个命令导致你的数据库出问题了，想办法挽回损失。 而且，你也可以利用二进制日志来还原你误操作的数据库。
        2：主从服务器之间同步数据 
            主服务器上所有的操作都在记录日志中，从服务器可以根据该日志来进行，以确保两个同步。因此，我们经常做的mysql-salva也是利用master的二进制日志来和master数据一致的。
    sql_log_bin 是一个动态变量，修改该变量时，可以只对当前会话生效（Session），也可以是全局的（Global），当全局修改这个变量时，只会对新的会话生效 （这意味当对当前会话也不会生效），
        因此一般全局修改了这个变量后，都要把原来的所有连接 kill 掉。
        用处：
        当还原数据库的时候，如果不关闭二进制日志，那么你还原的过程仍然会记录在二进制日志里面，不仅浪费资源，那么增加了磁盘的容量，
        还没有必要（特别是利用二进制还原数据库的时候）所以一般还原的时候会选择关闭二进制日志，可以通过修改配置文件，重启关闭二进制日志。也可以动态命令关闭sql_log_bin,然后导入数据库。
    
## 11.如何设置MySQL数据库备份的binlog_format【阿里云】

    阿里云推荐-->ROW
    数据库备份DBS提供数据全量备份、增量备份和数据恢复。用户首先要创建备份计划（DBS实例），随后配置备份计划，为了备份正常运行，DBS备份对数据库配置和账号有一定要求。
    使用说明
    binlog_format需要设置为row，而row模式binlog会包含DML完整的前镜像和后镜像数据，便于数据恢复。
    binlog_format不推荐设置为statement、mixed模式，相比row模式，没有更好收益。
    将binlog_format设置为row，只会改变binlog日志内容，不会影响数据库查询，但建议kill数据库当前所有连接，以保证row模式在所有数据库连接上生效。
