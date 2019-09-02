
**1.安装：**

    1.环境：java环境前提 mysql/README.md
    2.安装：
        ·wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo 
            wget -O ：下载并以不同的文件名保存
            yum的repo中默认没有Jenkins，需要先将Jenkins存储库添加到yum repos，执行下面的命令：
        ·rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
        ·yum install -y jenkins 
            默认安装最新的
        ·service jenkins start  
            启动