# -*- coding: utf-8 -*-

import tornado.ioloop
import tornado.web
import tornado.httpclient

class MainHandler(tornado.web.RequestHandler):
#     def get(self):
#         self.write("Hello World")

    @tornado.web.asynchronous
    def get(self):
        http = tornado.httpclient.AsyncHTTPClient()
        http.fetch("http://news.ifeng.com/a/20180828/59985151_0.shtml", callback=self.on_response)
        
    def on_response(self, response):
        if response.error : raise tornado.web.HTTPError(500)
        self.write(response.body)
        self.finish()
        
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

