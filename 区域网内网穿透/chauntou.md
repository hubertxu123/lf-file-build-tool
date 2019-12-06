

**1.在本地调试代码常会用到内网穿透：**

    1.路由侠：下载安装使用
    
    2.使用命令行Localtunnel工具
      Localtunnel是一个可以让内网服务器暴露到公网上的开源项目，它可以通过NPM来全局安装：
      $ npm install localtunnel -g
      如果安装很慢，可以指定安装源：
      $ npm install localtunnel -g --registry=https://registry.npm.taobao.org
      安装完成后，调用以下命令来开启隧道服务：
      $ lt --port 8081
      tunnel server offline: connect ETIMEDOUT 138.197.63.247:80, retry 1s
      tunnel server offline: connect ETIMEDOUT 138.197.63.247:80, retry 1s
      tunnel server offline: connect ETIMEDOUT 138.197.63.247:80, retry 1s
      tunnel server offline: connect ETIMEDOUT 138.197.63.247:80, retry 1s
      your url is: https://gzpmrvqixf.localtunnel.me
      --port是指定本地web服务监听的端口，我这里是8081。
      你可能会遇上我上面的情况，就是隧道服务开启失败，此时别着急，等到它自动重新连接就好了。
      这时候我们就可以通过https://gzpmrvqixf.localtunnel.me公网的形式来访问本地的项目了。

    3.以上两种启动后可能访问不到：Invalid Host header
      这是最新webpack-dev-server做的安全防护
      可以如下 在package.json 文件中添加
      --disableHostCheck=true
      修改 跳过检查
      也可以加在命令中使用，例如启动angular：
      
      ng serve --disableHostCheck=true

      
      
