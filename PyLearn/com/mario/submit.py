# -*- coding: UTF-8 -*-
from com.mario.utils.MysqlUtil import MysqlUtil

#select * from file_upload t where t.create_time > '2018-08-21';

if __name__ == "__main__":
    app = MysqlUtil()
    sql = "select * from file_upload t where t.create_time > '2018-08-21';"
    result_all_obtain = app.fetchall(sql)
    for row in result_all_obtain:
        filename = row[4]
        filename = filename[0:-9]
        sql = "select * from aoi_info where guid = '%s'" % filename
        result_one = app.fetchone(sql)
        if result_one == None:
            print sql
        else:
            print result_one[0]
        
