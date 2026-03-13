def decorator1(func):
    def wrapper():
        print("Decorator 1 - Before")
        func()
        print("Decorator 1 - After")
    return wrapper


def decorator2(func):
    def wrapper():
        print("Decorator 2 - Before")
        func()
        print("Decorator 2 - After")
    return wrapper


@decorator1
@decorator2
def greet():
    print("Hello")

greet()