

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
