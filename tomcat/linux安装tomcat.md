
**4.tomcat安装配置：**   
    
    1.地址：https://tomcat.apache.org/download-90.cgi
    2.链接地址：http://mirrors.shu.edu.cn/apache/tomcat/tomcat-9/v9.0.10/bin/apache-tomcat-9.0.10.zip
    
    3.安装：
        wget ...    下载
        unzip ...   解压缩
    4.赋予可執行權限
        cd apache-tomcat-9.0.10
        chmod a+x -R *   --給tomcat下所有文件赋予可执行权限
            a+x代表赋予linux登录的所有人
            -R当前路径下及所有子路径
            *代表路径下所有文件名
    5.端口修改：
        vim conf/server.xml
    6.运行测试：
        bin/startup.sh
        ps -ef |grep tomcat
    7.浏览器测试：
        ip+8080  
        如果在windows上无法访问VM中的linux中的tomcat，请尝试关闭防火墙
