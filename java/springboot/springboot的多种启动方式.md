

**1.打包测试：**

    --项目打包时会自动启动测试用例，并告知测试结果，故只需添加 mvn install 命令执行，便可全部进行测试
    --跳过单元测试进行打包命令：
            mvn clean package -Dmaven.test.skip=true
            mvn install -DskipTests

**2.mvn启动：**

    1.maven启动：
        mvn spring-boot:run
    2.java启动：指定外部配置文件
        java -jar -Dspring.config.location=application.yml  xxxx.war
        解释：
            命令里面的application.yml 在这个xxx.war 同级目录下, 可以自己指定, 这样就可以使用外面的配置文件覆盖掉war包里面的配置文件了
    3.maven启动：指定内部配置文件
        application.properties中配有：spring.profiles.active=dev
        application-dev.properties 中配有：server.port=8081
        application-prod.properties 中配有：server.port=8082
        命令：
        [Maven启动prod配置指定Profile通过-P]: -- 【好像不可以用】
            `mvn spring-boot:run -Pprod`，但这是Maven的Profile。
        [指定spring-boot的spring.profiles.active，则必须使用]：
            `mvn spring-boot:run -Drun.profiles=test`启动test配置   
    4.java启动：指定内部配置文件
        `java -jar -Dspring.profiles.active=test demo-0.0.1-SNAPSHOT.jar`启动test配置
        java -jar girl-0.0.1-SNAPSHOT.jar --spring.profiles.active=deve
    5.开发工具配置启动参数：
        `--spring.profiles.active=test`启动test配置
    
        
**3.指定端口：**
    
    mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=8999
