
**1.sed命令介绍：**

    1.作用：主要用脚本来处理文本文件
    2.使用：
        ·可依据脚本命令处理或编辑文本文件
        ·可同时处理多个文件，批量操作，进行程序转换等

**2.sed语法介绍：**

    sed [-hnV][-e<script>][-f<script文件>][文本文件]
    解释：
        1.参数说明：
            -e<script>或--expression=<script> 以选项中指定的script来处理输入的文本文件。
            -f<script文件>或--file=<script文件> 以选项中指定的script文件来处理输入的文本文件。
            -h或--help 显示帮助。
            -n或--quiet或--silent 仅显示script处理后的结果。
            -V或--version 显示版本信息。
        2.动作说明：
            a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)～
            c ：取代， c 的后面可以接字串，这些字串可以取代 n1,n2 之间的行！
            d ：删除，因为是删除啊，所以 d 后面通常不接任何咚咚；
            i ：插入， i 的后面可以接字串，而这些字串会在新的一行出现(目前的上一行)；
            p ：打印，亦即将某个选择的数据印出。通常 p 会与参数 sed -n 一起运行～
            s ：取代，可以直接进行取代的工作哩！通常这个 s 的动作可以搭配正规表示法！例如 1,20s/old/new/g 就是啦！

**3.示例：**

    1.在testfile文件的第四行后添加一行，并将结果输出到标准输出，在命令行提示符下输入如下命令：
        1.touch testfile      #里面的内容必须至少有四行，否则输出不了想要的结果
            错误示例：
                    1
                    2
                    3    
                sed -e 4a\newLine testfile 输出结果如下，此结果为标准输出并不会修改源文件
                    1
                    2
                    3
            正确示例：
                    1
                    2
                    3
                    4
                    5
                sed -e 4a\newLine testfile 输出结果如下，此结果为标准输出并不会修改源文件
                    1
                    2
                    3
                    4
                    newLine
                    5  
            想要将以下结果存到新文件则需要输出到文件：
                sed -e 4a\newLine testfile > testfile2
                cat testfile2
    2.将 /etc/passwd 的内容列出并且列印行号，同时，请将第 1~2 行删除，必须有单引号
        nl testfile | sed '1,2d'  #结果删除了前两行-注意没有修改源文件
        nl testfile | sed '2d'    #只删除第二行
        nl testfile | sed '3,$d'  #删除第三行到最后一行
        nl testfile | sed '3a ttt'#在第三行后加上ttt一行（行插入）
        nl testfile | sed '3i ttt'#在第三行前加上ttt一行-即第二行后加ttt
            [root@VM_0_4_centos sh]# nl testfile | sed '3a ttt or ......\    #添加多行数据，每行都要以\结尾，即回车继续命令
            > dierhan'
                 1	1
                 2	2
                 3	3
            ttt or ......
            dierhan
        nl testfile | sed '2,5c No 2-5 number' #将第2-5行的内容取代成为『No 2-5 number』
        nl testfile | sed -n '1,2p' #列出这个文件的1-2行
        nl testfile | sed '/2/p' #搜索有2关键字的行 输出所有行和匹配行
            1 1
            2 2
            2 2
            3 3
        nl testfile | sed -n '/2/p' #搜索有2关键字的行 仅输出匹配行
            2 2
        nl testfile | sed '/2/d' #搜索并删除有2关键字的行，输出其他行
        数据的搜寻并执行命令
            搜索/etc/passwd,找到root对应的行，执行后面花括号中的一组命令，每个命令之间用分号分隔，这里把bash替换为blueshell，再输出这行：
            nl /etc/passwd | sed -n '/root/{s/bash/blueshell/;p;q}'    
            1  root:x:0:0:root:/root:/bin/blueshell
            最后的q是退出。
        数据的搜寻并替换
            除了整行的处理模式之外， sed 还可以用行为单位进行部分数据的搜寻并取代。基本上 sed 的搜寻与替代的与 vi 相当的类似！他有点像这样：
            sed 's/要被取代的字串/新的字串/g'
        nl 文件名称：查看文件内容，带行号（第一列为行号），示例：-接上面
            nl testfile：
                1 1
                2 2
                3 3
                4 4 
                5 newLine
                6 5
                7 6

**3.查看并截取本机ip：**

    1.先观察原始信息，利用 /sbin/ifconfig 查询 IP
        [root@www ~]# /sbin/ifconfig eth0
        eth0 Link encap:Ethernet HWaddr 00:90:CC:A6:34:84
        inet addr:192.168.1.100 Bcast:192.168.1.255 Mask:255.255.255.0
        inet6 addr: fe80::290:ccff:fea6:3484/64 Scope:Link
        UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1
        .....(以下省略).....
        本机的ip是192.168.1.100。
    2.将 IP 前面的部分予以删除
        [root@www ~]# /sbin/ifconfig eth0 | grep 'inet addr' | sed 's/^.*addr://g'
        192.168.1.100 Bcast:192.168.1.255 Mask:255.255.255.0
        接下来则是删除后续的部分，亦即： 192.168.1.100 Bcast:192.168.1.255 Mask:255.255.255.0
    3.将 IP 后面的部分予以删除
        [root@www ~]# /sbin/ifconfig eth0 | grep 'inet addr' | sed 's/^.*addr://g' | sed 's/Bcast.*$//g'
        192.168.1.100

**4.多点编辑：**

    一条sed命令，删除/etc/passwd第三行到末尾的数据，并把bash替换为blueshell
    nl /etc/passwd | sed -e '3,$d' -e 's/bash/blueshell/'
    1  root:x:0:0:root:/root:/bin/blueshell
    2  daemon:x:1:1:daemon:/usr/sbin:/bin/sh
    -e表示多点编辑，第一个编辑命令删除/etc/passwd第三行到末尾的数据，第二条命令搜索bash替换为blueshell。

**5.sed直接修改文件：**

    sed 可以直接修改文件的内容，不必使用管道命令或数据流重导向！ 不过，由於这个动作会直接修改到原始的文件，所以请你千万不要随便拿系统配置来测试！ 
    我们还是使用文件 regular_express.txt 文件来测试看看吧！
    regular_express.txt 文件内容如下：
    [root@www ~]# cat regular_express.txt 
    runoob.
    google.
    taobao.
    facebook.
    zhihu-
    weibo-
    利用 sed 将 regular_express.txt 内每一行结尾若为 . 则换成 !
    [root@www ~]# sed -i 's/\.$/\!/g' regular_express.txt
    [root@www ~]# cat regular_express.txt 
    runoob!
    google!
    taobao!
    facebook!
    zhihu-
    weibo-:q:q
    利用 sed 直接在 regular_express.txt 最后一行加入 # This is a test:
    [root@www ~]# sed -i '$a # This is a test' regular_express.txt
    [root@www ~]# cat regular_express.txt 
    runoob!
    google!
    taobao!
    facebook!
    zhihu-
    weibo-
    # This is a test
    由於 $ 代表的是最后一行，而 a 的动作是新增，因此该文件最后新增 # This is a test！
    sed 的 -i 选项可以直接修改文件内容，这功能非常有帮助！举例来说，如果你有一个 100 万行的文件，你要在第 100 行加某些文字，
    此时使用 vim 可能会疯掉！因为文件太大了！那怎办？就利用 sed 啊！透过 sed 直接修改/取代的功能，你甚至不需要使用 vim 去修订！

**追加行说明：**

    追加行的说明：
    sed -e 4a\newline testfile
    a 动作是在匹配的行之后追加字符串，追加的字符串中可以包含换行符（实现追加多行的情况）。
    
    追加一行的话前后都不需要添加换行符 \n，只有追加多行时在行与行之间才需要添加换行符(最后一行最后也无需添加，添加的话会多出一个空行)。
    man sed 信息：
    Append text, which has each embedded newline preceded by a backslash.
    例如：
    
    4 行之后添加一行：
    sed -e '4 a newline' testfile
    4 行之后追加 2 行：
    sed -e '4 a newline\nnewline2' testfile
    4 行之后追加 3 行(2 行文字和 1 行空行)
    sed -e '4 a newline\nnewline2\n' testfile
    4 行之后追加 1 行空行：
    #错误：sed -e '4 a \n' testfile
    sed -e '4 a \ ' testfile 实际上
    实际上是插入了一个含有一个空格的行，插入一个完全为空的空行没有找到方法（不过应该没有这个需求吧，都要插入行了插入空行干嘛呢？）
    添加空行：
    # 可以添加一个完全为空的空行
    sed '4 a \\'
    # 可以添加两个完全为空的空行
    sed '4 a \\n'
