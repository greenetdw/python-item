# -*- coding: UTF-8 -*-

from com.mario.utils.MysqlUtil import MysqlUtil
from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil
from com.mario.common_earning_process import checkTocashById
from com.mario.common_earning_process import checkTocashLessThanId


def generate_username():
    app = LocalMysqlUtil()
    
    sql = "select username, user_realname from pay_info_wuhan_20180628  GROUP BY username, user_realname union \
    select username, user_realname from pay_info_xinxiang_20180628  GROUP BY username, user_realname union \
    select username, user_realname from earning_tocash_exp_20180705 where user_realname in (select username from pay_info) group by username, user_realname";
    str_uname = ""
    result = app.fetchall(sql)
    count = 0
    for row in result:
        str_uname += "'" + row[0] + "',"
        count = count + 1
    str_uname = str_uname[0:len(str_uname)-1]
    #print str_uname
    #print count
    
    count = 0
    sql = "select username, id, tocash from earning_tocash_info where username not in (" +  str_uname + ") "
    #print sql
    
    result = app.fetchall(sql)
    for row in result:
        username = row[0]
        earning_tocash_id = row[1]
        lastTocashEarning = row[2]
        count = count + 1
        print ''
        sql = "update earning_tocash_info set status = -1 where id = %d;" % earning_tocash_id
        print sql
        sql = "insert into obtain_earning_info(type, earning_tocash_id , username, operate, earning, remark, create_user, create_time) values (2, %d, '%s', 1, %.2f, 'system set pay fail', 'system', now());" % (earning_tocash_id, username, lastTocashEarning)
        print sql
        sql = "update app_user_total_info set earning_balance = round(earning_balance + %.2f, 2) where username = '%s';" % (lastTocashEarning, username)
        print sql
    
    print count    
    
    return str_uname
    
def validate():
    app = LocalMysqlUtil()
    
    sql = "select username, user_realname from pay_info_wuhan_20180628  GROUP BY username, user_realname union \
    select username, user_realname from pay_info_xinxiang_20180628  GROUP BY username, user_realname union \
    select username, user_realname from earning_tocash_exp_20180705 where user_realname in (select username from pay_info) group by username, user_realname";
    str_uname = ""
    result = app.fetchall(sql)
    count = 0
    for row in result:
        str_uname += "'" + row[0] + "',"
        count = count + 1
    str_uname = str_uname[0:len(str_uname)-1]
    #print str_uname
    #print count
    
    count = 0
    sql = "select username, id, tocash from earning_tocash_info where username not in (" +  str_uname + ") "
    #print sql
    
    result = app.fetchall(sql)
    for row in result:
        username = row[0]
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = 1" % username
        rs = app.fetchone(sql)
        totalAdd = rs[0]
        
        sql = "select round(sum(earning),2) from obtain_earning_info where username = '%s' and operate = -1" % username
        rs = app.fetchone(sql)
        totalSub = rs[0]
        
        sql = "select round(earning_balance,2), username from app_user_total_info where username = '%s'" % username
        totalRs = app.fetchone(sql)
        totalMoney = totalRs[0]
        
        total = round(totalAdd - totalSub, 2)
        # print "total:%.2f, totalMoney:%.2f" % (total, totalMoney)
        
        
        if totalMoney == total:
#             print "ok"
            a = 21
        else:
            print (round(total - totalMoney, 2))
            print "fail, username = %s" % username
        
    
if __name__ == "__main__":
    validate()
    
    
    
    
    
    
    