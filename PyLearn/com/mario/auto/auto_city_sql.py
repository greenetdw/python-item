# -*- coding: UTF-8 -*-

city_codes = [
    "110000", 
    "150300", 
    "310000", 
    "320100", 
    "330100", 
    "410100", 
    "410200", 
    "410500", 
    "410600", 
    "410700", 
    "410800", 
    "410900", 
    "411400", 
    "419000", 
    "420100", 
    "440100", 
    "440300", 
    "441300", 
    "610100"
]

for city_code in city_codes:
    sql = "create table fruit_aoi_"+city_code+" like fruit_aoi_template;"
    print sql

print 

for city_code in city_codes:
    sql = "create table fruit_build_name_"+city_code+" like fruit_build_name_template;"
    print sql

print
    
for city_code in city_codes:
    sql = "create table fruit_build_unit_"+city_code+" like fruit_build_unit_template;"
    print sql
    
print    
    
for city_code in city_codes:
    sql = "create table fruit_inroad_point_"+city_code+" like fruit_inroad_point_template;"
    print sql
print
    

for city_code in city_codes:
    sql = "create table fruit_inroad_track_"+city_code+" like fruit_inroad_track_template;"
    print sql
print

for city_code in city_codes:
    sql = "create table fruit_aoi_error_"+city_code+" like fruit_aoi_error_template;"
    print sql
print

for city_code in city_codes:
    sql = "create table fruit_inroad_error_"+city_code+" like fruit_inroad_error_template;"
    print sql
print

#####################################
for city_code in city_codes:
    sql = "alter table common_task_data_"+city_code+" add column error_cause int default null comment '1临时房屋 2地图楼栋画错了 3此处无楼栋 4商铺/服务设施 5车棚/垃圾房/变电室 6不是本区域楼栋 7内部区域进不去 99其他' after record_type;"
    print sql
    sql = "alter table common_task_data_"+city_code+" add column error_cause_txt varchar(200) default null comment '报错描述' after error_cause;"
    print sql
    sql = "alter table common_task_data_history_"+city_code+" add column error_cause int default null comment '1临时房屋 2地图楼栋画错了 3此处无楼栋 4商铺/服务设施 5车棚/垃圾房/变电室 6不是本区域楼栋 7内部区域进不去 99其他' after record_type;"
    print sql 
    sql = "alter table common_task_data_history_"+city_code+" add column error_cause_txt varchar(200) default null comment '报错描述' after error_cause;"
    print sql 

    sql = "ALTER TABLE `common_task_data_buildunit_"+city_code+"`\n\
            ADD COLUMN `door_system_audit_result`  int(11) NULL COMMENT '单元门禁系统方式审核结果' AFTER `door_system_audit`,\n\
            ADD COLUMN `door_system_unpass_cause`  varchar(200) NULL COMMENT '单元门禁系统方式审核未通过的原因' AFTER `door_system_audit_result`,\n\
            ADD COLUMN `door_system_unpass_causetxt`  varchar(200) NULL COMMENT '单元门禁系统方式审核未通过的其他原因' AFTER `door_system_unpass_cause`,\n\
            ADD COLUMN `elevator_nums_audit_result`  int(11) NULL COMMENT '单元电梯数审核结果' AFTER `elevator_nums_audit`,\n\
            ADD COLUMN `elevator_nums_unpass_cause`  varchar(200) NULL COMMENT '单元电梯数审核未通过的原因' AFTER `elevator_nums_audit_result`,\n\
            ADD COLUMN `elevator_nums_unpass_causetxt`  varchar(200) NULL COMMENT '单元电梯数审核未通过的其他原因' AFTER `elevator_nums_unpass_cause`,\n\
            ADD COLUMN `door_nums_audit_result`  int(11) NULL COMMENT '单元每层户数审核结果' AFTER `door_nums_audit`,\n\
            ADD COLUMN `door_nums_unpass_cause`  varchar(200) NULL COMMENT '单元每层户数审核未通过的原因' AFTER `door_nums_audit_result`,\n\
            ADD COLUMN `door_nums_unpass_causetxt`  varchar(200) NULL COMMENT '单元每层户数审核未通过的其他原因' AFTER `door_nums_unpass_cause`,\n\
            ADD COLUMN `floor_nums_audit_result`  int(11) NULL COMMENT '单元楼层数审核结果' AFTER `floor_nums_audit`,\n\
            ADD COLUMN `floor_nums_unpass_cause`  varchar(200) NULL COMMENT '单元楼层数审核未通过的原因' AFTER `floor_nums_audit_result`,\n\
            ADD COLUMN `floor_nums_unpass_causetxt`  varchar(200) NULL COMMENT '单元楼层数审核未通过的其他原因' AFTER `floor_nums_unpass_cause`;"
    print sql
    
    sql = "ALTER TABLE `common_task_data_buildunit_history_420100` \n \
            ADD COLUMN `door_system_audit_result`  int(11) NULL COMMENT '单元门禁系统方式审核结果' AFTER `door_system_audit`,\n\
            ADD COLUMN `door_system_unpass_cause`  varchar(200) NULL COMMENT '单元门禁系统方式审核未通过的原因' AFTER `door_system_audit_result`,\n\
            ADD COLUMN `door_system_unpass_causetxt`  varchar(200) NULL COMMENT '单元门禁系统方式审核未通过的其他原因' AFTER `door_system_unpass_cause`,\n\
            ADD COLUMN `elevator_nums_audit_result`  int(11) NULL COMMENT '单元电梯数审核结果' AFTER `elevator_nums_audit`,\n\
            ADD COLUMN `elevator_nums_unpass_cause`  varchar(200) NULL COMMENT '单元电梯数审核未通过的原因' AFTER `elevator_nums_audit_result`,\n\
            ADD COLUMN `elevator_nums_unpass_causetxt`  varchar(200) NULL COMMENT '单元电梯数审核未通过的其他原因' AFTER `elevator_nums_unpass_cause`,\n\
            ADD COLUMN `door_nums_audit_result`  int(11) NULL COMMENT '单元每层户数审核结果' AFTER `door_nums_audit`,\n\
            ADD COLUMN `door_nums_unpass_cause`  varchar(200) NULL COMMENT '单元每层户数审核未通过的原因' AFTER `door_nums_audit_result`,\n\
            ADD COLUMN `door_nums_unpass_causetxt`  varchar(200) NULL COMMENT '单元每层户数审核未通过的其他原因' AFTER `door_nums_unpass_cause`,\n\
            ADD COLUMN `floor_nums_audit_result`  int(11) NULL COMMENT '单元楼层数审核结果' AFTER `floor_nums_audit`,\n\
            ADD COLUMN `floor_nums_unpass_cause`  varchar(200) NULL COMMENT '单元楼层数审核未通过的原因' AFTER `floor_nums_audit_result`,\n\
            ADD COLUMN `floor_nums_unpass_causetxt`  varchar(200) NULL COMMENT '单元楼层数审核未通过的其他原因' AFTER `floor_nums_unpass_cause`;"
    print sql 
    
    print
    





































