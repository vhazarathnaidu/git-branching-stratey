 def even(n):
    for i in range(n):
        if i % 2 == 0:
            yield i

for num in even(10):
    print(num)