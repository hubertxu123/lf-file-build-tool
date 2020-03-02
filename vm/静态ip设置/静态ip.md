
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
    

