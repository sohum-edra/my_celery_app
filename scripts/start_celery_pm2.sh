#!/bin/bash

APP_DIR="/home/ec2-user/my_celery_app"
PROCESS_NAME=my-celery-app

echo "Starting Celery worker with PM2..."

cd "$APP_DIR" || exit

# Check if the process exists, stop and delete it
if pm2 describe "$PROCESS_NAME" > /dev/null 2>&1; then
    echo "Existing process ($PROCESS_NAME) found. Stopping and deleting it..."
    pm2 stop "$PROCESS_NAME"
    pm2 delete "$PROCESS_NAME"
else
    echo "No existing process ($PROCESS_NAME) found."
fi

# Export environment variables from .env
export $(grep -v '^#' .env | xargs)

# Start Celery with PM2
pm2 start --name "$PROCESS_NAME" "poetry run celery -A app worker --loglevel=info" --time

# Save the PM2 process list and setup startup script
pm2 save
pm2 startup systemd -u ec2-user --hp /home/ec2-user

# Ensure PM2 starts on boot
sudo env PATH=$PATH:/usr/local/bin pm2 startup systemd -u ec2-user --hp /home/ec2-user
