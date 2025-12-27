# Stage 1: Build the HTML
FROM python:3.9-slim AS builder
WORKDIR /app
COPY app.py .
RUN python app.py

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=builder /app/index.html /usr/share/nginx/html/index.html
EXPOSE 80