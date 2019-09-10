

insert into test(name) value ('li');
insert into test(name) values ('li');
insert into test(name) values ('li'),('wang'),('hah');
insert into test(name) select (cwss_mc) from clear_his_fpjc_cwss where cwss_id ='00bab6e459da6afcc764ba1c33d8a81c';
insert into test(name) select (cwss_mc) from clear_his_fpjc_cwss limit 2;

show tables;

select * from test;
select * from clear_his_fpjc_cwss;