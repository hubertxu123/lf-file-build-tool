解压命令：unzip EtnetChinaApplication.jar -d app
压缩命令：jar cvfm0 MR-XDR-JMR-NEW.jar META-INF/MANIFEST.MF .
移动命令：mv EtnetChinaApplication.jar ../kps.jar
安装命令： yum install zip    #提示输入时，请输入y；
安装命令：yum install unzip #提示输入时，请输入y；
运行项目：nohup java -jar kps.jar --server.port=80 >> mss.log  2>& 1 &
查看启动所有的服务：ps	-a
查询指定启动的服务：ps -ef | grep java


docker run --detach \
            --name wx-nginx \
            -p 443:443\
            -p 80:80 \
            -v /usr/local/dockerdata/nginx/data:/usr/share/nginx/html:rw\
            -v /usr/local/dockerdata/nginx/config/nginx.conf:/etc/nginx/nginx.conf/:rw\
            -v /usr/local/dockerdata/nginx/config/conf.d/default.conf:/etc/nginx/conf.d/default.conf:rw\
            -d nginx
