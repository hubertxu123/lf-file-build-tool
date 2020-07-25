
#https://www.jianshu.com/p/a9540d9f8d9c

## Nexus私服：
>Nexus 大家应该知道是对 Maven 包管理的私服工具，其实他还支持 npm 、docker 、yum 等等  
>推荐查看官方使用方式：https://blog.sonatype.com/using-nexus-3-as-your-repository-part-2-npm-packages
### 1.安装启动

    docker run -d --restart=unless-stopped  --name nexus \
    -p 8081:8081 -p 5000:5000 -p 5001:5001 -p 5002:5002 -p 5003:5003 -p 5004:5004 \
    --ulimit nofile=90000:90000 \
    -v /usr/local/nexus-data \
    -e INSTALL4J_ADD_VM_PARAMS="-Xms2g -Xmx2g" \
    sonatype/nexus3:3.8.0

    服务启动后访问：http://127.0.0.1:8081/
    默认使用的用户名密码是： admin/admin123
    
### 2.建托管仓库，用户信息
    
    淘宝镜像：https://registry.npm.taobao.org
    源镜像：https://registry.npmjs.org
    
### 3.打包发布
    0.规范：
        1.package.json的规范：https://docs.npmjs.com/creating-a-package-json-file
        2. .npmrc文件所在位置：C:\Users\Administrator\.npmrc
    1.linux下执行命令获取base64的密码 ：
        echo -n 'myuser:mypassword' | openssl base64
    2.如果您有一个只想从Nexus 下载依赖项的项目，请使用以下.npmrc命令在项目的根目录下创建一个文件：
      也就是说只要有这个文件，就可以使用私有仓库
      registry=http://your-host:8081/repository/npm-group/
      _auth=YWRtaW46YWRtaW4xMjM=
    3.如果您有要发布到Nexus的项目，请将其放入package.json：找到.npmrc文件修改为以上内容
        并且修改private为false
      {
        ...
        "private": false,
        "publishConfig": {
          "registry": "http://your-host:8081/repository/npm-private/"
        }
      }
    4.发布：
        npm install
        npm publish
    5.运行和使用：
        1.上传时上传到私有仓库，下载时去组合仓库下载（既可以下载中央仓库的，又可以下载私有仓库的）
            使用时，会出现 checking installable status，实际是去group检测是否有包，不是问题，但是会慢
            npm --registry http://118.25.13.144:8081/repository/npm-group/ install report-api
        2.当做成的是一个依赖时，引用到当前项目
            npm install report-api
        3.当做成了一个服务时，
            1.全局安装，使用package.json中的 bin下的命令可直接执行
                npm i -g report-api
                卸载全局
                npm uninstall -g report-api
                示例：
                    C:\Users\Administrator\xxx>npm i -g node-static-web
                    C:\Users\Administrator\xxx>node-static-web 【直接是启动命令，取自package.json中的bin下的内容】
            2.局部安装：示例
                C:\Users\Administrator\xxx>npm i  node-static-web
                C:\Users\Administrator\xxx>cd node_modules/.bin/
                C:\Users\Administrator\xxx\node_modules\.bin> node-static-web【直接是启动命令，取自package.json中的bin下的内容】
    6.删除：
        npm unpublish --force //强制删除
        npm unpublish guitest@1.0.1 //指定版本号
        npm deprecate //某些情况
        
    7.npm install report-api 时
        清理npm历史缓存：sudo npm cache clean
        更改npm仓库源为淘宝源：npm config set registry https://registry.npm.taobao.org
        验证一下结果和内容（这步可以不用做）：npm config get registry 或  npm info express
    
    8.注意，使用：
    
    
    
    

