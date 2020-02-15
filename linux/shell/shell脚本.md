
#参考菜鸟教程:http://www.runoob.com/linux/linux-shell-passing-arguments.html

**1.shell：**
    
    1.新建test.sh
        -----------------
        --1.执行器指定：
            #!/bin/bash             #!是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell。
        --2.输出文本：
            echo "Hello World !"    echo 命令用于向窗口输出文本
        -----------------
        --3.显式定义变量
            your_name="runoob.com"  
                -1.变量名不加美元符号
                -2.变量名和等号之间不能有空格
                -3.命名只能使用英文字母，数字和下划线，首个字符不能以数字开头
                -4.不能使用bash里的关键字（可用help命令查看保留关键字）
        --4.隐式赋值定义变量
            for file in `ls /etc` 或 for file in $(ls /etc)  
                -1.隐式赋值
                -2.将 /etc 下目录的文件名循环出来。
        -----------------
        --5.使用$输出变量内容
            echo $your_name         使用$输出变量内容
        --6.使用${},加花括号是为了帮助解释器识别变量的边界
            echo ${your_name}       
                -1.例如:for skill in Ada Coffe Action Java; do
                       echo "I am good at ${skill}Script"
                   done
        -----------------
        --7.变量的重新赋值
            your_name="runoob.com"  
            your_name="alibaba"
        --8.只读变量申明
            myurl="www.baidu.com"
            readonly myurl
        --9.变量删除：不能删除只读变量
            unset variable_name
        -----------------
    2.添加执行权限
        chmod +x ./test.sh
    3.执行脚本
        ./test.sh   直接写test.sh，linux 系统会去PATH里寻找有没有叫test.sh的，
                    而只有 /bin, /sbin, /usr/bin，/usr/sbin 等在 PATH 里,所以无法找到，./表示当前路径下
        /bin/sh test.sh
                    此种执行方式不需要在文件开头指定#!/bin/bash解释器
    4.变量类型：
        --1.局部变量：脚本或命令中定义
        --2.环境变量：所有的程序，包括shell启动的程序，都能访问环境变
        --3.shell变量：shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量
    5.shell字符串：单双引号区别
        your_name="runoob"
        # 使用双引号拼接
        greeting="hello, "$your_name" !"    hello, runoob ! 
        greeting_1="hello, ${your_name} !"  hello, runoob !
        echo $greeting  $greeting_1
        # 使用单引号拼接
        greeting_2='hello, '$your_name' !'  hello, runoob ! 
        greeting_3='hello, ${your_name} !'  hello, ${your_name} !
        echo $greeting_2  $greeting_3
    6.获取字符串长度：
        string="abcd"
        echo ${#string} #输出 4
    7.字符串截取：
        string="runoob is a great site"
        echo ${string:1:4} # 输出 unoo
    8.字符串查找：查找字符 i 或 o 的位置(哪个字母先出现就计算哪个)：
        string="runoob is a great site" 注意： 以下脚本中 ` 是反引号，而不是单引号 '
        echo `expr index "$string" io`  # 输出 4 
    9.数组定义：bash支持一维数组（不支持多维数组），并且没有限定数组的大小。
        array_name=(1 2 3 4)    
        array_name[0]=0     数组赋值
        ${array_name[0]}    读取下标为零的数组值
        echo ${array_name[@]}   获取数组中所有元素
        echo ${#array_name[@]}  获取数组元素个数
        echo ${#array_name[*]}  获取数组元素个数
        echo ${#array_name[0]}  获取下标为0的元素的长度
    10.shell注释：
        单行：#
        多行：
            :<<EOF
            注释内容...
            注释内容...
            注释内容...
            EOF
            ——————————————
            :<<'
            注释内容...
            注释内容...
            注释内容...
            '
            :<<!
            注释内容...
            注释内容...
            注释内容...
            !
    11.shell参数传递：
        --1.编写脚本test.sh
            #!/bin/bash
            # author:菜鸟教程
            # url:www.runoob.com
            
            echo "Shell 传递参数实例！";
            echo "执行的文件名：$0";
            echo "第一个参数为：$1";
            echo "第二个参数为：$2";
            echo "第三个参数为：$3";
        --2.为脚本设置执行权限：
            chmod +x test.sh 
        --3.执行脚本
            ./test.sh 1 2 3
        --4.结果输出：
            Shell 传递参数实例！
            执行的文件名：./test.sh
            第一个参数为：1
            第二个参数为：2
            第三个参数为：3
        --5.获取的其他值：
            -1.$n   n为数字，表示获取的第几个参数，n==0时，获取执行文件名
            -2.$#   传递到脚本的参数个数
            -3.$*   列出$n的所有值，脚本中加""
            -4.$@   与$*使用一致
            -5.$$   脚本运行的当前进程id号
            -6.$!   后台运行的最后一个进程的id号
            -7.$-	显示Shell使用的当前选项，与set命令功能相同。
            -8.$?	显示最后命令的退出状态。0表示没有错误，其他任何值表明有错误。
            
        