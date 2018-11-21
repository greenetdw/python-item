# -*- coding: UTF-8 -*-
from com.mario.utils.LocalMysqlUtil import LocalMysqlUtil

if __name__ == "__main__":
    app = LocalMysqlUtil()
#     sql = "select distinct account from gz_xiaoge";
#     sql = "select distinct account from xiaoge_binghe";
#     sql = "select distinct account from xiaoge_shenzhen2"
#     sql = "select distinct account from xiaoge_shenzhen3 where account not in (select account from app_user_temp_account)"
#     sql = "select distinct account from xiaoge_guangzhou where account not in (select account from app_user_temp_account)"
#     sql = "select distinct account from xiaoge_shenzhen4 where account not in (select account from app_user_temp_account)"
#     sql = "select distinct account from xiaoge_guangzhou1 where account not in (select account from app_user_temp_account)"
    sql = "select distinct account from xiaoge_guangzhou1 limit 5"
    result_all_obtain = app.fetchall(sql)
    gen_sql = "insert into app_user_temp_account(account, source, status, create_time, update_time, remark) values "
    values_sql = "";
    for row in result_all_obtain:
#         gen_sql = "insert into app_user_temp_account(account, source, status, create_time, update_time, remark) values ('%s', 1, 1, now(), now(), null);" % (row[0])
        values_sql += "('" + row[0] + "', 1, 1, now(), now(), null), \n"
       
    values_sql = values_sql[0:-3]
    print gen_sql + values_sql + ";"
        
        
        



