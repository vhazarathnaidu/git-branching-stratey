import os

filename = "sample.bin"

def write_file():
    with open(filename, "wb") as f:
        data = input("Enter content: ")
        f.write(data.encode())
    print("Written successfully")

def read_file():
    if os.path.exists(filename):
        with open(filename, "rb") as f:
            data = f.read()

            print("\n--- Normal Text ---")
            print(data.decode())

            print("\n--- Bytes Format ---")
            print(data)

            print("\n--- Binary (0 & 1) ---")
            for byte in data:
                print(format(byte, '08b'), end=' ')
            print()
    else:
        print("File not found")

def delete_file():
    if os.path.exists(filename):
        os.remove(filename)
        print("File Deleted")
    else:
        print("File not found")

while True:
    choice = input("\nwrite/read/delete/exit: ").lower()

    if choice == "write":
        write_file()
    elif choice == "read":
        read_file()
    elif choice == "delete":
        delete_file()
    elif choice == "exit":
        break
    else:
        print("Invalid choice")