from . import celery_app
import time
import logging
from dotenv import load_dotenv
import os

load_dotenv()

RANDOM_VALUE=os.getenv("RANDOM_VALUE")


@celery_app.task
def add(x, y):
    """A simple task to add two numbers."""
    logging.info(f"CALLED BY {RANDOM_VALUE}: update123")
    logging.info("Adding two numbers...")
    time.sleep(5)
    return x + y

@celery_app.task
def multiply(x, y):
    """A simple task to multiply two numbers."""
    logging.info(f"CALLED BY {RANDOM_VALUE}")
    logging.info("Multiplying two numbers...")
    time.sleep(5)
    return x * y
