#! /bin/sh
# 上面那行注释必须顶行写 或者 #! /bin/bash
# 测试主机是否在线
# chmod +x testhost.sh
# chmod -R +x shell-sh/ 给该文件夹下所有文件添加执行权限
# ./testhost.sh & /后台执行任务返回当前任务pid
# ./testhost.sh
for i in $(seq 2 254)
do
  ping -c1 -w1 192.168.0."$i" > /dev/null 2>&1
  #-c可以指定ping的次数，-w测试的时间 -w 1就是1秒中无论成功失败都结束
  #-c -w后面都要输入参数所以都要带上l
  #$?代表最后命令退出状态，0代表没错，其他代表有错
  [ $? -eq 0 ] && echo "192.168.0.$i IP is UP!" >> ./up.log || echo "192.168.0.$i IP is down!" >> ./down.log
done
