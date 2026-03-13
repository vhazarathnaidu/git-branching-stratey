def calculator(a, b):
    print("Addition:", a + b)
    print("Subtraction:", a - b)
    print("Multiplication:", a * b)

    if b == 0:
        print("Error: Division by zero is not allowed")
    else:
        print("Division:", a / b)


def rectangle(length, width):
    if length <= 0 or width <= 0:
        print("Error: Length and Width must be greater than 0")
    else:
        print("Area:", length * width)
        print("Perimeter:", 2 * (length + width))
def student_details(name, age, branch):
    if age <= 0:
        print("Error: Age must be positive")
    else:
        print("Name:", name)
        print("Age:", age)
        print("Branch:", branch)


try:
    a = int(input("Enter first number: "))
    b = int(input("Enter second number: "))

    length = int(input("Enter rectangle length: "))
    width = int(input("Enter rectangle width: "))

    name = input("Enter name: ")
    age = int(input("Enter age: "))
    branch = input("Enter branch: ")

except ValueError:
    print("Error: Please enter valid numbers only")

else:
    calculator(a, b)
    rectangle(length, width)
    student_details(name, age, branch)
