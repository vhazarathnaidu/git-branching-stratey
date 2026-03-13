import threading
def ride():
   print("threadingcompleted")
t = threading.Thread(target = ride)
t.start()