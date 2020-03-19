
### @Val 很强的类型推断 var注解，在Java10之后就不能使用了

    这个和Java10里的Var很像，强大的类型推断。并且不能使用在全局变量上，只能使用在局部变量的定义中。
    
**1.使用：**

    class Parent {
    
        //private static final val set = new HashSet<String>(); //编译不通过
    
        public static void main(String[] args) {
            val set = new HashSet<String>();
            set.add("aa");
            System.out.println(set); //[aa]
        }
    
    }

    编译后：
    
    class Parent {
        Parent() {
        }
    
        public static void main(String[] args) {
            HashSet<String> set = new HashSet();
            set.add("aa");
            System.out.println(set);
        }
    }






