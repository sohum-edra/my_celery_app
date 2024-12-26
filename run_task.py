from app.tasks import add, multiply

if __name__ == "__main__":
    # Call the 'add' task
    result = add.delay(4, 6)
    print(f"Task ID: {result.id}")
    print(f"Result of add task: {result.get(timeout=10)}")  # Wait for the task to complete

    # Call the 'multiply' task
    result = multiply.delay(3, 7)
    print(f"Task ID: {result.id}")
    print(f"Result of multiply task: {result.get(timeout=10)}")  # Wait for the task to complete
