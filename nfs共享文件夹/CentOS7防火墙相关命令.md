
**1.服务准备：**

    A-NFS-Server：192.168.1.230
    B-NFS-Client：192.168.1.244
    A作为服务端，B通过网络访问A的共享目录

**notice：Centos7下防火墙相关命令**
    
    1.开启端口：（开启add，关闭remove） 
        firewall-cmd --zone=public --add-port=22122/tcp --permanent #单个 
        firewall-cmd --zone=public --add-port=1000-2000/tcp --permanent #多个 
            --zone #作用域 
            --add-port=22122/tcp #添加端口，格式：端口/通讯协议 
            --permanent #永久生效，没有此参数重启后失效
        --1.移除端口
            firewall-cmd --permanent --remove-port=8080/tcp
    2.查看防火墙状态： 
        firewall-cmd --state
    3.查看端口列表： 
        firewall-cmd --permanent --list-port
        firewall-cmd --list-all 
        --3.1.查询端口是否开放
            firewall-cmd --query-port=8080/tcp
    4.重启防火墙： 
        firewall-cmd --reload
    5.禁用防火墙： 
        systemctl stop firewalld
    6.开启防火墙： 
        systemctl start firewalld
    7.设置开机启动： 
        systemctl enable firewalld
    8.停止并禁用开机启动： 
        systemctl disable firewalld
        cat /etc/redhat-release             #查看系统是不是Centos 

**2.安装使用:**

     1.A机:
        --1.安装 NFS 服务器所需的软件包：安装的过程中，会自动安装rpcbind   
            yum -y install nfs-utils rpcbind
        --2.编辑exports文件，添加客户端主机：
            vi /etc/exports
            /home/nfs 192.168.222.244(rw,sync,fsid=0)  192.168.222.202(rw,sync,fsid=0)  192.168.12.0/24(rw,no_root_squash,no_all_squash,sync,anonuid=501,anongid=501)   
                    配置说明：
                    这一行分为三个部分：
                    第一部分：/home/nfs ，这个是本地要共享出去的目录。
                    第二部分：允许访问的主机，可以是一个IP：192.168.222.201，也可以是一个IP段：192.168.12.0/24
                    第三部分：括号中部分
                        rw表示可读写，ro只读；sync ：同步模式，内存中数据时时写入磁盘；async ：不同步，把内存中数据定期写入磁盘中；no_root_squash ：客户机用root访问该共享文件夹时，
                        不映射root用户，root用户就会对共享的目录拥有至高的权限控制，就像是对本机的目录操作一样。不安全，不建议使用；root_squash：和上面的选项对应，
                        root用户对共享目录的权限不高，只有普通用户的权限，即限制了root；all_squash：不管使用NFS的用户是谁，
                        他的身份都会被限定成为一个指定的普通用户身份；anonuid/anongid ：要和root_squash 以及all_squash一同使用，用于指定使用NFS的用户限定后的uid和gid，
                        前提是本机的/etc/passwd中存在这个uid和gid。fsid=0表示将/home/nfs整个目录包装成根目录，insecure 允许从这台机器过来的非授权访问
                    启动A机上nfs服务 
            exportfs -r：使配置生效，输入命令
        --3.为rpcbind和nfs做开机启动：
            systemctl enable rpcbind.service    
            systemctl enable nfs-server.service  
        --4.分别启动rpcbind和nfs服务:
            systemctl start rpcbind.service    
            systemctl start nfs-server.service
            或
            service rpcbind start
            service nfs start
        --5.确认NFS服务器启动成功：--查看结果是否含有nfs      
            rpcinfo -p
        ————————————————————————————————————
        --6.防火墙端口设置：
            -1.解决方案：
                首先打开111和2049端口，这是portmap和nfsd进程对应的端口。但是其他端口是系统开机时随机分配的，很难确定，
                所以需要修改配置文件/etc/sysconfig/nfs,把这些端口固定下来，然后在防火墙上关闭。
            -2.步骤：
                --1.首先打开111和2049端口：
                    firewall-cmd  --permanent    --add-port=2049/udp
                    firewall-cmd  --permanent    --add-port=111/tcp
                    firewall-cmd  --permanent    --add-port=111/udp
                    firewall-cmd  --permanent    --add-port=2049/tcp
                --2.固定端口：
                    vi /etc/sysconfig/nfs
                        添加
                            RQUOTAD_PORT=1001
                        去掉下面语句前面的“#”号
                            LOCKD_TCPPORT=32803
                            LOCKD_UDPPORT=32769
                            MOUNTD_PORT=892
                --3.3.打开1001,32803,32769,892端口：
                    firewall-cmd  --permanent    --add-port  1001/tcp
                    firewall-cmd  --permanent    --add-port  1001/udp
                    firewall-cmd  --permanent    --add-port 32803/tcp
                    firewall-cmd  --permanent    --add-port 32769/udp
                    firewall-cmd  --permanent    --add-port 892/tcp
                    firewall-cmd  --permanent    --add-port 892/udp
                --4.重启验证端口：   
                     systemctl restart rpcbind.service    
                     systemctl restart nfs-server.service
                     rpcinfo -p
                
            
            
            
            
            