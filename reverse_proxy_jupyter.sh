#!/bin/bash


# reverse proxy for a Jupyter Notebook server running in Docker

# Replace /path/to/notebooks with the path to your Jupyter Notebook files, yourdomain.com with your domain name, /path/to/ssl/certificate with the path to your SSL certificate and key 
files, and /path/to/reverse_proxy with the path to your reverse proxy directory.

# After saving this script to a file and making it executable with chmod +x script.sh, you can run it with ./script.sh to automatically set up your reverse proxy for your Jupyter Notebook 
server running in Docker.

# Install Docker and Docker Compose
sudo apt-get update
sudo apt-get install -y docker.io docker-compose

# Create Docker network for Jupyter Notebook server and reverse proxy
docker network create jupyter_network

# Start Jupyter Notebook server container
docker run -d --name jupyter-notebook --network jupyter_network -v /path/to/notebooks:/home/jovyan/work jupyter/datascience-notebook

# Create directory for reverse proxy configuration files
mkdir -p /path/to/reverse_proxy/config

# Create Nginx configuration file
cat > /path/to/reverse_proxy/config/nginx.conf <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name yourdomain.com;

    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name yourdomain.com;

    ssl_certificate /path/to/ssl/certificate;
    ssl_certificate_key /path/to/ssl/certificate/key;

    location / {
        proxy_pass http://jupyter-notebook:8888;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Create Docker Compose file
cat > /path/to/reverse_proxy/docker-compose.yml <<EOF
version: "3"
services:
  nginx:
    image: nginx:latest
    container_name: nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /path/to/reverse_proxy/config:/etc/nginx/conf.d
      - /path/to/ssl:/etc/ssl/private
    restart: always
    networks:
      - jupyter_network
EOF

# Start reverse proxy container
cd /path/to/reverse_proxy
docker-compose up -d

