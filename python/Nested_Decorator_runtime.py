def my_decorator(func):
    def wrapper():
        print("---- Program Started ----")
        func()
        print("---- Program Ended ----")
    return wrapper

@my_decorator
def main():

    def square(n):    
        print("Square is:", n * n)

    num = int(input("Enter a number: "))
    square(num)


main()