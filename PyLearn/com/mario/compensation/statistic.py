# -*- coding: UTF-8 -*-
import sys 
import csv
from com.mario.utils.MysqlUtil import MysqlUtil
from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil

reload(sys) 
sys.setdefaultencoding("utf-8")

def query_user_balance():
    
    writer = csv.writer(open('user_20181106.csv', 'w'))
    fields = ('username', 'realname', 'earning_balance')
    writer.writerow(fields)
    
    
    localApp = LocalMysqlUtil()
    app = MysqlUtil()
    sql = "select distinct work_user from compensation_610100;"
    result = localApp.fetchall(sql)
    for row in result:
        sql = "select a.username, a.realname, t.earning_balance from app_user_info a, app_user_total_info t where a.username = t.username and a.username='%s'" % row[0]
        rs = app.fetchone(sql)
        print rs
        row = []
        row.append(rs[0])
        if(rs[1] != None):
            row.append(rs[1])
        else:
            row.append("")
        row.append(rs[2])
        writer.writerow(row)

def compare():
    localApp = LocalMysqlUtil()
    sql = "select username, earning_balance from user_account_2018110614"
    result = localApp.fetchall(sql)
    for row in result:
        username = row[0].replace('\n', '')
#         print username
        sql = "select username, earning_balance from user_account_2018110615 where username = '\n%s'" % (username)
        oldBalance = float(row[1])
        rs = localApp.fetchone(sql)
        newBalance = float(rs[1])
        diffBalance = round(newBalance - oldBalance, 2)
        
        
        sql_ = "select work_user, round(sum(add_earning),2) from compensation_account_old_610100 where work_user = '%s'" % (username) 
#         print sql_
        rs_ = localApp.fetchone(sql_)
        compute_diff = float(rs_[1])
        
        if(compute_diff - diffBalance != 0) :
            print rs[0] + "," + str(diffBalance) + ", " + str(compute_diff)
    
    
if __name__ == '__main__':
#     query_user_balance()
    compare()


