
## 1.安装docker版PostgreSQL
### 1.1拉取指定版本的PostgreSQL

    docker pull postgres:12.5

### 1.2创建PostgreSQL数据目录

    mkdir -p /usr/local/pgdata

### 1.3运行PostgreSQL

    docker run --name postgres -e POSTGRES_PASSWORD=123xxx56 \
     -p 5432:5432  -v /usr/local/pgdata:/var/lib/postgresql/data \
     -d postgres:12.5

### 1.4安装psql客户端

    wget https://download.postgresql.org/pub/repos/yum/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-3.noarch.rpm
    rpm -ivh pgdg-centos93-9.3-3.noarch.rpm
    yum install -y postgresql93

### 5. 使用psql客户端连接数据库
    
    psql -U postgres -d postgres -h 127.0.0.1 -p 5444
    Password for user postgres:
    psql (9.3.24)
    Type "help" for help.
 
### 更多的时候，我们希望能用图形界面来管理和操作数据库，可以部署pgadmin工具（例如下面），然后在浏览器中访问宿主机的5080端口，便能打开pgadmin。
    
    docker pull dpage/pgadmin4:4.17
    docker run --name pgadmin -p 5080:80 \
        -e 'PGADMIN_DEFAULT_EMAIL=pekkle@abc.com' \
        -e 'PGADMIN_DEFAULT_PASSWORD=xxxxxx' \
        -e 'PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION=True' \
        -e 'PGADMIN_CONFIG_LOGIN_BANNER="Authorised users only!"' \
        -e 'PGADMIN_CONFIG_CONSOLE_LOG_LEVEL=10' \
        -d dpage/pgadmin4:4.17

### 查看慢sql

    有几种情况  
    1. 查看历史慢SQL  
    首先要设置log_min_duration_statement，记录慢SQL。  
    然后在参数log_directory 指定的目录中查看日志。  
        PostgreSQL 日志支持的输出格式有 stderr（默认）, csvlog , syslog
        一般的错误跟踪，只需在配置文件 【postgresql.conf】简单设置几个参数，当然还有错误级别等要设置。
        logging_collector = on
        log_destination = 'stderr'
        log_directory = 'log'
        log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
        SELECT name,setting,vartype,boot_val,reset_val FROM pg_settings 
        where name in('logging_collector','log_destination','log_directory','log_filename');
        默认的跟踪日志记录在 pgdate/log 中，如 /usr/local/pgsql/data/log 。
        其他几个重要参数说明：
        log_rotation_age = 1440                #minute,多长时间创建新的文件记录日志。0 表示禁扩展。
        log_rotation_size = 10240            #kb,文件多大后创建新的文件记录日志。0 表示禁扩展。
        log_truncate_on_rotation = on         #可重用同名日志文件
        当需要跟踪SQL语句或者慢语句，得需要设置以下参数：
        log_statement = all     #需设置跟踪所有语句，否则只能跟踪出错信息
        log_min_duration_statement = 5000    #milliseconds,记录执行5秒及以上的语句
        log_statement：
        设置跟踪的语句类型，有4种类型：none(默认), ddl, mod, all。跟踪所有语句时可设置为 "all"。
        log_min_duration_statement：
        跟踪慢查询语句，单位为毫秒。如设置 5000，表示日志将记录执行5秒以上的SQL语句。
        当 log_statement=all 和 log_min_duration_statement 同时设置时，将跟踪所有语句，忽略log_min_duration_statement 设置。所以需按情况设置其中一个或两个值。
    2. 查看当前慢SQL  
    例如查询执行时间超过1秒的SQL  
    select * from pg_stat_activity where state<>'idle' and now()-query_start > interval '1 s' order by query_start ; 
