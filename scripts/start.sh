#!/bin/bash

# Navigate to your application directory
cd /home/ec2-user/my_celery_app

# Activate the Poetry environment (if necessary)
# source /home/ec2-user/my_celery_app/.venv/bin/activate

# Start Celery in the background
nohup poetry run celery -A app worker --loglevel=info > celery.log 2>&1 &

# Optionally, you can output the PID to a file
echo $! > celery.pid
