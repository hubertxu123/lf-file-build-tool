

## 查看内存情况
    
    free -h
    free -m
    
## 查看内核日志

    dmesg

## 查看系统日志

    tail -n 1000 /var/log/messages

## linux查看文件大小：

    du -sh [文件名] 查看该文件大小，单位M
    du -sk [文件名] 查看该文件大小, 单位KB
    du -sh * | sort -n 统计当前文件夹(目录)大小，并按文件大小排序

## vim查看文件并定位字符串位置

    vim -n /var/log/secure
    打开文件：
        gg           ： 跳转到文件头
        Shift+g      ： 跳转到文件末尾
        行数+gg      ： 跳转到指定行，例跳转到123行：123gg
    搜索字符串：
        命令：/【搜索的字符串】
        回车,会有高亮显示
        此时,
        命令：n
        解释：上一个
        命令：shift+n
        解释：下一个
    示例：
        搜索：pam_unix(sshd:session): session opened for user root by (uid=0)
        表示：登录成功的记录
        同理：可以找出登录失败的记录，都是什么ip
       
## 查看软件日志
    
    tail:  
       -n  是显示行号；相当于nl命令；例子如下：
            tail -100f test.log      实时监控100行日志
            tail  -n  10  test.log   查询日志尾部最后10行的日志;
            tail -n +10 test.log    查询10行之后的所有日志;
    head:  
        跟tail是相反的，tail是看后多少行日志；例子如下：
            head -n 10  test.log   查询日志文件中的头10行日志;
            head -n -10  test.log   查询日志文件除了最后10行的其他所有日志;
    cat： 
        tac是倒序查看，是cat单词反写；例子如下：
            cat -n test.log |grep "debug"   查询关键字的日志
    2. 应用场景一：按行号查看---过滤出关键字附近的日志
         1）cat -n test.log |grep "debug"  得到关键日志的行号
         2）cat -n test.log |tail -n +92|head -n 20  选择关键字所在的中间一行. 然后查看这个关键字前10行和后10行的日志:
                tail -n +92表示查询92行之后的日志
                head -n 20 则表示在前面的查询结果里再查前20条记录
    3. 应用场景二：根据日期查询日志
          sed -n '/2014-12-17 16:17:20/,/2014-12-17 16:17:36/p'  test.log
          特别说明:上面的两个日期必须是日志中打印出来的日志,否则无效；
                          先 grep '2014-12-17 16:17:20' test.log 来确定日志中是否有该 时间点
    4.应用场景三：日志内容特别多，打印在屏幕上不方便查看
        (1)使用more和less命令,
               如： cat -n test.log |grep "debug" |more     这样就分页打印了,通过点击空格键翻页
        (2)使用 >xxx.txt 将其保存到文件中,到时可以拉下这个文件分析
               如：cat -n test.log |grep "debug"  >debug.txt        

