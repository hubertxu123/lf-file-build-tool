

**1.安装包：严格安装菜鸟教程安装即可**

    1.百度网盘：
        ·20190811-soft/安装/2020vmware
        ·20190811-soft/linux镜像/
        ·备份好的centos-basic【centos7】
    2.安装教程：https://www.runoob.com/w3cnote/vmware-install-centos7.html
    3.centos下载地址：https://www.runoob.com/w3cnote/vmware-install-centos7.html
    
    
    阿里云站点：http://mirrors.aliyun.com/centos/7/isos/x86_64/
    每个链接都包括了镜像文件的地址、类型及版本号等信息
    选择当前国家资源区站点下载，获取资源速度比较快
    
    step1: 进入阿里云站点，选择 CentOS-7-x86_64-DVD-1804.iso下载
    
    各个版本的ISO镜像文件说明：
    CentOS-7-x86_64-DVD-1708.iso               标准安装版（推荐）
    CentOS-7-x86_64-Everything-1708.iso        完整版，集成所有软件（以用来补充系统的软件或者填充本地镜像）
    CentOS-7-x86_64-LiveGNOME-1708.iso         GNOME桌面版  
    CentOS-7-x86_64-LiveKDE-1708.iso           KDE桌面版  
    CentOS-7-x86_64-Minimal-1708.iso           精简版，自带的软件最少
    CentOS-7-x86_64-NetInstall-1708.iso        网络安装版（从网络安装或者救援系统）  
   
**2.VM中的虚拟机备份导出导入：**

    首先，选择我们需要进行导出的虚拟机，在左边的资源池中选择；【前提：必须关闭虚拟机】
    
    然后，点击上方菜单栏的“文件”，然后选择导出ovf；
    
    紧接着，我们指定我们要导出这个ovf文件的路径，然后点击保存，即可了
    
    当然，除此之外，我们还可以直接来到我们保存虚拟机的路径，把这个路径下的所有文件拷贝出来也可以；
    
    导入和恢复的方法，反过来就可以了，通过导入ovf文件或者在指定的路径打开虚拟机就可以了；
    
    好了，以上就是关于如何使用VMware导出和恢复虚的方法了

**3.重启错误：**

    1.今天在测试一台服务器，安装在虚拟机里面，但是发现在安装后，重启了一下电脑，出现了这个错误：
        【无法获取 vmci 驱动程序版本： 句柄无效。
          驱动程序 vmci.sys 版本不正确。请尝试重新安装 VMware Workstation。
          打开模块DevicePowerOn电源失败。】
               找了很多方法，最后找到了一个好的解决方法：
        1.别打开电源，然后到建好的虚拟机文件夹里，
        找到你的虚拟系统文件，后缀为vmx的文件，右击用记事本打开。
        2.搜索找到vmci0.present=‘TRUE’,字段，把true改为false。
        3.开启虚拟机发现可以使用了。
    2.vmware虚拟机提示：无法将Ethernet0连接到虚拟网络vmnet0：
        编辑——虚拟机网络编辑——还原虚拟机网络配置可以解决
    
    
**4.vm中的虚拟机设置静态ip：D:\git-20191022\buildTool\vm\静态ip设置\vm设置静态ip.docx**

    见文档，当设置完成后，即可通过xshell进行连接
    
**5.**
    
    
    
    
