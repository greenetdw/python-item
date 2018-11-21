# -*- coding: utf-8 -*-

#xiaorui.cc
import tornado.ioloop
from tornado.httpclient import AsyncHTTPClient

def handle_request(response):
    '''callback needed when a response arrive'''
    if response.error:
        print "Error:", response.error
    else:
        print 'called'
        print response.body
        
http_client = AsyncHTTPClient()
for i in range(10):                                                
    http_client.fetch("http://news.ifeng.com/a/20180828/59985151_0.shtml", handle_request)
    

tornado.ioloop.IOLoop.instance().start()