
### NonNull 不常用-会自己处理

    这个注解用在方法上，可以将方法中的代码用try-catch语句包裹起来，捕获异常并在catch中用Lombok.sneakyThrow(e)把异常抛出，
    可以使用@SneakyThrows(Exception.class)的形式指定抛出哪种异常
    
**1.使用：**

    @SneakyThrows(UnsupportedEncodingException.class)
       public String utf8ToString(byte[] bytes) {
           return new String(bytes, "UTF-8");
       }
    编译后：
    @SneakyThrows(UnsupportedEncodingException.class)
       public String utf8ToString(byte[] bytes) {
           try{
               return new String(bytes, "UTF-8");
           }catch(UnsupportedEncodingException uee){
               throw Lombok.sneakyThrow(uee);
           }
       }




