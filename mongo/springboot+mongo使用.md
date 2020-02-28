
#https://docs.spring.io/spring-data/jpa/docs/current/reference/html/
#CSDN
##1.MongoRepository-QueryByExampleExecutor

    1. 继承MongoRepository
        public interface StudentRepository extends MongoRepository<Student, String> {
        }
    2. 代码实现
        使用ExampleMatcher匹配器-----只支持字符串的模糊查询，其他类型是完全匹配
        Example封装实体类和匹配器
        使用QueryByExampleExecutor接口中的findAll方法
        复制代码
        public Page<Student> getListWithExample(StudentReqVO studentReqVO) {
            Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
            Pageable pageable = PageRequest.of(studentReqVO.getPageNum(), studentReqVO.getPageSize(), sort);
            Student student = new Student();
            BeanUtils.copyProperties(studentReqVO, student);
            //创建匹配器，即如何使用查询条件
            ExampleMatcher matcher = ExampleMatcher.matching() //构建对象
                    .withStringMatcher(ExampleMatcher.StringMatcher.CONTAINING) //改变默认字符串匹配方式：模糊查询
                    .withIgnoreCase(true) //改变默认大小写忽略方式：忽略大小写
                    .withMatcher("name", ExampleMatcher.GenericPropertyMatchers.contains()) //采用“包含匹配”的方式查询
                    .withIgnorePaths("pageNum", "pageSize");  //忽略属性，不参与查询
        
            //创建实例
            Example<Student> example = Example.of(student, matcher);
            Page<Student> students = studentRepository.findAll(example, pageable);
            return students;
        }
    3.缺点：以下都支持...
        //不支持过滤条件分组。即不支持过滤条件用 or(或) 来连接，所有的过滤条件，都是简单一层的用 and(并且) 连接
        //不支持两个值的范围查询，如时间范围的查询
    4.常见查询操作：
        1.查询总数：
            long size = personRepository.count();
        2.根据实体类中属性查询：
            find + By + 属性名（首字母大写）
            Person person = personRepository.findByName(name);
        3.根据实体类中的属性进行模糊查询：
            find + By + 属性名（首字母大写） + Like
            List<Person> person = personRepository.findByNameLike(name);
        4.根据实体类中的属性进行模糊查询带分页：
            PageRequest pageRequest = new PageRequest(page-1,rows);
            List<Person> person = personRepository.findByNameLike(name, pageRequest).getContent();
        5.根据实体类中的属性进行模糊查询带分页，同时指定返回的键（数据库中的key,实体类中的属性）：
            目的：只返回Person中的id和name，不返回age.
            PersonRepository：添加方法，同时使用注解@Query
                 @Query(value="{'name':?0}",fields="{'name':1}")
                 public Page<Person> findByNameLike(String name,Pageable pageable);
                 解释：
                    value：是查询的条件
                    ?0:占位符-对应着方法中参数中的第一个参数
                    ?1:占位符-对应着方法中参数中的第二个参数
                    fields：是我们指定的返回字段，其中id是自动返回的
                    bson中{'name':1}的1代表true，也就是代表返回的意思。
            Service调用PersonRepository：
                 PageRequest pageRequest = new PageRequest(page-1,rows);        
                 List<Person> person = personRepository.findByNameLike(name, pageRequest).getContent();
        6.查询所有数据，同时指定返回的键:
            注意：
                ·指定返回的键时，则不能使用仓库中自带的findAll（）方法
                ·查询所有id不为空的数据，同时指定返回的键
            find + By + 属性名（首字母大写） + NotNull
            仓库：
                @Query(value="{'_id':{'$ne':null}}",fields="{'name':1}")
                public Page<Person> findByIdNotNull(Pageable pageable);
            service:
                PageRequest pageRequest = new PageRequest(page-1,rows);    
                List<Person> person = personRepository.findByIdNotNull(pageRequest).getContent();
        7.其他：
             GreaterThan(大于) 
             方法名举例：findByAgeGreaterThan(int age) 
             query中的value举例：{"age" : {"$gt" : age}}
     
             LessThan（小于） 
             方法名举例：findByAgeLessThan(int age) 
             query中的value举例：{"age" : {"$lt" : age}}
     
             Between（在...之间） 
             方法名举例：findByAgeBetween(int from, int to)  
             query中的value举例：{"age" : {"$gt" : from, "$lt" : to}}
            
             Not（不包含） 
             方法名举例：findByNameNot(String name)
             query中的value举例：{"age" : {"$ne" : name}}
            
             Near（查询地理位置相近的） 
             方法名举例：findByLocationNear(Point point) 
             query中的value举例：{"location" : {"$near" : [x,y]}}
        
##2.
