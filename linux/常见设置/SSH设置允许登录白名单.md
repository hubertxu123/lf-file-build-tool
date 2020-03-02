



#sshd 允许登陆的ip 白名单或者黑名单

    白名单设置：一般只允许指定的ip ssh 登陆机器
    cat /etc/hosts.deny  //禁用文件
    sshd:ALL  #所有的都不允许ssh 登陆，无论什么用户  
    ————————
    cat /etc/hosts.allow #允许下面的ip/ip 段登陆  
    sshd:10.xx.xx.xxx:allow  
    sshd:10.xx.xx.xxx:allow  
