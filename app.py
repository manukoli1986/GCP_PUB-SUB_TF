#!/usr/bin/env python3

from flask import Flask, request, jsonify
import requests, random, json

app = Flask(__name__)

@app.route('/welcome', methods=['GET'])
def welcome():
    return jsonify({ "message" : "welcome" })

@app.route('/bye', methods=['GET'])
def bye():
    return jsonify({ "message" : "bye" })

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)