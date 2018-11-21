# -*- coding: utf-8 -*-
from tornado.httpclient import AsyncHTTPClient
from tornado import gen
import tornado.ioloop
from tornado.ioloop import IOLoop

def demoIterator():
    print "I'm first"
    yield 1
    print "I'm second"
    yield 3
    print "I'm thrid"
    yield 9

# for i in demoIterator():
#     print i
    
@gen.coroutine
def coroutine_visit():
    http_client = AsyncHTTPClient()
    response = yield http_client.fetch("http://news.ifeng.com/a/20180828/59985151_0.shtml")
    print response.body
    
    
@gen.coroutine
def outer():
    print "start call"
    yield coroutine_visit()
    print "end of outer"
    
def func_normal():
    print "start call"
#     IOLoop.current().run_sync(lambda:outer())
    IOLoop.current().spawn_callback(lambda:outer())
    print "end of call"
    
# tornado.ioloop.IOLoop.instance().start()
# func_normal()