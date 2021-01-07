
## 1.核心目的
    
    不需要去安装node环境就可以直接打开使用
    
## 2.可选方案
### 2.1 Electron: (首选，前提是熟悉)
    
    它是目前使用 JavaScript，HTML 和 CSS 构建跨平台的桌面应用程序最常用的解决方案，但是要用它的话，就要遵循它的规范，说不定还要重构我的程序，
    且学习起来还是需要一些成本在里面的，基于这些情况，我把它抛弃了
        
### 2.2 pkg
    
    介绍：它的作用就是 打包node为可执行文件(.exe)的工具 
    使用：
        npm install -g pkg
        pkg server.js           
        pkg -t win server.js  //上面的命令会同时编译出 linux 、windows 、mac 版的 exe，加 -t win 就可以只编译 windows 下的
    编译完成后，会生成server.exe文件，双击该文件，浏览器访问http://localhost:8081即可
    
    报错：注意在编译的过程中（pkg -t win server.js）可能会出现报错的情况，如下
        > pkg@4.3.0
        > Fetching base Node.js binaries to PKG_CACHE_PATH
          fetched-v12.18.1-win-x64     [                    ] 0%
        > Error! connect ETIMEDOUT 13.229.188.59:443
        > Asset not found by direct link:
          {"tag":"v2.6","name":"uploaded-v2.6-node-v12.18.1-win-x64"}
        这是因为编译的时候要从github下载uploaded-v2.6-node-v12.18.1-win-x64包，由于下载不了导致的，
        这时我们可以先去github下载到这个包，放到当前用户下，如C:\Users\cheng\.pkg-cache\v2.6
        ,让包的名字改为 fetched-v12.18.1-win-x64 ，再次运行编译即可。
        要下载什么版本的包看自己的报错需要什么版本。
        github地址：https://github.com/vercel/pkg-fetch/releases
        正常下载网速很慢，推荐使用 IDM 进行下载
        注：pkg除了根据文件名打包，还可以根据package.json文件打包，要注意的是项目中引用文件的方式，pkg只会打包使用 require 或者 通过 __filename 和 __dirname 的文件
        这一篇我们讲了将nodejs打包成exe，但是不知道你们有没有注意到，我们上面的操作都只是为了启动nodejs的服务，但是要访问的话，还是需要在浏览器中访问，
        那么如果代码中用了es6的语法，是不是还要带个谷歌浏览器让其他要访问你页面的人安装呢，这是一个值得思考的问题，我们继续看下一篇
        
## 3.加浏览器外壳
    
    上面我们提到站点访问的问题，可能会说的比较极端，但是确实也是我当时在考虑的问题，那么这个要怎么解决呢。
    这次就不卖关子了，直接使用npm的easy-window包
    地址：https://gitee.com/zha2/easy-window
    可以直接下载，或者使用git克隆下来
    里面有一些案例感兴趣的可以看看
    我们所需要的是里面的 easy-window.exe 文件，将该文件拷贝到第二篇或者第三篇文件所在的目录中，比如我们用第二篇的目录为例，创建一个bat文件，内容如下
    start easy-window.exe -url http://localhost:3000/ -title "管理系统" -maxbox true -topmost true
    -url :要用的url地址
    -title ：标题
    -maxbox ：允许窗口最大化
    -topmost ：将窗口置顶
    运行后就可以弹出一个的窗口，我们上面输入的地址内容就在这个窗口里面运行，这就像是给我们的项目加了一个壳，让我们项目在我们给定的壳里运行，这个壳是一个精简版的浏览器
    需要注意的是easy-window里面运行传统的网页没问题，但是运行单页应用就会出问题。
    
## 4.总结
    
    如果需要继续进阶，可以考虑学习Electron、PyQt(用python写Qt)等桌面应用相关的知识。
    
