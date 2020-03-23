

**1.存储过程申明：**

**2.mybatis调用存储过程：**

    dao:
         /**
           * 使用存储过程执行秒杀
           * @param param
           */
          void killByProceduce(Map<String, Object> param);
    mapper:
        
        <!--mybatis调用存储过程,該大写的必须大写-->
        <select id="killByProceduce" statementType="CALLABLE">
            CALL excute_seckill(
                    #{seckillId,jdbcType=BIGINT,mode=IN},
                    #{phone,jdbcType=BIGINT,mode=IN},
                    #{killTime,jdbcType=TIMESTAMP,mode=IN},
                    #{result,jdbcType=INTEGER,mode=OUT}
            );
        </select>
