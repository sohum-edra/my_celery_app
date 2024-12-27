#!/bin/bash

# Enable strict error handling and debug mode
set -euo pipefail
set -x

# Define log file for debugging
LOG_FILE=/home/ec2-user/my_celery_app/setup.log

# Redirect all output to the log file
exec > >(tee -i "$LOG_FILE") 2>&1

# Function to log messages with timestamp
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") : $1"
}

log "Starting setup.sh script."

APP_DIR="/home/ec2-user/my_celery_app"
ENV_PATH="$APP_DIR/.env"

cd "$APP_DIR" || { log "Application directory not found!"; exit 1; }

log "Installing dependencies with Poetry (no-root)..."
poetry install --no-root

log "Fetching SSM parameters..."
PARAMETERS=$(aws ssm get-parameters-by-path \
    --path "/my-app/env/" \
    --with-decryption \
    --query 'Parameters[*].[Name,Value]' \
    --output text)

log "Creating .env file..."
echo "# Environment Variables" > "$ENV_PATH"
while IFS=$'\t' read -r name value; do
    key=$(basename "$name")
    echo "$key=$value" >> "$ENV_PATH"
done <<< "$PARAMETERS"

log "Setting permissions for .env file..."
chmod 600 "$ENV_PATH"

log ".env file created successfully:"
cat "$ENV_PATH"

log "Completed setup.sh script."
exit 0
