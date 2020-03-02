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
             
**2.vm中centos和windows交互问题：**
    
    本机linux初设用户名密码：
    linux：=
    	--admin	
    	--root
    ------------------------------------------------------
    linux下鼠标不可见：
    	--重新登陆
    ------------------------------------------------------
    linux桌面切换dos终端：
    	--Ctrl+alt+F2 或者F3-5
    	--切换回桌面：Ctrl+alt+F1
    linux图形切面打开dos窗口
    	--Applications--SystemTools--Terminal
    ------------------------------------------------------
    linux从dos终端切换到桌面：
    	--Ctrl+alt+F1
    linux在dos命令中登录后如何退出：
    	--exit
    window10系统下用虚拟机创建出的linux系统进行鼠标切换时：
    	--Ctrl+alt

**3.linux设置静态ip地址：**

    ·以管理员身份运行
    	su root
    ·查看ip地址：
    	ifconfig -a  或者 ip add
    	记住ip：102.168.6.128/24
    ·设置静态地址：
    	vi /etc/sysconfig/network-scripts/ifcfg-eth0
    	新增：
    	IPADDRO=192.168.6.128
    	GATEWAYO=192.168.6.1
    	DNS1=192.168.6.1
    	PREFIXO=24
    	修改：
    	#BOOTPROTO=dhcp(dhcp为自动分配ip地址,我们把他注释了，在下面另外加)
    	BOOTPROTO=static(新添加)
    ·重启网卡： service network restart
    ·保存退出：
    	:wq
    	:q!---强制退出不保存
    ·重启：shutdown -r now
    
**重要：**

    1. 查看tomcat进程
        ps -aux | grep tomcat
        （或者ps -ef | grep tomcat都行）
        [plain] view plain copy
            root      1537  0.1  3.7 12829256 1248140 ?    Sl   Oct13   <span style="font-family: Arial, Helvetica, sans-serif;">...（这里其它内容省略）</span>  
            tomcat7  14177  1.3  0.3 3202376 124332 ?      Sl   10:02   <span style="font-family: Arial, Helvetica, sans-serif;">...（这里其它内容省略）</span>  
        可以看到现在运行着两个tomcat进程，一个进程的pid为1537，另一个pid为14177。
    2. 根据进程查看端口号
        sudo netstat -naop | grep 14177
        可以看到8055和8088端口号被占用，其中805是tomact Server的SHUTDOWN的端口号，8088是tomcat的CATALINA Service的Connector的端口号。
    3. 根据端口号查看进程
        sudo lsof -i:8088
        [plain] view plain copy


**3.其他：**

    ————————————————————————————————————————
    搜索文件夹：
    	find / -name pub 搜索遍历当前文件夹下的指定的pub文件夹
    	
    查看linux系统下的所有用户：
    	grep bash /etc/passwd 就可以得到所有的普通用户
    查看系统所有用户信息：
    	cat /etc/passwd
    删除linux用户信息：
    	userdel  xiaoluo  
    	·不能删除该用户账号所有相关信息，再次创建此用户时，会报错
    	·只是删除掉了/etc/passwd、/etc/shadow、/etc/group/、/etc/gshadow四个文件里的该账户和组的信息
    完全删除账号：
    	1.userdel -r xiaoluo
    	2.userdel xiaoluo 
    	  find / -name "*xiaoluo*"
              使用rm -rf 删除
    查看用户组：
    	1.groups yonguhming
    查看/etc/group 文件
    	1.cat /etc/group | sort			查询结果排序	
    	2.cat /etc/group | grep -E "shiyanlou"  查询结果过滤
    	root1:x:5000:
    	以上内容分别表示用户组，密码(x表示密码不可见)，GID，该用户组包含的用户
    命令重启linux：
    	shutdown -r now 立即重启 
    	reboot		立即重启
    	shutdown -h now 立即关机
    	shutdown -h 5 	5分钟后关机
    	shutdown -r 5 	5分钟后重启
    
    		            
