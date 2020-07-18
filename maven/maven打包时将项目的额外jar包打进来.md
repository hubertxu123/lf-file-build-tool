
## 前言
>http://element-ui.cn/news/show-17222.aspx
>前言
> 在项目开发中，项目用maven管理，是一个maven项目。
> 一般情况下jar包都可以使用pom.xml来配置管理，但也有一些时候，我们项目中使用了一个内部jar文件，但是这个文件我们又没有开放到maven库中。
> 我们会将文件放到我们项目WEB-INF/lib中。如果是springboot项目放到resources/lib。
> 如果我们不对pom.xml进行特殊配置的话，maven打包是不会自动去引用和编译lib中的jar文件的，所以需要我们修改下pom.xml文件。导致的类找不到的问题


## 1.方法一：Maven提供了scope为system的依赖，我们可以在maven中进行如下配置
     
      <dependency>
          <groupId>com.jd.cps</groupId>
          <artifactId>jd-cps-client</artifactId>
          <version>2.2</version>
          <scope>system</scope>
          <systemPath>${project.basedir}/src/main/resources/lib/jd-cps-client-2.2.jar</systemPath>
      </dependency>

      这种方式在jar的个数较少时非常方便，但是一但jar多时就会显得很麻烦了。所以最好是能方便配置整个lib目录，让该目录下所有jar包都参与编译，方法二便可以解决这种需求。
      
## 2.在pom文件中配置maven-compiler-plugin，配置编译参数<compilerArguments>，添加extdirs将jar包相对路径添加到配置中，如下：
    
    <pluginManagement>
       <plugins>
           <plugin>
               <groupId>org.apache.maven.plugins</groupId>
               <artifactId>maven-compiler-plugin</artifactId>
               <version>3.1</version>
               <configuration>
                   <source>1.8</source>
                   <target>1.8</target>
                   <encoding>UTF-8</encoding>
                   <compilerArguments>
                       <extdirs>${project.basedir}/src/main/resources/lib</extdirs>
                   </compilerArguments>
               </configuration>
           </plugin>
       </plugins>
    </pluginManagement>

    需要注意一下，在maven3.1版本以后maven-compiler-plugin将compilerArguments定为过时了，如果使用的maven版本高于3.1，上述配置已被废弃，需要做如下修改：
    
    <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.1</version>
        <configuration>
            <source>1.8</source>
            <target>1.8</target>
            <encoding>UTF-8</encoding>
            <compilerArgs> 
                <arg>-verbose</arg>
                <arg>-Xlint:unchecked</arg>
                <arg>-Xlint:deprecation</arg>
                <arg>-extdirs</arg> 
                <arg>${project.basedir}/src/main/resources/lib</arg>
            </compilerArgs> 
        </configuration>
    </plugin>
    
    上面的配置是放在pom文件中的build元素内。${project.basedir}是pom文件的内置属性，指的是项目的的根录。
    其中${project.basedir}一定要写，不然会出现“在windows”下可以正常编译，在Linux服务器上就“有可能”出现编译找不到jar包的错误。
