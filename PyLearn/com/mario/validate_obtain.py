# -*- coding: UTF-8 -*-

import MySQLdb
import traceback
import sys
from com.mario.utils.ValidateMysqlUtil import ValidateMysqlUtil
 
def validateTotal():
    sql = "select max(id), username from earning_tocash_info where status = 1 group by username"
    app = ValidateMysqlUtil()
    result = app.fetchall(sql)
    for row in result:
        tocash_id = row[0]
        username = row[1]
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = 1" % username
        rs = app.fetchone(sql)
        totalAdd = rs[0]
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = -1" % username
        rs = app.fetchone(sql)
        totalSub = rs[0]
        
        sql = "select earning_balance, username from app_user_total_info where username = '%s'" % username
        totalRs = app.fetchone(sql)
        totalMoney = totalRs[0]
        
        total = round(totalAdd - totalSub, 2)
        if totalMoney == total:
#             print "ok"
            a = 21
        else:
            print "fail"
    
def validateObtain():
    sql = "select max(id), username, cutoff_earning_id from earning_tocash_info where cutoff_earning_id is not null and status = 1 group by username"
    app = ValidateMysqlUtil()
    result = app.fetchall(sql)
    for row in result:
        tocash_id = row[0]
        username = row[1]
        if username == "mario_6FV1S0HSGO":
            print username
        cutoff_earning_id = row[2]
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = 1 and id <=%d " % (username, cutoff_earning_id)
        rs = app.fetchone(sql)
        totalAdd = rs[0]
        
#         sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = -1 and id <=%d " % (username, cutoff_earning_id)
#         rs = app.fetchone(sql)
#         totalSub = rs[0]
        
        sql = "select round(sum(tocash),2) from earning_tocash_info where username = '%s' and status = 1" % (username)
        rs = app.fetchone(sql)
        totalMoney = rs[0]
        
#         total = round(totalAdd - totalSub, 2)
        
        
        if totalMoney == totalAdd:
#             print "ok"
            a = 21
        else:
            print "fail"

def validateObtain2():
    sql = "select max(id), username, cutoff_earning_id from earning_tocash_info where cutoff_earning_id is not null and status = 1 group by username"
    app = ValidateMysqlUtil()
    result = app.fetchall(sql)
    for row in result:
        tocash_id = row[0]
        username = row[1]
        cutoff_earning_id = row[2]
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = 1 and id >%d " % (username, cutoff_earning_id)
        rs = app.fetchone(sql)
        totalAdd = rs[0]
        if totalAdd == None:
            totalAdd = 0.0
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = -1 and id >%d and earning_tocash_id > %d" % (username, cutoff_earning_id, tocash_id)
        rs = app.fetchone(sql)
        totalSub = rs[0]
        if totalSub == None:
            totalSub = 0.0
        
        sql = "select earning_balance, username from app_user_total_info where username = '%s'" % username
        totalRs = app.fetchone(sql)
        totalMoney = totalRs[0]
        
        total = round(totalAdd - totalSub, 2)
        
        #print "total:%.2f, totalMoney:%.2f" % (total, totalMoney)
        
        if totalMoney == total:
#             print "ok"
            a = 21
        else:
            print "fail"    
    
    
if __name__ == "__main__":
#     validateTotal()
    validateObtain()
#     validateObtain2()
