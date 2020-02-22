

###1.命令：
    
    docker run --restart always -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=YourStrongP@SSW0RD' -e 
    'MSSQL_PID=Developer' -p 1433:1433 --name SQL_CONTAINER -d microsoft/mssql-server-linux

###2.解释：
    
    --restart always -如果因为任何原因，CONTAINER被终止，这将自动重新启动它。
    
    -e 'ACCEPT_EULA=Y' 这是一个参数，提示您接受最终用户许可协议。如果您不同意，安装将不会继续。
    
    -e 'MSSQL_SA_PASSWORD=YourStrongP@SSW0RD' 一定要改变YourStrongP@SSW0RD 在此命令中为SA帐户选择密码。长度必须至少为8位，并且必须至少包含以下3个:大写(A-Z)、小写(A-Z)、数字(0-9)和/或特殊字符。
    
    -e 'MSSQL_PID=Developer'这是一个进入许可和产品密钥的参数。它可以和 Evaluation, Developer, Express, Web, Standard, Enterprise 或者 ##### - ##### - ##### - ##### - #####使用。(#是字母或数字)
    
    -p 1433:1433此参数指定端口转发。第一个1433指定要在外部使用的端口，第二个1433指定Docker中的端口。
    
    --name SQL_CONTAINER 指定CONTAINER的名称。
    
    -d microsoft/mssql-server-linux 一个CONTAINER的图像。如果没有指定，默认情况下，它将安装最新版本。

###3.使用命令：

    docker run  -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=AAAAXXXx123' -e  'MSSQL_PID=Developer' -p 1433:1433 --name sqlserver -d microsoft/mssql-server-linux
    docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=AAAAXXXx123' \
     -p 1433:1433 --name mssql -v /data:/var/opt/mssql \
     -d mcr.microsoft.com/mssql/server:2017-latest

    -e 'ACCEPT_EULA=Y'	设置此参数说明同意 SQL SERVER 使用条款 , 否则无法使用
    -e 'SA_PASSWORD=密码'	此处设置 SQL SERVER 数据库 SA 账号的密码
    -p 1433:1433	将宿主机 1433 端口映射到容器的 1433 端口
    --name mssql	设置容器名为 mssql
    -v /data:/var/opt/mssql	y将宿主机 /data 映射到容器 /var/opt/mssql , 方便备份数据
    生产环境配置建议
        服务器重启自动启动容器
            --restart=always
        必须设置路径映射或者创建数据卷

###4.登录连接测试：
    
    账号：SA
    密码：AAAAXXXx123

###5.运行状态：
    
    1.docker container ls --查看容器运行状态
    2.修改SA密码：
        sudo docker exec -it sql1 /opt/mssql-tools/bin/sqlcmd \
           -S localhost -U SA -P '旧密码' \
           -Q 'ALTER LOGIN SA WITH PASSWORD="新密码"'
    3.连接sqlserver：
        1.docker exec -it mssql bash    --进入容器内部
        2./opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '设置的sa密码' --登陆成功后会出现
            >1
    4.操作：
        创建数据库
            使用如下命令可以创建名为 TestDB 的数据库
            CREATE DATABASE TestDB
            下面命令查询所有的所有数据库名
            SELECT Name from sys.Databases
            上面两行命令输入后 , 实际没有立即执行 , 必须在下一行输入 GO , 将执行如上命令
            GO
        插入数据
            创建名为 Inventory 的表并插入两条数据
            选择数据库
            USE TestDB
            建表
            CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT)
            插入数据
            INSERT INTO Inventory VALUES (1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);
            执行命令
            GO
        查询数据
        
        通过 sqlcmd 输入如下命令查询所有数据
        
        SELECT * FROM Inventory
        执行
        
        GO
        退出 sqlcmd 命令行工具
        
        使用 QUIT 命令退出 sqlcmd
        
        
        QUIT
        
