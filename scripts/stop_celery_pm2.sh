#!/bin/bash

# Define the PM2 process name
PROCESS_NAME=my-celery-app

# Check if the process is running
if pm2 describe "$PROCESS_NAME" > /dev/null 2>&1; then
    echo "Stopping Celery worker ($PROCESS_NAME) gracefully..."
    pm2 stop "$PROCESS_NAME"

    # Wait for the process to stop
    TIMEOUT=60  # seconds
    while pm2 describe "$PROCESS_NAME" > /dev/null 2>&1 && [ $TIMEOUT -gt 0 ]; do
        echo "Waiting for Celery to stop..."
        sleep 5
        TIMEOUT=$((TIMEOUT - 5))
    done

    if pm2 describe "$PROCESS_NAME" > /dev/null 2>&1; then
        echo "Celery did not stop within timeout. Forcing stop..."
        pm2 delete "$PROCESS_NAME"
    else
        echo "Celery stopped successfully."
    fi
else
    echo "Celery worker ($PROCESS_NAME) is not running."
fi
