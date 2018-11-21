
# -*- coding: UTF-8 -*-
import traceback
import MySQLdb
from com.mario.utils.MysqlUtil import MysqlUtil
from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil
from com.mario.common_earning_process import checkTocashById
from com.mario.common_earning_process import checkTocashLessThanId

#检查收益台账表的总金额    与    收益总账表的总金额    不符的记录
def checkTotalEarning():
    app = MysqlUtil()
    totalResults = allUsers()
    for row in totalResults:
        username = row[1]
        earning_balance = round(float(row[2]), 2)
        
        #ID由小到大排列
        obtainSql = "select earning , operate from obtain_earning_info where username = '%s' order by id" % (username)
        obtainResults = app.fetchall(obtainSql)
          
        totalObtain = 0.0
        for obtainRow in obtainResults:
            obtainEarning = obtainRow[0]
            obtainOperate = int(obtainRow[1])
            if obtainOperate == 1 :
                totalObtain = round(totalObtain + obtainEarning, 2)
            else:
                totalObtain = round(totalObtain - obtainEarning, 2)
                
                  
        totalObtain = round(totalObtain, 2)
          
        if(totalObtain != earning_balance):
            print "username:%s, total_earning:%.2f, obtain_total:%.2f" % (username, earning_balance, totalObtain)
            

def allUsers():
    app = MysqlUtil()
    totalSql = "SELECT * FROM app_user_total_info"
    totalResults = app.fetchall(totalSql)
    return totalResults

#检查提现金额
def checkTocash():
    app = MysqlUtil()
    totalResults = allUsers()
    for row in totalResults:
        username = row[1]
        obtainSql = "select earning, operate, id, create_time from  obtain_earning_info where username = '%s' and operate = -1 order by id desc limit 1" % username
        #查询提现前的所有的账目
        maxTocashObtainResults = app.fetchone(obtainSql)
        if maxTocashObtainResults == None:
            continue
        
        #最后一次提现金额
        lastTocashEarning = maxTocashObtainResults[0];
        lastTocashId = maxTocashObtainResults[2]
        lastCreateTime = maxTocashObtainResults[3]
        
        #查询这次提现之前的金额
        checkAddObtainSql = "select round(sum(earning), 2) from obtain_earning_info where username = '%s' and operate = 1 and id < %d" % (username, lastTocashId)
        checkSubObtainSql = "select round(sum(earning), 2) from obtain_earning_info where username = '%s' and operate = -1 and id < %d" % (username, lastTocashId)
        
        checkAddResult = app.fetchone(checkAddObtainSql)
        if checkAddResult[0] == None:
            checkAddResult = 0.0
        else:
            checkAddResult = checkAddResult[0]
        
        checkSubResult = app.fetchone(checkSubObtainSql)
        if checkSubResult[0] == None:
            checkSubResult = 0.0
        else:
            checkSubResult = checkSubResult[0]
            
        checkResult = round(checkAddResult - checkSubResult, 2)
        if lastTocashEarning != checkResult:
            print "username : %s, lastTocashEarning : %.2f, checkResult : %.2f,  lastTocashId : %d, lastCreateTime : %s" % (username, lastTocashEarning, checkResult, lastTocashId, lastCreateTime)


#打款最后一次提现前的提现检查
def checkSocialPayTocashBefore(username, lastTocashObtainId):
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
def checkSocialPayTocashAfter(username, lastTocashObtainId):
    remoteApp = MysqlUtil()
    sql = "select * from obtain_earning_info where username = '%s' and  id > %d and operate = -1" % (username, lastTocashObtainId)
    result = remoteApp.fetchall(sql)
    if result!=():
        for row in result : 
            obtain_id = row[0]
            checkTocashById(obtain_id, username) #发现在打款后提现的都是全额提现的

#社会人士支付（27人）
def checkSocialRealPayTocash():
    app = LocalMysqlUtil()
    remoteApp = MysqlUtil()
    #1、核对总账
    payInfoSql = "select earning, username from pay_info";
    payInfoResult = app.fetchall(payInfoSql);
    for payInfoRow in payInfoResult :
#         earning = payInfoRow[0]
        username = payInfoRow[1]
        
        #1、核实总账与打款的是否相等，目前验证是相等的 
#         earningTocashExpTotalSql = "select round(sum(tocash),2) from earning_tocash_exp_20180705 where user_realname = '%s' " % username
#         earningTocashExpTotalResult = app.fetchone(earningTocashExpTotalSql)
#         if earning != earningTocashExpTotalResult[0]:
#             print "username : %s , earning : %.2f , earningTocashExpResult:%.2f" % (username, earning, earningTocashExpTotalResult[0])
        
        
        #2、核对付款信息，最后一条提现明细的金额对应的ID
        earningTocashExpSql = "select username, tocash, id from earning_tocash_exp_20180705 where user_realname = '%s' order by create_time desc limit 1" % username
        earningTocashExpResult = app.fetchone(earningTocashExpSql)
        tocashUserName = earningTocashExpResult[0]
        tocash = earningTocashExpResult[1]
        tocashId = int(earningTocashExpResult[2])
        
        #3、与台账表的id去比对
        remoteObtainSQL = "select id, username, earning, earning_tocash_id from obtain_earning_info where username = '%s' and earning = %f and earning_tocash_id = %d" % (tocashUserName,tocash,tocashId)
#         print remoteObtainSQL
        remoteObtainResult = remoteApp.fetchone(remoteObtainSQL)
        lastTocashObtainId = remoteObtainResult[0]
        lastEarningTocashId = remoteObtainResult[3]
#         print "last tocash id = %d, username = %s, earning = %.2f, earning_tocash_id = %d" % (lastTocashObtainId, remoteObtainResult[1], remoteObtainResult[2], lastEarningTocashId)
        
        #拿到付款用户， 最后一次提现id前的最后一次收益id
        remoteCutoffEarningIdSQL = "select max(id) from obtain_earning_info where username = '%s' and  id <= %d and operate = 1" % (tocashUserName, lastTocashObtainId)
        remoteCutoffEarningIdRs = remoteApp.fetchone(remoteCutoffEarningIdSQL)
        cutoffEarningId = remoteCutoffEarningIdRs[0]
#         print "cutoffEarningId : %d" % cutoffEarningId
        print '付款最后一次提现之前（含最后一次)的提现'
        checkSocialPayTocashBefore(tocashUserName, lastTocashObtainId)
            
        #拿到付款对应的最后的那次提现
#         sql = "select * from earning_tocash_info where id = %d" % lastEarningTocashId
#         result = remoteApp.fetchone(sql)
#         devices_id = result[2]
#         aplipay = result[3]
#         weixin = result[4]
#         create_time = result[6]
        
#         
#         sql = "insert into earning_tocash_info(id, username, devices_id, aplipay, weixin, tocash, create_time, \
#         confirm_user, confirm_time, payment_type, payment_account, tocash_time, tocash_id , payment_remark, cutoff_earnging_id \
#         status, update_time) values (%d, 1, %d)" % (lastEarningTocashId, username, )
#         print sql


#         sql = "insert into earning_tocash_info(id, username, devices_id, aplipay, weixin, tocash, create_time, \
#         confirm_user, confirm_time, payment_type, payment_account, tocash_time, tocash_id , payment_remark, cutoff_earnging_id \
#         status, update_time) values (%d, 1, %d)" % (lastEarningTocashId, username, devices_id, aplipay, weixin, earning, create_time, 
#         )
#         print sql
        print '付款最后一次提现之后的提现'
        checkSocialPayTocashAfter(tocashUserName, lastTocashObtainId)
        print '--------------------------------------'        
                
                
        
    
if __name__ == "__main__":
#     checkTotalEarning()
#     checkTocash()                   
    checkSocialRealPayTocash()
    
   
    
    


