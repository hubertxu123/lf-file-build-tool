_________________________________________________________________________

1.memcached:分布式k-v数据库
    ·Memcached是一个自由开源的，高性能，分布式内存对象缓存系统。
    ·Memcached是一种基于内存的key-value存储，用来存储小块的任意数据（字符串、对象）
    ----------------
    ·使用：
        -1.第一次访问：从rdbms中取出数据放入memcached
        -2.第二次访问：从memcached中取出数据并显示页面
2.特征：
    -1.协议简单
    -2.基于libevent的事件处理
    -3.内置内存存储方式
    -4.memcached不互相通信的分布式
    -5.多语言支持
3.安装：
    -注意：
        ·Linux系统安装memcached，首先要先安装libevent库。
    -（Ubuntu/Debian）自动安装：
        sudo apt-get install libevent libevent-deve             自动下载安装（Ubuntu/Debian）
        sudo apt-get install memcached
    -（Redhat/Fedora/Centos）自动安装
        yum install libevent libevent-deve                      自动下载安装（Redhat/Fedora/Centos）
        yum install memcached
    -FreeBSD自动安装：
        portmaster databases/memcached
4.源代码安装:
    wget http://memcached.org/latest                    下载最新版本
    tar -zxvf memcached-1.x.x.tar.gz                    解压源码
    cd memcached-1.x.x                                  进入目录
    ./configure --prefix=/usr/local/memcached           配置
    make && make test                                   编译
    sudo make install                                   安装
5.命令：
    $ /usr/local/memcached/bin/memcached -h                           命令帮助
    -d是启动一个守护进程；
    -m是分配给Memcache使用的内存数量，单位是MB；
    -u是运行Memcache的用户；
    -l是监听的服务器IP地址，可以有多个地址；
    -p是设置Memcache监听的端口，最好是1024以上的端口；
    -c是最大运行的并发连接数，默认是1024；
    -P是设置保存Memcache的pid文件。

    -作为前台程序运行：
        -/usr/local/memcached/bin/memcached -p 11211 -m 64m -vv
    -作为后台服务程序运行：
        -/usr/local/memcached/bin/memcached -p 11211 -m 64m -d
        -或者-
        -/usr/local/memcached/bin/memcached -d -m 64M -u root -l 192.168.0.200 -p 11211 -c 256 -P /tmp/memcached.pid
6.使用自动安装memcached的要找到其执行位置：
    -查找安装位置：whereis memcached
        -/usr/bin/memcached
        -/usr/share/man/man1/memcached.1.gz
    -执行启动命令：
        -/usr/bin/memcached -p 11211 -m 64m -vv 前台
        -/usr/bin/memcached -p 11211 -m 64m -d  后台
        --报错：can't run as root without the -u switch
        --解决：加上-u root
            -/usr/bin/memcached -d -m 512 -l 127.0.0.1 -p 10000 -u root
            -表示已守护进程的方式启动，监听于 127.0.0.1 的10000端口，使用root用户，最大使用512M内存
            -可以同时开多个memcached，但要监听在不同的端口.
    -连接测试memcached：
        -配置telnet：
            ·1.yum install xinetd   telnet要依靠xinetd服务启动，所以要先安装该服务
             yum list telnet*       查看telnet相关的安装包
             yum install telnet-server 安装telnet服务
             yum install telnet.*   安装telnet客户端
7.memcached的卸载；
    -查看安装目录：
        find / -name memcached
    -结束memcached进程：
        killall memcached
    -删除memcached目录及文件：
        # rm -rf /www/wdlinux/memcached
        # rm -rf /www/wdlinux/init.d/memcached
    -关闭memcached开机启动：
        # chkconfig memcached off
    -把memcached移出开机启动：
        # chkconfig --del memcached
_________________________________________________________________________
windows安装参见：http://www.runoob.com/memcached/window-install-memcached.html
—————————————————————————————————————————————————————————————————————————
完整安装流程：--linux完整
    1.#rpm -qa|grep libevent            查看系统是否已经安装libevent
      #yum -y install libevent          如果有，不要高兴，先升级
      #ls -al /usr/lib | grep libevent  测试libevent是不是已经安装成功
      #yum install libevent-devel

      # wget http://memcached.googlecode.com/files/memcached-1.4.8.tar.gz
      # tar zxvf memcached-1.4.8.tar.gz
      # cd memcached-1.4.8
      # ./configure –help
        ./configure --prefix=/usr/local/memcached           配置
        make && make test                                   编译
        sudo make install                                   安装
      #########################
      1.# whereis memcached
      2.# find / -name memcached
      #########################
    3.启动：
      /usr/local/memcached/bin/memcached -d -m 50m -p 11211 -u root
    2.连接测试：
      #yum -y install telnet            安装telnet命令
      #telnet 127.0.0.1 11211
       Trying 192.168.127.130...
       Connected to 192.168.127.130.
       Escape character is '^]'.
       //当前窗口处于等待状态，可以直接输入命令执行
       stats //直接运行该命令
      #是否运行检查：netstat -na|grep 11211
—————————————————————————————————————————————————————————————————————————
—————————————————————————————————————————————————————————————————————————
—————————————————————————————————————————————————————————————————————————
memcached的常用的参数配置
    -m 指定缓存所使用的最大内存容量，单位是Megabytes，默认是64MB
    -u 只有以root身份运行时才指定该参数
    -d 以daemon的形式运行
    -l 指定监听的地址
    -p 指定监听的TCP端口号，默认是11211
    -t 指定线程数，默认是4个
    -h 打印帮助信息
    -c 最大同时连接数，默认是1024.
    -U 指定监听的UDP端口号，默认是11211
    -M 内存耗尽时显示错误，而不是删除项
    一开始说的“-d”参数需要进行进一步的解释
        -d install 安装memcached
        -d uninstall 卸载memcached
        -d start 启动memcached服务
        -d restart 重启memcached服务
        -d stop 停止memcached服务
        -d shutdown 停止memcached服务
————————————————————————
Memcached的高性能源于两阶段哈希（two-stage hash）结构。
Memcached就像一个巨大的、存储了很多<key,value>对的哈希表。
通过key，可以存储或查询任意的数据。
客户端可以把数据存储在多台memcached上。
当查询数据时：
    1.客户端首先参考节点列表计算出key的哈希值（阶段一哈希），进而选中一个节点；
    2.客户端将请求发送给选中的节点，然后memcached节点通过一个内部的哈希算法（阶段二哈希），
         查找真正的数据（item）并返回给客户端。
从实现的角度看，memcached是一个非阻塞的、基于事件的服务器程序。
为了提高性能，memcached 中保存的数据都存储在memcached 内置的内存存储空间中。由于数据仅存在于内存中，
因此重启memcached、重启操作系统会导致全部数据消失。另外，内容容量达到指定值之后，就基于LRU(Least Recently Used)
算法自动删除不使用的缓存。memcached 本身是为缓存而设计的服务器，因此并没有过多考虑数据的永久性问题
memcached 不互相通信的分布式
memcached 尽管是“分布式”缓存服务器，但服务器端并没有分布式功能。各个
memcached 不会互相通信以共享信息。那么，怎样进行分布式呢？这完全取决于客户端的实现。

————————————————————————
观点一：
    1、Redis和Memcache都是将数据存放在内存中，都是内存数据库。不过memcache还可用于缓存其他东西，例如图片、视频等等；
    2、Redis不仅仅支持简单的k/v类型的数据，同时还提供list，set，hash等数据结构的存储；
    3、虚拟内存--Redis当物理内存用完时，可以将一些很久没用到的value 交换到磁盘；
    4、过期策略--memcache在set时就指定，例如set key1 0 0 8,即永不过期。Redis可以通过例如expire 设定，例如expire name 10；
    5、分布式--设定memcache集群，利用magent做一主多从;redis可以做一主多从。都可以一主一从；
    6、存储数据安全--memcache挂掉后，数据没了；redis可以定期保存到磁盘（持久化）；
    7、灾难恢复--memcache挂掉后，数据不可恢复; redis数据丢失后可以通过aof恢复；
    8、Redis支持数据的备份，即master-slave模式的数据备份；
观点二：
    Redis与Memcached的区别
         如果简单地比较Redis与Memcached的区别，大多数都会得到以下观点：
        1 Redis不仅仅支持简单的k/v类型的数据，同时还提供list，set，hash等数据结构的存储。
        2 Redis支持数据的备份，即master-slave模式的数据备份。
        3 Redis支持数据的持久化，可以将内存中的数据保持在磁盘中，重启的时候可以再次加载进行使用。

    在Redis中，并不是所有的数据都一直存储在内存中的。这是和Memcached相比一个最大的区别（我个人是这么认为的）。
    Redis 只会缓存所有的key的信息，如果Redis发现内存的使用量超过了某一个阀值，将触发swap的操作，Redis根据“swappability = age*log(size_in_memory)”计算出哪些key对应的value需要swap到磁盘。然后再将这些key对应的value持久化到磁 盘中，同时在内存中清除。这种特性使得Redis可以保持超过其机器本身内存大小的数据。当然，机器本身的内存必须要能够保持所有的key，毕竟这些数据 是不会进行swap操作的。
    同时由于Redis将内存中的数据swap到磁盘中的时候，提供服务的主线程和进行swap操作的子线程会共享这部分内存，所以如果更新需要swap的数据，Redis将阻塞这个操作，直到子线程完成swap操作后才可以进行修改。
    可以参考使用Redis特有内存模型前后的情况对比：

    VM off: 300k keys, 4096 bytes values: 1.3G used
    VM on: 300k keys, 4096 bytes values: 73M used
    VM off: 1 million keys, 256 bytes values: 430.12M used
    VM on: 1 million keys, 256 bytes values: 160.09M used
    VM on: 1 million keys, values as large as you want, still: 160.09M used

    当 从Redis中读取数据的时候，如果读取的key对应的value不在内存中，那么Redis就需要从swap文件中加载相应数据，然后再返回给请求方。 这里就存在一个I/O线程池的问题。在默认的情况下，Redis会出现阻塞，即完成所有的swap文件加载后才会相应。这种策略在客户端的数量较小，进行 批量操作的时候比较合适。但是如果将Redis应用在一个大型的网站应用程序中，这显然是无法满足大并发的情况的。所以Redis运行我们设置I/O线程 池的大小，对需要从swap文件中加载相应数据的读取请求进行并发操作，减少阻塞的时间。
    redis、memcache、mongoDB 对比
    从以下几个维度，对redis、memcache、mongoDB 做了对比，欢迎拍砖

    1、性能
        都比较高，性能对我们来说应该都不是瓶颈
        总体来讲，TPS方面redis和memcache差不多，要大于mongodb

    2、操作的便利性
        memcache数据结构单一
        redis丰富一些，数据操作方面，redis更好一些，较少的网络IO次数
        mongodb支持丰富的数据表达，索引，最类似关系型数据库，支持的查询语言非常丰富

    3、内存空间的大小和数据量的大小
        redis在2.0版本后增加了自己的VM特性，突破物理内存的限制；可以对key value设置过期时间（类似memcache）
        memcache可以修改最大可用内存,采用LRU算法
        mongoDB适合大数据量的存储，依赖操作系统VM做内存管理，吃内存也比较厉害，服务不要和别的服务在一起

    4、可用性（单点问题）
        对于单点问题，
        redis，依赖客户端来实现分布式读写；主从复制时，每次从节点重新连接主节点都要依赖整个快照,无增量复制，因性能和效率问题，
        所以单点问题比较复杂；不支持自动sharding,需要依赖程序设定一致hash 机制。
        一种替代方案是，不用redis本身的复制机制，采用自己做主动复制（多份存储），或者改成增量复制的方式（需要自己实现），一致性问题和性能的权衡
        Memcache本身没有数据冗余机制，也没必要；对于故障预防，采用依赖成熟的hash或者环状的算法，解决单点故障引起的抖动问题。
        mongoDB支持master-slave,replicaset（内部采用paxos选举算法，自动故障恢复）,auto sharding机制，对客户端屏蔽了故障转移和切分机制。

    5、可靠性（持久化）
        对于数据持久化和数据恢复，
        redis支持（快照、AOF）：依赖快照进行持久化，aof增强了可靠性的同时，对性能有所影响
        memcache不支持，通常用在做缓存,提升性能；
        MongoDB从1.8版本开始采用binlog方式支持持久化的可靠性
    6、数据一致性（事务支持）
        Memcache 在并发场景下，用cas保证一致性
        redis事务支持比较弱，只能保证事务中的每个操作连续执行
        mongoDB不支持事务
    7、数据分析
        mongoDB内置了数据分析的功能(mapreduce),其他不支持
    8、应用场景
        redis：数据量较小的更性能操作和运算上
        memcache：用于在动态系统中减少数据库负载，提升性能;做缓存，提高性能（适合读多写少，对于数据量比较大，可以采用sharding）
        MongoDB:主要解决海量数据的访问效率问题




































