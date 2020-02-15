
#参考博客：https://blog.csdn.net/beyondlpf/article/details/8065070

**1.命令解析：**

    kill -9 `ps -ef|grep cpu|grep -v grep|awk '{print $2}'`
    kiil -9后面``里面的内容表示参数输入，而ps -ef|grep cpu|grep -v grep|awk '{print $2}'的的效果需要说明Linux的一个原理
    管道符“|”用来隔开两个命令，管道符左边命令的输出会作为管道符右边命令的输入。
    那么这个命令行的解析如下：
    1、ps -ef 显示所有的进程，其中后面的e是显示结果的意思，f是显示完整格式，其他比如-w是不限制列宽显示，具体可见ps --help all
    2、ps -ef|grep cpu作用是把包括cpu这个关键字的进程都显示出来
    3、如2.1所示，ps -ef|grep cpu会把grep cpu的进程也统计进来，因此用ps -ef|grep cpu|grep -v grep去除grep进程
    4、最后，只包含cpu关键字的进程筛选结果作为输入给awk '{print $2}'，这个部分的作用是提取输入的第二列，而第二列正是进程的PID
