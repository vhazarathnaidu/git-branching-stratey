import threading
def greet(name):
    print("hello", name)
	
t = threading.Thread(target = greet, args=("venkatesh",))
t.start()