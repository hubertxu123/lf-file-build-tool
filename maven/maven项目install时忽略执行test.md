
## 1.在项目所在文件夹根目录使用maven命令打包时：

    <!-- 不执行单元测试，也不编译测试类 -->
    mvn install -Dmaven.test.skip=true
    或
    <!-- 不执行单元测试，但会编译测试类，并在target/test-classes目录下生成相应的class -->
    mvn install -DskipTests=true
## 2.springboot项目中，在pom.xml文件的中添加如下配置：
 
    <!-- 不执行单元测试，但会编译测试类，并在target/test-classes目录下生成相应的class -->
    <skipTests>true</skipTests> 	
    或
    <!-- 不执行单元测试，也不编译测试类 -->
    <maven.test.skip>true</maven.test.skip>
    
## 3.maven项目的pom.xml文件的中添加如下配置：

    <!-- 不执行单元测试，但会编译测试类并在target/test-classes目录下生成相应的class -->
    <plugin>  
        <groupId>org.apache.maven.plugins</groupId>  
        <artifactId>maven-surefire-plugin</artifactId>  
        <version>2.5</version>  
        <configuration>  
            <skipTests>true</skipTests>  
        </configuration>  
    </plugin>
