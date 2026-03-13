import os

filename = "sample.txt"

def create_file():
    if not os.path.exists(filename):
        open(filename, "w").close()
        print("File Created")
    else:
        print("File already exists")

def write_file():
    with open(filename, "w") as f:
        f.write(input("Enter content: "))
    print("Content Written")

def read_file():
    if os.path.exists(filename):
        with open(filename, "r") as f:
            print(f.read())
    else:
        print("File not found")

def add_file():
    with open(filename, "a") as f:
        f.write("\n" + input("Enter content to add: "))
    print("Content Added")

def update_file():
    if os.path.exists(filename):
        with open(filename, "r") as f:
            old = f.read()
        print("Old Content:\n", old)
        with open(filename, "w") as f:
            f.write(input("Enter new content: "))
        print("File Updated")
    else:
        print("File not found")

def delete_file():
    if os.path.exists(filename):
        os.remove(filename)
        print("File Deleted")
    else:
        print("File not found")

while True:
    choice = input("\ncreate/write/read/add/update/delete/exit: ").lower()

    if choice == "create":
        create_file()
    elif choice == "write":
        write_file()
    elif choice == "read":
        read_file()
    elif choice == "add":
        add_file()
    elif choice == "update":
        update_file()
    elif choice == "delete":
        delete_file()
    elif choice == "exit":
        break
    else:
        print("Invalid choice")