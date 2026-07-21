def dector(func):
	def inner(x,y):
		print('#' * 40)
		print('The sum of {} and {} :'.format(x,y) , end = ' ')
		func(x,y)
		print('#' * 40)
	return inner


@dector
def add(a,b):
	print(a*b)
	print(a+b)
add(10,20)