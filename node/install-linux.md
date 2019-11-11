

**1.linux安装nodejs：**

    mkdir /usr/local/nodejs
    cd /usr/local/nodejs
    wget https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz
    tar xvf node-v8.11.4-linux-x64.tar.xz
    mv node-v8.11.4-linux-x64 node-v8.11.4 
    ln -s /usr/local/nodejs/node-v8.11.4/bin/node /usr/bin/node
    ln -s /usr/local/nodejs/node-v8.11.4/bin/npm /usr/bin/npm
    node -v
    npm -v
    **********************************************************
    //软连接设置错误的删除方法：
    以上为例：ln -s /usr/local/nodejs/node-v8.11.4/bin/node /usr/bin/node
    cd /usr/bin/node
    rm -rf node
    //查看软连接：ls -il 或者 ls-L
    
