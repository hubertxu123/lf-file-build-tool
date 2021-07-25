# lf-execl-easy
excel的简易使用

### 1.测试用例：


    package com.github.lfexecleasy.test;
    
    import com.github.lfexecleasy.anno.LFColume;
    
    import java.util.Date;
    
    /**
     * @author : Mr huangye
     * URL : CSDN 皇夜_
     * createTime : 2020/5/29 16:19
     */
    public class TestDept {
    
        @LFColume("id")
        private String id;
        @LFColume("名称")
        private String deptName;
    
        public String getId() {
            return id;
        }
    
        public void setId(String id) {
            this.id = id;
        }
    
        public String getDeptName() {
            return deptName;
        }
    
        public void setDeptName(String deptName) {
            this.deptName = deptName;
        }
    }

    package com.github.lfexecleasy.test;
    
    import com.github.lfexecleasy.anno.LFColume;
    
    import java.util.Date;
    
    /**
     * @author : Mr huangye
     * URL : CSDN 皇夜_
     * createTime : 2020/5/29 16:19
     */
    public class TestUser {
    
        @LFColume("id")
        private String id;
        @LFColume("名称")
        private String name;
        @LFColume("年龄@1-1岁 2-2岁")
        private String age;
        @LFColume("时间")
        private Date time;
    
        public String getId() {
            return id;
        }
    
        public void setId(String id) {
            this.id = id;
        }
    
        public String getName() {
            return name;
        }
    
        public void setName(String name) {
            this.name = name;
        }
    
        public String getAge() {
            return age;
        }
    
        public void setAge(String age) {
            this.age = age;
        }
    
        public Date getTime() {
            return time;
        }
    
        public void setTime(Date time) {
            this.time = time;
        }
    }



    public static void main(String[] args) {
    
            //数据准备
            List<TestUser> testUsers = new ArrayList<>();
            for (int i = 0; i < 2; i++) {
                TestUser testUser = new TestUser();
                testUser.setAge("18");
                testUser.setId("12");
                testUser.setName("name");
                testUser.setTime(new Date());
                testUsers.add(testUser);
            }
            for (int i = 0; i < 1; i++) {
                TestUser testUser = new TestUser();
                testUser.setAge("1");
                testUser.setId("12");
                testUser.setName("name");
                testUser.setTime(new Date());
                testUsers.add(testUser);
            }
            //数据准备
            List<TestDept> testDept = new ArrayList<>();
            for (int i = 0; i < 2; i++) {
                TestDept testUser = new TestDept();
                testUser.setId("12");
                testUser.setDeptName("部门+" + i);
                testDept.add(testUser);
            }
     
            //导出全部
            ExportDataBase all1 = new ExportDataALL("sheet1", testUsers, TestUser.class);
            ExportDataBase all2 = new ExportDataALL("sheet2", testUsers, TestUser.class);
            ExportDataBase all3 = new ExportDataPart("sheet3", new String[]{"id", "部门名称"}, new String[]{"id", "deptName"}, testDept);
    
            all1.setExcelRuleInfo(new ExcelRuleInfo("hhh"));
    
            String fileName = "./TestOutputExcel.xlsx";
            ExportExcelUtils exportExcelUtils = new ExportExcelUtils();
            String s = exportExcelUtils.makeTable(all1, all2, all3);
    //        System.err.println(s);
            exportExcelUtils.outPutFile(fileName, s);
            //多sheet导出
    //        export(all1, all2);
    
        }
