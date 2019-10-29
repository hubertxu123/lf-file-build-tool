
**1.docker安装mongo：**

    docker pull mongo
    docker run --name mongodb -p 27017:27017 -d mongo --auth
    docker exec -it 7c7815cc3e1e mongo admin    -- 为MongoDB添加管理员用户
    -- 为admin库添加管理员账号
    db.createUser({ user: 'root', pwd: 'root', roles: [ { role: "userAdminAnyDatabase", db: "admin" } ] });

    docker exec -it 7c7815cc3e1e mongo admin
    db.auth("root","root");
    db.createUser({ user: 'swen', pwd: 'swen123456', roles: [ { role: "readWrite", db: "app" } ] });
    
    以 admin 用户身份进入mongo ：
    docker exec -it 7c7815cc3e1e mongo admin
    对 swen 进行身份认证：
    db.auth("swen","swen123456");
    切换数据库
    use app
    添加数据
    db.test.save({name:"zhangsan"});

    //mongoose连接需要加参数 ?authSource=admin 校验认证信息
    mongoose.connect("mongodb://swen:swen123456@192.168.31.136:27017/app?authSource=admin",{useNewUrlParser:true}, (err) => {

**2.错误：**
    
    not authorized on admin to execute command
    解决：
        角色授权分两种，一种是直接在当前库中创建用户并授予相关权限。如admin库中创建admin用户。
        另一种情况是将在admin中创建的用户授予操作其他库的权限，相关授权命令如下：
        授予角色：
        db.grantRolesToUser("userName", [ { role:"<role>", db: "<database>"} ]) 
        取消角色：
        db.grantRolesToUser("userName", [ { role:"<role>", db:"<database>"} ]) 
        下面我们在admin库中执行以下命令：
        db.grantRolesToUser("admin", [ { role:"dbOwner", db:"test"} ]) ;
        ##admin  指的是用户名  test 指的要授权的数据库
