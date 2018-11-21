# -*- coding: utf-8 -*-

import tornado.web
import tornado.ioloop

session_id = 1

class MainHandler(tornado.web.RequestHandler):

    def get(self):
        global session_id
        if not self.get_secure_cookie("session"):
            self.set_secure_cookie("session", str(session_id))
            session_id = session_id + 1
            self.write("you session got a new session")
        else:
            self.write("you session was set!")
        

def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
    ], cookie_secret = "SECRET_DONT_LEAK")
    
def main():
    app = make_app()
    app.listen(8888)
    tornado.ioloop.IOLoop.current().start()
    
if __name__ == '__main__':
    main()


















