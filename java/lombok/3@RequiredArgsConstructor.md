
### 部分参数构造方法：

    该注解会识别@nonNull字段，然后以该字段为元素产生一个构造函数。备注：如果所有字段都没有@nonNull注解，那效果同NoArgsConstructor

**1.示例1：**

    @RequiredArgsConstructor
    public class Demo {
        private final int finalVal = 10;
        @NonNull
        private String name;
        @NonNull
        private int age;
    }
    编译后：
    public class Demo {
        private final int finalVal = 10;
        @NonNull
        private String name;
        @NonNull
        private int age;
        public Demo(@NonNull String name, @NonNull int age) {
            if (name == null) {
                throw new NullPointerException("name is marked @NonNull but is null");
            } else {
                this.name = name;
                this.age = age;
            }
        }
    }
    结论1：
        该注解会识别@nonNull字段，然后以该字段为元素产生一个构造函数。备注：如果所有字段都没有@nonNull注解，那效果同NoArgsConstructor
        

