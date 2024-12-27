# scripts/setup.sh

# Go into your code directory
cd /home/ec2-user/my_celery_app

# Install dependencies
poetry install

# Create .env using SSM parameters
ENV_PATH="/home/ec2-user/my_celery_app/.env"
mkdir -p "$(dirname "$ENV_PATH")"

PARAMETERS=$(aws ssm get-parameters-by-path \
    --path "/my-app/env/" \
    --with-decryption \
    --query 'Parameters[*].[Name,Value]' \
    --output text)

echo "# Environment Variables" > "$ENV_PATH"
while IFS=$'\t' read -r name value; do
    key=$(basename "$name")
    echo "$key=$value" >> "$ENV_PATH"
done <<< "$PARAMETERS"

chown ec2-user:ec2-user "$ENV_PATH"
chmod 600 "$ENV_PATH"
