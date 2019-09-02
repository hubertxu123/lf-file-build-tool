
**1.git安装：**

    1.介绍:yum源上自动安装的git版本为1.7，所以需要掌握手动编译安装git方法。
    2.安装git依赖包
      　　yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker
    3.删除已有的git
      　　yum remove git
    4.下载：
        cd /usr/src
        wget https://www.kernel.org/pub/software/scm/git/git-2.8.3.tar.gz
        tar -zxvf git-2.8.3.tar.gz
        cd git-2.8.3
        ./configure prefix=/usr/local/git/  配置git安装路径
        make && make install                编译并且安装
        git --version
    5.vi /etc/profile
      　　在最后一行加入
      　　export PATH=$PATH:/usr/local/git/bin
      　　让该配置文件立即生效
      　　source /etc/profile
    6.卸载:
        which -a git
        d进入git所在的目录
        终端命令:cd /usr/bin/git(这个是一般的默认位置)
        删除命令
        rm -rf git*
        
**2.使用：**

    以线上为主抛弃本地代码：git reset --hard origin/master
    rpm -ql git   查看git的安装路径是/usr/bin/git
