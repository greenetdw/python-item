# -*- coding: UTF-8 -*-
from com.mario.utils.MysqlUtil import MysqlUtil

#付款最后一次提现之前的数据， 是否和提现的金额相等
def checkTocashLessThanId(obtain_id, username):
    app = MysqlUtil()
   
    obtainSql = "select earning, operate, id, create_time, earning_tocash_id from  obtain_earning_info where  id <= %d and username = '%s' and operate = -1 order by id desc limit 1" % (obtain_id, username)
#     print obtainSql
    #查询提现前的所有的账目
    maxTocashObtainResults = app.fetchone(obtainSql)
    if maxTocashObtainResults == None:
        return
    
    #最后一次提现金额
    lastTocashEarning = maxTocashObtainResults[0]
    lastTocashId = maxTocashObtainResults[2]
    lastCreateTime = maxTocashObtainResults[3]
    earning_tocash_id = maxTocashObtainResults[4]
    
    #查询这次提现之前的金额
    checkAddObtainSql = "select round(sum(earning), 2) from obtain_earning_info where username = '%s' and operate = 1 and id < %d" % (username, lastTocashId)
    checkSubObtainSql = "select round(sum(earning), 2) from obtain_earning_info where username = '%s' and operate = -1 and id < %d" % (username, lastTocashId)
    
    checkAddResult = app.fetchone(checkAddObtainSql)
    if checkAddResult[0] == None:
        checkAddResult = 0.0
    else:
        checkAddResult = checkAddResult[0]
    
    checkSubResult = app.fetchone(checkSubObtainSql)
    if checkSubResult[0] == None:
        checkSubResult = 0.0
    else:
        checkSubResult = checkSubResult[0]
        
    checkResult = round(checkAddResult - checkSubResult, 2)
    if lastTocashEarning != checkResult:
        print "username : %s, lastTocashEarning : %.2f, checkResult : %.2f,lastTocashId : %d, lastCreateTime : %s obtain_id =%d" % (username, lastTocashEarning, checkResult, lastTocashId, lastCreateTime, obtain_id)
        leftMoney = round(checkResult - lastTocashEarning, 2)
        if  leftMoney == 0.01:
            sql = "update obtain_earning_info set earning = round(earning - 0.01, 2), remark = 'obtain_earning_info sub 1 min' where username = '%s'  and id = (select id from  (select min(id) id from obtain_earning_info where username = '%s') tmp );" % (username, username)
            print sql
        else:
            #将一条台账，拆分成2条台账
            #1、将第一条台账减值
            obtain_diff = round(checkResult - lastTocashEarning, 2)
            sql = "select * from obtain_earning_info where username = '%s' and operate = 1 and earning > %.2f and id < %d order by id limit 1" % (username, obtain_diff, obtain_id)
            result_obtain = app.fetchone(sql)
            if result_obtain == None:
                print '未找到单条收益大于 %.2f 的收益' % obtain_diff
                
                
                sql = "select id from obtain_earning_info where username = '%s' and operate = -1 and id < %d order by id desc limit 1" % (username, obtain_id)
                beforeLastToachObtainId = app.fetchone(sql)
                if beforeLastToachObtainId == None:
                    obtain_sum = 0.0
                    #则需要去遍历求和
                    sql = "select * from obtain_earning_info where username = '%s' and id < %d order by id" %(username, obtain_id)
                    result_all_obtain = app.fetchall(sql)
                    for row in result_all_obtain:
                        operate = row[11]
                        if(operate == 1):
                            obtain_sum = round(obtain_sum + row[12], 2)
                        else:
                            obtain_sum = round(obtain_sum - row[12], 2)
                        if obtain_sum >= lastTocashEarning:
                            #拆分
                            first_obtain_id = row[0]
                            obtain_type = row[1] 
                            obtain_task_id = row[2]
                            obtain_workflow_id = row[3]
                            obtain_task_type = row[4]
                            obtain_task_type_item = row[5]
                            obtain_data_id = row[7]
                            obtain_aoi_guid = row[8]
                            obtain_operate = 1
                            old_obtain_earning = row[12]
                            obtain_create_user = row[14]
                            obtain_create_time = row[15]
                             
                            new_obtain_earning = old_obtain_earning - (obtain_sum - lastTocashEarning)
                            
                            obtain_diff = obtain_sum - lastTocashEarning
                             
                            sql = "update obtain_earning_info set earning = %.2f, remark = 'old value : %.2f , new value: %.2f' where id = %d;" % (new_obtain_earning, old_obtain_earning, new_obtain_earning, first_obtain_id)
                            print sql
                            #2、插入差值到第二条台账
                            obtain_remark = "old value: %.2f, new value: %.2f, old_obtain_id = %d" % (old_obtain_earning, new_obtain_earning, first_obtain_id)
                            if obtain_task_id == None:
                                sql = "insert into obtain_earning_info(type, username,aoi_guid,operate, earning,remark, create_user, create_time) values (%d, '%s','%s', %d, %.2f, '%s', '%s', '%s');" % (obtain_type, username,obtain_aoi_guid, obtain_operate, obtain_diff, obtain_remark, obtain_create_user, obtain_create_time)
                            else:
                                sql = "insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (%d, %d, %d, %d, %d, %d, '%s', %d, %.2f, '%s', '%s', '%s');" % (obtain_type, obtain_task_id, obtain_workflow_id, obtain_task_type, obtain_task_type_item, obtain_data_id, username, obtain_operate, obtain_diff, obtain_remark, obtain_create_user, obtain_create_time)
                            print sql
                            
                            
                            cutoff_earning_id = first_obtain_id
                            sql = "update earning_tocash_info set cutoff_earning_id = %d , status = 1 where id = %d and username = '%s';" % (cutoff_earning_id, earning_tocash_id, username)
                            print sql
                            #更新之前的提现记录为成功
                            sql = "update earning_tocash_info set status = 1 where id < %d and username = '%s' and operate = -1;" % (earning_tocash_id, username)
                            print sql
                            
                            break;
                else:
                    obtain_sum = 0.0
                    #则需要去遍历求和
                    sql = "select * from obtain_earning_info where username = '%s' and id < %d order by id" %(username, obtain_id)
                    result_all_obtain = app.fetchall(sql)
                    for row in result_all_obtain:
                        operate = row[11]
                        if(operate == 1):
                            obtain_sum = round(obtain_sum + row[12], 2)
                        else:
                            obtain_sum = round(obtain_sum - row[12], 2)
#                         print "obtain_sum:%.2f, beforeLastToachObtainId : %d"  % (obtain_sum , beforeLastToachObtainId)
                        if obtain_sum >= lastTocashEarning and row[0] > beforeLastToachObtainId[0]:
                            #拆分
                            first_obtain_id = row[0]
                            obtain_type = row[1] 
                            obtain_task_id = row[2]
                            obtain_workflow_id = row[3]
                            obtain_task_type = row[4]
                            obtain_task_type_item = row[5]
                            obtain_data_id = row[7]
                            obtain_aoi_guid = row[8]
                            obtain_operate = 1
                            old_obtain_earning = row[12]
                            obtain_create_user = row[14]
                            obtain_create_time = row[15]
                             
                            new_obtain_earning = old_obtain_earning - (obtain_sum - lastTocashEarning)
                            
                            obtain_diff = obtain_sum - lastTocashEarning
                             
                            sql = "update obtain_earning_info set earning = %.2f, remark = 'old value : %.2f , new value: %.2f' where id = %d;" % (new_obtain_earning, old_obtain_earning, new_obtain_earning, first_obtain_id)
                            print sql
                            #2、插入差值到第二条台账
                            obtain_remark = "old value: %.2f, new value: %.2f, old_obtain_id = %d" % (old_obtain_earning, new_obtain_earning, first_obtain_id)
                            if obtain_task_id == None:
                                sql = "insert into obtain_earning_info(type, username,aoi_guid,operate, earning,remark, create_user, create_time) values (%d, '%s','%s', %d, %.2f, '%s', '%s', '%s');" % (obtain_type, username,obtain_aoi_guid, obtain_operate, obtain_diff, obtain_remark, obtain_create_user, obtain_create_time)
                            else:
                                sql = "insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (%d, %d, %d, %d, %d, %d, '%s', %d, %.2f, '%s', '%s', '%s');" % (obtain_type, obtain_task_id, obtain_workflow_id, obtain_task_type, obtain_task_type_item, obtain_data_id, username, obtain_operate, obtain_diff, obtain_remark, obtain_create_user, obtain_create_time)
                            print sql
                            
                            
                            cutoff_earning_id = first_obtain_id
                            sql = "update earning_tocash_info set cutoff_earning_id = %d , status = 1 where id = %d and username = '%s';" % (cutoff_earning_id, earning_tocash_id, username)
                            print sql
                            #更新之前的提现记录为成功
                            sql = "update earning_tocash_info set status = 1 where id < %d and username = '%s' and operate = -1;" % (earning_tocash_id, username)
                            print sql
                            
                            break;
                
                     
            else:
                 
                print '拆台账收益'
                first_obtain_id = result_obtain[0]
                obtain_type = result_obtain[1]
                obtain_task_id = result_obtain[2]
                obtain_workflow_id = result_obtain[3]
                obtain_task_type = result_obtain[4]
                obtain_task_type_item = result_obtain[5]
                obtain_data_id = result_obtain[7]
                obtain_aoi_guid = result_obtain[8]
                obtain_operate = 1
                old_obtain_earning = result_obtain[12]
                obtain_create_user = result_obtain[14]
                obtain_create_time = result_obtain[15]
                 
                new_obtain_earning = old_obtain_earning - obtain_diff
                 
                sql = "update obtain_earning_info set earning = %.2f, remark = 'old value : %.2f , new value: %.2f' where id = %d;" % (new_obtain_earning, old_obtain_earning, new_obtain_earning, first_obtain_id)
                print sql
                #2、插入差值到第二条台账
                obtain_remark = "old value: %.2f, new value: %.2f, old_obtain_id = %d" % (old_obtain_earning, new_obtain_earning, first_obtain_id)
                if obtain_task_id == None:
                    sql = "insert into obtain_earning_info(type, username,aoi_guid,operate, earning,remark, create_user, create_time) values (%d, '%s','%s', %d, %.2f, '%s', '%s', '%s');" % (obtain_type, username,obtain_aoi_guid, obtain_operate, obtain_diff, obtain_remark, obtain_create_user, obtain_create_time)
                else:
                    sql = "insert into obtain_earning_info(type, task_id, workflow_id, task_type, task_type_item, data_id, username,operate, earning,remark, create_user, create_time) values (%d, %d, %d, %d, %d, %d, '%s', %d, %.2f, '%s', '%s', '%s');" % (obtain_type, obtain_task_id, obtain_workflow_id, obtain_task_type, obtain_task_type_item, obtain_data_id, username, obtain_operate, obtain_diff, obtain_remark, obtain_create_user, obtain_create_time)
                    print sql
                
    else :
        sql = "select earning, operate, id, create_time, earning_tocash_id from  obtain_earning_info where  id <= %d and username = '%s' and operate = 1 order by id desc limit 1" % (lastTocashId, username)
        result_obtain = app.fetchone(sql)
        cutoff_earning_id = result_obtain[2]
        sql = "update earning_tocash_info set cutoff_earning_id = %d , status = 1 where id = %d and username = '%s';" % (cutoff_earning_id, earning_tocash_id, username)
        print sql
        #更新之前的提现记录为成功
        sql = "update earning_tocash_info set status = 1 where id < %d and username = '%s' and operate = -1;" % (earning_tocash_id, username)
        print sql

def checkTocashById(obtain_id, username):
    app = MysqlUtil()
   
    obtainSql = "select earning, operate, id, create_time, earning_tocash_id from  obtain_earning_info where  id >= %d and username = '%s' and operate = -1 order by id asc limit 1" % (obtain_id, username)
    #将最后一次提现后的提现记录全部设置为失败
    
    
    #print obtainSql
    #查询提现前的所有的账目
    maxTocashObtainResults = app.fetchone(obtainSql)
    
     
    #最后一次提现金额
    lastTocashEarning = maxTocashObtainResults[0]
    lastTocashId = maxTocashObtainResults[2]
    lastCreateTime = maxTocashObtainResults[3]
    earning_tocash_id = maxTocashObtainResults[4]
    
    
    
    sql = "update earning_tocash_info set status = -1 where id = %d;" % earning_tocash_id
    print sql
    sql = "insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, %d, '%s', 1, %.2f, 'system set pay fail', 'system', now());" % (earning_tocash_id, username, lastTocashEarning)
    print sql
    sql = "update app_user_total_info set earning_balance = round(earning_balance + %.2f, 2) where username = '%s';" % (lastTocashEarning, username)
    print sql
#     
#     #查询这次提现之前的金额
#     checkAddObtainSql = "select round(sum(earning), 2) from obtain_earning_info where username = '%s' and operate = 1 and id < %d" % (username, lastTocashId)
#     checkSubObtainSql = "select round(sum(earning), 2) from obtain_earning_info where username = '%s' and operate = -1 and id < %d" % (username, lastTocashId)
#     
#     checkAddResult = app.fetchone(checkAddObtainSql)
#     if checkAddResult[0] == None:
#         checkAddResult = 0.0
#     else:
#         checkAddResult = checkAddResult[0]
#     
#     checkSubResult = app.fetchone(checkSubObtainSql)
#     if checkSubResult[0] == None:
#         checkSubResult = 0.0
#     else:
#         checkSubResult = checkSubResult[0]
#         
#     checkResult = round(checkAddResult - checkSubResult, 2)
#     if lastTocashEarning != checkResult:
#         print "username : %s, lastTocashEarning : %.2f, checkResult : %.2f,lastTocashId : %d, lastCreateTime : %s obtain_id =%d" % (username, lastTocashEarning, checkResult, lastTocashId, lastCreateTime, obtain_id)
#     else :
#         sql = "select earning, operate, id, create_time, earning_tocash_id from  obtain_earning_info where  id <= %d and username = '%s' and operate = 1 order by id desc limit 1" % (lastTocashId, username)
#         result = app.fetchone(sql)
#         cutoff_earning_id = result[2]
#         sql = "update earning_tocash_info set cutoff_earning_id = %d where id = %d and username = '%s';" % (cutoff_earning_id, earning_tocash_id, username)
#         print sql 
    
    