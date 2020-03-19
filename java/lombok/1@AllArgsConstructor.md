
### 包含所有参数的构造方法：

    1.可以指定生成的构造方法的访问权限，还可指定生成一个静态方法
    结论1：
            ·@AllArgsConstructor会生成所有参数的构造器，但会丢失无参构造函数
            ·final的属性值，是不会放进构造函数里面的
    结论2：
            ·@AllArgsConstructor(access = AccessLevel.PRIVATE)    --不生成静态方法
                指定生成的构造器的访问权限为private
            ·@AllArgsConstructor(access = AccessLevel.PROTECTED, staticName = "test") --生成静态方法
                若生成静态方法，会默认指定生成构造器的访问权限为private，
                并且生成一个静态方法，返回值为该构造器所创建出来的对象

**1.示例1：**

    @AllArgsConstructor
    public class Parent {
    	private final int finalVal = 10;
        private Integer id;
    }
    编译后：
    public class Parent {
    	private final int finalVal = 10;
        private Integer id;
        public Parent(Integer id) {
            this.id = id;
        }
    }
    结论1：
        ·@AllArgsConstructor会生成所有参数的构造器，但会丢失无参构造函数
        ·final的属性值，是不会放进构造函数里面的
        
**2.示例2：**

    @AllArgsConstructor(access = AccessLevel.PROTECTED, staticName = "test")
    public class Demo {
        private int age;
    }
    编译后：
    public class Demo {
        private int age;
        private Demo(int age) {
            this.age = age;
        }
        protected static Demo test(int age) {
            return new Demo(age);
        }
    }
    结论2：
        ·@AllArgsConstructor(access = AccessLevel.PRIVATE)    --不生成静态方法
            指定生成的构造器的访问权限为private
        ·@AllArgsConstructor(access = AccessLevel.PROTECTED, staticName = "test") --生成静态方法
            若生成静态方法，会默认指定生成构造器的访问权限为private，
            并且生成一个静态方法，返回值为该构造器所创建出来的对象
            

    
