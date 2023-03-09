#!/usr/bin/env python3

from flask import Flask, request, jsonify
import requests, random, json, os

app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    return jsonify({ "welcome page" : "Please append /welcome in URL", "data": "Please append /data in URL" })

@app.route('/welcome', methods=['GET'])
def welcome():
    return jsonify({ "message" : "welcome" })

@app.route('/data', methods=['GET'])
def bye():
    path = "/app"
    dir_list = os.listdir(path)
    return dir_list


if __name__ == "__main__":
    # app.run(debug=True, host="0.0.0.0", ssl_context='adhoc')
    app.run(debug=True, host="0.0.0.0", ssl_context=('/tmp/cert.pem', '/tmp/key.pem'))


