

**1.windows下写的sh脚本，在linux下执行错误：**

    1.错误：syntax error near unexpected token '$'\r''
    2.原因：windows换行符格式和linux换行格式不兼容
    2.解决：
        [root@centos shell-sh]# cat -v testhost.sh 
        #! /bin/sh^M
        # M-dM-8M-^JM-iM-^]M-"M-iM-^BM-#M-hM-!M-^LM-fM-3M-(M-iM-^GM-^JM-eM-?M-^EM-iM-!M-;M-iM-!M-6M-hM-!M-^LM-eM-^FM-^Y M-fM-^HM-^VM-hM-^@M-^E #! /bin/bash^M
        # M-fM-5M-^KM-hM-/M-^UM-dM-8M-;M-fM-^\M-:M-fM-^XM-/M-eM-^PM-&M-eM-^\M-(M-gM-:M-?^M
        # chmod +x testhost.sh^M
        # ./testhost.sh^M
        for i in $(seq 2 254)^M
        do^M
          ping -c1 -w1 192.168.0."$i" > /dev/null 2>&1^M
          #-cM-eM-^OM-/M-dM-;M-%M-fM-^LM-^GM-eM-.M-^ZpingM-gM-^ZM-^DM-fM-,M-!M-fM-^UM-0M-oM-<M-^L-wM-fM-5M-^KM-hM-/M-^UM-gM-^ZM-^DM-fM-^WM-6M-iM-^WM-4 -w 1M-eM-0M-1M-fM-^XM-/1M-gM-'M-^RM-dM-8M--M-fM-^WM- M-hM-.M-:M-fM-^HM-^PM-eM-^JM-^_M-eM-$M-1M-hM-4M-%M-iM-^CM-=M-gM-;M-^SM-fM-^]M-^_^M
          #-c -wM-eM-^PM-^NM-iM-^]M-"M-iM-^CM-=M-hM-&M-^AM-hM->M-^SM-eM-^EM-%M-eM-^OM-^BM-fM-^UM-0M-fM-^IM-^@M-dM-;M-%M-iM-^CM-=M-hM-&M-^AM-eM-8M-&M-dM-8M-^Jl^M
          #$?M-dM-;M-#M-hM-!M-(M-fM-^\M-^@M-eM-^PM-^NM-eM-^QM-=M-dM-;M-$M-iM-^@M-^@M-eM-^GM-:M-gM-^JM-6M-fM-^@M-^AM-oM-<M-^L0M-dM-;M-#M-hM-!M-(M-fM-2M-!M-iM-^TM-^YM-oM-<M-^LM-eM-^EM-6M-dM-;M-^VM-dM-;M-#M-hM-!M-(M-fM-^\M-^IM-iM-^TM-^Y^M
          [ $? -eq 0 ] && echo "192.168.0.$i IP is UP!" || echo "192.168.0.$i IP is down!"^M
        done^M
        [root@centos shell-sh]# sed 's/\r//g' testhost.sh > testhost.sh 
        [root@centos shell-sh]# cat -v testhost.sh
        [root@centos shell-sh]#
    3.主要命令：将原文件进行格式转换为新文件
        sed 's/\r//g' testhost.sh > testhost.sh 
        
