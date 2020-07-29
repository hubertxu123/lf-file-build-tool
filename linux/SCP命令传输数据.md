

## 1.命令介绍：类似CP命令
    
    scp file_name_to_copy username @ destination_host：destination_directory_path
    
    1.将一个文件从本地计算机复制到远程主机
        scp Hello.scp tuts@192.168.83.132:/home
        回车输入密码
    2.复制多文件:hello1,2,3
        scp Hello1 Hello2 Hello3 tuts@192.168.83.132:/home
    3.递归复制目录：
        scp -r FOSSTUTS tuts@192.168.83.132:/home
    4.复制文件且打印复制过程的日志    
        scp -v Hello1 Hello2 Hello3 tuts@192.168.83.132:/home
    5.在两个远程主机之间复制文件
        scp tuts@192.168.43.96:/home/Hello1 tuts@192.168.83.132:/home/Hello1
    6.压缩和复制文件:为了加快复制过程并节省带宽，可以使用-C参数压缩文件。数据将在本地计算机上即时压缩，并在远程主机上解压缩。请参见下面的语法。
        scp -vC Hello1 tuts@192.168.83.132:/home
    7.复制是指定带宽：将文件复制到远程主机可以解释为上载。如果上传带宽很高，则可能会影响在后台运行的其他进程。您可以使用-l参数限制在复制过程中使用的带宽。请参阅下面的命令。
        scp -l 100 Hello1 tuts@192.168.83.132:/home
        使用最大100Kb / s的速度进行复制过程
    8.使用自定义端口号:
        scp -P 22 Hello1 tuts@192.168.83.132:/home
    9.复制和保留文件属性:如果要复制文件并保留权限，修改时间，访问时间等属性，请在SCP命令中使用-p参数。请参阅下面的命令。
        scp -p Hello1 tuts@192.168.83.132:/home
    10.使用-q参数抑制SCP输出:假设您不想打印SCP输出，错误通知，警告甚至进度表。您可以使用-q参数来实现它，该参数禁止显示所有SCP输出。
        scp -q Hello1 tuts@192.168.83.132：/ home / tuts / FOSSLINUX
    11.使用SCP将文件从远程主机复制到本地计算机。
        scp tuts@192.168.83.132:/home/tuts/FOSSLINUX/serverFile.txt /home/tuts/FOSSLINUX
    12.复制文件和目录而不使用密码
        通过生成在身份验证过程中使用的SSH密钥来跳过密码输入步骤    
        ssh-keygen -t rsa               【系统应生成一个SSH密钥】
        ssh-copy-id root@192.168.4.200  【将密钥复制到我们的远程主机以用于身份验证】
        scp Hello1 tuts@192.168.83.132:/home 【可直接复制，不需要密码】
    13.SCP使用AES密码/加密来安全地复制文件。但是，可以使用-c参数指定其他密码方案。注意，c是小写字母，与压缩不同，其中c是大写字母。请参阅下面的命令。
        scp -c aes128-gcm@openssh.com TESTFILE tuts@192.168.83.132:/home    【AES加密】
        scp -c blowfish TESTFILE tuts@192.168.83.132:/home                  【河豚鱼】
    14.使用SSH密钥文件代替密码：SCP允许您使用-i参数和密钥文件来使用密钥文件而不是密码来完成身份验证过程。请参阅下面的命令。
        scp -c privateKey.pem TESTFILE tuts@192.168.83.132:/home
    15.使用SCP Shell脚本复制文件:假设您必须定期使用SCP命令，则可以编写一个Shell脚本来简化整个过程。在本文中，我们将编写一个脚本，该脚本从destfile.txt中读取目标主机。
        destfile.txt文件内容
            192.168.83.132  
        脚本文件：scp.sh
            echo "STARTING SCP SCRIPT"
            echo
            echo -e "Enter the path to the file you wish to copy:\c"
            read file
            for dest in `cat /tmp/destfile.txt`; do
            scp -rC $file ${dest}:/tmp/
            done          
        chmod 777 scp.sh
        ./scp.sh


    
        
       

        
        

    
        

 


            


        
      
        
        
              
    
    




    
