ENV_PATH="$HOME/my_celery_app/.env"

# Ensure the directory exists
mkdir -p "$HOME/my_celery_app"

# Fetch all parameters under the specified path
PARAMETERS=$(aws ssm get-parameters-by-path \
    --path "/my-app/env/" \
    --with-decryption \
    --query 'Parameters[*].[Name,Value]' \
    --output text)

# Write parameters to the .env file
echo "# Environment Variables" > "$ENV_PATH"
while IFS=$'\t' read -r name value; do
    # Extract the parameter key name (e.g., REDIS_BROKER_URL)
    key=$(basename "$name")
    echo "$key=$value" >> "$ENV_PATH"
done <<< "$PARAMETERS"

# Set appropriate permissions for the .env file
chown ec2-user:ec2-user "$ENV_PATH"
chmod 600 "$ENV_PATH"

# Output the .env file for verification (optional)
cat "$ENV_PATH"
