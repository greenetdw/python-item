# -*- coding: utf-8 -*-

import tornado.ioloop
import tornado.web
import tornado.httpclient

class MainHandler(tornado.web.RequestHandler):

    @tornado.gen.coroutine
    def get(self):
        http = tornado.httpclient.AsyncHTTPClient()
        response = yield http.fetch("http://news.ifeng.com/a/20180828/59985151_0.shtml")
        self.write(response.body)
        
        
def make_app():
    return tornado.web.Application([
        (r"/", MainHandler)
    ])
    
def main():
    app = make_app()
    app.listen(8888)
    tornado.ioloop.IOLoop.current().start()
    
if __name__ == '__main__':
    main()

