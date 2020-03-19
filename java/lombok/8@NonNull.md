
### NonNull

    参数的非空检查
    
**1.使用：**

    //成员方法参数加上@NonNull注解
    public String getName(@NonNull Person p){
        return p.getName();
    }
    编译后：
    public String getName(@NonNull Person p){
        if(p==null){
            throw new NullPointerException("person");
        }
        return p.getName();
    }



