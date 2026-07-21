n=int(input())
s = n
b=len(str(n))
sum1 = 0
While n!=0:
r = n%10
sum1 = sum1 + (r**b)
n = n//10
if s == sum1:
	print("Amstrong Number")
else:
	print("Not An Amstrong Number")
