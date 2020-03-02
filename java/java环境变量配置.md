

**1.下载：**

    地址：https://www.oracle.com/technetwork/java/javase/downloads/index.html
    账号密码：Oracle公司：下载mysql，java等
    	982338665@qq.com
    	Li5201314
    
**2.配置：**
    
    JAVA_HOME   D:\install-soft\java8
    CLASSPATH   .;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\tools.jar
    Path        ;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;
    
**3.验证：**

    javac -version
    java -version
    
**4.设置环境变量注意：**

    1.windows10，设置要将用封号连接的条目，分为多部分分别录入，例如：-按条录入
        CLASSPATH： 
            %JAVA_HOME%\lib\dt.jar
            %JAVA_HOME%\lib\tools.jar
    2.windows7，直接将以上配置录入
