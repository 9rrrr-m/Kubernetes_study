from flask import Flask
app = Flask(__name__)

@app.route('/')
def python_world():
    return 'Hello, Docker!'
