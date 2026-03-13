def count():
    i = 1
    while True:
        yield i
        i += 1

gen = count()

print(next(gen))
print(next(gen))
print(next(gen))