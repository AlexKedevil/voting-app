from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return """
    <!DOCTYPE html>
    <html>
    <head>
        <title>Voting App - Packer & Ansible</title>
        <style>
            body { font-family: Arial, sans-serif; background-color: #f4f4f9; text-align: center; padding-top: 50px; }
            h1 { color: #333; }
            .container { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); display: inline-block; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Voting App (Packer + Ansible)</h1>
        </div>
    </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)  # nosec
