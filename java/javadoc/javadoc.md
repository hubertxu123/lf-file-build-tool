#Maven在Java8下如何忽略Javadoc的编译错误详解

    JavaDoc简介And基础知识
    (一) Java注释类型
    //用于单行注释。
        /*...*/用于多行注释，从/*开始，到*/结束，不能嵌套。
        /**...*/则是为支持jdk工具javadoc.exe而特有的注释语句。
        说明：javadoc 工具能从java源文件中读取第三种注释，并能识别注释中用@标识的一些特殊变量（见表），制作成Html格式的类说明文档。javadoc不但能对一个 java源文件生成注释文档，而且能对目录和包生成交叉链接的html格式的类说明文档，十分方便。
    (二)JavaDoc中出现的@字符及其意义：
    1. 通用注释
    注释中可以出现的关键字以@开始
    意义
    @author
    作者名
    @version
    版本标识
    @since
    最早出现的JDK版本
    @deprecated
    引起不推荐使用的警告  
    @see
    交叉参考
    2. 方法注释
    @return
    返回值
    @throws
    异常类及抛出条件
    @param
    参数名及其意义
    引言
    
    好了，介绍完一些基本的知识，下面开始本文的正文。
    Java8对JavaDoc的语法检查非常严格，我在进行Maven编译发布项目到Maven Center的过程中，经常产生因为JavaDoc编译失败造成发布失败，但是很多情况下，都是一两个@param参数没有写全，@return没有写之类的问题，为此，我觉得非常有必要忽略这些异常。
    问题描述
    各位应该都知道发布一个Maven项目到Maven的中央仓库是必须要有JavaDoc，而我们在使用Maven JavaDoc plugin的过程中，一旦出现某些类似于此的问题：
    Failed to execute goal org.apache.maven.plugins:maven-javadoc-plugin:2.7:jar (attach-javadocs) on project [projectname]: MavenReportException: Error while creating archive:
    Exit code: 1 - [path-to-file]:[linenumber]: warning: no description for @param
    都会造成整个发布过程失败，解决办法一般是一个一个的把这些@param加上去，一两个还好，如果您的项目有成千上万个呢？
    
    解决办法
    直接修改Maven JavaDoc plugin的配置，忽略这些错误：
    
    <plugin>
     <groupId>org.apache.maven.plugins</groupId>
     <artifactId>maven-javadoc-plugin</artifactId>
     <version>2.10.3</version>
     <executions>
     <execution>
     <id>attach-javadocs</id>
     <goals>
     <goal>jar</goal>
     </goals>
     <configuration> 
     <additionalparam>-Xdoclint:none</additionalparam>
     </configuration>
     </execution>
     </executions>
    </plugin>
    经过测试，忽略后项目可以正常发布，不会有什么影响。
