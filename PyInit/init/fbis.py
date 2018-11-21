# -*- coding: UTF-8 -*-
import time
from datetime import datetime

def fbis(num):
    result = [0, 1]
    for i in range(num -2):
        result.append(result[-2] + result[-1])
    return result

def main():
    result = fbis(10)
    fobj = open('c:\\result.txt', 'w+');
    for i , num in enumerate(result):
        print u"第%d个数是:%d" % (i, num)
        fobj.write("%d\n"%num)
        time.sleep(1)

def compute():
    #数值四舍五入
    data = round(12.23 + 32.456, 2)
    str_data = str(data)
    float_data = float(str_data)
#     print data
    print type(str_data)
    print type(float_data)
    
    #字符串基本操作
    str_data = "0e8cd06a-6ce0-4f93-abee-8bfc300bc5ca.zip"
    str_data = str_data[0:-4]
    str_data_arr = str_data.split("-")
    print str_data
    for str_tmp in str_data_arr:
        print str_tmp
    
    print len(str_data_arr)
    
def sequence():
    #tuple
    #list
    #set
    
    sample1 = set('understand')
    print sample1
    mylist = [4, 6.6, "python"]
    sample1 = set(mylist)
    print sample1
    
    sample1.add("init")
    print sample1
    
    for item in sample1:
        print item    
    #dict
    dict_a = {'k1':'v1', 'k2':0.9}
    print dict_a['k1']
    dict_a.update({'k3':9, 'k2':0.8})
    print dict_a
    dict_a.pop('k2')
    print dict_a
    
#匿名函数
def namedFunc(a):
    return "I'm named function with param %s" % a

def call_func(func, param):
    print datetime.now()
    print func(param)
    print ""
    
#匿名函数
        
if __name__ == '__main__':
#     main()
#     compute()
#     sequence()
#     print (lambda x, y : x -y)(3, 4)
#     call_func(namedFunc, 'hello')
#     call_func(lambda x : x*2, 9)
#     call_func(lambda y: y*y, 4)
    pass
