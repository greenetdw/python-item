# -*- coding: UTF-8 -*-
from com.mario.utils.MysqlUtil import MysqlUtil
from com.mario.utils.common import getcitys

#检验表的字段名是否存在
def validateColumnExists(tableName, colunmName):
    sql = "SELECT count(*) FROM information_schema.columns WHERE table_schema='assacs' AND table_name = '%s' AND column_name = '%s';" % (tableName, colunmName)
    app = MysqlUtil()
    rs = app.fetchone(sql)
    if rs[0] > 0 :
        return True
    else :
        return False
    
def getAllEncTablesColumns():
    t_dict = {}
    t_dict['common_task_data_'] = ['dot_lat_enc', 'dot_lng_enc', 'photo_lat_enc', 'photo_lng_enc']
    t_dict['common_task_data_history_'] = ['dot_lat_enc', 'dot_lng_enc', 'photo_lat_enc', 'photo_lng_enc']
    t_dict['inner_road_audit_marker_'] = ['dot_lat_enc', 'dot_lng_enc']
    t_dict['fruit_aoi_'] = ['photo_lng_lat_enc']
    t_dict['fruit_build_name_']=['photo_lng_lat_enc','dot_lat_enc', 'dot_lng_enc' ]
    t_dict['fruit_build_unit_']=['photo_lng_lat_enc','dot_lat_enc', 'dot_lng_enc' ]
    t_dict['fruit_inroad_point_']=['photo_lng_enc','photo_lat_enc']
    t_dict['fruit_inroad_track_']=['photo_lng_enc','photo_lat_enc']
    t_dict['fruit_aoi_error_']=['photo_lng_lat_enc','dot_lat_enc', 'dot_lng_enc' ]
    t_dict['fruit_inroad_error_']=['photo_lng_lat_enc','dot_lat_enc', 'dot_lng_enc' ]
    return t_dict

def getColumns():
    t_dict = {}
    t_dict['common_task_workflow_']=['buildunit_audit_status']
    t_dict['common_task_data_buildunit_']=['first_audit_user', 'first_audit_get_time', 'first_audit_completed_time']
    
    
def validateTableEncColumn():
    for city in getcitys():
        print 'process ' + city
        t_dict = getAllEncTablesColumns()
        for key in t_dict.keys():
            tableName = key + city 
            columns = t_dict[key]
#             print 'process ' + tableName
            for columnName in columns:
                columnExists = validateColumnExists(tableName, columnName)
                if columnExists == False:
                    print tableName + ", " + columnName + ' is not Exists'
                    return False
    
    return True


if __name__ == '__main__':
    isAllEnc = validateTableEncColumn()
    print isAllEnc
    
    
    