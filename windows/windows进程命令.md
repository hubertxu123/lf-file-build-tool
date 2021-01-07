


## 1.windows自带的启动方式

    start /min node ./bin/www   [后台启动应用程序] ==》还是会有窗口存在
    netstat -aon |findstr 3011  查看进程号
    tasklist |findstr 468 查看进程名
    taskkill /f /t /im 进程号

## 2.forever启动

    npm i -g forever
    
    　　forever可以看做是一个nodejs的守护进程，能够启动，停止，重启我们的app应用。
    
    1.全局安装 forever
    // 记得加-g，forever要求安装到全局环境下 
    sudo npm install forever -g
    2.启动
    复制代码
    // 1. 简单的启动 
    forever start app.js 
    
    // 2. 指定forever信息输出文件，当然，默认它会放到~/.forever/forever.log 
    forever start -l forever.log app.js 
    
    // 3. 指定app.js中的日志信息和错误日志输出文件， 
    // -o 就是console.log输出的信息，-e 就是console.error输出的信息 
    forever start -o out.log -e err.log app.js 
    
    // 4. 追加日志，forever默认是不能覆盖上次的启动日志， 
    // 所以如果第二次启动不加-a，则会不让运行 
    forever start -l forever.log -a app.js 
    
    // 5. 监听当前文件夹下的所有文件改动 
    forever start -w app.js 
    复制代码
    3.文件改动监听并自动重启
    // 1. 监听当前文件夹下的所有文件改动（不太建议这样） 
    forever start -w app.js 
    4. 显示所有运行的服务
    forever list 
    5. 停止操作
    复制代码
    // 1. 停止所有运行的node App 
    forever stopall 
    
    // 2. 停止其中一个node App 
    forever stop app.js 
    // 当然还可以这样 
    // forever list 找到对应的id，然后： 
    forever stop [id] 
    复制代码
    6.重启操作
    重启操作跟停止操作保持一致。
    // 1. 启动所有 
    forever restartall

## 3.pm2启动方式
    
    1、全局安装pm2
        npm install pm2 -g
    2、全局安装window自启包
        npm install pm2-windows-startup -g  
    3、启动pm2
        pm2-startup install
    4、配置文件路径和名称并启动
        pm2 start 路径 --name 名称 --watch
        pm2 start  D:\我的坚果云\个人实用项目\灯塔\main.js --name  灯塔 --watch
    5、保存到pm2实现自启 （包含开机自启，已测试）
        pm2 save
    6、查看自启程序列表,重启一下就可以知道是不是成功了
        pm2 ls

    PM2简介
        PM2是node进程管理工具
    启动
        –warch:监听应用目录的变化，一旦发生变化，自动重启，如果要精确监听、不监听的目录，最好通过配置文件。
        -i --instances: 启用多少个实例，可用于负载均衡。如果-i 0 或者-i max，则根据当前机器核数确定实例数目。
        –ignore-watch：排除监听的目录/文件，可以是特定的文件名，也可以是正则。比如–ignore-watch=“test node_modules “some scripts””
        -n --name：应用的名称。查看应用信息的时候可以用到。
        -o --output ：标准输出日志文件的路径。
        -e --error ：错误输出日志文件的路径。
        –interpreter ：the interpreter pm2 should use for executing app (bash, python…)。比如你用的coffee script来编写应用。
    重启
        pm2 restart app.js
    停止
        pm2 stop 名称或id
    停止所有
        pm2 stop all
    删除
        pm2 delete app_name|app_id
        pm2 delete all
    查看进程状态
        pm2 list
    查看日志
        pm2 logs
