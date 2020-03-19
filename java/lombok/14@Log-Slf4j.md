
### @Slf4j 常用

    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LogExample.class);

**1.使用：**
    
    @Slf4j
    class Parent {
    }
    编译后：
    class Parent {
        private static final Logger log = LoggerFactory.getLogger(Parent.class);
    
        Parent() {
        }
    }
    
    
    @Slf4j
    @CommonsLog(topic = "commonLog")
    class Parent {
    }
    编译后：
    class Parent {
        private static final Logger log = LoggerFactory.getLogger("commonLog");
    
        Parent() {
        }
    }








