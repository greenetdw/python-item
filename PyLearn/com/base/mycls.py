# -*- coding: UTF-8 -*-

class MyClass(object):
    
    message = 'Hello, Developer.'
    
    def show(self):
        print self.message
        print 'Here is %s in %s !' % (self.name, self.color)
        
    @staticmethod    
    def printMessage():
        print "printMessage is called"
        print MyClass.message
        
    @classmethod
    def createObj(cls, name, color):
        print 'Object will be created: %s (%s, %s)' % (cls.__name__, name, color)
        return cls(name, color)
        
    def __init__(self, name='unset', color='black'):
        self.name = name;
        self.color = color
        self.__age = 10
        
class Base(object):
    
    def __init__(self):
        print 'Construct Base'
        
    def __del__(self):
        print 'Destructor Base'
        
    def move(self):
        print 'move in Base'
        
class SubA(Base):
    def __init__(self):
        print 'Construct SubA'
     
class Tool(object):

    #类属性
    num = 0

    #方法
    def __init__(self, new_name):
        #实例属性
        self.name = new_name
        #对类属性+=1
        Tool.num += 1


tool1 = Tool("铁锹")
tool2 = Tool("工兵铲")
tool3 = Tool("水桶")

print(Tool.num)      

if __name__ == '__main__':    
         
    MyClass.printMessage()
    inst = MyClass.createObj("John", 'red')
    print inst.message
   
        
        