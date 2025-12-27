import datetime

# 1. Get current time
now = datetime.datetime.now()

# 2. Define the website content
html_content = f"""
<!DOCTYPE html>
<html>
<head>
    <title>Integrated DevOps Pipeline</title>
    <style>
        body {{ background-color: #2D2D2D; color: #ffffff; font-family: Arial, sans-serif; text-align: center; padding-top: 50px; }}
        h1 {{ color: #4CAF50; }}
        .box {{ border: 2px solid #4CAF50; padding: 20px; display: inline-block; border-radius: 10px; }}
    </style>
</head>
<body>
    <div class="box">
        <h1>Deployment Successful!</h1>
        <h2>Version: 1.0</h2>
        <p>Managed by: <b>Jenkins & Ansible</b></p>
        <hr>
        <p>Timestamp: {now}</p>
    </div>
</body>
</html>
"""

# 3. Create the index.html file
with open("index.html", "w") as file:
    file.write(html_content)

print(f"SUCCESS: index.html created at {now}")