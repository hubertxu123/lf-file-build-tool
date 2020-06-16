
**1.MySQL分隔符（DELIMITER）：**
    
    DELIMITER $
    ... --触发器创建语句；
    $   --提交创建语句；
    DELIMITER ;

**2.变量赋值：**
    
    -- 变量直接赋值
    set @num=999;
    -- 使用select语句查询出来的数据方式赋值，需要加括号：
    set @name =(select name from table);

**3.条件判断：**
    
    -- 简单的if语句：
    set sex = if (new.sex=1, '男', '女');
    -- 多条件if语句：
    if old.type=1 then
        update table ...;
    elseif old.type=2 then
        update table ...;
    end if;

**4.查看触发器：**
    
    -- 通过information_schema.triggers表查看触发器：
    select * from information_schema.triggers;
     
    -- mysql 查看当前数据库的触发器
    show triggers;
     
    -- mysql 查看指定数据库"aiezu"的触发器
    show triggers from aiezu;
    
**5.删除触发器：**
    
    1，可以使用drop trigger删除触发器：
    drop trigger trigger_name;
     
    2，删除前先判断预设是否存在：
    drop trigger if exists trigger_name
   
**6.实例1：**
    
    -- 创建测试表
    drop table if exists tmp1;
    create table tmp1 (n1 int, n2 int);
     
    -- 创建触发器
    DELIMITER $
    drop trigger if exists tmp1_insert$
    create trigger tmp1_insert
    before insert on tmp1
    for each row
    begin
        set new.n2 = new.n1*5;
    end$
    DELIMITER ;
    
**7.实例2：**

    -- 创建测试表和插入测试数据
    drop table if exists tmp1;
    drop table if exists tmp2;
    create table tmp1 (id int, name varchar(128)) default charset='utf8';
    create table tmp2 (fid int, name varchar(128)) default charset='utf8';
    insert into tmp1 values(1, '爱E族');
    insert into tmp2 values(1, '爱E族');
     
    -- 创建触发器
    DELIMITER $
    drop trigger if exists tmp1_update$
    create trigger tmp1_update
    after update on tmp1
    for each row
    begin
        update tmp2 set name=new.name where fid=new.id;
    end$
    DELIMITER ; 

**3.实例3：**
    
    DELIMITER $
    CREATE TRIGGER user_log AFTER INSERT ON users FOR EACH ROW
    BEGIN
    DECLARE s1 VARCHAR(40)character set utf8;
    DECLARE s2 VARCHAR(20) character set utf8;#后面发现中文字符编码出现乱码，这里设置字符集
    SET s2 = " is created";
    SET s1 = CONCAT(NEW.name,s2);     #函数CONCAT可以将字符串连接
    INSERT INTO logs(log) values(s1);
    END $
    DELIMITER ;

**4.调试：**
    
    第一步，创建一张临时表 t (x,cc)
    
    第二步，set global?general_log=on；（立即生效，无需重启mysql）
    
    ----打开后 general_log后 mysql 会把触发器运行的每一步sql 语句写到 日志文件中?general_log_file?
    
    就可以根据日志输出结果来判断trigger 是哪一步异常没有执行下去；
    
    ####待调试的触发器如下
    
    CREATE DEFINER=`root`@`%` TRIGGER `t_afterinsert_to_summary` AFTER INSERT ON `a` FOR EACH ROW ?
    begin
    declare v1 VARCHAR( 20 );
    declare v2 VARCHAR( 20 );
    declare done int default 0;?
    DECLARE?? ?mob VARCHAR ( 20 );
    DECLARE?? ?content VARCHAR ( 500 );
    DECLARE?? ?node_ip VARCHAR ( 20 );
    DECLARE mobile_list CURSOR FOR ?SELECT mobile FROM?? ?c ?WHERE?? ?c.c = ?new.c1;
    declare continue handler for not FOUND set done = 1; /*done = true;亦可*/
    
    
    insert into t (x,cc) ?? ?VALUES(?? ?new.c1,?? ?'topfirest0');-------人为插入作业点
    IF ( new.c1 = 0 ) THEN
    ? insert into t (x,cc) ?? ?VALUES(?? ?new.c1,?? ?'firest1');-------人为插入作业点
    ? select b into v1 from b where b.a=new.c1;
    ?? ?set v2=new.c1;
    ?? ?insert into t (x,cc) ?? ?VALUES(?? ?new.c1,?? ?'firest2');-------人为插入作业点
    ?? ?SET content = CONCAT( 'abcabcabc', '[', v2, ']', 'dede', v2,'ccddddd' );
    ?? ?insert into t (x,cc) ?? ?VALUES(?? ?new.c1,?? ?'firest3');-------人为插入作业点
    
    ?? ?insert into t (x,cc) ?? ?VALUES(?? ?new.c1,?? ?'firest4');-------人为插入作业点
    ?? ?
    ?? ?OPEN mobile_list;-- 将游标中的值赋值给变量，要注意sql结果列的顺序
    ?? ?REPEAT
    ?? ??? ?FETCH mobile_list INTO mob;-- while循环
    ?? ??? ? ?if not done then
    ?? ??? ??? ??? ??? ?insert into t (x,cc) ?? ?VALUES(?? ?new.c1,?? ?'firest5');-------人为插入作业点
    ?? ??? ??? ??? ??? ?INSERT INTO t (x,cc) ?? ?VALUES(?? ?v2,?? ?content);
    ?? ??? ? ?end if;
    ?? ??? ?-- 关闭游标
    ?? ??? ?until done end repeat;
    ?? ?CLOSE mobile_list;
    END IF;
    end;
