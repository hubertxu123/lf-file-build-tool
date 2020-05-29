
#来源：https://help.github.com/cn/packages/using-github-packages-with-your-projects-ecosystem/configuring-apache-maven-for-use-with-github-packages
#github帮助文档：https://help.github.com/cn/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line

###1.github包文档概述：
    
    1.使用github分享，存储，执行包
    2.概念：
        ·github包注册表：软件包托管服务，允许私下或公开托管软件包，并将包作用于项目中的依赖项【maven依赖】
        ·发布包：将jar发布发哦github包注册表，供他人使用下载
        ·安装包：从github包注册表安装包，并将包作用于自己项目中的依赖项

###2.发布和管理包

#####2.1github包注册表
    
    1.GitHub 包注册表 可用于 GitHub Free、GitHub Pro、组织的 GitHub Free、GitHub Team、GitHub Enterprise Cloud 和 GitHub One
    2.可以在一个仓库中托管多个包，并通过查看包的自述文件、下载统计、版本历史等，了解每个包的更多信息。
    3.可以将 GitHub 包注册表 与 GitHub API、GitHub 操作 以及 web 挂钩集成在一起，以创建端到端的 DevOps 工作流程，其中包括您的代码、CI 和部署解决方案  
    4.公有免费，私有收费
    5.支持的客户端和格式：
    
 包客户端	|语言	|包格式	|描述
 |----|----|---|---|
|npm 	|JavaScript     |package.json   |节点包管理器
|gem 	|Ruby	        |Gemfile	    |RubyGems包管理器
|mvn	|Java	        |pom.xml	    |Apache Maven 项目管理和理解工具
|gradle	|Java	        |build.gradle 或 build.gradle.kts	|Java 的 Gradle 构建自动化工具
|docker	|不适用	        |Dockerfile	    |Docker 容器管理平台
|dotnet CLI	|.NET	    |nupkg	        |.NET 的 NuGet 包管理

    6.令牌：有令牌才可以进行包管理
        1.个人访问令牌直接向 GitHub 包注册表 或 GitHub API 验证您的用户名
        2.可以使用 GITHUB_TOKEN 以通过 GitHub 操作 工作流程进行身份验证
        3.令牌权限分配：
            下载安装包：令牌必须具有 read:packages 作用域，并且您的用户帐户必须对该仓库具有读取权限。 如果是私有仓库，您的令牌还必须具有 repo 作用域
            GitHub 上删除私有包的特定版本，您的令牌必须具有 delete:packages 和 repo 作用域。 公共包无法删除
        4.权限作用域：
 作用域	        |Description	                    |仓库权限
|----|----|----|
|read:packages	|从 GitHub 包注册表 下载和安装包	|读取
|write:packages	|将包上传和发布到 GitHub 包注册表	|写入
|delete:packages|从 GitHub 包注册表 删除私有包的特定版本	|管理员
|repo	        |安装、上传和删除私有仓库中的某些包（对应 read:packages、write:packages 或 delete:packages）	|读取、写入或管理员            
        5.创建 GitHub 操作 工作流程时，您可以使用 GITHUB_TOKEN 发布和安装 GitHub 包注册表 中的包，无需存储和管理个人访问令牌
        6.在命令行或 API 上通过 HTTPS 执行 Git 操作时使用它代替密码
        7.作为安全预防措施，GitHub 会自动删除一年内未使用过的个人访问令牌。
    7.令牌创建：https://help.github.com/cn/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line
    8.令牌保管： 像对待密码一样对待您的令牌，确保其机密性。 使用 API 时，应将令牌用作环境变量，而不是将其硬编码到程序中。
    9.令牌使用：有令牌则在密码行输入令牌：
        $ git clone https://github.com/username/repo.git
        Username: your_username
        Password: your_token
        注意：个人访问令牌只能用于 HTTPS Git 操作。 如果您的仓库使用 SSH 远程 URL，则需要将远程 URL 从 SSH 切换到 HTTPS
    10.缓存的令牌过期和替换：https://help.github.com/cn/github/using-git/updating-credentials-from-the-osx-keychain
    
**3.发布：**

    找到你要发布的项目，在根目录下打包发布
    mvn install
    mvn deploy -Dregistry=https://maven.pkg.github.com/a982338665 -Dtoken=XXXXX
    修改本地仓库 .m2目录下的settings.xml,指定私库的账号密码
            <?xml version="1.0" encoding="UTF-8"?>
            <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
                      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                      xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
                <servers>
                  <server>
                     <id>github</id>
                     <username>a982338665</username>
                     <password>XXX</password>
                  </server>
                </servers>
            </settings>
    管理该项目的pom下添加：
        <distributionManagement>
                <repository>
                    <id>github</id>
        <!--            <name>pers.lish</name>-->
                    <url>https://maven.pkg.github.com/a982338665/customRPC</url>
                </repository>
            </distributionManagement>

        
        
        
