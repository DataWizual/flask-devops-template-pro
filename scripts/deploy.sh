#!/bin/bash
set -e

echo "Pulling latest image..."
docker pull eldordevops/flask-devops:latest

echo "Stopping old container (if running)..."
docker stop flask_app || true
docker rm flask_app || true

echo "Starting new container..."
docker run -d --name flask_app -p 5000:5000 eldordevops/flask-devops:latest

echo "Deployment complete. App running at http://localhost:5000"

