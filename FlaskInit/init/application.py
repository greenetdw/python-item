# -*- coding: utf-8 -*-

from flask import render_template
from flask import Flask
from flask import abort , redirect

app = Flask(__name__)

@app.route('/hello')
@app.route('/hello/<name>')
def hello(name=None):
    return render_template('hello.html', name=name)

@app.route('/')
def index():
    return redirect('/check')

@app.route('/check', methods=['GET'])
def f_check():
    abort(400)
    
@app.errorhandler(400)
def bad_request(error):
    return render_template('bad_request.html'), 400

if __name__ == '__main__':
    app.run()