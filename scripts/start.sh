#!/bin/bash
cd /home/ec2-user/my_celery_app
# Example of using Poetry environment:
poetry run celery -A app worker --loglevel=info
