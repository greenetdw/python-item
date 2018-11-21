# -*- coding: UTF-8 -*-
from com.mario.utils.MysqlUtil import MysqlUtil

if __name__ == "__main__":
    app = MysqlUtil()
#     sql = "select o.* from obtain_earning_info o inner join aoi_info a on a.guid = o.aoi_guid where o.earning = '0.01' and o.task_type = 1 and o.task_type_item = 2  and a.type != 2 and a.adcode like '4105%' and o.operate = 1"
#     result_all_obtain = app.fetchall(sql)
#     for row in result_all_obtain:
#         classify = row[1]
#         type_ = row[2]
#         task_id = row[3]
#         workflow_id = row[4]
#         task_type = row[5]
#         task_type_item = row[6]
#         
#         aoi_guid = row[9]
#         username = row[11]
#         create_user = row[15]
#         sql = "insert into obtain_earning_info(classify, type, task_id, workflow_id , task_type, task_type_item, aoi_guid, username, operate, earning, remark , create_user, create_time) \
#         values (%d, %d, %d, %d, %d, %d, '%s', '%s', 1, 0.99, 'build-unit add 0.99', '%s', now());" % (classify, type_, task_id, workflow_id, task_type, task_type_item, aoi_guid, username, create_user)
#         print sql
#         sql = "update app_user_total_info set earning_balance = round(earning_balance + %.2f, 2) where username = '%s';" % (0.99, username)
#         print sql
    
    
#     sql = "select o.* from obtain_earning_info o inner join aoi_info a on a.guid = o.aoi_guid where o.earning >= '0.01' and o.task_type = 1 and o.task_type_item = 2  and a.type != 2 and a.adcode like '4401%' and o.operate = 1"
    sql = "select o.* from obtain_earning_info o inner join aoi_info a on a.guid = o.aoi_guid where o.earning >= '0.01' and o.task_type = 1 and o.task_type_item = 2  and a.adcode like '4401%' and o.operate = 1"
    result_all_obtain = app.fetchall(sql)
    for row in result_all_obtain:
        obtain_id = row[0]
        classify = row[1]
        type_ = row[2]
        task_id = row[3]
        workflow_id = row[4]
        task_type = row[5]
        task_type_item = row[6]
        
        aoi_guid = row[9]
        username = row[11]
        create_user = row[15]
        
        earning = row[13]
        
        n = earning / 0.01
        
        print n
        
        earning_add =  round(n * 0.99, 2)
        earning_add_remark = "build-unit add %.2f, origin obtain_earning_info id = %d" % (earning_add, obtain_id)
        
        sql = "insert into obtain_earning_info(classify, type, task_id, workflow_id , task_type, task_type_item, aoi_guid, username, operate, earning, remark , create_user, create_time) \
        values (%d, %d, %d, %d, %d, %d, '%s', '%s', 1, %.2f, '%s', '%s', now());" % (classify, type_, task_id, workflow_id, task_type, task_type_item, aoi_guid, username, earning_add, earning_add_remark, create_user)
        print sql
        sql = "update app_user_total_info set earning_balance = round(earning_balance + %.2f, 2) where username = '%s';" % (earning_add, username)
        print sql
        
