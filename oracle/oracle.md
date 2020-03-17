
**1.Oracle数据库用SQL语句查询方法如下：**

    Select object_name From user_objects Where object_type='TRIGGER';  --所有触发器
    Select object_name From user_objects Where object_type='PROCEDURE';  --所有存储过程
    Select object_name From user_objects Where object_type='VIEW';  --所有视图
    Select object_name From user_objects Where object_type='TABLE'; --所有表
