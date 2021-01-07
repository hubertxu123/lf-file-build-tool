
## 核心思想 cmd 转 exe

    借助一个工具(cmd to exe converter)，这个工具可以将bat文件打包成exe，并且可以设置该打包的文件隐身运行，那么这样就达到了我所需要的在后台运行的需求
        bat文件如果是ANSI格式的，引入到cmd to exe converter 中，中文可能乱码，因为cmd to exe converter 默认是UTF8编码
        cmd窗口默认不解析UTF8编码的中文，可以在bat文件中添加代码让cmd窗口解析UTF8编码
        chcp 65001

    里面先关掉之前的进程，再去调用，这样就保证了每次都只存在一个实例
    
    taskkill /f /t /im cgServer.exe
    start cgServer.exe
    
    
    
