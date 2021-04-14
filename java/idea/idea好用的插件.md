

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
    
    1. Header
        Header的部分只有一行,包括三个字段: type(必需), scope(可选), subject(必需)
    对应到idea插件上图的配置分别为 Header部分的:
        type(必需)	Type of change	commit类别
        scope(可选)	Scope of this change	commint影响的范围
        subject(必需)	Short description	简短的描述
    (1)type用于说明 commit 的类别，只允许使用下面7个标识
        feat：新功能（feature）
        fix：修补bug
        docs：文档（documentation）
        style： 格式（不影响代码运行的变动,空格,格式化,等等）
        refactor：重构（即不是新增功能，也不是修改bug的代码变动）
        perf: 性能 (提高代码性能的改变)
        test：增加测试或者修改测试
        build: 影响构建系统或外部依赖项的更改(maven,gradle,npm 等等)
        ci: 对CI配置文件和脚本的更改
        chore：对非 src 和 test 目录的修改
        revert: Revert a commit
    (2) scope
        scope用于说明 commit 影响的范围，比如数据层、控制层、视图层等等，视项目不同而不同。
    (3) subject
        subject是 commit 目的的简短描述，不超过50个字符。
    以动词开头，使用第一人称现在时，比如change，而不是changed或changes
    第一个字母小写
    结尾不加句号（.）
    2. Body
    Body 部分是对本次 commit 的详细描述，可以分成多行。下面是一个范例。
    
    More detailed explanatory text, if necessary.  Wrap it to 
    about 72 characters or so. 
    
    Further paragraphs come after blank lines.
    
    - Bullet points are okay, too
    - Use a hanging indent
    有两个注意点。
    （1）使用第一人称现在时，比如使用change而不是changed或changes。
    （2）应该说明代码变动的动机，以及与以前行为的对比。
    3. Footer
      Footer 部分只用于两种情况。
    （1）不兼容变动
    如果当前代码与上一个版本不兼容，则 Footer 部分以BREAKING CHANGE开头，后面是对变动的描述、以及变动理由和迁移方法。
    BREAKING CHANGE: isolate scope bindings definition has changed.
     To migrate the code follow the example below:
     Before:
     scope: {
       myAttr: 'attribute',
     }
     After:
     scope: {
       myAttr: '@',
     }
     The removed `inject` wasn't generaly useful for directives so there should be no code using it.
    （2）关闭 Issue
        如果当前 commit 针对某个issue，那么可以在 Footer 部分关闭这个 issue 。
    
    Closes #234
    1
    也可以一次关闭多个 issue 。
    
    Closes #123, #245, #992
    1
    最后, 一个完整的commit message示例可能如下:
