# -*- coding: UTF-8 -*-

from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil
from com.mario.utils.MysqlUtil import MysqlUtil


def validateTotal():
    
    localApp = LocalMysqlUtil()
    app = MysqlUtil()
    
    sql = "select distinct o.username from obtain_earning_info o inner join aoi_info a on a.guid = o.aoi_guid where o.task_type = 1 and o.task_type_item = 2  and a.type != 2 and a.adcode like '4105%' and o.operate = 1"
    result = app.fetchall(sql)
    for row in result:
        
        
        username = row[0]
#         print username
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = 1" % username
        rs = localApp.fetchone(sql)
        totalAdd = rs[0]
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = -1" % username
        rs = localApp.fetchone(sql)
        totalSub = rs[0]
        if totalSub == None:
            totalSub = 0.0
        
        sql = "select earning_balance, username from app_user_total_info where username = '%s'" % username
        totalRs = localApp.fetchone(sql)
        totalMoney = totalRs[0]
        
        total = round(totalAdd - totalSub, 2)
        if totalMoney == total:
#             print "ok"
            a = 21
        else:
            print "fail"
    
    
if __name__ == "__main__":
    validateTotal()
