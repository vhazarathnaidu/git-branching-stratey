def login_required(func):
    def wrapper():
        password = input("Enter password: ")
        if password == "1234":
            func()
        else:
            print("Access Denied")
    return wrapper

@login_required
def dashboard():
    print("Welcome to Dashboard")

dashboard()