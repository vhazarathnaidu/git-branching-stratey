def add(a, b):
    print("Sum is:", a + b)

sum_func = add

x = int(input("Enter first number: "))
y = int(input("Enter second number: "))
sum_func(x, y)