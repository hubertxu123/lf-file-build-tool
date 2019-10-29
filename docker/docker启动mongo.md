
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
