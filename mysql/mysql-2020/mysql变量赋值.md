

**1.mysql变量赋值的三种方法**
    
    mysql中变量不用事前申明，在用的时候直接用“@变量名”使用就可以了。
    第一种用法：set @num=1; 或set @num:=1; //这里要使用变量来保存数据，直接使用@num变量
    第二种用法：select @num:=1; 或 select @num:=字段名 from 表名 where ……
        注意上面两种赋值符号，使用set时可以用“=”或“：=”，但是使用select时必须用“：=赋值”
    第三种用法：select 字段名1,字段名2 into @变量1,@变量2 from 表名 where ......
        在函数或存储过程或触发器中，在不能使用set的时候推荐第三种，因为第二种会在执行时返回查询结果，
        这在函数或触发器中会报 “Not allowed to return a result set from a function”错误。而第三种则不会报错。

**2.MySQL标准变量、临时变量、系统变量：**

    1.标准变量:
        DECLARE end_flag INT DEFAULT 0;
    2.临时变量:
        见上
    3.系统变量:
        全局变量@@
        系统变量，只能读取，不能修改，如@@error
