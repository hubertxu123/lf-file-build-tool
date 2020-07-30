

# 1.数据导出导入：

    1.进入docker中的mongo：
        docker exec -it docker_mongodb_1 bash
    2.导出文件：
        ·注意：
            用来查看参数：
            mongodump --help 
        ·gz压缩文件：
            mongodump -h 127.0.0.1:27017 --archive=/home/agri.20191208.gz --gzip -d=agri
        ·BSON文件：
            mongodump -h 127.0.0.1:27017 -d agri -o /home/
        ·解释：
            -h 表示 host
            -d/--db 表示 database
            --archive 表示打包
            -o 表示 output directory
            --gzip 表示压缩
            -u 表示 username
            -p 表示 password
    3.导出文件取回本地：
        docker cp docker_mongodb_1:/home/agri.20191208.gz ~/ mongodb-backup/
            docker_mongodb_1 表示容器名
            /home/agri.20191208.gz 导出路径
            ~/mongodb-backup/ 表示本机路径
    4.数据库导入（Docker 里的 MongoDB）：
        2.1、拷贝本机文件至 Docker 里的 MogonDB
            sudo docker cp ~/mongodb-backup/agri.20191208.gz docker_mongodb_1:/home/
        2.2、恢复 gz 数据至 MongoDB
            mongorestore --gzip --archive=/home/agri.20191208.gz dump/ --dryRun --verbose
        --dryRun 表示演习一下
        --verbose 显示执行详情
        注：去掉 --dryRun --verbose 才算真的恢复数据
   
# 2.示例：
    
    [root@centos ~]# docker exec -it 8b37 bash
    root@8b3794ffc91c:/# 
    root@8b3794ffc91c:/# mongodump --uri=mongodb://swen:swen123456@127.0.0.1:27017/app?authSource=admin --archive=/home/app.20191208.gz --gzip
    ... 省略日志
    root@8b3794ffc91c:/# exit 
    exit
    [root@centos ~]# docker cp mongodb:/home/app.20191208.gz ./
    [root@centos ~]# scp app.20191208.gz root@118.25.13.144:/root
    
    //进入远程机器：
    [root@VM_0_9_centos ~]# docker cp app.20191208.gz mongodb2:/home
    [root@VM_0_9_centos ~]# docker exec -it mongodb2 bash
    root@8eccb1daf69c:/# mongorestore --uri=mongodb://swen:qwrq@@@#@127.0.0.1:27017/app?authSource=admin --archive=/home/app.20191208.gz dump/ --gzip
    //以上或报错由于有密码中@
    提示用户名或者密码里面出现“：”或者“@”字符时，必须需要进行编码。其实问题很简单，就是出现：或者@符号时，解析这个字符串时就会出现问题，URL中原本有：和@字符，如果用户名或者密码出现这些字符，
    就无法区分哪些是真正的分隔符。
    解决办法：
        对@使用16进制进行URL编码：%40
        对：使用16进制进行URL编码：%3A
        用上面16进制的URL编码代替原本的字符就行了。
    root@8eccb1daf69c:/# mongorestore --uri=mongodb://swen:qwrq%40%40%40#@127.0.0.1:27017/app?authSource=admin --archive=/home/app.20191208.gz dump/ --gzip


