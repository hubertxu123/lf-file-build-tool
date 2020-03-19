
### NonNull 不常用-会自己处理

    这个注解用在类方法或者实例方法上，效果和synchronized关键字相同，区别在于锁对象不同，对于类方法和实例方法，
    synchronized关键字的锁对象分别是类的class对象和this对象，而@Synchronized得锁对象分别是私有静态final对象LOCK和私有final对象lock，
    当然，也可以自己指定锁对象
    
**1.使用：**

    @Synchronized
        public static void hello() {
            System.out.println("world");
        }
    
        @Synchronized
        public int answerToLife() {
            return 42;
        }
    
        @Synchronized("readLock")
        public void foo() {
            System.out.println("bar");
        }

    编译后：
    
    public static void hello() {
            Object var0 = $LOCK;
            synchronized($LOCK) {
                System.out.println("world");
            }
        }
    
        public int answerToLife() {
            Object var1 = this.$lock;
            synchronized(this.$lock) {
                return 42;
            }
        }
    
        public void foo() {
            Object var1 = this.readLock;
            synchronized(this.readLock) {
                System.out.println("bar");
            }
        }





