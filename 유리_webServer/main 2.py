from flask import Flask, render_template, request, jsonify
import os
import pymysql
from flask_mysqldb import MySQL

app = Flask(__name__)

@app.route("/")
def home():
    return render_template('index.html')

@app.route("/start.html", methods = ['POST', 'GET'])
def labeling():
    return render_template('start.html')

@app.route("/service.html")
def service():
    return render_template('service.html')

@app.route("/news.html")
def news():
    return render_template('news.html')

# post 방식 test
@app.route('/result.html', methods = ['POST', 'GET'])
def result():
    if request.method == 'POST':
        mysql = pymysql.connect(host='localhost',
                               user='root',
                               password='abcd',
                               db='classDB',
                               charset='utf8')
        cur = mysql.cursor()
        value = request.form # start.html에서 name을 통해 submit한 값들을 val 객체로 전달
        lists = list(value.values())
        sql = "INSERT INTO class (num, name)  VALUES (%s, %s)"
        val = (lists[0], lists[1])
        cur.execute(sql, val)

        mysql.commit()
        mysql.close()

    return render_template('start.html')
       # return render_template("result.html", result = value) # name은 key, name에 저장된 값은 value
