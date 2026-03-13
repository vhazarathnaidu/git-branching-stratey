def greet():
    yield "Hello"
    yield "Venkatesh"
    yield "Good Morning"

for msg in greet():
    print(msg)