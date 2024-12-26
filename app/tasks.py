from . import celery_app
import time
import logging


@celery_app.task
def add(x, y):
    """A simple task to add two numbers."""
    logging.info("Adding two numbers...")
    time.sleep(5)
    return x + y

@celery_app.task
def multiply(x, y):
    """A simple task to multiply two numbers."""
    logging.info("Multiplying two numbers...")
    time.sleep(5)
    return x * y
