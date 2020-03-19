
### @ToString/@EqualsAndHashCode

    生成toString，equals和hashcode方法，同时后者还会生成一个canEqual方法，用于判断某个对象是否是当前类的实例
    @Generated：暂时貌似没什么用
    @Getter/@Setter
    这一对注解从名字上就很好理解，用在成员变量上面或者类上面，相当于为成员变量生成对应的get和set方法，同时还可以为生成的方法指定访问修饰符，当然，默认为public
    这两个注解直接用在类上，可以为此类里的所有非静态成员变量生成对应的get和set方法。如果是final变量，那就只会有get方法
    
**1.使用：**

    @ToString(
            includeFieldNames = true, //是否使用字段名
            exclude = {"name"}, //排除某些字段
            of = {"age"}, //只使用某些字段
            callSuper = true //是否让父类字段也参与 默认false
    )



