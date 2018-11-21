# -*- coding: UTF-8 -*-

def write_init():
    f = open("xxx.txt","w")
    f.write("hahaha")
    f.close()
    
def read_init():
    f = open("xxx.txt","r")
    content = f.read()
    print(content)
    f.close()

def copy_file():
    #1. 获取用户要复制的文件名
    old_file_name = input("请输入要复制的文件名:")
    
    #2. 打开要复制的文件
    old_file = open(old_file_name,"r")
    
    #test.py  -----> test[复件].py
    #new_file_name = "[复件]"+old_file_name
    position = old_file_name.rfind(".")
    new_file_name = old_file_name[:position] + "[复件]" + old_file_name[position:]
    
    #3. 新建一个文件
    #new_file = open("laowang.txt", "w")
    new_file = open(new_file_name, "w")
    
    #4. 从旧文件中读取数据,并且写入到新文件中
    while True:
        content = old_file.read(1024)
    
        if len(content)==0:
            break
    
        new_file.write(content)
    
    #5. 关闭2个文件
    old_file.close()
    new_file.close()    
    

def rename():
    import os
    #1. 获取要重命名的文件夹 名字
    folder_name =  input("请输入要重命名的文件夹:")
    
    #2. 获取制定的文件夹中的所有 文件名字
    file_names = os.listdir(folder_name)
    
    #os.chdir(folder_name)
    
    #3. 重命名
    for name in file_names:
        print(name)
        old_file_name = folder_name+"/"+name
        new_file_name = folder_name+"/"+"[京东出品]-"+name
        os.rename(old_file_name, new_file_name)

    
    
    
    
    
    
    
    