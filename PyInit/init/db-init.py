# -*- coding: UTF-8 -*-
import sqlite3
conn = sqlite3.connect('test.db')

#获取游标对象
cur = conn.cursor()

#执行一系列SQL语句
#建立一个表
cur.execute("CREATE TABLE demo(num int,str varchar(20));")
# 插入一些记录
cur.execute("INSERT INTO demo VALUES (%d, '%s')" % (1, 'aaa'))
cur.execute("INSERT INTO demo VALUES (%d, '%s')" % (2, 'bbb'))
cur.execute("INSERT INTO demo VALUES (%d, '%s')" % (3, 'ccc'))

#更新一条记录
cur.execute("UPDATE demo SET str='%s' WHERE num = %d" % ('ddd', 3))

#查询
cur.execute("SELECT * FROM demo;")
rows = cur.fetchall()       
print "number of records: ", len(rows)
for i in rows:
    print i

#提交事务
conn.commit()

#关闭游标对象
cur.close()

#关闭数据库连接
conn.close()