

#sehll教程

**1.shell的基本介绍：**

    1.shell的定义：
        是一个用 C 语言编写的程序，它是用户使用 Linux 的桥梁。Shell 既是一种命令语言，又是一种程序设计语言。
        Shell 是指一种应用程序，这个应用程序提供了一个界面，用户通过这个界面访问操作系统内核的服务。
        Ken Thompson 的 sh 是第一种 Unix Shell，Windows Explorer 是一个典型的图形界面 Shell。
    2.shell脚本：shell script
        是一种为 shell 编写的脚本程序，以下皆为shell脚本编程，而非shell编程
    3.shell环境：
        ·Shell 编程跟 JavaScript、php 编程一样，只要有一个能编写代码的文本编辑器和一个能解释执行的脚本解释器就可以了。 
        ·Linux 的 Shell 种类众多，常见的有：
         Bourne Shell（/usr/bin/sh或/bin/sh）
         Bourne Again Shell（/bin/bash）
         C Shell（/usr/bin/csh）
         K Shell（/usr/bin/ksh）
         Shell for Root（/sbin/sh）
        ·常用的是Bash，也就是 Bourne Again Shell，由于易用和免费，Bash 在日常工作中被广泛使用。同时，Bash 也是大多数Linux 系统默认的 Shell。
         在一般情况下，人们并不区分 Bourne Shell 和 Bourne Again Shell，所以，像 #!/bin/sh，它同样也可以改为 #!/bin/bash。
         #! 告诉系统其后路径所指定的程序即是解释此脚本文件的 Shell 程序。

**2.简易shell脚本：**
    
    1.vim test.sh
        #!/bin/bash             #指定该脚本的解释器
        echo "Hello World !"    #控制台输出
    2.添加执行权限：
        chmod +x ./test.sh
    3.两种执行方法：
        ./test.sh
        /bin/sh ./test.sh
        
**2.shell变量：**

    1.变量赋值：
        1.显式赋值：
            yourname='lisheng'    --一次赋值
            yourname='lishenghh'  --二次赋值
        2.使用语句赋值：将 /etc 下目录的文件名循环出来。
            for file in `ls /etc`
            for file in $(ls /etc)
        3.使用变量：-->$符号仅用于变量使用
            echo $yourname
            echo ${yourname} 加花括号是为了帮助解释器识别变量的边界【建议使用】
    2.只读变量：尝试更改只读变量，结果报错：
        #!/bin/bash
        myUrl="http://www.google.com"
        readonly myUrl
        myUrl="http://www.runoob.com"
        运行结果：/bin/sh: NAME: This variable is read only.
    3.删除变量：【unset 命令不能删除只读变量】。
        unset variable_name
    4.变量类型：
        1.局部变量  脚本或命令中定义，当前shell有效
        2.环境变量  所有程序可访问，shell中也可以定义
        3.shell变量 shell程序设置的特殊变量，保证shell的正常运行
    
**3.shell字符串处理：**

    1.字符串拼接：
        your_name="runoob"
        # 使用双引号拼接
        greeting="hello, "$your_name" !"        hello, runoob !
        greeting_1="hello, ${your_name} !"      hello, runoob !
        echo $greeting  $greeting_1
        # 使用单引号拼接
        greeting_2='hello, '$your_name' !'      hello, runoob !
        greeting_3='hello, ${your_name} !'      hello, runoob ! hello, ${your_name} !
        echo $greeting_2  $greeting_3
    2.获取字符串长度：
        string="abcd"
        echo ${#string} #输出 4
    3.提取子字符串：第一个字符的索引值为 0。
        string="runoob is a great site"
        echo ${string:1:4} # 输出 unoo
    4.查找字符 i 或 o 的位置(哪个字母先出现就计算哪个)：
        string="runoob is a great site"
        echo `expr index "$string" io`  # 输出 4
        
 **4.shell数组：**
 
    1.定义：bash支持一维数组（不支持多维数组），并且没有限定数组的大小
    2.格式：数组名=(值1 值2 ... 值n)
    3.数组赋值：
        array_name=(value0 value1 value2 value3)
        array_name[n]=valuen    【可以不使用连续的下标，而且下标的范围没有限制。】
    4.数组读取：
        ${数组名[下标]}
        valuen=${array_name[n]}
        echo ${array_name[@]}   【使用 @ 符号可以获取数组中的所有元素】
    5.获取数组长度：
        # 取得数组元素的个数
        length=${#array_name[@]}
        # 或者
        length=${#array_name[*]}
        # 取得数组单个元素的长度
        lengthn=${#array_name[n]}
 
 **5.shell注释：**
 
    1.单行注释：#
    2.多行注释：
        :<<EOF
        注释内容...
        注释内容...
        注释内容...
        EOF
        EOF 也可以使用其他符号:
        :<<'
        注释内容...
        注释内容...
        注释内容...
        '
        或
        :<<!
        注释内容...
        注释内容...
        注释内容...
        !
 **6.shell参数传递：**
 
    1.举例脚本：test.sh $0代表执行文件名，$1,2,3分别代表传递参数
        #!/bin/bash
        # author:菜鸟教程
        # url:www.runoob.com
        echo "Shell 传递参数实例！";
        echo "执行的文件名：$0";
        echo "第一个参数为：$1";
        echo "第二个参数为：$2";
        echo "第三个参数为：$3";
        echo "传递参数总个数：$#";
        echo "以一个单字符串显示所有向脚本传递的参数：$*" #【不加引号，单个结果】;
        echo "显示所有向脚本传递的参数：$@" #【加引号,多个结果】;
        echo "脚本运行的当前进程ID号:$$";
        echo "后台运行的最后一个进程的ID号:$!";
        echo "脚本运行的当前进程ID号:$$";
        echo "显示Shell使用的当前选项，与set命令功能相同:$-";
        echo "显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误:$?";
    2.设置权限并执行：
        $ chmod +x test.sh 
        $ ./test.sh 1 2 3
        Shell 传递参数实例！
        执行的文件名：./test.sh
        第一个参数为：1
        第二个参数为：2
        第三个参数为：3

**7.shell基本运算符：**

    1.原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。
        expr 是一款表达式计算工具，使用它能完成表达式的求值操作，使用时用的是反引号【``】
    2.算术运算符：假定a=10，b=20
        1.脚本示例：
            val=`expr 2 + 2`#【注意 2 + 2 之间要有空格】
            echo "两数之和为 : $val"
        2.常用：注意：条件表达式要放在方括号之间，并且要有空格，例如: [$a==$b] 是错误的，必须写成 [ $a == $b ]。乘法需要加转义
            +	加法	`expr $a + $b` 结果为 30。
            -	减法	`expr $a - $b` 结果为 -10。
            *	乘法	`expr $a \* $b` 结果为  200。
            /	除法	`expr $b / $a` 结果为 2。
            %	取余	`expr $b % $a` 结果为 0。
            =	赋值	a=$b 将把变量 b 的值赋给 a。
            ==	相等。用于比较两个数字，相同则返回 true。	[ $a == $b ] 返回 false。
            !=	不相等。用于比较两个数字，不相同则返回 true。	[ $a != $b ] 返回 true。
    3.关系运算符：关系运算符支持数字，不支持全是数字的字符串，不支持非数字字符串。
        -eq	检测两个数是否相等，相等返回 true。	[ $a -eq $b ] 返回 false。
        -ne	检测两个数是否不相等，不相等返回 true。	[ $a -ne $b ] 返回 true。
        -gt	检测左边的数是否大于右边的，如果是，则返回 true。	[ $a -gt $b ] 返回 false。
        -lt	检测左边的数是否小于右边的，如果是，则返回 true。	[ $a -lt $b ] 返回 true。
        -ge	检测左边的数是否大于等于右边的，如果是，则返回 true。	[ $a -ge $b ] 返回 false。
        -le	检测左边的数是否小于等于右边的，如果是，则返回 true。	[ $a -le $b ] 返回 true。
    4.布尔运算符：
        下表列出了常用的布尔运算符，假定变量 a 为 10，变量 b 为 20：
        !	非运算，表达式为 true 则返回 false，否则返回 true。	[ ! false ] 返回 true。
        -o	或运算，有一个表达式为 true 则返回 true。	[ $a -lt 20 -o $b -gt 100 ] 返回 true。
        -a	与运算，两个表达式都为 true 才返回 true。	[ $a -lt 20 -a $b -gt 100 ] 返回 false。
    5.逻辑运算符
      以下介绍 Shell 的逻辑运算符，假定变量 a 为 10，变量 b 为 20:
      &&	逻辑的 AND	[[ $a -lt 100 && $b -gt 100 ]] 返回 false
      ||	逻辑的 OR	[[ $a -lt 100 || $b -gt 100 ]] 返回 true    
    6.字符串运算符
      下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：
      =	检测两个字符串是否相等，相等返回 true。	[ $a = $b ] 返回 false。
      !=	检测两个字符串是否相等，不相等返回 true。	[ $a != $b ] 返回 true。
      -z	检测字符串长度是否为0，为0返回 true。	[ -z $a ] 返回 false。
      -n	检测字符串长度是否为0，不为0返回 true。	[ -n "$a" ] 返回 true。
      $	检测字符串是否为空，不为空返回 true。	[ $a ] 返回 true。
    7.文件测试：
        #!/bin/bash
        # author:菜鸟教程
        # url:www.runoob.com
        
        file="/var/www/runoob/test.sh"
        if [ -r $file ]
        then
           echo "文件可读"
        else
           echo "文件不可读"
        fi
        if [ -w $file ]
        then
           echo "文件可写"
        else
           echo "文件不可写"
        fi
        if [ -x $file ]
        then
           echo "文件可执行"
        else
           echo "文件不可执行"
        fi
        if [ -f $file ]
        then
           echo "文件为普通文件"
        else
           echo "文件为特殊文件"
        fi
        if [ -d $file ]
        then
           echo "文件是个目录"
        else
           echo "文件不是个目录"
        fi
        if [ -s $file ]
        then
           echo "文件不为空"
        else
           echo "文件为空"
        fi
        if [ -e $file ]
        then
           echo "文件存在"
        else
           echo "文件不存在"
        fi
        
        
        执行脚本，输出结果如下所示：
        文件可读
        文件可写
        文件可执行
        文件为普通文件
        文件不是个目录
        文件不为空
        文件存在           

 **8.shell的echo命令：**
 
    1.显示普通字符串:
      echo "It is a test"
      这里的双引号完全可以省略，以下命令与上面实例效果一致：
      echo It is a test
    2.显示转义字符
      echo "\"It is a test\""
      结果将是:
      "It is a test"
      同样，双引号也可以省略
      echo \"It is a test\"
    3.显示变量
      read 命令从标准输入中读取一行,并把输入行的每个字段的值指定给 shell 变量
      #!/bin/sh
      read name 
      echo "$name It is a test"
      以上代码保存为 test.sh，name 接收标准输入的变量，结果将是:
      [root@www ~]# sh test.sh
      OK                     #标准输入
      OK It is a test        #输出
    4.显示换行:-e 开启转义
      echo -e "OK! \n" # -e 开启转义
      echo "It is a test"
      输出结果：
      OK!
      
      It is a test
    5.显示不换行
      #!/bin/sh
      echo -e "OK! \c" # -e 开启转义 \c 不换行
      echo "It is a test"
      输出结果：
      OK! It is a test
    6.显示结果定向至文件
      echo "It is a test" > myfile
    7.原样输出字符串，不进行转义或取变量(用单引号)
      echo '$name\"'
      输出结果：
      $name\"
    8.显示命令执行结果
      echo `date`
      注意： 这里使用的是反引号 `, 而不是单引号 '。
      结果将显示当前日期
      Thu Jul 24 10:08:46 CST 2014   

**9.shell流程控制：**

    1.if else语法格式：
        1.多行：
            if condition
            then
                command1 
            elif condition2 
            then 
                command2
            else
                commandN
            fi
        2.一行：
            if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true"; fi
    2.for循环：
        1.输出数字：
            for loop in 1 2 3 4 5
            do
                echo "The value is: $loop"
            done
            输出结果：
            The value is: 1
            The value is: 2
            The value is: 3
            The value is: 4
            The value is: 5    
        2.输出字符：
            for str in 'This is a string'
            do
                echo $str
            done
            输出结果：
            This is a string
    3.while循环：
        #!/bin/bash
        int=1
        while(( $int<=5 ))
        do
            echo $int
            let "int++"     #Bash let 命令，它用于执行一个或多个表达式，变量计算中不需要加上 $ 来表示变量
        done
        运行脚本，输出：
        
        1
        2
        3
        4
        5
    4.while循环可用于读取键盘信息：输入信息被设置为变量FILM，按<Ctrl-D>结束循环
        echo '按下 <CTRL-D> 退出'
        echo -n '输入你最喜欢的网站名: '
        while read FILM
        do
            echo "是的！$FILM 是一个好网站"
        done
        运行脚本，输出类似下面：
        按下 <CTRL-D> 退出
        输入你最喜欢的网站名:菜鸟教程
        是的！菜鸟教程 是一个好网站
    5.while无限循环：
        while :
        do
            command
        done
        或者
        while true
        do
            command
        done
        或者
        for (( ; ; ))
    6.until 循环：
        #!/bin/bash
        a=0
        until [ ! $a -lt 10 ]
        do
           echo $a
           a=`expr $a + 3`
        done
        输出：
        0
        3
        6
        9
    7.for循环：
        #!/bin/bash
        for((i=1;i<=5;i++));do
            echo "这是第 $i 次调用";
        done;
    8.case控制：
        echo '输入 1 到 4 之间的数字:'
        echo '你输入的数字为:'
        read aNum
        case $aNum in
            1)  echo '你选择了 1'
            ;;
            2)  echo '你选择了 2'
            ;;
            3)  echo '你选择了 3'
            ;;
            4)  echo '你选择了 4'
            ;;
            *)  echo '你没有输入 1 到 4 之间的数字'
            ;;
        esac
    9.break跳出循环：
        #!/bin/bash
        while :
        do
            echo -n "输入 1 到 5 之间的数字:"
            read aNum
            case $aNum in
                1|2|3|4|5) echo "你输入的数字为 $aNum!"
                ;;
                *) echo "你输入的数字不是 1 到 5 之间的! 游戏结束"
                    break
                ;;
            esac
        done
    10.continue进行下次循环：echo "游戏结束"这句代码永远不会被执行，【;;】被用来表示break
        #!/bin/bash
        while :
        do
            echo -n "输入 1 到 5 之间的数字: "
            read aNum
            case $aNum in
                1|2|3|4|5) echo "你输入的数字为 $aNum!"
                ;;
                *) echo "你输入的数字不是 1 到 5 之间的!"
                    continue
                    echo "游戏结束"
                ;;
            esac
        done
**10.shell函数：**

    1.说明：
        1、可以带function fun() 定义，也可以直接fun() 定义,不带任何参数。
        2、参数返回，可以显示加：return 返回，如果不加，将以最后一条命令运行结果，作为返回值。 return后跟数值n(0-255
    2.无返回函数：
        #!/bin/bash
        # author:菜鸟教程
        # url:www.runoob.com
        demoFun(){
            echo "这是我的第一个 shell 函数!"
        }
        echo "-----函数开始执行-----"
        demoFun
        echo "-----函数执行完毕-----"
    3.有返回函数：
        #!/bin/bash
        # author:菜鸟教程
        # url:www.runoob.com
        funWithReturn(){
            echo "这个函数会对输入的两个数字进行相加运算..."
            echo "输入第一个数字: "
            read aNum
            echo "输入第二个数字: "
            read anotherNum
            echo "两个数字分别为 $aNum 和 $anotherNum !"
            return $(($aNum+$anotherNum))
        }
        funWithReturn
        echo "输入的两个数字之和为 $? !"
        输出类似下面：
            这个函数会对输入的两个数字进行相加运算...
            输入第一个数字: 
            1
            输入第二个数字: 
            2
            两个数字分别为 1 和 2 !
            输入的两个数字之和为 3 !
    4.函数的参数传递：$10 不能获取第十个参数，获取第十个参数需要${10}。当n>=10时，需要使用${n}来获取参数。
        #!/bin/bash
        # author:菜鸟教程
        # url:www.runoob.com
        funWithParam(){
            echo "第一个参数为 $1 !"
            echo "第二个参数为 $2 !"
            echo "第十个参数为 $10 !"
            echo "第十个参数为 ${10} !"
            echo "第十一个参数为 ${11} !"
            echo "参数总数有 $# 个!"
            echo "作为一个字符串输出所有参数 $* !"
        }
        funWithParam 1 2 3 4 5 6 7 8 9 34 73

**11.shell文件包含：即文件脚本提取为单独文件**

    1.和其他语言一样，Shell 也可以包含外部脚本。这样可以很方便的封装一些公用的代码作为一个独立的文件。
    2.示例：
        创建两个 shell 脚本文件。
        test1.sh 代码如下：
            #!/bin/bash
            # author:菜鸟教程
            # url:www.runoob.com
            url="http://www.runoob.com"
        test2.sh 代码如下：
            #!/bin/bash
            # author:菜鸟教程
            # url:www.runoob.com
            #使用 . 号来引用test1.sh 文件
            . ./test1.sh
            # 或者使用以下包含文件代码
            # source ./test1.sh
            echo "菜鸟教程官网地址：$url"
        接下来，我们为 test2.sh 添加可执行权限并执行：
        $ chmod +x test2.sh 
        $ ./test2.sh 

