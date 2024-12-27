#!/bin/bash

# Define the PM2 process name
PROCESS_NAME=my-celery-app

# Check if the process is running
if pm2 describe "$PROCESS_NAME" > /dev/null 2>&1; then
    echo "Celery worker ($PROCESS_NAME) is running."
    exit 0
else
    echo "Celery worker ($PROCESS_NAME) is not running."
    exit 1
fi
