**1.常用命令：**

     1.linux内核常用：ubuntu，centos
            --1.www.ubuntu.com/download/server  -->长使用不带界面版本的，生产环境必须使用以LTS结尾的
     2.linux系统运算速度快，常被用于服务器
     3.linux命令：
         --1.关机命令：
             1、halt   立刻关机 
             2、poweroff  立刻关机 
             3、shutdown -h now 立刻关机(root用户使用) 
             4、shutdown -h 10 10分钟后自动关机 
         --2.重启命令：
             1、reboot 
             2、shutdown -r now 立刻重启(root用户使用) 
             3、shutdown -r 10 过10分钟自动重启(root用户使用)  
             4、shutdown -r 20:35 在时间为20:35时候重启(root用户使用) 
                如果是通过shutdown命令设置重启的话，可以用shutdown -c命令取消重启
         --3.查看目录文件命令：
             1.ls
             2.ll
             3.ls -a --显示隐藏文件
         --4.创建目录：
             1.mkdir 
             2.mkdir -p 递归创建目录
         --5.创建文件;
             1.touch a.txt
         --6.将打印内容写入文件
             1.echo "hello" > test.txt
             2.echo "hello" >> test.txt      --在原文件上追加文本hello（会换行）
         --7.查看文件：
             1.cat test.txt  --全部
             2.more test.txt --分页显示文件
             3.head test,txt --显示文件开头
             4.tail test.txt --显示文件结尾
             5.tail -f       --显示实时日志
             6.stat test.txt --显示文件详细信息：大小，类型等
         --8.复制，移动(也可重命名)，删除
             1.cp
             2.mv
             3.rm 
         --9.查找文件：
             1.find -m "*test"   --查看当前文件夹下以test结尾的文件
         --10.查找某文件中某内容：
             1.cat test.txt | grep linux     --在test.txt文件中查找含linux的字符串
         --11.显示当前路径
             1.pwd
         --12.显示主机名称：
             1.hostname
         --13.显示当前登录用户
             1.who
         --14.显示系统信息
             1.uname
         --15.显示当前系统中耗费资源最多的进程--等同于windows的任务管理器
             1.top
         --16.显示瞬间进程状态：
             1.ps  
         --17.显示指定文件或所在目录已经使用的磁盘空间的总量
             1.du -h
         --18.显示文件系统磁盘的空间使用情况
             1.df -h
         --19.显示当前内存和交换空间的使用情况：
             1.free -h
         --20.显示网络接口信息;
             1.ifconfig
         --21.显示网络状态信息
             1.netstat
         --22.测试网络畅通性
             1.ping 网址
         --23.清屏
             1.clear
         --24.杀死进程：
             1.kill  -9 pid
         --25.文件夹压缩:
             1.tar -zcvf yasuo.tar.gz download/  将download文件夹压缩为yasuo.tar.gz包
         --26.文件解压：
             1..tar -zxvf yasuo.tar.gz
         --27.文件编辑：vim file
             1.:q            直接退出
             2.:q!           强制退出
             3.:wq           保存后退出
             4.:set number   在编辑文件显示行号
             5.:set nonumber 在编辑文件不显示行号
             6.:w file       将当前内容保存成某个文件
         --28.修改数据源：--
         --29.安装软件：
             1.yum install tree -y   --安装：-y表示yes
             2.tree                  --显示当前结构目录树
         --30.软链接：类似于快捷方式
             1.ln /test/t.txt mm.txt --当前目录下mm.txt文件是/test/t.txt文件的软链接，修改软链接内容，原t.txt文件也会被修改
         --31.卸载软件：
             1.yum erase nginx -y 
         --32.linux用户及用户组管理：linux支持多用户登录使用资源
             1.passwd root           --给root用户设置密码包含修密码
             2.exit(或者ctrl+d)      --推出root用户登录
             3.cat /etc/passwd       --查看系统用户信息；每行代表一个账号
             4.userdel -r 用户名      --删除用户
             5.id 用户名              --查看用户信息
         --33.更改权限操作：
             1.rwx：分别代表读，写，可执行权限
             2.测试：
                 vi test.sh 添加
                     #!/bin/bash        --选择执行器
                     echo "hello"    --打印hello
                 :wq
                 chmod +x test.sh    --给此文件添加x权限--可执行
                 ./test.sh           --执行文件
             3.chown -R root:root jdk1.8/    --将jdk1.8这个文件夹的用户归属改为root用户组下的root用户
             
        
    
            
