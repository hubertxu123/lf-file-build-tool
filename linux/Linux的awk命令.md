
**1.awk命令格式:**

    awk '条件1 {动作 1} 条件 2 {动作 2} …' 文件名
    
**2.条件：**

    1.保留字：
        BEGIN：程序开始是执行一次
        END：程序结束时执行一次
    2.关系运算符：
        1.>,<,>=,<=,==,!=
        2.A~B   A是否包含B   
        3.A!~B  A不包含B 
    3.正则：/正则/    

**3.动作：**

    1.准备文件：student.txt
        ID Name PHP Linux MySQL Average
        1 Liming 82 95 86 87.66
        2 Sc 74 96 87 85.66
        3 Gao 99 83 93 91.66
    2.命令：cat student.txt
        注意：
            以下涉及的$0,1,2,3,4,5分别代表全部数据，第一列数据，第二列数据...
        ·awk '{printf $2 "\t" $6 "\n"}' student.txt
            无条件执行命令
            printf标准格式输出，默认不换行，所以尾部需要加\n手动换行，输出第二，第六列
            结果：
                Name	Average
                Liming	87.66
                Sc	85.66
                Gao	91.66
        ·awk '{print $2 "\t" $6}' student.txt
            print换行格式输出，所以可以去掉\n，但会结果同上
        ·df -h | awk '{print $1 "\t" $3}'
            换行输出第一第三列
        ·awk 'BEGIN{printf "This is a transcript\n"}{printf $2 "\t" $6 "\n"}' student.txt
            条件输出
            在输出第二，第六列之前先输出BEGIN打印的内容
        ·awk 'END{printf "The End \n"}{printf $2 "\t" $6 "\n"}' student.txt
            条件输出
            在输出第二，第六列之后输出END打印的内容
        ·cat student.txt | grep -v Name |awk'$6 >= 87 {printf $2'\n"}'
            grep -v Name    去除带Name的行
            awk'$6 >= 87    取出第六行大于87的数据
            {printf $2'\n"} 输出查询出数据的第二行
        ·awk'$2 -/Sc/ {printf $6 "\n"}' student.txt
            正则条件
            如果第二个字段中包含"Sc"字符，则打印第六个字段
        ·awk '/Liming/ {print}' student.txt
            正则
            打印Liming的成绩
        ·df -h | awk '/sda[0-9]/ {printf $1 '\t\ $5 "\n"}'
            当使用 df 命令査看分区的使用情况时，如果我只想査看真正的系统分区的使用情况，而不想査看光盘和临时分区的使用情况，则可以这样做：
            #查询包含"sda数字"的行，并打印第一个字段和第五个字段
        ·fdisk -l
            磁盘分区情况查看
        ·df -h /usr
            查看当前目录下的分区情况-可查看根分区
        ·awk 'NR==2{php1 =$3}NR==3{php2=$3}NR==4{php3= $3;totle=php1+php2+php3;print "totle php is" totle}' student.txt
            统计php总分：变量申明
            NR==2{php1 =$3}:如果输入数据是第二行（第一行是标题行），就把第二行的第三个字段的值赋予变量"php1"
            NR==3{php2 =$3}:如果输入数据是第三行（第一行是标题行），就把第三行的第三个字段的值赋予变量"php2"
            ...
            申明变量total并输出
        ·在awk编程中，因为命令语句非常长，所以在输入格式时需要注意以下内容：
             多个条件{动作}可以用空格分隔，也可以用回车分隔。
             在一个动作中，如果需要执行多条命令，则需要用分隔，或用回车分隔。
             在awk中，变量的赋值与调用都不需要加入"$"符号。
             在条件中判断两个值是否相同，请使用"=="，以便和变量赋值进行区分
        ·awk'{if (NR>=2){if ($4>90) printf $2" is a good man!\n"}}' student.txt
            从第二行开始                          if (NR>=2)
            第四列值大于90的数据，输出他的第二列   if ($4>90) printf $2" 
        ·awk' NR>=2 {test=$4}test>90 {printf $2" is a good man!\n"}' student.txt
            同上
       
****

    -F指定分隔符
    $1 指指定分隔符后，第一个字段，$3第三个字段， \t是制表符
    一个或多个连续的空格或制表符看做一个定界符，即多个空格看做一个空格
    awk -F":" '{print $1}'  /etc/passwd
    awk -F":" '{print $1 $3}'  /etc/passwd                       //$1与$3相连输出，不分隔
    awk -F":" '{print $1,$3}'  /etc/passwd                       //多了一个逗号，$1与$3使用空格分隔
    awk -F":" '{print $1 " " $3}'  /etc/passwd                  //$1与$3之间手动添加空格分隔
    awk -F":" '{print "Username:" $1 "\t\t Uid:" $3 }' /etc/passwd       //自定义输出  
    awk -F: '{print NF}' /etc/passwd                                //显示每行有多少字段
    awk -F: '{print $NF}' /etc/passwd                              //将每行第NF个字段的值打印出来
     awk -F: 'NF==4 {print }' /etc/passwd                       //显示只有4个字段的行
    awk -F: 'NF>2{print $0}' /etc/passwd                       //显示每行字段数量大于2的行
    awk '{print NR,$0}' /etc/passwd                                 //输出每行的行号
    awk -F: '{print NR,NF,$NF,"\t",$0}' /etc/passwd      //依次打印行号，字段数，最后字段值，制表符，每行内容
    awk -F: 'NR==5{print}'  /etc/passwd                         //显示第5行
    awk -F: 'NR==5 || NR==6{print}'  /etc/passwd       //显示第5行和第6行
    route -n|awk 'NR!=1{print}'                                       //不显示第一行
