from celery import Celery
from dotenv import load_dotenv
import os

# Load environment variables from .env
load_dotenv()

# Get the Redis broker URL and backend from environment variables
REDIS_BROKER_URL = os.getenv("REDIS_BROKER_URL")
REDIS_BACKEND = os.getenv("REDIS_BACKEND")

# Initialize the Celery app
celery_app = Celery(
    "my_celery_app",
    broker=REDIS_BROKER_URL,
    backend=REDIS_BACKEND,
)

# Optional Celery configurations
celery_app.conf.update(
    task_serializer="json",
    accept_content=["json"],  # Ignore other content
    result_serializer="json",
    timezone="UTC",
    enable_utc=True,
    broker_use_ssl={
        'ssl_cert_reqs': 'required',  # Ensure certificates are validated
    },
    redis_backend_use_ssl={
        'ssl_cert_reqs': 'required',  # Ensure certificates are validated
    },
)

# Import the tasks to ensure they are registered
from app import tasks  # noqa: E402, F401
