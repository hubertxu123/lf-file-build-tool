
**1.服务准备：**

    Centos7.5：
    A-NFS-Server：192.168.1.230
    B-NFS-Client：192.168.1.244
    A作为服务端，B通过网络访问A的共享目录

**2.nfs本地挂载测试：**
    
    1.查看是否安装NFS
        rpm -qa nfs-utils rpcbind
    2.安装：
        yum install nfs-utils rpcbind 
    3.查看服务状态：
        systemctl status rpcbind.service
    4.查看rpcbind命令在哪
        which rpcbind
    5.启动rpc服务
        systemctl restart rpcbind.service
    6.安装net-tools
        yum install net-tools lsof
    7.查看rpc
        lsof -i :111
        netstat -lntup|grep rpcbind 
    8.查看nfs服务向rpc注册的端口信息
        rpcinfo -p localhost
    9.检查rpcbind是否开机启动
        chkconfig --list rpcbind
    10.启动NFS服务：
        systemctl start nfs.service
    11.查看状态
        systemctl status nfs.service
    12.再次查看rpc注册的端口信息
        rpcinfo -p localhost
    13.NFS常见进程详解
        ps -ef|egrep "rpc|nfs"
            root      40440      2  0 10:28 ?        00:00:00 [rpciod]
            rpcuser   40441      1  0 10:28 ?        00:00:00 /usr/sbin/rpc.statd
            rpc       52861      1  0 14:28 ?        00:00:00 /sbin/rpcbind -w
            root      53364      2  0 14:37 ?        00:00:00 [nfsiod]
            root      53640      1  0 14:40 ?        00:00:00 /usr/sbin/rpc.idmapd
            root      53641      1  0 14:40 ?        00:00:00 /usr/sbin/rpc.mountd
            root      53651      2  0 14:40 ?        00:00:00 [nfsd4_callbacks]
            root      53657      2  0 14:40 ?        00:00:00 [nfsd]
            root      53658      2  0 14:40 ?        00:00:00 [nfsd]
        nfsd(rpc.nfsd)主进程，主要是管理客户端能否登入服务端，登入者ID判别。
        mountd(rpc.mountd)管理NFS文件系统，登入者的权限管理
        rpc.lockd(非必要)用来锁定文件，用于客户端同时写入
        rpc.statd(非必要)检查文件一致性
        rpc.idmapd 名字映射后台进程
    14.配置NFS开机自启动
        chkconfig rpcbind on
        chkconfig nfs on
        chkconfig --list rpcbind
        chkconfig --list nfs 
    15.NFS服务端配置:
        vi /etc/exports
            exports文件配置格式:
            NFS共享的目录 NFS客户端地址1(参数1,参数2,...) 客户端地址2(参数1,参数2,...)
            说明：
            NFS共享目录：
            要用绝对路径，可被nfsnobody读写。
            NFS客户端地址：
            指定IP: 192.168.0.1
            指定子网所有主机: 192.168.0.0/24
            指定域名的主机: test.com
            指定域名所有主机: *.test.com
            所有主机: * 
            参数：
                ro：目录只读
                rw：目录读写
                sync：将数据同步写入内存缓冲区与磁盘中，效率低，但可以保证数据的一致性
                async：将数据先保存在内存缓冲区中，必要时才写入磁盘
                all_squash：将远程访问的所有普通用户及所属组都映射为匿名用户或用户组(nfsnobody)
                no_all_squash：与all_squash取反(默认设置)
                root_squash：将root用户及所属组都映射为匿名用户或用户组(默认设置)
                no_root_squash：与rootsquash取反
                anonuid=xxx：将远程访问的所有用户都映射为匿名用户，并指定该用户为本地用户(UID=xxx)
                anongid=xxx：将远程访问的所有用户组都映射为匿名用户组账户
            例如：
            /data/tmp 192.168.1.0/24(rw,sync,all_squash)
    16.创建需要共享的目录
        mkdir -p /data/tmp
        chown nfsnobody.nfsnobody /data/tmp
    17.重新加载nfs配置
        exportfs -rv
    18.查看nfs服务器挂载情况
        showmount -e localhost
    19.挂载测试：若要用其他服务器实现网络挂载，需要关闭防火墙或添加端口，此处测试采用本地，若报错，则重启
        mkdir -p /data/tmp2
        mount -t nfs 192.168.1.230:/data/tmp /data/tmp2
    20.查看挂载
        df -h
    21.在tmp下创建文件
        touch /data/tmp/1.txt
    22.查看tmp2下是否有文件
        ls /data/tmp2
    23.卸载挂载
        umount /data/tmp2
    24.防火墙阻断取消配置：
        --1.关闭防火墙即可：systemctl stop firewalld
        --2.配置防火墙：
            firewall-cmd --state
            vim /etc/sysconfig/nfs
                RQUOTAD_PORT=30001
                LOCKD_TCPPORT=30002
                LOCKD_UDPPORT=30002
                MOUNTD_PORT=30003
                STATD_PORT=30004
            systemctl restart rpcbind.service    
            systemctl restart nfs-server.service
            rpcinfo -p
                  program vers proto   port  service
                    100000    4   tcp    111  portmapper
                    100000    3   tcp    111  portmapper
                    100000    2   tcp    111  portmapper
                    100000    4   udp    111  portmapper
                    100000    3   udp    111  portmapper
                    100000    2   udp    111  portmapper
                    100005    1   udp  30003  mountd
                    100005    2   udp  30003  mountd
                    100005    3   udp  30003  mountd
                    100003    3   tcp   2049  nfs
                    100003    4   tcp   2049  nfs
                    100227    3   tcp   2049  nfs_acl
                    100003    3   udp   2049  nfs
                    100003    4   udp   2049  nfs
                    100227    3   udp   2049  nfs_acl

            firewall-cmd  --permanent    --add-port=2049/udp
            firewall-cmd  --permanent    --add-port=111/tcp
            firewall-cmd  --permanent    --add-port=111/udp
            firewall-cmd  --permanent    --add-port=2049/tcp
            firewall-cmd  --permanent    --add-port=30003/udp
            firewall-cmd  --permanent    --add-port=30003/tcp
            
**2.false:**
    
    1.mount -t nfs -o nolock,nfsvers=3 192.168.200.132:/mnt/ /opt/执行报错：
        mount.nfs: requested NFS version or transport protocol is not supported
        解决：重启nfs 
            -service nfs restart 或
            -systemctl restart nfs.service
