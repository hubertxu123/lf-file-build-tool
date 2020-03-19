
### Data 组合包

    相当于注解集合。效果等同于**@Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsConstructor**
    @Value注解和@Data类似，区别在于它会把所有成员变量默认定义为private final修饰，并且不会生成set方法。
    所以@Value更适合只读性更强的类，所以特殊情况下，还是可以使用的。

