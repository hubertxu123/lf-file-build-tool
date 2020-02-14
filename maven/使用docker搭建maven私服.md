

**1.docker搭建Maven私服：**

    1.docker pull sonatype/nexus3
    2.docker run --rm -d --privileged=true -p 8081:8081 --name nexus -v /root/nexus-data:/var/nexus-data sonatype/nexus3
    3.docker ps --> 查看容器id
    4.docker exec -it 16038 bash    -->进入容器内部
    5.cd /opt/sonatype/sonatype-work/nexus3     获取登录密码
    6.vi admin.password
        c0e85657-0205-4b74-be36-7e5314362a2b
    7.登录后设置新密码：admin123

**2.仓库类型介绍：**
    
    1.proxy 远程仓库的代理，比如说nexus配置了一个central repository的proxy,当用户向这个proxy请求一个artifact的时候，
        会现在本地查找，如果找不到，则会从远程仓库下载，然后返回给用户。
    2.hosted 宿主仓库，用户可以把自己的一些仓库deploy到这个仓库中
    3.group 仓库组，是nexus特有的概念，目的是将多个仓库整合，对用户暴露统一的地址，这样就不需要配置多个仓库地址。
    
**3.登录后查看：**
    
    1.设置--Repositories：
        ·点击maven-central仓库 可以看到是一个proxy类型的仓库，他代理的远程仓库地址是https://repo1.maven.org/maven2/
        ·点击maven-public仓库 可以看到这是一个group类型的仓库，里面包含了maven-releases/maven-snapshots/maven-central仓库，
            意思是我们只需要在本地添加这个仓库，则可以依赖到上述3个仓库中的库了。
    2.使用：
        1.创建宿主仓库：创建仓库，点击Create repository,然后选择maven2(hosted)然后输入仓库名称（test-release）
        2.在version policy中选择这个仓库的类型，这里选择release,在Deployment policy中选择Allow redeploy（这个很重要）
        3.创建用户：点击左侧菜单栏的Users菜单，然后点击Create local user.我这里创建了一个用户，账号密码都是：admin
    3.修改本地仓库 .m2目录下的settings.xml,指定私库的账号密码
        <?xml version="1.0" encoding="UTF-8"?>
        <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
                  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
            <servers>
              <server>
                <id>admin </id>
                <username>admin</username>
                <password>admin</password>
              </server>
            </servers>
        </settings>
    4.修改项目的pom.xml
        <?xml version="1.0" encoding="UTF-8"?>
        <project xmlns="http://maven.apache.org/POM/4.0.0"
                 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
            <parent>
                <artifactId>dubbo</artifactId>
                <groupId>com.iti</groupId>
                <version>0.0.1-SNAPSHOT</version>
                <relativePath>../pom.xml</relativePath>
            </parent>
            <packaging>jar</packaging>
            <modelVersion>4.0.0</modelVersion>
        
            <artifactId>dubbo-api</artifactId>
        
            <!--注意限定版本一定为RELEASE,因为上传的对应仓库的存储类型为RELEASE-->
            <version>1.0-RELEASE</version>
            <!--指定仓库地址-->
            <distributionManagement>
                <repository>
                    <!--此名称要和.m2/settings.xml中设置的ID一致-->
                    <id>admin</id>
                    <url>http://172.21.13.229:8081/repository/test-release/</url>
                </repository>
            </distributionManagement>
        
            <build>
                <plugins>
                    <!--发布代码Jar插件-->
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-deploy-plugin</artifactId>
                        <version>2.7</version>
                    </plugin>
                    <!--发布源码插件-->
                    <plugin>
                        <groupId>org.apache.maven.plugins</groupId>
                        <artifactId>maven-source-plugin</artifactId>
                        <version>3.0.0</version>
                        <executions>
                            <execution>
                                <phase>package</phase>
                                <goals>
                                    <goal>jar</goal>
                                </goals>
                            </execution>
                        </executions>
                    </plugin>
                </plugins>
            </build>
        </project> 
    5.打包上传代码：
        mvn deploy
    6.依赖测试：依赖pom.xml修改
        <dependencies>
                <dependency>
                    <groupId>com.iti</groupId>
                    <artifactId>dubbo-api</artifactId>
                    <version>0.0.1-SNAPSHOT</version>
                </dependency>
                <dependency>
                    <groupId>com.iti</groupId>
                    <artifactId>dubbo-config</artifactId>
                    <version>0.0.1-SNAPSHOT</version>
                </dependency>
            </dependencies>
        
            <repositories>
                <repository>
                    <!--此名称要和.m2/settings.xml中设置的ID一致-->
                    <id>test</id>
                    <url>http://172.21.13.229:8081/repository/test-release/</url>
                </repository>
            </repositories>
        
