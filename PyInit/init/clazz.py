# -*- coding: UTF-8 -*-

class MyClass(object):
    
    #成员变量, 类和所有的Myclass对象共享该成员变量
    message = "Hello"
    
    def __init__(self, name = "unset"):
        #实例变量
        self.name = name
        print "构造函数"
        
    def __del__(self):
        print "析构函数 : %s" % self.name
    
    def show(self):
        print self.message
    
    @staticmethod
    def printMessage():
        print "printMessage is called"
        print MyClass.message
        
    #比staticmethod多了获取cls的信息
    @classmethod
    def createObj(cls, name):
        print "Object will be created:"
        return cls(name)
    
if __name__ == '__main__':
    MyClass.printMessage()
    inst = MyClass.createObj('tom')
    print inst.message
    del inst