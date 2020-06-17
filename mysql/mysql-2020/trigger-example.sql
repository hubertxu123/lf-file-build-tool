
-- 触发器调试表
-- CREATE TABLE `t_s_triggers` (
--   `id` int(11) NOT NULL AUTO_INCREMENT,
--   `error_code` VARCHAR(255) DEFAULT NULL COMMENT '错误码',
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT '华夏银行，错误码对应表';

-- 充值触发器：
DELIMITER $
drop trigger if exists t_s_cash_in_zn_insert_account$
create trigger t_s_cash_in_zn_insert_account
    after INSERT on t_s_cash_in_zn
    for each row
begin
    DECLARE id int(11) DEFAULT 0;
    IF new.examine_state = 2 THEN
        SET id =(select id from t_s_user_account where user_code = new.user_code);
        IF id is not null THEN
            update t_s_user_account set amount=amount+new.amount_money where id=id;
        end if;
        IF id is null THEN
            insert into t_s_user_account(user_code,name,amount,frozen,is_use) values (new.user_code,new.name,new.amount_money,0,1);
        end if;
    end if;
end$
DELIMITER ;



DELIMITER $
drop trigger if exists t_s_cash_in_zn_update_account$
create trigger t_s_cash_in_zn_update_account
    after UPDATE on t_s_cash_in_zn
    for each row
begin
    DECLARE id int(11) DEFAULT 0;
    IF new.examine_state = 2 AND old.examine_state !=2 THEN
        SET id =(select id from t_s_user_account where user_code = new.user_code);
        IF id is not null THEN
            update t_s_user_account set amount=amount+new.amount_money where id=id;
        end if;
        IF id is null THEN
            insert into t_s_user_account(user_code,name,amount,frozen,is_use) values (new.user_code,new.name,new.amount_money,0,1);
        end if;
    end if;
end$
DELIMITER ;

-- 测试
-- insert into t_s_cash_in_zn(user_code,name,amount_money,examine_state) values ('1','cesji','1.01',2);
-- insert into t_s_cash_in_zn(user_code,name,amount_money,examine_state) values ('1','cesji','1.01',1);
-- select * from t_s_cash_in_zn;
-- select * from t_s_user_account;
-- select * from t_s_triggers;
-- TRUNCATE TABLE t_s_triggers;
-- TRUNCATE TABLE t_s_user_account;
-- show ERRORS;



-- 扣减数据
DELIMITER $
drop trigger if exists t_s_expend_details_zn_insert_account$
create trigger t_s_expend_details_zn_insert_account
    after INSERT on t_s_expend_details_zn
    for each row
begin
    update t_s_user_account set amount=amount-new.cash_money-new.poundage where user_code=new.user_code;
end$
DELIMITER ;

-- 测试
INSERT INTO `ziniutest`.`t_s_expend_details_zn` (`user_code`, `name`, `iPhone`, `id_card`, `bank_card_num`, `bank_reg`,
                                                 `cash_money`, `poundage`, `source`, `update_time`) VALUES ('1', NULL, NULL, NULL, NULL, NULL, '0.01', '1.01', NULL, NULL);
select * from t_s_expend_details_zn;
select * from t_s_user_account;


select * from t_s_commission_detail_zn ORDER BY id desc limit 10;
select * from t_s_user_account ORDER BY id desc limit 10;


-- 预减金额触发器：
DELIMITER $
drop trigger if exists t_s_commission_detail_zn_update_account$
create trigger t_s_commission_detail_zn_update_account
    after UPDATE on t_s_commission_detail_zn
    for each row
begin
    -- 待处理 - 支付中
    IF new.is_finish = 2 and old.is_finish=1 THEN
        update t_s_user_account set frozen=frozen+new.issued_amount+new.poundage where user_code=new.company_code;
    end if;
    -- 失败 - 支付中
    IF new.is_finish = 2 and old.is_finish=5 THEN
        update t_s_user_account set frozen=frozen+new.issued_amount+new.poundage where user_code=new.company_code;
    end if;
    -- 支付中 - 成功
    IF new.is_finish = 3 and old.is_finish=2 THEN
        update t_s_user_account set frozen=frozen-new.issued_amount-new.poundage where user_code=new.company_code;
    -- 支付中 - 失败
    end if;
    IF new.is_finish = 4 and old.is_finish=2 THEN
        update t_s_user_account set frozen=frozen-new.issued_amount-new.poundage where user_code=new.company_code;
    -- 支付中 - 可重提失败
    end if;
    IF new.is_finish = 5 and old.is_finish=2 THEN
        update t_s_user_account set frozen=frozen-new.issued_amount-new.poundage where user_code=new.company_code;
    end if;
end$
DELIMITER ;

select * from t_s_commission_detail_zn ORDER BY id desc limit 10;
select * from t_s_user_account ORDER BY id desc limit 10;
select * from t_s_cash_in_zn ORDER BY id desc ;
select * from t_s_dock_company_zn ORDER BY id desc ;
select * from t_s_cash_withdrawal_zn ORDER BY id desc limit 10;


DELIMITER $
drop trigger if exists t_s_cash_withdrawal_zn_update_account$
create trigger t_s_cash_withdrawal_zn_update_account
    after UPDATE on t_s_cash_withdrawal_zn
    for each row
begin
    DECLARE user_code VARCHAR(11) DEFAULT '0';
    SET user_code = (select user_code from t_s_dock_company_zn where appid=new.appid);
    IF new.is_finish = 3 and old.is_finish=0 THEN
        update t_s_user_account set frozen=frozen+new.cash_money+new.poundage where user_code=user_code;
    end if;
    IF new.is_finish = 3 and old.is_finish=4 THEN
        update t_s_user_account set frozen=frozen+new.cash_money+new.poundage where user_code=user_code;
    end if;
    IF new.is_finish = 1 and old.is_finish=3 THEN
        update t_s_user_account set frozen=frozen-new.cash_money-new.poundage where user_code=user_code;
    end if;
    IF new.is_finish = 2 and old.is_finish=3 THEN
        update t_s_user_account set frozen=frozen-new.cash_money-new.poundage where user_code=user_code;
    end if;
    IF new.is_finish = 4 and old.is_finish=3 THEN
        update t_s_user_account set frozen=frozen-new.cash_money-new.poundage where user_code=user_code;
    end if;
end$
DELIMITER ;

DELIMITER $
drop trigger if exists t_s_commission_detail_zn_update_account$
create trigger t_s_commission_detail_zn_update_account
    after UPDATE on t_s_commission_detail_zn
    for each row
begin
    IF new.is_finish = 2 and old.is_finish=1 THEN
        update t_s_user_account set frozen=frozen+new.issued_amount+new.poundage where user_code=new.company_code;
    end if;
    IF new.is_finish = 2 and old.is_finish=5 THEN
        update t_s_user_account set frozen=frozen+new.issued_amount+new.poundage where user_code=new.company_code;
    end if;
    IF new.is_finish = 3 and old.is_finish=2 THEN
        update t_s_user_account set frozen=frozen-new.issued_amount-new.poundage where user_code=new.company_code;

    end if;
    IF new.is_finish = 4 and old.is_finish=2 THEN
        update t_s_user_account set frozen=frozen-new.issued_amount-new.poundage where user_code=new.company_code;

    end if;
    IF new.is_finish = 5 and old.is_finish=2 THEN
        update t_s_user_account set frozen=frozen-new.issued_amount-new.poundage where user_code=new.company_code;
    end if;
end$
DELIMITER ;
