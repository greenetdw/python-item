# -*- coding: utf-8 -*-
from flask import Flask, jsonify, request, render_template
import sys
import paramiko

app = Flask(__name__)

@app.route('/')
def hello_world():
    return render_template('index.html', title="this is")

@app.route('/test_post/',methods=['POST','GET'])
def test_post():
    name=request.form.get('name')
    hostname = '192.168.136.128'
    command = str(name)
    port = 22
    username = "root"
    password = "123456"
    s = paramiko.SSHClient()
    s.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    s.connect(hostname, port, username, password)
    stdin, stdout, sterr = s.exec_command(command)
    z = stdout.read()
    s.close()
    return jsonify({'result': z})

if __name__ == "__main__":
    app.run(
        port=7777,
        debug=True
    )