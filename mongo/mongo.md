# nosql


nosql-非关系型数据库



**mongodb:**

    1.key-value数据库：时间复杂度O(1)
        memcached
        redis
    2.文档数据库(mongodb)：存储的是文档-(Bson->json的二进制化后的对象)
        -1.内部引擎使用js解释器实现的，把文档存储成bson结构，查询时专转换为js对象，并且可以通过js来操作对象
    3.mongo和关系型数据库(mysql,oracle等)比较：
        -1.关系型数据库存储结构化数据，定好表结构，内容一定符合表结构
        -2.文档数据库：--存储bson，数据内容可不同，如下
            ·{id：3,name:list}
            ·{id：3,name:list,area:hubei}
            -以文档为单位，无结构，表下的每篇文档都有自己独特的结构和属性
        -3.以影评回复为例：
            -关系型数据库设计：
                -电影表
                -评论表
                -评论回复表
                -评论打分记录表
            -mongodb设计：等同于树，设计简单
                {film:'龙的传人',long:'120',comment[
                    {
                     content:'影评1...',
                        reply:['回复1','回复2']
                    },
                    {
                        ...
                    }
                ]}
            -类似于影评及回复的业务场景，可采用文档完成，反范式化

**mongodb的安装：**

    1.www.mongodb.org下载
    2.https://www.mongodb.com/download-center?jmp=nav#community
    3.以linux系统为例：https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-amazon2-4.0.0.tgz
          curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.6.tgz    # 下载
          tar -zxvf mongodb-linux-x86_64-3.0.6.tgz                                   # 解压
          mv  mongodb-linux-x86_64-3.0.6/ /usr/local/mongodb                         # 将解压包拷贝到指定目录
          export PATH=<mongodb-install-directory>/bin:$PATH
                #MongoDB 的可执行文件位于 bin 目录下，所以可以将其添加到 PATH 路径中：
                #<mongodb-install-directory> 为你 MongoDB 的安装路径。如本文的 /usr/local/mongodb
          mkdir -p /data/db
                #MongoDB的数据存储默认在data目录的db目录，需要手动创建
                #/data/db 是 MongoDB 默认的启动的数据库路径(--dbpath)
                #如果你的数据库目录不是/data/db，可以通过 --dbpath 来指定。如果你的数据库目录不是/data/db，可以通过 --dbpath 来指定
          ./bin/mongod
                #启动mongo服务端：默认端口 27017
          ./bin/mongod  --rest
                #启动mongo服务端web用户界面：默认端口 28017
                #访问地址：http://localhost:28017
                #MongoDB 的 Web 界面访问端口比服务的端口多1000
                 如果你的MongoDB运行端口使用默认的27017，你可以在端口号为28017访问web用户界面

          ./bin/mongo
                #启动mongo客户端连接：--
                ----------------------
                --简单计算：
                > 1+1
                2
                > 1*1
                1
                ----------------------
                --增加：
                > db.runoob.insert({x:10})
                WriteResult({ "nInserted" : 1 })
                --对插入的数据进行检索：
                > db.runoob.find()
                { "_id" : ObjectId("5b695077c39941e6f2e7f627"), "x" : 10 }
                ----------------------
                --显示所有数据库列表
                > show dbs
                local  0.078GB
                test   0.078GB
                --显示当前数据库对象
                > db
                test
                --切换数据库
                > use loacl
                switched to db loacl
                > db
                loacl
         4.以windows为例：
            1.下载位置：http://dl.mongodb.org/dl/win32/x86_64
            2.将下载文件放在指定文件夹： E:\SoftMgr\MongoDB\Server\data\db
            3.新建文件夹：E:\SoftMgr\MongoDB\Server\data\log
            4.在cmd 中找到log文件 执行 type nul>MongoDB.log
            5.注意：mongod  --logpath  "E:\SoftMgr\MongoDB\Server\data\log\MongoDB.txt"
              这边日志需要制定，不然日志文件不会有内容.
            6.在bin项目下执行：dir——》启动项目执行：mongod --dbpath E:\SoftMgr\MongoDB\Server\data\db
            7.打开http://localhost:27017验证

** mongo DB概念解析 **

    1.一些数据库名是保留的，可以直接访问这些有特殊作用的数据库。
        admin： 从权限的角度来看，这是"root"数据库。要是将一个用户添加到这个数据库，这个用户自动继承所有数据库的权限。一些特定的服务器端命令也只能从这个数据库运行，比如列出所有的数据库或者关闭服务器。
        local: 这个数据永远不会被复制，可以用来存储限于本地单台服务器的任意集合
        config: 当Mongo用于分片设置时，config数据库在内部使用，用于保存分片的相关信息
    2.关系型数据库和mongo的对应关系：
        表名-集合名
        表格-集合
        行  -文档
        列  -字段
        表联合-嵌入文档
        主键-主键（MongoDB 提供了 key 为 _id）
    3.注意及规范：
        1.文档中键值对是有序的
        2.值可为多种数据类型，包括文档类型
        3.区分类型和大小写
        4.不能有重复的键
        5.键是字符串（除少数例外情况，键可以使用任意utf8字符）
        6.键不能有空字符(因为空字符表示键的结尾)
        7.以下划线"_"开头的键是保留的(不是严格要求的)
    4.集合名命名规则：
        1.不能使空字符串
        2.不能含有空字符
        3.集合名不能以"system."开头，这是为系统集合保留的前缀
        4.不要在名字里出现$，除非你要访问这种系统创建的集合
    5,Capped collections 就是固定大小的collection：
        1.它有很高的性能以及队列过期的特性(过期按照插入的顺序). 有点和 "RRD" 概念类似。
        2.Capped collections是高性能自动的维护对象的插入顺序。它非常适合类似记录日志的功能
        3.必须要显式的创建一个capped collection， 指定一个collection的大小，单位是字节。collection的数据存储空间值提前分配的
        4.注意的是指定的存储大小包含了数据库的头信息
          db.createCollection("mycoll", {capped:true, size:100000})
        5.操作：
            在capped collection中，你能添加新的对象。
            能进行更新，然而，对象不会增加存储空间。如果增加，更新就会失败 。
            数据库不允许进行删除。使用drop()方法删除collection所有的行。
            注意: 删除之后，你必须显式的重新创建这个collection。
            在32bit机器中，capped collection最大存储为1e9( 1X109)个字节。
    6.MongoDB 数据类型：
        1.不用在文档内申明创建时间，因为文档本身就有创建时间
        2.MongoDB 中存储的文档必须有一个 _id 键。这个键的值可以是任何类型的，默认是个 ObjectId 对象
          由于 ObjectId 中保存了创建的时间戳，所以你不需要为你的文档保存时间戳字段，你可以通过 getTimestamp
          函数来获取文档的创建时间:
          > var newObject = ObjectId()
          > newObject.getTimestamp()
          ISODate("2017-11-25T07:21:10Z")
          ObjectId 转为字符串
          > newObject.str
          5a1919e63df83ce79df8b38f
        3.日期：
          表示当前距离 Unix新纪元（1970年1月1日）的毫秒数。日期类型是有符号的, 负数表示 1970 年之前的日期。
          ------------------------------------------
          > var mydate1 = new Date()     //格林尼治时间
          > mydate1
          ISODate("2018-03-04T14:58:51.233Z")
          > typeof mydate1
          object
          ------------------------------------------
          > var mydate2 = ISODate() //格林尼治时间
          > mydate2
          ISODate("2018-03-04T15:00:45.479Z")
          > typeof mydate2
          object
          这样创建的时间是日期类型，可以使用 JS 中的 Date 类型的方法。
           ------------------------------------------
          返回一个时间类型的字符串：
          > var mydate1str = mydate1.toString()
          > mydate1str
          Sun Mar 04 2018 14:58:51 GMT+0000 (UTC)
          > typeof mydate1str
          string
          或者
           ------------------------------------------
          > Date()
          Sun Mar 04 2018 15:02:59 GMT+0000 (UTC)

** mongo DB-常见操作 **

        ==================================================================================
        数据库操作++
        > use runoob        --创建或切换数据库，若数据库不存在则创建
        switched to db runoob
        > db                --查看当前数据库
        runoob
        > show dbs          --查看数据库列表，当runoob中未写入数据时，则不算在内
        test   0.000GB
        local   0.000GB
        > db.runoob.insert({"name":"--"})   --runoob数据库中插入数据
        WriteResult({ "nInserted" : 1 })
        > show dbs          --查看数据库列表
        local   0.078GB
        runoob  0.078GB
        test    0.078GB
        > db.dropDatabase() --删除当前数据库
        ==================================================================================
        集合(表操作)++
        ————————
        { "dropped" : "runoob", "ok" : 1 }
        > show tables       --展示当前数据库所有集合
        site
        > db.site.drop()    --删除集合
        true
        ————————
        > use test
        switched to db test
        > db.createCollection("runoob")     --创建runoob集合
        { "ok" : 1 }
        ————————
        > show collections  --展示已有集合
        runoob
        system.indexes
        ————————
        -capped : true      --创建固定集合，当达到最大值时，它会自动覆盖最早的文档。
                              当该值为 true 时，必须指定 size 参数
        -autoIndexId : true --自动在 _id 字段创建索引。默认为 false
        -注意：在插入文档时，MongoDB 首先检查固定集合的 size 字段，然后检查 max 字段
         创建 固定集合 mycol，整个集合空间大小 6142800 KB, 文档最大个数为 10000 个
        > db.createCollection("mycol", { capped : true, autoIndexId : true, size :
           6142800, max : 10000 } )
        { "ok" : 1 }
        ————————
        ==================================================================================
        文档数据操作++数据插入
        db.mycol2.insert({"name" : "教程"})   --mongo在插入文档时会自动创建集合
        ————————
        > db.col.insert({title:'教程1'})      --给集合插入数据
            WriteResult({ "nInserted" : 1 })
        > db.col.insert({title:'教程2'})
        > db.col.insert({title:'教程3'})
        > db.col.insert({title:'教程3'})
        > document=({title:'教程4'})          --申明变量
          {
            "title":"教程4"
          }
        >document
          {
             "title":"教程4"
          }
        >db.col.insert(document)              --插入变量数据insert
        >db.col.save(document)                --插入变量数据save
        ————————
        3.2版本后：支持多条插入
        >var document = db.collection.insertOne({"a": 3})
        >var res = db.collection.insertMany([{"b": 3}, {'c': 4}])
        ==================================================================================
        文档数据操作++数据(文档)更新：
        db.collection.update(
           <query>,     --update的查询条件，类似sql update查询内where后面的
           <update>,    --update的对象和一些更新的操作符（如$,$inc...）等，也可以理解为sql update查询内set后面的
           {
             upsert: <boolean>,         --如果不存在update的记录，是否插入objNew,true为插入，默认是false，不插入
             multi: <boolean>,          --mongodb 默认是false,只更新找到的第一条记录，这个参数为true,就把按条件查出来多条记录全部更新
             writeConcern: <document>   --抛出异常的级别
           }
        )
        > db.col.update({title:'教程'},{"title":"lisheng----"},{})
        > db.col.save({"_id" : ObjectId("56064f89ade2f21f36b03136"),"title" : "MongoDB"})
            --根据主键id替换文档内容
        只更新第一条记录：
        db.col.update( { "count" : { $gt : 1 } } , { $set : { "test2" : "OK"} } );
        全部更新：
        db.col.update( { "count" : { $gt : 3 } } , { $set : { "test2" : "OK"} },false,true );
        只添加第一条：
        db.col.update( { "count" : { $gt : 4 } } , { $set : { "test5" : "OK"} },true,false );
        全部添加加进去:
        db.col.update( { "count" : { $gt : 5 } } , { $set : { "test5" : "OK"} },true,true );
        全部更新：
        db.col.update( { "count" : { $gt : 15 } } , { $inc : { "count" : 1} },false,true );
        只更新第一条记录：


        db.col.update( { "count" : { $gt : 10 } } , { $inc : { "count" : 1} },false,false );
         ————————
        更新单个文档a
        > db.test_collection.updateOne({"name":"abc"},{$set:{"age":"28"}})
        更新多个文档
        > db.test_collection.updateMany({"age":{$gt:"10"}},{$set:{"status":"xyz"}})
        ==================================================================================
        文档数据操作++数据(文档)删除：
        db.collection.remove(
           <query>,                   query :（可选）删除的文档的条件。
           {
             justOne: <boolean>,      justOne : （可选）如果设为 true 或 1，则只删除一个文档。
             writeConcern: <document> writeConcern :（可选）抛出异常的级别。
           }
        )
        删除集合下全部文档：
        db.inventory.deleteMany({})
        删除 status 等于 A 的全部文档：
        db.inventory.deleteMany({ status : "A" })
        删除 status 等于 D 的一个文档：
        db.inventory.deleteOne( { status: "D" } )
