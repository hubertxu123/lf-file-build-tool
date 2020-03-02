



#sshd命令

    rpm -qa | grep ssh  查看系统中ssh安装包   
    ps  -ef | grep ssh  查看ssh服务有没有运行
    service sshd start  运行ssh 
    service sshd stop   停止ssh 
    service sshd restart重启ssh 
    service sshd status 查看ssh是否运行 
    netstat -ntlp	    ssh服务的网络连接情况

