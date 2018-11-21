# -*- coding: UTF-8 -*-

import traceback
import sys

# studentSet = set([4,4,1,3,4])
# print studentSet

# dicts = {'title':'book'}
# dicts.update({'pages':45})
# print dicts


def show_message(message, *tupleName):
    for name in tupleName:
        print message, ", ", name
        
def check_book(**dictParam):
    if dictParam.has_key('Price'):
        price = int(dictParam['Price'])
        if price > 100:
            print 'i want to buy'
    print "book info"
    for key in dictParam.keys():
        print key, ":", dictParam[key]
    print ""

def test_error():
    try:
        result = 3 / 0
        print 'This is never been called'
    except:
        traceback.print_exc()
    finally:
        print  'except finished'   

class MyError(Exception):        
    
    def __init__(self, name = 'unset', color='black'):
        print 'Constructor, name:', name, ", color:", color
        
    def __del__(self):
        print '析构函数'
    
    def __str__(self, *args, **kwargs):
        return 'I am a self-defined Error'

def test_construct():
    inst = MyError()
    inst = MyError("davide")
    inst = MyError(color='red')

def main():
    try:
        print 'start of main'
        if len(sys.argv) == 1:
            raise MyError()
        print 'end of main'
    except MyError, e:
        print e

   
    
if __name__ == '__main__':
#     show_message("Good morning", "Jack", "Eureka")
#     check_book(author='James', Title='math book')
#     main()
#     high = input('请输入你的身高:')
    print ''
