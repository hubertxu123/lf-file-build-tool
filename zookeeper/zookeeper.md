
## 1.安装zookeeper-3.4.6：

        ·注册中心服务器：192.168.6.128
        1.修改操作系统的 /etc/hosts文件中添加：
            su root
            vi  /etc/hosts:
            #zookeeper server
            192.168.6.128 provider-01
            
            esc+:wq
        2.下载：
            cd /home/admin/
            wget http://apache.fayea.com/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz
        3.解压：tar -zxvf zookeeper-3.4.10.tar.gz
        4.cd /home/admin/zookeeper-3.4.10
        5.创建目录
            # mkdir data 
            # mkdir logs
        6.文件拷贝：
            # cd conf
            # cp zoo_sample.cfg  zoo.cfg
        7.修改新增：vim zoo.cfg
        # The number of milliseconds of each tick
        #—————————————
        tickTime=2000 
        # The number of ticks that the initial
        # synchronization phase can take
        #—————————————
        initLimit=10
        #此配置是用来配置zookeeper接受客户端初始化连接时最长能忍受多少个心跳时间间隔数
        #此处的客户端：非用户连接zookeeper服务器的客户端，而是zookeeper服务器集群中连接到leader的follow服务器
        #当已经超过10个的心跳时间(即tickTIme)长度后，zookeeper服务器还没有收到客户端的返回消息
        #那表明这个客户端连接失败，总的时间长度就为5*2000=10秒
        # The number of ticks that can pass between
        # sending a request and getting an acknowledgement
        #——————————————
        #这个配置项标识leader与follower之间发送消息，请求和响应时间长度，最长不能超过多少个tickTime的时间长度
        #总的时间长度就是2*2000=4秒（之所以乘以2是因为请求和响应各一次）
        
        syncLimit=5
        # the directory where the snapshot is stored.
        # do not use /tmp for storage, /tmp here is just
        # example sakes.
        # ---------------------------
        dataDir=/home/admin/zookeeper-3.4.10/data
        dataLogDir=/home/admin/zookeeper-3.4.10/logs
        # ---------------------------
        # the port at which the clients will connect
        # ---------------------------
        # 2181通过此端口进行通讯
        clientPort=2181 
        server.1=provider-01:2888:3888
        # 2888是zookeeper服务之间的通信端口(集群时会用到)，3888是zookeeper与其他应用程序通讯的端口
        # ---------------------------
        # the maximum number of client connections.
        # increase this if you need to handle more clients
        #maxClientCnxns=60
        #
        # Be sure to read the maintenance section of the
        # administrator guide before turning on autopurge.
        #
        # http://zookeeper.apache.org/doc/current/zookeeperAdmin.html#sc_maintenance
        #
        # The number of snapshots to retain in dataDir
        #autopurge.snapRetainCount=3
        # Purge task interval in hours
        # Set to "0" to disable auto purge feature
        #autopurge.purgeInterval=1
        
        8.在dataDir=/home/admin/zookeeper-3.4.10/data下创建myid文件并编辑
            # mkdir myid
            # vi myid    创建并编辑myid文件命令
            在对应的ip的机器上输入对应的编号，
            如在zookeeper上，myid文件内容就是1
            如在单点上进行安装配置，那么只有一个server.1
            此处输入1，即可
        9.admin用户下修改文件增加zookeeper配置(配置环境变量)
            # vi /home/admin/.bash_profile
            export ZOOKEEPER_HOME=/home/admin/zookeeper-3.4.10
            export Path=$ZOOKEEPER_HOME/bin:$PATH
            # source .bash_profile  使配置文件生效
        10.防火墙打开要用到的端口：2181,2888,3888
            # su root
            # chkconfig iptables on 
            # service iptables start
            # vi /etc/sysconfig/iptables
            -A INPUT -m state --state NEW -m tcp -p tcp --dport 2181  -j 	ACCEPT
            -A INPUT -m state --state NEW -m tcp -p tcp --dport 2888  -j 	ACCEPT
            -A INPUT -m state --state NEW -m tcp -p tcp --dport 3888  -j 	ACCEPT
            # service iptables restart
            # service iptables status
        11.启动并测试zookeeper（使用admin用户而不是root）
            # exit 退出root用户
            # pwd  查看当前路径
            # cd /home/admin/zookeeper-3.4.10/bin
            #/
            # jps --查看进程
                1456 QuorumPeerMain  --zookeeper进程
                1475 Jps
            # zkServer.sh status  --
            # zkServer.sh stop  --停止
            # ps -ef |grep java --查看进程
        12.配置zookeeper开机自启：
            # vi /etc/rc.local	
            su - admin -c '/home/admin/zookeeper-3.4.10/bin/zkServer.sh start'

## 2.docker安装zk：
    
    1.单机：
        docker run -d -p 2181:2181 --restart always --name zookeeper \
        -v $PWD/volume/data:/data \
        -v $PWD/volume/datalog:/datalog \
        zookeeper:3.4.13
        解释：
            -v 挂载
            $PWD 指当前目录
            --restart always 表示总会重启
    2.集群：
        -- 创建节点文件夹
        mkdir cluster/node1 -p && mkdir cluster/node2 -p && mkdir cluster/node3 -p
        
        -- 机器ip
        machine_ip=10.82.12.95
        
        -- 运行节点1
        docker run -d -p 2181:2181 -p 2887:2888 -p 3887:3888 --name zookeeper_node1 --restart always \
        -v $PWD/cluster/node1/volume/data:/data \
        -v $PWD/cluster/node1/volume/datalog:/datalog \
        -e "TZ=Asia/Shanghai" \
        -e "ZOO_MY_ID=1" \
        -e "ZOO_SERVERS=server.1=0.0.0.0:2888:3888 server.2=$machine_ip:2888:3888 server.3=$machine_ip:2889:3889" \
        zookeeper:3.4.13
        
        -- 运行节点2
        docker run -d -p 2182:2181 -p 2888:2888 -p 3888:3888 --name zookeeper_node2 --restart always \
        -v $PWD/cluster/node2/volume/data:/data \
        -v $PWD/cluster/node2/volume/datalog:/datalog \
        -e "TZ=Asia/Shanghai" \
        -e "ZOO_MY_ID=2" \
        -e "ZOO_SERVERS=server.1=$machine_ip:2887:3887 server.2=0.0.0.0:2888:3888 server.3=$machine_ip:2889:3889" \
        zookeeper:3.4.13
        
        -- 运行节点3
        docker run -d -p 2183:2181 -p 2889:2888 -p 3889:3888 --name zookeeper_node3 --restart always \
        -v $PWD/cluster/node3/volume/data:/data \
        -v $PWD/cluster/node3/volume/datalog:/datalog \
        -e "TZ=Asia/Shanghai" \
        -e "ZOO_MY_ID=3" \
        -e "ZOO_SERVERS=server.1=$machine_ip:2887:3887 server.2=$machine_ip:2888:3888 server.3=0.0.0.0:2888:3888" \
        zookeeper:3.4.13
