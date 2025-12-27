from flask import Flask, render_template
import datetime

app = Flask(__name__)

@app.route('/')
def hello_world():
    # Get current time
    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Render the HTML template (make sure templates/index.html exists!)
    return render_template('index.html', timestamp=current_time)

if __name__ == '__main__':
    # This keeps the server running forever!
    app.run(host='0.0.0.0', port=5000)