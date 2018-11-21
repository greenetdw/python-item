# -*- coding: UTF-8 -*-
from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil
import sys
reload(sys)
sys.setdefaultencoding('utf8')  

if __name__ == "__main__":
    
    app = LocalMysqlUtil()
    sql = "select distinct account,dot_code from xiaoge_gz where account in (select account from app_user_temp_account where dot_code is null)"
    result_all_obtain = app.fetchall(sql)
    for row in result_all_obtain:
        account = row[0]
        dot_code = row[1]
        gen_sql = "update app_user_temp_account set province='广东省', city='广州市', adcode='440100', dot_code='%s' where account = '%s' and dot_code is null;" % (dot_code, account)
        print gen_sql
