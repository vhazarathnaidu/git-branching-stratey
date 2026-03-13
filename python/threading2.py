import threading
def task():
    print("task is compleded")
   
def complete():
    print("complete thread")
	
t1 = threading.Thread(target = task)

t2 = threading.Thread(target = complete)


t1.start()
t2.start()
 