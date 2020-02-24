



##1.获取_id属性字段时：
  
    问题：
        为了获取每条数据的"_id"字段时，使用了@Field("_id")注解作为别名,read时候没问题
        MongoRepository的insert方法序列化失败，产生异常“Required identifier property not found for class”。
    解决方法：    
        用注解@Id替换@Field
##2.insert时，不使用mongo自动生成_id,在程序中写明
 
    ObjectId objectId = new ObjectId();
    intent.setIntentId(objectId.toString());
    return intentRepository.insert(intent);
              

