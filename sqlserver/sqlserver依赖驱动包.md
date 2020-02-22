

百度网盘：20190811-soft/maven私服依赖

      <dependency>
            <groupId>com.microsoft.sqlserver</groupId>
            <artifactId>sqljdbc4</artifactId>
            <version>4.0</version>
        </dependency>
注意：从maven私服下载jar包失败，为了简便使用，可以先下载sqljdbc4.jar，然后用命令行切换到jar包所在路径，执行



mvn install:install-file -Dfile=sqljdbc4.jar -Dpackaging=jar -DgroupId=com.microsoft.sqlserver -DartifactId=sqljdbc4 -Dversion=4.0
