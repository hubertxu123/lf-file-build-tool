
-- 查看数据库
show databases;
show databases like 'test';

-- 创建数据库
create DATABASE testdb;
show create DATABASE testdb;

-- 删除数据库
drop DATABASE tttest;

-- mysql存储引擎列表
show engines;
-- 查看mysql当前默认的存储引擎:
show variables like '%storage_engine%';
-- 查看某个库下指定表使用的存储引擎
show table status from ttest where name='tb_emp2';

-- 选择操作数据库
use testdb;
-- 查看数据表
show TABLES;
-- 数据表创建
create table temp1(
  id int(11),
  name VARCHAR(25),
  deptId int (11),
  salary FLOAT
);
-- 数据表创建 主键约束 -1
create table temp2(
  id int(11) PRIMARY KEY,
  name VARCHAR(25),
  deptId int (11),
  salary FLOAT
);
-- 数据表创建 主键约束 -2
create table temp3(
  id int(11),
  name VARCHAR(25),
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id)
);
-- 数据表创建 主键约束 -3 联合主键约束
create table temp4(
  id int(11),
  name VARCHAR(25),
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id,name)
);
-- 数据表创建 外键约束 	CONSTRAINT <外键名称> FOREIGN KEY(deptId) REFERENCES temp5(id) id 和 deptId的数据类型必须一致
create table temp5(
  id int(11),
  name VARCHAR(25),
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id)
);
create table temp5_foreignkey(
  id int(11),
  name VARCHAR(25),
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id),
  CONSTRAINT fk_forign_temp FOREIGN KEY(deptId) REFERENCES temp5(id)
);
-- 数据表创建 非空约束
create table temp6(
  id int(11),
  name VARCHAR(25) not null,
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id)
);
-- 数据表创建 唯一约束 可为null但是能有一个 -1
create table temp7(
  id int(11),
  name VARCHAR(25) UNIQUE,
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id)
);
-- 数据表创建 唯一约束 可为null但是能有一个 -2 	CONSTRAINT <唯一约束名称> UNIQUE(name)
create table temp8(
  id int(11),
  name VARCHAR(25) ,
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id),
  CONSTRAINT sth UNIQUE(name)
);
-- 数据表创建 默认约束 指定默认值
create table temp9(
  id int(11),
  name VARCHAR(25) DEFAULT '0000',
  deptId int (11),
  salary FLOAT,
  PRIMARY KEY(id),
  CONSTRAINT sth UNIQUE(name)
);
-- 数据表创建 主键自增 一个表中只能有一个自增约束，并且必须是主键的一部分
create table temp10(
  id int(11) PRIMARY key AUTO_INCREMENT,
  name VARCHAR(25) DEFAULT '0000',
  deptId int (11),
  salary FLOAT
);
-- 数据表修改 修改表名
show tables;
select t.table_name from information_schema.TABLES t where t.TABLE_SCHEMA ="testdb" and t.TABLE_NAME ="temp11";
ALTER TABLE temp10 RENAME temp11;
-- 数据表修改 修改字段数据类型
desc temp11;
ALTER TABLE temp11 MODIFY name VARCHAR(30);
-- 数据表修改 修改字段名称 及数据类型 -不同的数据类型的存储方式及长度有所不同，所以修改数据类型可能会导致数据丢失，所以在有数据时，慎改
desc temp11;
ALTER TABLE temp11 change `name` sname VARCHAR(30);
-- 数据表修改 添加字段 :开始最后指定字段
desc temp11;
ALTER TABLE temp11 add  add_sname_last VARCHAR(30) ;
ALTER TABLE temp11 add  add_sname_first VARCHAR(30) FIRST ;
ALTER TABLE temp11 add  add_sname_my VARCHAR(30) AFTER id ;
ALTER TABLE temp11 add  add_sname_my_not VARCHAR(30) not null AFTER id ;
ALTER TABLE temp11 add  add_sname_my_not_default VARCHAR(30) not null DEFAULT 'haha' AFTER id ;
-- 数据表修改 删除字段
desc temp11;
ALTER TABLE temp11 drop  add_sname_last ;
-- 数据表修改 修改位置
desc temp11;
ALTER TABLE temp11 MODIFY  id int(11) FIRST;-- id修改为第一个字段
ALTER TABLE temp11 MODIFY  id int(11) AFTER add_sname_first;-- id放在add_sname_first之后
-- 数据表修改 修改存储引擎
show table status from testdb where name='temp11';
ALTER TABLE temp11 engine=MyISAM;
ALTER TABLE temp11 engine=InnoDB;

-- 查看数据表结构
show create TABLE temp4;
DESCRIBE temp4;
desc temp4;
-- 组装json
SELECT
       CONCAT('{',GROUP_CONCAT(CONCAT('"',COLUMN_NAME,'":0') SEPARATOR ","),'}'),
       COUNT(0) FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'ziniu' AND TABLE_NAME = 't_s_post_want_zn';
-- 组装sql insert
SELECT
       CONCAT('insert into ',TABLE_NAME,'(',GROUP_CONCAT(COLUMN_NAME SEPARATOR ","),') values (',GROUP_CONCAT('?' SEPARATOR ","),')') as `sql`,
    COUNT(0) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = 'testdb' AND TABLE_NAME = 'temp4';
-- 组装sql update
SELECT
       CONCAT('update ',TABLE_NAME,' set ',GROUP_CONCAT(CONCAT(COLUMN_NAME,'=?') SEPARATOR ",")) as `sql`,
    COUNT(0) FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = 'testdb' AND TABLE_NAME = 'temp4';
-- 删除数据表
drop TABLE if EXISTS temp1;

-- 当结果提示警告时，可以使用以下语句查看警告
show warnings ;

-- 运算符
-- 算术
select 1/0;   -- NULL
select 93/3;  -- 整除31
select 1/3;   -- 0.3333保留4位小数，四舍五入
-- 比较
-- 等于
select 1=0,1='1',null=null; -- 0 1 NULL
-- 安全等于
select 1<=>0,1<=>'1',null<=>null;  -- 0 1 1
select 1<=>0,1<=>'1',null<=>1; -- 0 1 0
-- 不等于
select 1!=0,null!=null;

