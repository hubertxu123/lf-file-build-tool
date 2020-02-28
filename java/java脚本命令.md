

###1.基本命令：

    1.Windows+R：
        ·/c close   关闭
        ·/k keep    保持
        cmd /c echo name    在当前cmd窗口下，执行echo name，完成后关闭窗口，所以此命令闪一下即关闭
        cmd /k echo name    在当前cmd窗口下，执行echo name，完成后保持窗口，所以执行完此命令后的内容仍打印出来，且窗口保留
            name
            C:\Users\Administrator>
        cmd /c start echo name    --一个dos
            打开当前cmd，执行命令start echo name,执行完后，当前cmd关闭
            start echo name命令，打开新的cmd并执行命令echo name,此窗口会被保留，仅关闭第一个窗口
        cmd /k start echo name    --两个dos
            打开当前cmd，执行命令start echo name,执行完后，当前cmd保留
            start echo name命令，打开新的cmd并执行命令echo name,此窗口仍会被保留
        taskkill /f /im cmd.exe
            强制杀掉所有的cmd进程
        cmd  /c start mvn spring-boot:run
            新开一个窗口执行命令mvn spring-boot:run
    2.java程序：
        //关闭所有cmd
        Process exec = Runtime.getRuntime().exec("taskkill /f /im cmd.exe");
        while (exec.isAlive()){
            Thread.sleep(1000);
            System.err.println("等待cmd关闭...");
        }
        //打开新窗口，在当前文件夹下，执行命令mvn
        Runtime.getRuntime().exec("cmd  /c start mvn spring-boot:run", null, new File("./"));
