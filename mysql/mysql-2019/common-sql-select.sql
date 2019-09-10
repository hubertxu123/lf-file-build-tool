
-- 下划线 _ 匹配单个任意字符
select *from test where name  like '_f';
-- % 匹配多个任意字符
select *from test where name  like '%f';
-- 空值查询
select *from test where name  is null;
-- 非空值查询
select *from test where name  is not null;

-- 分组查询，分组结果排序，分组求和
select SUM(id),name,COUNT(0),GROUP_CONCAT(CONCAT(id,'-',name) order
by id desc separator '~') from test
where 1=1 GROUP BY name HAVING COUNT(0)>=1 ;

-- 求和，计数，平均值，最大，最小
select sum(id),COUNT(1),AVG( id),MAX(id),MIN(id) from test;

-- 嵌套子查询：查询test中的id 大于 testall表中的id的任意一条记录的 所有值
select * from test where id > any (select id from testall);
-- 嵌套子查询：查询test中的id 大于 testall表中所有id的 所有值
select * from test where id > all (select id from testall);
-- 嵌套子查询：当exists后面的语句满足时才查询前面的语句 必须加括号
select * from test where 1=1 and exists (select id from testall);
-- 嵌套子查询：当exists后面的语句满足时才查询前面的语句
select * from test where 1=1 and not exists (select id from testall);


-- 合并结果集 union 和 union all 两个表对应的列数和数据结构必须相同
-- union all会保留重复行数据，应尽量使用union all 占用资源较少
select id from test
union all
select cwss_id from testall;
-- 合并结果集 union 会去重
select id from test
union
select cwss_id from testall;

