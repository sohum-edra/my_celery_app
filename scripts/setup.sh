#!/bin/bash

APP_DIR="/home/ec2-user/my_celery_app"
ENV_PATH="$APP_DIR/.env"

# Navigate to the application directory
cd "$APP_DIR" || exit

# Install dependencies without installing the current project
poetry install --no-root

# Fetch SSM parameters
PARAMETERS=$(aws ssm get-parameters-by-path \
    --path "/my-app/env/" \
    --with-decryption \
    --query 'Parameters[*].[Name,Value]' \
    --output text)

# Create the .env file
echo "# Environment Variables" > "$ENV_PATH"
while IFS=$'\t' read -r name value; do
    key=$(basename "$name")
    echo "$key=$value" >> "$ENV_PATH"
done <<< "$PARAMETERS"

# Adjust permissions
chown ec2-user:ec2-user "$ENV_PATH"
chmod 600 "$ENV_PATH"

# (Optional) Output the .env file for verification
cat "$ENV_PATH"
