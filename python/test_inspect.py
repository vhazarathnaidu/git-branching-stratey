import inspect

def add(a,b):
    return a+b

print(inspect.getsource(add))