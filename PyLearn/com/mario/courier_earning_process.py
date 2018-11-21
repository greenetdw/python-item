
# -*- coding: UTF-8 -*-
from com.mario.utils.MysqlUtil import MysqlUtil
from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil
from com.mario.common_earning_process import checkTocashById
from com.mario.common_earning_process import checkTocashLessThanId

def getExpUserInfo():
    app = LocalMysqlUtil()
    sql = "select distinct username from earning_tocash_exp_20180628"
    result = app.fetchall(sql)
    return result

#打款最后一次提现前的提现检查
def checkCourierPayTocashBefore(username, lastTocashObtainId):
    print ''
    remoteApp = MysqlUtil()
    #获取之前的所有提现,看是否全部提现
    sql = "select * from obtain_earning_info where username = '%s' and  id <= %d and operate = -1" % (username, lastTocashObtainId)
    result = remoteApp.fetchall(sql)
    if result!=():
        print username
        for row in result : 
            obtain_id = row[0]
            checkTocashLessThanId(obtain_id, username) #发现在打款后提现的都是全额提现的
    else:
        print username
        

#打款最后一次提现后的提现检查
def checkCourierPayTocashAfter(username, lastTocashObtainId):
    remoteApp = MysqlUtil()
    sql = "select * from obtain_earning_info where username = '%s' and  id > %d and operate = -1" % (username, lastTocashObtainId)
    result = remoteApp.fetchall(sql)
    if result!=():
        for row in result : 
            obtain_id = row[0]
            checkTocashById(obtain_id, username) #发现在打款后提现的都是全额提现的

#快递小哥支付
def checkCourierRealPayTocash():
    app = LocalMysqlUtil()
    remoteApp = MysqlUtil()
    for row in getExpUserInfo() :
        
        username = row[0]
         
#         earningTocashExpTotalSql = "select round(sum(tocash),2) from earning_tocash_exp_20180628 where user_realname = '%s' " % username
#         earningTocashExpTotalResult = app.fetchone(earningTocashExpTotalSql)
        
        
        #2、核对付款信息，最后一条提现明细的金额对应的ID
        earningTocashExpSql = "select username, tocash, id from earning_tocash_exp_20180628 where username = '%s' order by create_time desc limit 1" % username
        earningTocashExpResult = app.fetchone(earningTocashExpSql)
        tocashUserName = earningTocashExpResult[0]
        tocash = earningTocashExpResult[1]
        tocashId = int(earningTocashExpResult[2])
        
        #与总账表的id去比对
        remoteObtainSQL = "select id, username, earning, earning_tocash_id from obtain_earning_info where username = '%s' and earning = %f and earning_tocash_id = %d" % (tocashUserName, tocash, tocashId)
        remoteObtainResult = remoteApp.fetchone(remoteObtainSQL)
        lastTocashObtainId = remoteObtainResult[0]
        lastEarningTocashId = remoteObtainResult[3]
    #         print "last tocash id = %d, username = %s, earning = %.2f, earning_tocash_id = %d" % (lastTocashObtainId, remoteObtainResult[1], remoteObtainResult[2], lastEarningTocashId)
        
        
        
        #拿到付款用户， 最后一次提现id前的最后一次收益id
        remoteCutoffEarningIdSQL = "select max(id) from obtain_earning_info where username = '%s' and  id <= %d and operate = 1" % (tocashUserName, lastTocashObtainId)
        remoteCutoffEarningIdRs = remoteApp.fetchone(remoteCutoffEarningIdSQL)
        cutoffEarningId = remoteCutoffEarningIdRs[0]
    #         print "cutoffEarningId : %d" % cutoffEarningId
        
        #print '付款最后一次提现之前（含最后一次)的提现'
        #checkCourierPayTocashBefore(tocashUserName, lastTocashObtainId)
        
    
        #print '付款最后一次提现之后的提现'
        checkCourierPayTocashAfter(tocashUserName, lastTocashObtainId)
        print ''
        #print '--------------------------------------'
    
    
if __name__ == "__main__":
    checkCourierRealPayTocash()
