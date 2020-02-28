
###1.业务场景：

    目的：通过接口调用重启项目,并重新编译java源文件，重新加载class

###2.代码实现：
####2.1准备代码重启工具类 (单例模式)
    
    package org.common.cutil;
    
    import lombok.Data;
    import org.springframework.context.ConfigurableApplicationContext;
    
    import java.io.File;
    import java.io.IOException;
    import java.util.concurrent.ArrayBlockingQueue;
    import java.util.concurrent.ExecutorService;
    import java.util.concurrent.ThreadPoolExecutor;
    import java.util.concurrent.TimeUnit;
    
    /**
     * 项目重启工具类
     */
    @Data
    public class RestartUtil1 {
    
        private static RestartUtil1 restartUtil = new RestartUtil1();
    
        private ConfigurableApplicationContext configurableApplicationContext;
        private Class start;
        private String[] args;
        private boolean isRestart = false;
    
        private RestartUtil1() {
        }
    
        public static RestartUtil1 getInstance() {
            return restartUtil;
        }
    
        public void restart() {
            ExecutorService threadPool = new ThreadPoolExecutor(1, 1, 0,
                    TimeUnit.SECONDS, new ArrayBlockingQueue<>(1), new ThreadPoolExecutor.DiscardOldestPolicy());
            threadPool.execute(() -> {
                //关闭服务，此种方式关闭服务不会释放内存，会导致内存不足
                while (configurableApplicationContext.isActive()) {
                    configurableApplicationContext.close();
                }
                System.err.println("程序已关闭...");
                try {
                    //关闭所有cmd
                    Process exec = Runtime.getRuntime().exec("taskkill /f /im cmd.exe");
                    while (exec.isAlive()) {
                        Thread.sleep(1000);
                        System.err.println("等待cmd关闭...");
                    }
                    //打开新窗口，在当前文件夹下，执行命令mvn
                    Runtime.getRuntime().exec("cmd  /c start mvn spring-boot:run", null, new File("./"));
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });
            threadPool.shutdown();
        }
    }

####2.2集成springboot（启动类）

    package org.jingniu;
    
    import org.common.cutil.RestartUtil;
    import org.springframework.boot.SpringApplication;
    import org.springframework.boot.autoconfigure.SpringBootApplication;
    import org.springframework.context.ConfigurableApplicationContext;
    import org.springframework.stereotype.Component;
    
    @SpringBootApplication()
    @Component
    public class ASeckillApplication1 {
    
        public static void main(String[] args) {
            ConfigurableApplicationContext run = SpringApplication.run(
                    ASeckillApplication1.class, args);
            //是否重启
            restart(args, run);
        }
        private static void restart(String[] args, ConfigurableApplicationContext run) {
            RestartUtil.getInstance().setArgs(args);
            RestartUtil.getInstance().setRestart(true);
            RestartUtil.getInstance().setConfigurableApplicationContext(run);
            RestartUtil.getInstance().setStart(ASeckillApplication1.class);
        }
    }
####2.3使用：
    
    package org.common.cweb;
    
    import org.common.cutil.RestartUtil;
    import org.common.cutil.Result;
    import org.springframework.stereotype.Controller;
    import org.springframework.web.bind.annotation.RequestMapping;
    import org.springframework.web.bind.annotation.RequestMethod;
    import org.springframework.web.bind.annotation.ResponseBody;
    
    @Controller
    @RequestMapping("/test")
    public class NBTestController1 {
    
        @RequestMapping(value = "/test", method = RequestMethod.POST)
        @ResponseBody
        public Result list() {
            RestartUtil instance = RestartUtil.getInstance();
            if (instance.getRestart()) instance.restart();
            return Result.success(0);
        }
    }
  
 
    
###final.开发中遇见的问题：
    
    1.项目被重启后，原来的内存未被释放，进程仍存在，导致java进程累积，致使内存不足
        问题代码：
            ExecutorService threadPool = new ThreadPoolExecutor(1, 1, 0,
                            TimeUnit.SECONDS, new ArrayBlockingQueue<>(1), new ThreadPoolExecutor.DiscardOldestPolicy());
                    threadPool.execute(() -> {
                        //关闭服务，此种方式关闭服务不会释放内存，会导致内存不足
                        while (configurableApplicationContext.isActive()){
                            configurableApplicationContext.close();
                        }
                        System.err.println("程序已关闭...");
                        //重新启动后，会发现原来的进程并未被kill
                        ConfigurableApplicationContext configurableApplicationContext2 = SpringApplication.run(start, args);
                        this.configurableApplicationContext = configurableApplicationContext2;
                    });
                    threadPool.shutdown();
