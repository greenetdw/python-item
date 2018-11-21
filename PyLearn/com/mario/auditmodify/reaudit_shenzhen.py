# -*- coding: UTF-8 -*-
from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil
from com.mario.utils.ValidateMysqlUtil import ValidateMysqlUtil
import sys
from _mysql import NULL
from __builtin__ import str
reload(sys)
# sys.setdefaultencoding('utf8')  

def insertData(task_id, workflow_id, old_workflow_id):
    #一个批次数据关联
    sql = "select * from common_task_data_history_440300_bak where (task_id, workflow_id) in ((%d, %d));" % (task_id, old_workflow_id)
    remoteapp = LocalMysqlUtil()
    result_data = remoteapp.fetchall(sql)
    
    sql = "insert into common_task_data_440300(task_id, workflow_id, task_type, task_type_item, record_type, cannot_work_cause ,special_dot_number, \
        dot_lat, dot_lng, photo_lat, photo_lng, location_mode, location_type, accuracy, bearing,track_serial_number,photo_url, collect_time,  \
        audit_earning) values "
    values_sql = "" 
    for data_row in result_data:
        task_id = str(data_row[1])
#         old_workflow_id = data_row[2]
        task_type = str(data_row[3])
        task_type_item = str(data_row[4])
        record_type = data_row[5]
        if record_type == None:
            record_type = NULL
        else :
            record_type = str(data_row[5])
            
        cannot_work_cause = data_row[6]
        if cannot_work_cause == None:
            cannot_work_cause = NULL
        else :
            cannot_work_cause = "'" + str(data_row[6]) + "'"
#         edit_name = data_row[7]
#         unit_number = data_row[8]
        special_dot_number = data_row[9]
        if special_dot_number == None:
            special_dot_number = NULL
        else:
            special_dot_number = str(data_row[9])
        
        dot_lat = data_row[10]
        if dot_lat == None:
            dot_lat = NULL
        else:
            dot_lat = "'" + str(data_row[10]) + "'"
            
        dot_lng = data_row[11]
        if dot_lng == None:
            dot_lng = NULL
        else :
            dot_lng = "'" + str(data_row[11]) + "'"
        
        photo_lat = data_row[12]
        if photo_lat == None:
            photo_lat = NULL
        else :
            photo_lat = "'" + str(data_row[12]) + "'"
        
        photo_lng = data_row[13]
        if photo_lng == None:
            photo_lng = NULL
        else :
            photo_lng = "'" + str(data_row[13]) + "'"
            
        location_mode = data_row[14]
        if location_mode == None:
            location_mode = NULL
        else:
            location_mode = str(data_row[14])
            
        location_type = data_row[15]
        if location_type == None:
            location_type = NULL
        else :
            location_type = str(data_row[15])
            
            
        accuracy = data_row[16]
        if accuracy == None:
            accuracy = NULL
        else :
            accuracy = str(data_row[16])
        
        bearing = data_row[17]
        if bearing == None:
            bearing = NULL
        else :
            bearing = str(data_row[17])
        
        track_serial_number = data_row[18]
        if track_serial_number == None:
            track_serial_number = NULL
        else:
            track_serial_number = str(data_row[18])
            
        photo_url = data_row[19]
        if photo_url == None:
            photo_url = NULL
        else:
            photo_url = "'" + photo_url + "'"
#         photo_type = data_row[20]
        collect_time = str(data_row[21])
#             audit_result = data_row[22]
#             audit_result_level = data_row[23]
#             audit_input_name = data_row[24]
#             audit_input_other = data_row[25]
#             audit_point_type = data_row[26]
#             audit_point_typetxt = data_row[27]
        audit_earning = data_row[28]
        if audit_earning == None:
            audit_earning = NULL
        else:
            audit_earning = str(data_row[28])
#             audit_unpass_cause = data_row[29]
#             audit_unpass_causetxt = data_row[30]
#             other_flag = data_row[31]
        
#         sql = "insert into common_task_data_440300(task_id, workflow_id, task_type, task_type_item, record_type, cannot_work_cause, edit_name, unit_number, special_dot_number, \
#         dot_lat, dot_lng, photo_lat, photo_lng, location_mode, location_type, accuracy, bearing,track_serial_number,photo_url, collect_time,  \
#         audit_earning) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, '%s', '%s', %s)" % \
#         (task_id, workflow_id, task_type, task_type_item, record_type, cannot_work_cause, special_dot_number, \
#         dot_lat, dot_lng, photo_lat, photo_lng, location_mode, location_type, accuracy, bearing,track_serial_number,photo_url, collect_time, \
#         audit_earning)
        
        values_sql += "(" + task_id + "," + workflow_id + ", " + task_type + "," + task_type_item + "," + record_type + "," + cannot_work_cause + "," + special_dot_number + "," +\
        dot_lat+","+dot_lng+","+photo_lat+","+photo_lng+","+location_mode+","+location_type+","+accuracy+","+bearing+","+track_serial_number+","+photo_url+",'"+collect_time+"'," + audit_earning+"), \n"
        
    if values_sql == "" or values_sql == None:
        a = 1
    else:
        values_sql = values_sql[0:-3]
        print sql + values_sql + ";"
        
def insertSpecial(task_id, workflow_id, old_workflow_id):
    #标注
    sql = "select * from special_dot_label_history_440300 where (task_id, workflow_id) in ((%d, %d))" % (task_id, old_workflow_id)
    app = LocalMysqlUtil()
    result_special_data = app.fetchall(sql)
    
    sql = "insert into special_dot_label_440300(task_id , workflow_id, special_dot_number, first_type, first_type_audit, first_type_remark,\
    first_type_remark_audit, through_direction, through_direction_audit, through_type,through_type_audit, door_system_type,  door_system_type_audit, update_time) \
    values "
    values_sql = ""
    for srow in result_special_data:
        task_id = str(srow[1])
#         old_workflow_id = srow[2]
        special_dot_number = str(srow[3])
        first_type = srow[4]
        if first_type == None:
            first_type = NULL
        else:
            first_type = str(srow[4])
#         first_type_audit = srow[5]
        first_type_audit = first_type
        
        first_type_remark = srow[6]
        if first_type_remark == None:
            first_type_remark = NULL
        else :
            first_type_remark = "'" + srow[6] + "'"
#         first_type_remark_audit = srow[7]
        first_type_remark_audit = first_type_remark
        
        through_direction = srow[8]
        if through_direction == None:
            through_direction = NULL
        else:
            through_direction = str(srow[8])
#         through_direction_audit = srow[9]
        through_direction_audit = through_direction
        
        through_type = srow[10]
        if through_type == None:
            through_type = NULL
        else:
            through_type = "'" + str(srow[10]) + "'"
#         through_type_audit = srow[11]
        through_type_audit = through_type
        
        door_system_type = srow[12]
        if door_system_type == None:
            door_system_type = NULL
        else :
            door_system_type = "'" + str(srow[12]) + "'"
#         door_system_type_audit = srow[13]
        door_system_type_audit = door_system_type
        
#         sql = "insert into special_dot_label_440300(task_id , workflow_id, special_dot_number, first_type, first_type_audit, first_type_remark,\
#         first_type_remark_audit, through_direction, through_direction_audit, through_type,through_type_audit, door_system_type,  door_system_type_audit) \
#         values (%s, %s, %s, %s, %s, '%s', '%s', %s, %s, '%s', '%s', '%s', '%s', now())" % \
#         (task_id , workflow_id, special_dot_number, first_type, first_type_audit, first_type_remark,\
#         first_type_remark_audit, through_direction, through_direction_audit, through_type,through_type_audit, door_system_type,  door_system_type_audit)
        values_sql += "(" + task_id + "," + workflow_id + "," + special_dot_number + "," + first_type + "," + first_type_audit + "," + first_type_remark + "," +first_type_remark_audit + "," + \
        through_direction + "," +through_direction_audit + "," +through_type + "," +through_type_audit + "," + door_system_type + "," + door_system_type_audit + ",now()), \n"
        
    
    if values_sql == "" or values_sql == None:
        a = 1
    else:
        values_sql = values_sql[0:-3]
        print sql + values_sql + ";"
        
def getWorkflowResult():
    app = LocalMysqlUtil()
    sql = "select * from common_task_workflow_440300_bak"
    result_all_obtain = app.fetchall(sql)
    return result_all_obtain

def insertWorkflow():
    result_all_obtain = getWorkflowResult()
    for row in result_all_obtain:
        old_workflow_id = row[0]
        task_id = int(row[1])
        earning = float(row[2])
        work_user = row[3]
        work_user = 'mario_0000000000'
        work_get_time = row[4]
        work_duration = int(row[5])
        work_submit_time = row[6]
        can_work = int(row[7])
        cannot_work_cause = row[8]
        if cannot_work_cause == None:
            cannot_work_cause = NULL
        else:
            cannot_work_cause = int(row[8])
        new_flag = int(row[9])
#         first_audit_user = row[10]
#         first_audit_get_time = row[11]
#         first_audit_completed_time = row[12]
#         audit_user = row[13]
#         audit_get_time = row[14]
#         audit_completed_time = row[15]
        trackcover_rate = float(row[16])
#         audit_trackcover_rate = row[17]
        track_km_length = float(row[18])
#         audit_trackkm_length = row[19]
#         audit_allot = row[20]
#         if audit_allot == None:
#             audit_allot = -1
        audit_allot = -1
#         audit_status = row[21]
        data_to_history = -1
        
        sql = "insert into common_task_workflow_440300(task_id, work_user, work_get_time, work_duration, work_submit_time, can_work, \
        cannot_work_cause, new_flag, \
        trackcover_rate, track_km_length, audit_allot, data_to_history) values (%s, '%s','%s', %s, '%s', %s, %s, %s, \
        %.2f, %.2f, %s, %s);" % (task_id, work_user, work_get_time, work_duration, work_submit_time, can_work, \
        cannot_work_cause, new_flag,\
        trackcover_rate, track_km_length, audit_allot, data_to_history)
        
        #print sql
        app = ValidateMysqlUtil()
        workflow_id = str(app.insertTable(sql))
        
        sql = "insert into common_task_workflow_440300(id, task_id, work_user, work_get_time, work_duration, work_submit_time, can_work, \
        cannot_work_cause, new_flag, \
        trackcover_rate, track_km_length, audit_allot, data_to_history) values (%s, %s, '%s','%s', %s, '%s', %s, %s, %s, \
        %.2f, %.2f, %s, %s);" % (workflow_id, task_id, work_user, work_get_time, work_duration, work_submit_time, can_work, \
        cannot_work_cause, new_flag,\
        trackcover_rate, track_km_length, audit_allot, data_to_history)
        
        print sql
        
        
        insertData(task_id, workflow_id, old_workflow_id)
        insertSpecial(task_id, workflow_id, old_workflow_id)


if __name__ == "__main__":
    
    insertWorkflow()
    
            
            
            
            
            
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
