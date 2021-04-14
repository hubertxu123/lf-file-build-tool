

1.安装lombok插件
2.安装easycode代码生成插件
3.配置eclipse快捷键
4.安装javap等工具
    
    Settings =》 External Tools：
        在tool setting 的
            Program：输入工具的路径，这中间可以插入宏，比如【$JDK_PATH$\bin\javap.exe】，不需要自己再手动输入jdk的路径了，$JDK_PATH$要加到系统环境变量
            Parameters：中输入【-c $FileClass$】 ，$FileClass$代表要解析的 class文件,-c代表输出分解后的代码
            Workding：Directory中输入【$OutputPath$】,代表项目的输出路径
    使用：
        类 --> 右键External Tools --> javap
5.安装中文界面插件
    
    Chinese(Simplified) Language Pack EAP

6.安装zk插件：zookeeper
    
    配置好后在 settings ->  other settings下登录连接使用

7.p3c：阿里巴巴出品的代码规范扫描插件
8.GsonFormat：一键根据json文件生成java类 
9.Maven Helper：一键查看maven依赖，查看冲突
10.translate：翻译
11.Git Commit Template插件，提交代码规范问题
