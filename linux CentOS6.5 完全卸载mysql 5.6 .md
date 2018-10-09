查看已经安装的服务 
rpm –qa|grep -i mysql 
-i 作用是不区分大小写

yum remove mysql mysql-server mysql-libs compat-mysql51
rm -rf /var/lib/mysql
rm /etc/my.cnf
查看是否还有mysql软件：
rpm -qa|grep mysql
有的话继续删除

可以看到有两个安装包 
MySQL-server-5.6.19-1.linux_glibc2.5.x86_64.rpm
MySQL-client-5.6.19-1.linux_glibc2.5.x86_64.rpm

删除这两个服务(去掉后缀) 
rpm –e MySQL-client-5.6.19-1.linux_glibc2.5.x86_64
rpm -e MySQL-server-5.6.19-1.linux_glibc2.5.x86_64  
查看残留的目录：

whereis mysql 

然后删除mysql目录：

rm –rf /usr/lib64/mysql 

删除相关文件： 
rm –rf /usr/my.cnf
rm -rf /root/.mysql_sercret  
最关键的：

rm -rf /var/lib/mysql

如果这个目录如果不删除，再重新安装之后，密码还是之前的密码，不会重新初始化！