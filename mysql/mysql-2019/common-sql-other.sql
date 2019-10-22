
================================================================
内连接修改：
	--update t_s_school s  inner join t_d_area_cmcc  d on s.C_CITYID=d.country_code set
    --s.C_CITYNAME=d.region_name ;
================================================================
连表删除：
	--delete s from gsallschoolcode s where s.school_id not in (
    --select SUBSTR(d.c_schoolid,9,20) from temp_school_id d
        --);
================================================================
拿到此行数据连接显示：（concat（））
	--select CONCAT(xk_name,c_type) from t_t_d_contrast;	--
================================================================
select GROUP_CONCAT(xk_name) from t_t_d_contrast GROUP BY c_type; -- 默认逗号分割
select GROUP_CONCAT(xk_name separator '|') from t_t_d_contrast GROUP BY c_type;
select id,group_concat(distinct name) from aa group by id;
select id,group_concat(name order by name desc) from aa group by id;
select GROUP_CONCAT(xk_name) from t_t_d_contrast;	-- 拿到此列所有数据并用逗号分隔
================================================================
substring：
	--1、从左开始截取字符串
		left（str, length）
		说明：left（被截取字段，截取长度）
		例：select left（content,200） as abstract from my_content_t
    --2、从右开始截取字符串
    right（str, length）
    说明：right（被截取字段，截取长度）
    例：select right（content,200） as abstract from my_content_t
    --3、截取字符串
    substring（str, pos）
    substring（str, pos, length）
    说明：substring（被截取字段，从第几位开始截取）
    substring（被截取字段，从第几位开始截取，截取长度）
    例：select substring（content,5） as abstract from my_content_t
select substring（content,5,200） as abstract from my_content_t
    注：如果位数是负数 如-5 则是从后倒数位数，到字符串结束或截取的长度）
    --4、按关键字截取字符串
    substring_index（str,delim,count）
    说明：substring_index（被截取字段，关键字，关键字出现的次数）
    例：select substring_index（"blog.jb51.net"，"。"，2） as abstract from my_content_t
    结果：blog.jb51
    ================================================================

-- 退订，订购
    ====================================================================================
    ====================================================================================;
select DISTINCT SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'studentId') + 12,10)as studentId ,SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'familyPhone') + 14,11) as parentPhone
from t_l_api_log where L_REQ_URI like '%订购%退订%' and L_EXEC_RESULT=0 and L_RES_RESULT='该用户不存在';
-- 老师删除
====================================================================================
====================================================================================;
select  SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'{') + 1,8) as teacherId from t_l_api_log where L_REQ_URI like '%老师%删除%'; and L_EXEC_RESULT=0 and L_RES_RESULT='该用户不存在') ;
select DISTINCT SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'{') + 1,8) as teacherId from t_l_api_log where L_REQ_URI like '%老师%删除%'and L_EXEC_RESULT=0 and L_RES_RESULT='老师删除失败，老师信息不存在，请检验ID'
                                                                                                            and L_CREATE_TIME>'2017-05-22';;
;
-- 学生删除
====================================================================================
====================================================================================;
select DISTINCT SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'"studentId') + 13,10) as studentid from t_l_api_log where L_REQ_URI like '%学生%删除%'
                                                                                                                       and L_EXEC_RESULT=0 and L_RES_RESULT like '此學生不存在%'and L_CREATE_TIME>'2017-05-22';;

-- 修改老师信息
====================================================================================
====================================================================================;
select  * from t_l_api_log where L_REQ_URI like '%change%Te%'and L_EXEC_RESULT=0 and L_RES_RESULT like '该老师不存在，请走新建接口';
select  DISTINCT SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'"teacherId') + 13,8)from t_l_api_log where L_REQ_URI like '%change%Te%'and L_EXEC_RESULT=0 and L_RES_RESULT like '该老师不存在，请走新建接口';

-- 修改学生信息
====================================================================================
====================================================================================;
select  * from t_l_api_log where L_REQ_URI like '%change%Stu%'and L_EXEC_RESULT=0 and L_RES_RESULT like '該學生不存在，無對應學酷id%';
select DISTINCT SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'"studentId') + 12,10) as studentId from t_l_api_log
where L_REQ_URI like '%change%Stu%'and L_EXEC_RESULT=0 and L_RES_RESULT like '該學生不存在，無對應學酷id%'and L_CREATE_TIME>'2017-05-22';;


-- 修改家长信息
====================================================================================
====================================================================================;
select  DISTINCT SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'familyPhone') + 14,11) as familyPhone from t_l_api_log where L_REQ_URI like '%changeFamilyInfo%'and L_EXEC_RESULT=0 and
        L_RES_RESULT like '该家長不存在，请走新建接口%' and L_CREATE_TIME>'2017-05-22';;

-- 修改密码
====================================================================================
====================================================================================;
select  DISTINCT SUBSTRING(L_PARAM_CONTENT,INSTR(L_PARAM_CONTENT,'id') + 5,8) as ID from t_l_api_log where L_REQ_URI like '%updatepwd(修改密码)%'
                                                                                                       and L_EXEC_RESULT=0 and L_RES_RESULT like '用户不存在请检验ID%' and L_CREATE_TIME>'2017-05-22';
====================================================================================;


