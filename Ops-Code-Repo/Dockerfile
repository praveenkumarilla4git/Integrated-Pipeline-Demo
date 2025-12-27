# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy all files (app.py and templates/) into the container
COPY . .

# 1. INSTALL FLASK (This was missing)
RUN pip install flask

# 2. USE 'CMD' INSTEAD OF 'RUN' to start the app
CMD ["python", "app.py"]
