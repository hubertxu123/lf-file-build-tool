
### 常用地址：

> 官网地址：https://issues.sonatype.org  
> GPG环境下载地址：https://www.gnupg.org/download/  
> 查看上传的代码：https://oss.sonatype.org/#stagingRepositories  
> 参考地址：https://www.jianshu.com/p/354f66ed4f89  ，https://www.jianshu.com/p/eea4650b57cf  
> 查看发布成果[2小时左右]：https://search.maven.org/  
> 查看发布成果[几星期]：https://mvnrepository.com  
> 将快照工件部署到存储库：https://oss.sonatype.org/content/repositories/snapshots  
> 将发布工件部署到登台存储库：https://oss.sonatype.org/service/local/staging/deploy/maven2  

### 1.0 注册并且创建工单：
    
    0.官网地址：https://issues.sonatype.org
    1.groupId的审核，https://github.com/a982338665/lf-execl-easy时，建议写为com.github.a982338665保证唯一
    2.跟审核人员的不断沟通，按提醒完成相关操作，审核状态由OPEN -> Resolved
    
### 2.0 配置MVN的Settings.xml信息：conf/settings.xml的servers标签下

     <servers>
         <server>
             <id>oss</id>
             <username>用户名</username>
             <password>密码</password>
         </server>
     </servers>

### 3.0 配置项目下的pom.xml：配置代码发布器：
    
    <!-- pom.xml 中必须包括：name、description、url、licenses、developers、scm 等基本信息，使用了 Maven 的 profile 功能，
    <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    
        <modelVersion>4.0.0</modelVersion>
    
        <groupId>com.github.a982338665</groupId>
        <artifactId>lf-execl-easy</artifactId>
        <version>0.0.1-SNAPSHOT</version>
        <packaging>jar</packaging>
        <url>https://github.com/a982338665/lf-execl-easy</url>
        <name>lf-execl-easy</name>
        <description>excel 简易使用</description>
    
    
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            <java.version>1.8</java.version>
            <maven.compiler.source>1.8</maven.compiler.source>
            <maven.compiler.target>1.8</maven.compiler.target>
        </properties>
    
        <licenses>
            <license>
                <name>The Apache Software License, Version 2.0</name>
                <url>http://www.apache.org/licenses/LICENSE-2.0.txt</url>
            </license>
        </licenses>
    
        <build>
            <!--打包后的名称-->
            <finalName>${project.artifactId}</finalName>
            <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <configuration>
                        <source>1.8</source>
                        <target>1.8</target>
                    </configuration>
                </plugin>
                <!-- Source -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-source-plugin</artifactId>
                    <version>2.1</version>
                    <configuration>
                        <attach>true</attach>
                    </configuration>
                    <executions>
                        <execution>
                            <phase>compile</phase>
                            <goals>
                                <goal>jar</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
    
                <!-- Javadoc -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-javadoc-plugin</artifactId>
                    <version>2.1</version>
                    <configuration>
                        <show>private</show>
                        <nohelp>true</nohelp>
                        <charset>UTF-8</charset>
                        <encoding>UTF-8</encoding>
                        <docencoding>UTF-8</docencoding>
                    </configuration>
                    <executions>
                        <execution>
                            <phase>package</phase>
                            <goals>
                                <goal>jar</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
                <!-- GPG -->
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-gpg-plugin</artifactId>
                    <version>1.5</version>
                    <executions>
                        <execution>
                            <id>sign-artifacts</id>
                            <phase>verify</phase>
                            <goals>
                                <goal>sign</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
            </plugins>
    
        </build>
    
        <distributionManagement>
            <snapshotRepository>
                <id>oss</id>
                <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
            </snapshotRepository>
            <repository>
                <id>oss</id>
                <url>https://oss.sonatype.org/service/local/staging/deploy/maven2/</url>
            </repository>
        </distributionManagement>
    
        <!--    需要替换的内容-->
        <scm>
            <url>https://github.com/a982338665/lf-execl-easy</url>
            <connection>https://github.com/a982338665/lf-execl-easy.git</connection>
            <developerConnection>https://github.com/a982338665/lf-execl-easy</developerConnection>
        </scm>
        <developers>
            <developer>
                <name>luofeng</name>
                <email>982338665@qq.com</email>
                <url>https://github.com/a982338665/lf-execl-easy</url>
                <roles>
                    <role>developer</role>
                </roles>
            </developer>
        </developers>
    
    </project>

    
### 4.0 GPG环境，用来对上传的文件进行加密和签名，保证你的jar包不被篡改:
    
    1.下载地址：
        windows(二进制安装，安装后将可执行命令添加至系统环境变量中)：https://www.gpg4win.org/
        linux: https://www.gnupg.org/download/
    2.相关命令：
        ·安装是否成功： gpg –version 
        ·生成密钥对：gpg --gen-key
                    D:\install-soft\Gpg4win\bin>gpg --gen-key
                    gpg (GnuPG) 2.2.19; Copyright (C) 2019 Free Software Foundation, Inc.
                    This is free software: you are free to change and redistribute it.
                    There is NO WARRANTY, to the extent permitted by law.
                    
                    Note: Use "gpg --full-generate-key" for a full featured key generation dialog.
                    
                    GnuPG needs to construct a user ID to identify your key.
                    
                    Real name: a982338665
                    Email address: 982338665@qq.com
                    You selected this USER-ID:
                        "a982338665 <982338665@qq.com>"
                    
                    Change (N)ame, (E)mail, or (O)kay/(Q)uit? o
                    We need to generate a lot of random bytes. It is a good idea to perform
                    some other action (type on the keyboard, move the mouse, utilize the
                    disks) during the prime generation; this gives the random number
                    generator a better chance to gain enough entropy.
                    We need to generate a lot of random bytes. It is a good idea to perform
                    some other action (type on the keyboard, move the mouse, utilize the
                    disks) during the prime generation; this gives the random number
                    generator a better chance to gain enough entropy.
                    gpg: key 6A08A45BDF4C5202 marked as ultimately trusted
                    gpg: directory 'C:/Users/Administrator/AppData/Roaming/gnupg/openpgp-revocs.d' created
                    gpg: revocation certificate stored as 'C:/Users/Administrator/AppData/Roaming/gnupg/openpgp-revocs.d\29851CD296284B502C608DE06A08A45BDF4C5202.rev'
                    public and secret key created and signed.
                    
                    pub   rsa2048 2020-06-02 [SC] [expires: 2022-06-02]
                          29851CD296284B502C608DE06A08A45BDF4C5202
                    uid                      a982338665 <982338665@qq.com>
                    sub   rsa2048 2020-06-02 [E] [expires: 2022-06-02]
                    生成的时候会弹框要求输密码：打包上传的时候需要它，保存好【GPG密码】
                    以上完成后，【6A08A45BDF4C5202】就是申请的key
        ·查看公钥：gpg --list-keys
                    D:\install-soft\Gpg4win\bin>gpg --list-keys
                    C:/Users/Administrator/AppData/Roaming/gnupg/pubring.kbx
                    --------------------------------------------------------
                    pub   rsa2048 2020-06-02 [SC] [expires: 2022-06-02]
                          29851CD296284B502C608DE06A08A45BDF4C5202
                    uid           [ultimate] a982338665 <982338665@qq.com>
                    sub   rsa2048 2020-06-02 [E] [expires: 2022-06-02]
                    公钥为：【29851CD296284B502C608DE06A08A45BDF4C5202】
        ·将公钥发布到GPG密钥服务器-linux：将我们的公钥发布给官方，让其能够解析我们本地用私钥加密后的数据
            gpg --keyserver hkp://pool.sks-keyservers.net --send-keys 公钥ID
        ·将公钥发布到PGP密钥服务器-windows：gpg --keyserver hkp://keyserver.ubuntu.com:11371 --send-keys 5C1845F3
        ·查询公钥是否发布成功：
            gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 公钥ID

### 5.0 上传发布：上传一定不要点击idea的deploy按钮，因为deploy和maven-gpg-plugin结合的不是很好，那个gpg插件无法运行，一定要用客户端
    
    注意：第一次不能上传SNAPSHOT版本
    mvn clean deploy --settings /Users/zhouzhenyong/.m2/setting_maven_center.xml
    若settings已经配置好，则只需执行：
    mvn clean deploy
    命令之后会提示输入密码：上一步中的【GPG密码】
    
### 6.0 查看上传结果：

    地址：https://oss.sonatype.org/#stagingRepositories
    登陆：账号是我们注册的用户名和密码
    点击：左侧的“Staging Respositories（暂存仓库）”，然后在右上角输入groupId，就可以搜索
    然后close，然后release即可
    
### 7.0 推广您的第一个发行版时，请对此票发表评论，谢谢
        
    release之后：
        Although I have encountered some problems, finaly I have released my staging repo.The component has been successfully released，please confirm, thanks very much
        
### 8.0 查看中央仓库：

    当那边的工作人员审批完成之后，就可以将这个issue关闭了，一般过十分钟或者两个小时左右，我们就可以去
    中央仓库https://search.maven.org/中查看，应该就可以看到我们的这个项目了，对于更加
    流行的仓库https://mvnrepository.com，可能需要好几个星期之后才会看到，主要是同步慢。我这边是过了一天之后，这边就可以查看了
    
### 9.0 以后的发布：
    
    以后如果发布该项目，则直接maven发布即可，然后close，然后release即可。不用像上面一样创建issue了，
    如果发布的项目跟该项目group相同，则按照maven发布->close->release即可，如果不同则要开始注册issue了。
    不过对于每次发布都手动close和release有点麻烦的话，可以使用nexus-staging-maven-plugin这个插件，但是建议第一次不要使用该插件，
    手动执行是可以填写一些描述的，但是这个插件执行是不会有任何再输入的，而是一次性就执行完，最后等十几分钟就直接发到仓库中心了。
         
### 10.0 问题：
    
    1.无效的POM：/com/github/a982338665/lf-execl-easy/1.0.0-RELEASE/lf-execl-easy-1.0.0-RELEASE.pom：项目URL丢失 
        添加url
    2.没有公钥：ID为（6a08a45bdf4c5202）的密钥无法位于<a href="http://keyserver.ubuntu.com:11371/"> http://keyserver.ubuntu.com:11371/ < / a>。上载您的公钥，然后重试该操作。
        可能是因为 windows的缘故
        gpg --keyserver hkp://keyserver.ubuntu.com:11371 --send-keys 29851CD296284B502C608DE06A08A45BDF4C5202
        gpg --keyserver hkp://keyserver.ubuntu.com:11371 --recv-keys 29851CD296284B502C608DE06A08A45BDF4C5202
    3.com.github.a982338665已准备就绪，现在用户a982338665可以：
      将快照工件部署到存储库https://oss.sonatype.org/content/repositories/snapshots
      将发布工件部署到登台存储库https://oss.sonatype.org/service/local/staging/deploy/maven2
      将分阶段的工件释放到存储库“发布”中
      推广您的第一个发行版时，请对此票发表评论，谢谢
    4.发布成功，但是无法下载问题：
        检查pom.xml中是否有报错，修改后重新导入
    
    
    

