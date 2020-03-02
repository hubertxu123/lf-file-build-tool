

#linux的连接通道SSH端口号增加和修改：
    
    ·查看当前linux是否已经安装SSH软件包 rpm -qa|grep ssh
    ·修改端口号：vi /etc/ssh/sshd_config 
        将光标定位到port  22这行复制一行insert插入编辑22端口为21578
    ·:wq---保存退出
    ·重启ssh服务：/etc/init.d/sshd restart
