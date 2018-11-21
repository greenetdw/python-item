# -*- coding: UTF-8 -*-
import sys

def init():
    try:
        myList = [4, 6]
        print myList[10]
    except ZeroDivisionError, e:
        print "ZeroDivisionError happened"
        print e
    except (IndexError, EOFError), e:
        print "Exception happened"
        print e
    except :
        print "Unkown exception happened"
    else:
        print "No exception happpened"
    finally:
        print "Process finished"
        
class MyError(Exception):
    def __str__(self):
        return "I'm a self-defined Error!"
    
def call():
    try :
        if len(sys.argv) == 1:
            raise MyError()
    except MyError, e:
        print e

if __name__ == '__main__':
#     init()
    call()






