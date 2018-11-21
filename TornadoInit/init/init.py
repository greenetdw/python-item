# -*- coding: utf-8 -*-


from tornado.httpclient import HTTPClient
from tornado.ioloop import IOLoop

from concurrent.futures import ThreadPoolExecutor

thread_pool = ThreadPoolExecutor(2)

def mySleep(count):
    import time
    for i in range(count):
        print i
        time.sleep(1)

def synchronous_visit():
    http_client = HTTPClient()
    response = http_client.fetch("http://news.ifeng.com/a/20180828/59985151_0.shtml")
    print response.body
    

def call_blocking():
    print "start"
    yield thread_pool.submit(mySleep(10))
    print "end"

# synchronous_visit()   
# asynchronous_visit()
if __name__ == '__main__':
    
#     IOLoop.current().run_sync(lambda:call_blocking())
    call_blocking()


