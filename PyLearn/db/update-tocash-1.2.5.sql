alter table pay_info modify column earning double NOT NULL;

alter table earning_tocash_exp_20180705 modify column tocash_time datetime default null;
alter table earning_tocash_exp_20180705 modify column create_time datetime not null;
alter table earning_tocash_exp_20180705 modify column tocash double not null;

alter table earning_tocash_exp_20180628 modify column tocash_time datetime default null;
alter table earning_tocash_exp_20180628 modify column create_time datetime not null;
alter table earning_tocash_exp_20180628 modify column tocash double not null;


alter table pay_info_wuhan_20180628 modify column create_time datetime default null;
alter table pay_info_wuhan_20180628 modify column tocash double not null;

alter table pay_info_xinxiang_20180628 modify column create_time datetime default null;
alter table pay_info_xinxiang_20180628 modify column tocash double not null;



