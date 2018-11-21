# -*- coding: UTF-8 -*-
from com.mario.utils.MysqlUtil import MysqlUtil

def queryWorkflow(aoi_name):
    sql = '''
    select count(*) from (
        select distinct w.work_user, w.work_submit_time from common_task_data_history_310000 d, common_task_workflow_310000 w,  common_task_310000 t 
        where d.workflow_id = w.id and w.task_id = t.id and t.aoi_guid = ( select guid from aoi_info where name = '%s' limit 1) 
        and d.task_type = 1 and d.task_type_item = 2 
    ) tmp
    ''' % (aoi_name)
    
    app = MysqlUtil()
    rs = app.fetchone(sql)
    if rs == None:
        pass
    elif rs[0] > 1 :
        print '多个用户提交'
    elif rs[0] == 1:
        print aoi_name + ' 1个用户提交'


def getAllAoi():
    t = []
    t.append('李园二村东区')   
    t.append('塔城小区')
    t.append('育苑小区南区') 
    t.append('嘉邦小区东区')
    t.append('嘉邦小区西区')
    t.append('李园二村北区')
    t.append('宝菊新家园')
    t.append('嘉钟花苑')
    t.append('御桥馨华苑')
    t.append('★东陆新村六街坊')
    return t

def queryBuildunit(aoi_name):
    #查询包下的任务
    sql = '''
    select distinct w.task_id , w.id from common_task_data_history_310000 d, common_task_workflow_310000 w,  common_task_310000 t 
    where d.workflow_id = w.id and w.task_id = t.id and t.aoi_guid = ( select guid from aoi_info where name = '%s' limit 1) 
    and d.task_type = 1 and d.task_type_item = 2 
    ''' % (aoi_name)
    app = MysqlUtil()
    rs = app.fetchall(sql)
    for item in rs:
        task_id = item['task_id']
        workflow_id = item['id']
        
        #查询单元门的收益（包括附加属性)
        sql = '''
        select audit_earning from common_task_data_history_310000 where task_id = %d and workflow_id = %d and task_type = 1 and task_type_item = 2 and record_type = 1 limit 1
        ''' % (task_id, workflow_id)
        audit_earning_rs = app.fetchone(sql)
        audit_earning = audit_earning_rs['audit_earning']
        
        #查询附加属性金额
        build_unit_earning = 0
        pass_cnt = 0
        all_cnt = 0
        #查询一个楼栋任务下的单元门数
        sql = '''
        select distinct unit_number from common_task_data_history_310000 d where task_id = %d and workflow_id = %d and d.task_type = 1 and d.task_type_item = 2 and record_type = 0 
        ''' % (task_id, workflow_id)
        buildunitRs = app.fetchall(sql)
        all_cnt = len(buildunitRs)
        print 'task_id = %d workflow_id = %d audit_earning = %.2f' % (task_id, workflow_id, audit_earning)
        for row in buildunitRs:
            unit_number = row['unit_number']
            #查询单个附加属性收益
            sql = '''
            select * from common_task_data_buildunit_history_310000 d  where task_id = %d and workflow_id = %d and unit_number = %d limit 1
            ''' % (task_id, workflow_id, unit_number)
            build_dict = app.fetchone(sql)
            #单元门禁审核结果
            door_system_audit_result = build_dict['door_system_audit_result']
            #单元电梯数审核结果
            elevator_nums_audit_result = build_dict['elevator_nums_audit_result']
            #单元每层户数审核结果
            door_nums_audit_result = build_dict['door_nums_audit_result']
            #单元楼层数审核结果
            floor_nums_audit_result = build_dict['floor_nums_audit_result']
            if door_system_audit_result == 1:
                build_unit_earning += 0.1
            if elevator_nums_audit_result == 1:
                build_unit_earning += 0.4
            if door_nums_audit_result == 1:
                build_unit_earning += 0.4
            if floor_nums_audit_result == 1:
                build_unit_earning += 0.2
            
            #查询对应的单元门是否审核通过
            sql = '''
            select count(*) as cnt from common_task_data_history_310000 d where task_id = %d and workflow_id = %d and d.task_type = 1 and d.task_type_item = 2 and 
            record_type = 0 and unit_number=%d and audit_result = 1 limit 1
            ''' % (task_id, workflow_id, unit_number)
            cnt = app.fetchone(sql)['cnt']
            if cnt > 0:
                pass_cnt += 1
            if door_system_audit_result == 1 and elevator_nums_audit_result == 1 and door_nums_audit_result == 1 and floor_nums_audit_result == 1 and cnt > 0 :
                build_unit_earning += 0.6
         
        print 'task_id = %d workflow_id = %d build_unit_earning = %.2f' % (task_id, workflow_id, build_unit_earning)
        unit_earning = audit_earning - build_unit_earning
        print 'task_id = %d workflow_id = %d unit_earning = %.2f, pass_cnt : %d , all_cnt: %d' % (task_id, workflow_id, unit_earning, pass_cnt, all_cnt)
        print        
    
if __name__ == '__main__':
    for item in getAllAoi():
        print item
        queryBuildunit(item)

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    