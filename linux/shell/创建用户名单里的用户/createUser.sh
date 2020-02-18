#!/bin/bash       #规定运行环境

##########################
#测试文件准备：userFile：
#  testUser1
#  testUser2
#  testUser3
#测试：
# ./createUser.sh userFile
#检验：
# id testUser1
#   uid=0(testUser1) gid=0(testUser1) groups=0(testUser1)
##########################



[ -z "$1" ] && {           # 判断是否有用户名单文件
        echo Error :please input the userfile following script !!
        exit         #未输入用户文件报错提示并退出脚本
}
[ -e "$1" ] || {            #判断提供的用户名单是否存在
        echo Error : $1 is not exist !!
        exit         #不存在报错提示并退出
}

USER_NUB=$(sed '/^$/d' $1 |wc -l)     #定义变量  表示名单中用户的个数
for number in $(seq 1 $USER_NUB)   # 循环条件 从1 到 用户个数
do            #执行的动作
        USERNAME=$(sed '/^$/d' $1 |sed -n  ${number}p )    #定义变量 表示名单中的用户名称，^头 $尾 d行，从头到尾所有行，p打印，-n仅显示
        id $USERNAME  &>/dev/null && {      #判断用户是否存在
                echo $USERNAME is exist !!         #如果用户存在输出用户存在
                }||{
                useradd $USERNAME            #用户不存在创建用户 提示用户创建成功
                echo $USERNAME created successfully
                }
done
