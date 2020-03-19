
### Cleanup 能够自动释放资源

    这个注解用在变量前面，可以保证此变量代表的资源会被自动关闭，默认是调用资源的close()方法。
    如果该资源有其它关闭方法，可使用@Cleanup(“methodName”)来指定要调用的方法，就用输入输出流来举个例子吧：
    
**1.示例1：**

    public static void main(String[] args) throws Exception {
            @Cleanup InputStream in = new FileInputStream(args[0]);
            @Cleanup OutputStream out = new FileOutputStream(args[1]);
            byte[] b = new byte[1024];
            while (true) {
                int r = in.read(b);
                if (r == -1) break;
                out.write(b, 0, r);
            }
        }
    编译后：
    public static void main(String[] args) throws Exception {
            FileInputStream in = new FileInputStream(args[0]);
    
            try {
                FileOutputStream out = new FileOutputStream(args[1]);
    
                try {
                    byte[] b = new byte[1024];
    
                    while(true) {
                        int r = in.read(b);
                        if (r == -1) {
                            return;
                        }
    
                        out.write(b, 0, r);
                    }
                } finally {
                    if (Collections.singletonList(out).get(0) != null) {
                        out.close();
                    }
    
                }
            } finally {
                if (Collections.singletonList(in).get(0) != null) {
                    in.close();
                }
    
            }
        }

    
