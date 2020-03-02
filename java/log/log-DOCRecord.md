=========================================================================================

    Log4j由三个重要的组件构成：日志信息的优先级，日志信息的输出目的地，日志信息的输出格式。
    log4j.rootLogger=INFO, A1,...
        --INFO--指日志记录的优先级：Log4j建议只使用四个级别，优先级从高到低分别是ERROR、WARN、INFO、DEBUG
        --A1----就是指定日志信息输出到哪个地方。您可以同时指定多个输出目的地。 
    log4j.appender.A1=org.apache.log4j.ConsoleAppender 
        --org.apache.log4j.ConsoleAppender（控制台），
        --org.apache.log4j.FileAppender（文件）， 
        --org.apache.log4j.DailyRollingFileAppender（每天产生一个日志文件）， 
        --org.apache.log4j.RollingFileAppender（文件大小到达指定尺寸的时候产生一个新的文件）， 
        --org.apache.log4j.WriterAppender（将日志信息以流格式发送到任意指定的地方）
    log4j.appender.A1.Threshold=WARN
    log4j.appender.A1.ImmediateFlush=true
        --(1).ConsoleAppender,FileAppender,DailyRollingFileAppender,RollingFileAppender共有属性
            --Threshold=WARN:指定日志消息的输出最低层次。 
            --ImmediateFlush=true:默认值是true,意谓着所有的消息都会被立即输出。 
        --个性：
            --1.ConsoleAppender选项:
                --Target=System.err：默认情况下是：System.out,指定输出控制台 
            --2.FileAppender 选项:
                --File=mylog.txt:指定消息输出到mylog.txt文件。 
                --Append=false:默认值是true,即将消息增加到指定文件中，false指将消息覆盖指定的文件内容
            --3.DailyRollingFileAppender 选项 
                --File=mylog.txt:指定消息输出到mylog.txt文件。 
                --Append=false:默认值是true,即将消息增加到指定文件中，false指将消息覆盖指定的文件内容。 
                --DatePattern=’.'yyyy-ww:每周滚动一次文件，即每周产生一个新的文件。当然也可以指定按月、周、天、时和分。即对应的格式如下： 
                --  1)’.'yyyy-MM: 每月 
                --  2)’.'yyyy-ww: 每周 
                --  3)’.'yyyy-MM-dd: 每天 
                --  4)’.'yyyy-MM-dd-a: 每天两次 
                --  5)’.'yyyy-MM-dd-HH: 每小时 
                --  6)’.'yyyy-MM-dd-HH-mm: 每分钟 
            --4..RollingFileAppender 选项 
                --File=mylog.txt:指定消息输出到mylog.txt文件。 
                --Append=false:默认值是true,即将消息增加到指定文件中，false指将消息覆盖指定的文件内容。 
                --MaxFileSize=100KB: 后缀可以是KB, MB 或者是 GB. 在日志文件到达该大小时，将会自动滚动，即将原来的内容移到mylog.log.1文件。 
                --MaxBackupIndex=2:指定可以产生的滚动文件的最大数。 
    log4j.appender.A1.layout=org.apache.log4j.PatternLayout 
    log4j.appender.A1.layout.ConversionPattern=%-4r %-5p [%t] %37c %3x - %m%n 
        --日志的输出格式：
            --org.apache.log4j.HTMLLayout（以HTML表格形式布局）， 
            --org.apache.log4j.PatternLayout（可以灵活地指定布局模式）， 
            --org.apache.log4j.SimpleLayout（包含日志信息的级别和信息字符串）， 
            --org.apache.log4j.TTCCLayout（包含日志产生的时间、线程、类别等等信息） 
        --4、输出格式设置 
            --在配置文件中可以通过log4j.appender.A1.layout.ConversionPattern设置日志输出格式。 
            --参数： 
            --%p: 输出日志信息优先级，即DEBUG，INFO，WARN，ERROR，FATAL, 
            --%d: 输出日志时间点的日期或时间，默认格式为ISO8601，也可以在其后指定格式，比如：%d{yyy MMM dd HH:mm:ss,SSS}，输出类似：2002年10月18日 22：10：28，921 
            --%r: 输出自应用启动到输出该log信息耗费的毫秒数 
            --%c: 输出日志信息所属的类目，通常就是所在类的全名 
            --%t: 输出产生该日志事件的线程名 
            --%l: 输出日志事件的发生位置，相当于%C.%M(%F:%L)的组合,包括类目名、发生的线程，以及在代码中的行数。举例：Testlog4.main(TestLog4.java:10) 
            --%x: 输出和当前线程相关联的NDC(嵌套诊断环境),尤其用到像java servlets这样的多客户多线程的应用中。 
            --%%: 输出一个”%”字符 
            --%F: 输出日志消息产生时所在的文件名称 
            --%L: 输出代码中的行号 
            --%m: 输出代码中指定的消息,产生的日志具体信息 
            --%n: 输出一个回车换行符，Windows平台为”\r\n”，Unix平台为”\n”输出日志信息换行 
            --可以在%与模式字符之间加上修饰符来控制其最小宽度、最大宽度、和文本的对齐方式。如： 
            --1)%20c：指定输出category的名称，最小的宽度是20，如果category的名称小于20的话，默认的情况下右对齐。 
            --2)%-20c:指定输出category的名称，最小的宽度是20，如果category的名称小于20的话，”-”号指定左对齐。 
            --3)%.30c:指定输出category的名称，最大的宽度是30，如果category的名称大于30的话，就会将左边多出的字符截掉，但小于30的话也不会有空格。 
            --4)%20.30c:如果category的名称小于20就补空格，并且右对齐，如果其名称长于30字符，就从左边交远销出的字符截掉。
    ===============================================================================================
    --web项目Log4j日志输出路径配置问题：
        --问题描述：一个web项目想在一个tomcat下运行多个实例（通过修改war包名称的实现），然后每个实例都将日志输出到tomcat的logs目录下实例名命名的文件夹下进行区分查看每个实例日志，要求通过尽可能少的改动配置文件，最好修改实例名后可以不修改log4j的配置文件。
    实现分析：一般实现上面需求，需要在修改完war包名称之外要再做下面配置：
    1、修改每个实例名下web.xml中参数webAppRootKey为不同值。同一个tomcat下运行多个web应用时，该值相同的话，运行时会抛异常。
         <context-param>
            <param-name>webAppRootKey</param-name>
            <param-value>webApp.root</param-value>
        </context-param>
    2、log4j配置文件日志输出路径修改
         log4j配置文件中路径配置一般有三种方法：
    （1）绝对路径法：直接配置为系统觉得路径；
    （2）相对路径法：
                log4j.appender.logfile.File=../logs/app.log，将日志记录到tomcat下的logs文件夹；
                log4j.appender.logfile.File=logs/app.log，将日志记录到tomcat的bin目录下的logs文件夹；
    （3）使用环境变量相对路径法：程序会优先找jvm环境变量，然后再找系统环境变量，来查找配置文件中的变量。
            log4j.appender.logfile.File=${user.dir}/logs/app.log，使用tomcat容器时${user.dir}对应tomcat的bin目录；
            log4j.appender.logfile.File=${user.home}/logs/app.log，${user.home}对应操作系统当前用户目录；
            log4j.appender.logfile.File=${webApp.root}/logs/app.log，${webApp.root}对应当前应用根目录；
    
    暂时没找到不修改log4j配置而实现上面需求的方法。在log4j配置文件中可以获取环境变量来配置，但变量里没有当前应用的名称（不能直接通过webApp.root，因为它在不同的实例名称不一样），尝试在web.xml中增加listener，获取应用名称，然后调用System.setProperty("contextPath", sce.getServletContext().getContextPath());将上下文设置到系统变量中在log4j应用，但多实例运行时每个实例都会改变该属性值。
    结论，该问题的解决方法：
    1、手动修改配置，修改war名称后手动修改web.xml和log4j配置文件，实现上述需求。
    2、通过其它程序来进行批量修改，若bat或maven等在修改war包名称时，自动修改掉web.xml和log4j中相关配置。
    ===============================================================================================
    --方法一：直接在log4j配置中写绝对路劲
    --方法二：新建一个ServletContextListener的实现类Log4jConfigListener，Log4jConfigListener做：
        [java] view plain copy
            String path = Environment.class.getResource("").getPath();  
            String webAppPath = path.substring(0, path.toUpperCase().lastIndexOf("WEB-INF/")).replaceAll("%20", " ");  
            System.setProperty("webapp",webAppPath + "logs/log.log");  
        在log4j配置中：
        [plain] view plain copy
            log4j.appender.A2.File=${webapp}/logs/log.log  
    --方法三（跟Spring集成）：在web.xml中配置
    [html] view plain copy
            <context-param>  
                <param-name>webAppRootKey</param-name>    
                <param-value>webapp.root</param-value>    
            </context-param>   
            <context-param>  
                        <param-name>log4jConfigLocation</param-name>  
                        <param-value>/WEB-INF/config/log4j.properties</param-value>  
            </context-param>   
            <context-param>  
                        <param-name>log4jRefreshInterval</param-name>  
                        <param-value>6000</param-value>  
            </context-param>  
            <listener>  
                       <listener-class>org.springframework.web.util.Log4jConfigListener</listener-class>  
            </listener>  
            然后在log4j中用上述配置的webAppRootKey对应的值
            [plain] view plain copy
            log4j.appender.file.File=${webapp.root}/WEB-INF/logs/log.log  
            
            =================================================================
            
    log4j.appender.R=org.apache.log4j.RollingFileAppender 
    log4j.appender.R.File=c\://tsbonlinetraininglog/tsb_web_sns.html 
    #log4j.appender.R.File=../logs/TSB_SYSTEM_WEB.log
    log4j.appender.R.MaxFileSize=2000KB 
    log4j.appender.R.MaxBackupIndex=20 
    log4j.appender.R.layout=org.apache.log4j.FormatHTMLLayout
    #log4j.appender.R.layout=org.apache.log4j.HTMLLayout 
    #log4j.appender.R.layout=org.apache.log4j.PatternLayout 
    #log4j.appender.R.layout.ConversionPattern=%d{yyyy-MM-dd HH\:mm\:ss}-%m%n
    log4j.appender.R.layout.ConversionPattern=%-d{yyyy-MM-dd HH:mm:ss}-[%p] %m%n
