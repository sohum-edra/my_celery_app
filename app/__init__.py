from celery import Celery
from dotenv import load_dotenv
import os

# Load environment variables from .env
load_dotenv()

# Get the Redis broker URL and backend from environment variables
REDIS_BROKER_URL = os.getenv("REDIS_BROKER_URL", "redis://localhost:6379/0")
REDIS_BACKEND = os.getenv("REDIS_BACKEND", "redis://localhost:6379/0")

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
)

# Import the tasks to ensure they are registered
from app import tasks  # noqa: E402, F401
