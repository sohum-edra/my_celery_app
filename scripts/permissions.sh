#!/bin/bash

# Enable strict error handling
set -euo pipefail

# Function to log messages with timestamp
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") : $1"
}

log "Starting permissions.sh script."

# Set ownership to ec2-user:ec2-user
log "Setting ownership of /home/ec2-user/my_celery_app to ec2-user."
chown -R ec2-user:ec2-user /home/ec2-user/my_celery_app

# Set directory permissions to 755
log "Setting directory permissions to 755."
chmod -R 755 /home/ec2-user/my_celery_app

# Optionally, set file permissions to 644
log "Setting file permissions to 644."
find /home/ec2-user/my_celery_app -type f -exec chmod 644 {} \;

log "Completed permissions.sh script."
exit 0
