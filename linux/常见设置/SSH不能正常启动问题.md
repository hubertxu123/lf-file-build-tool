



#不能正常启动问题：

    $ service sshd status 
      openssh-daemon is stopped
    解决：
    ----
    仍不能连接时：
    ·rpm -qa| grep iptables #查看是否安装了iptables防火墙
    ·如果安装了，编辑防火墙配置文件
    	vi /etc/sysconfig/iptables
     	#增加的规则(端口号改为自己的，禁止22端口登陆也可以在这里将22端口的规则删除
     	-A RH-Firewall-1-INPUT -m state --state NEW -m tcp -p tcp --dport 21578 -j 	ACCEPT
    	-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
    ·service iptables restart  #重启防火墙
