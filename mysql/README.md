# dubbo
dubbo官网--
#在线文档：https://www.gitbook.com/
#代码相关：https://github.com/topsale/code-java-cloud-dubbo

**1.微服务：**
    
    1.简介：
        单体应用-->拆分为多个服务(微服务-即解耦过程)
        每一个服务都有自己的数据库--分库（会出现数据冗余，此时就不遵守数据库的三大范式了）
    2.优点：
        --1.解决复杂问题，解耦单体服务，模块化，提高开发效率，服务与服务之间的相互调用方式：rpc-远程调用|消息驱动api
        --2.每个服务均可以被独立开发，易维护，利于协同开发
        --3.可实现每个微服务独立部署-持续集成部署成为可能
        --4.每个服务都可以进行独立拓展：针对不同的需求部署不同的服务：
            --1.要求计算能力的--可部署在cpu处理能力强的服务器
            --2.要是数据存储的--可部署在内存强大的服务器
            --3.可根据实际情况购置相匹配的云服务器：路由网关，应用，数据库服务器...
    3.缺点：
        --1.分布式系统服务之间调用麻烦
        --2.分布式事物问题：每个服务对应一个数据库
            -->导致分布式事务处理问题
            -->尽力保证数据一致性即可
            -->后果：会造成脏数据，冗余数据较多，此种忽略不计，保证数据一致即可
        --3.测试问题：
            -->一个普通的测试需要启动该服务及其所有依赖的服务
        --4.服务依赖问题：
            -->A依赖B，B依赖C，C依赖D
            -->若改变D，则需要一次更新DCBA
        --5.部署问题：每个文件都会有自己不同的配置，要成功部署，则需要高度掌控部署方式和高度自动化
            -->一种自动化方式是使用线程的平台即服务：PaaS 如 Cloud Founday --使用阿里云的产品服务--价格昂贵成本高
            -->或自己开发PaaS：普遍使用集群方案+kubernetes+docker容器相结合--主流方案
**2.linux：**
    
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
            
    3.VM上安装centos:
        1.创建虚拟机：
            文件--新建虚拟机--自定义--下一步--稍后安装操作系统--linux & centos64
            --虚拟机名称 & 安装位置 -- 处理器数量1 &内核数量2 --虚拟机内存1G 
            --使用网络地址转换(NET)(E) --I/O控制器类型：推荐 
            --虚拟磁盘类型：推荐 --创建新的虚拟磁盘 --指定磁盘容量：默认下一步--指定磁盘文件存储位置
            --创建虚拟机完成    
        2.安装centos：
            --参考位置：https://www.cnblogs.com/mosson0816/p/5416376.html
            编辑虚拟机设置--CD/DVD--使用ios镜像文件--选择ios文件位置--启动虚拟机--SKIP--
            --生产环境选择磁盘分区时一定要选择带LVM的--即磁盘扩容技术
            --注意不配置自动更新
            --只安装openssh server
            --安装完成后克隆虚拟机做备份--将干净的虚拟机备份--操作克隆机器
            --shutdown -h now
            --备份
        3.开启远程连接：--安装完成后默认是开着的，若没有则参见linux仓库下的相关文件进行配置
            --安装openssh：
                基于口令的安全验证：账号+密码可远程登录，口令和数据在传输过程中会被加密
                基于秘钥的安全验证：需要创建一对秘钥，将公有秘钥放在远程服务器自己的宿主目录中，四有迷药自己保存
                --1.检查是否安装：
                    apt-cache policy openssh-client openssh-server
                --2.安装服务端和客户端：
                    apt-get install openssh-server
                    apt-get install openssh-client
            --配置修改：主要是/etc/ssh/sshd\_config
        4.xshell连接：--
**3.安装jdk：**       
        
        1.检索1.8的列表
          yum list java-1.8*   
        2.安装1.8.0的所有文件
          yum install java-1.8.0-openjdk* -y
        3.使用命令检查是否安装成功
          java -version
        （系统环境变量文件：/etc/environment）
        （用户环境变量文件：/etc/profile）
**4.tomcat安装配置：**   
    
    1.地址：https://tomcat.apache.org/download-90.cgi
    2.链接地址：http://mirrors.shu.edu.cn/apache/tomcat/tomcat-9/v9.0.10/bin/apache-tomcat-9.0.10.zip
    
    3.安装：
        wget ...    下载
        unzip ...   解压缩
    4.赋予可執行權限
        cd apache-tomcat-9.0.10
        chmod a+x -R *   --給tomcat下所有文件赋予可执行权限
            a+x代表赋予linux登录的所有人
            -R当前路径下及所有子路径
            *代表路径下所有文件名
    5.端口修改：
        vim conf/server.xml
    6.运行测试：
        bin/startup.sh
        ps -ef |grep tomcat
    7.浏览器测试：
        ip+8080  
        如果在windows上无法访问VM中的linux中的tomcat，请尝试关闭防火墙
        
**5.mysql安装配置：**  
        
    1.见其他md
    2.重启：service mysqld restart
    3.登录重置密码：
        $ mysql -u root
        mysql > use mysql;
        mysql > update user set password=password('123456') where user='root';
        mysql > exit;
    4.创建普通用户并授权：
        mysql > use mysql;
        mysql > grant all privileges on *.* to 'root'@'%' identified by '123456';
        mysql > flushn privileges;
    5.重启即可通过navcat连接数据库服务器
    6.远程访问速度慢的问题解决：
        vi  /etc/my.cnf
        添加：--跳过mysql的dns解析
        skip-name-resolve
        重启解决

**6.docker部署微服务：**

    1.克隆一个干净的虚拟机：只安装docker即可
    2.其余参考buildTool仓库

        
        
        
        
        
        
        
               
        