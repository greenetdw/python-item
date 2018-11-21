# -*- coding: UTF-8 -*-
from com.mario.utils.MysqlUtil import MysqlUtil

# select * from aoi_info a where a.name like '★%' 需要翻倍的

#17日 -22日提交
def compensation():
    sql = '''
    select distinct a.guid from 
        aoi_info a, common_task_440300 c, common_task_workflow_440300 w 
    where 
        a.guid = c.aoi_guid and c.id = w.task_id and 
        c.workflow = 5 and c.workflow_status = 2 and 
        w.work_submit_time >= '2018-10-17 00:00:00' and w.work_submit_time <='2018-10-22 23:59:59';"
    '''
   
    app = MysqlUtil()
    guids = app.fetchall(sql)
    if guids == None:
        pass
    else:
        for guid in guids:
#             sql = "select count(*) from compensation where guid = '%s' and type = 1 ;"
#             cnt = app.fetchone(sql)
#             if cnt != 0:
#                 continue
            #查找guid下的所有任务是否归档
            sql = "select count(*) from common_task_440300 where aoi_guid = '%s' and (workflow, workflow_status) != (5,2) " % guid
            cnt = app.fetchone(sql)
            
            if cnt[0] == 0 :
                #说明所有任务归档,则去查找最新批次提交的数据一条即可
                sql = '''
                select o.id, o.task_id, o.workflow_id, o.data_id, o.username, o.earning from  common_task_data_history_440300 d  , (
                    select max(work_submit_time), max(w.id) as id from 
                        common_task_440300 c, common_task_workflow_440300 w 
                    where 
                        c.id = w.task_id and c.aoi_guid = '%s' 
                ) tmp, obtain_earning_info o  where d.workflow_id = tmp.id and d.task_id = o.task_id 
                and d.record_type = 1 and d.audit_result = 1 limit 1;
                ''' % guid
                
                row = app.fetchone(sql)
                if row == None:
                    print guid
#                 obtain_id = str(row[0])
#                 task_id = str(row[1])
#                 workflow_id = str(row[2])
#                 data_id = str(row[3])
#                 work_user = str(row[4])
#                 earning = str(row[5])
                
                print row
                #更新台账
                
                #更新总账
                
                #补偿记录表
#                 sql = "insert into compensation(guid, task_id, workflow_id, data_id, work_user, type , earning, add_earning, obtain_id) values ('" + guid + "', " + task_id + "," + workflow_id + ", " + data_id + ", " + work_user + ", 1," + earning + ", 5," + obtain_id + ")"
                
#                 print sql
                
                


                
if __name__ == '__main__':
    compensation()
    
    

