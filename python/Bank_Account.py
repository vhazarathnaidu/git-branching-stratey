class BankAccount:
    def __init__(self, name, balance):
        self.name = name
        self.balance = balance
        
    def deposit(self, amount):
        self.balance += amount
        
    def withdraw(self, amount):
        if amount <= self.balance:
            self.balance -= amount
        else:
            print("Insufficient balance")
        
    def display(self):
        print("Name:", self.name)
        print("Balance:", self.balance)



name = input("Enter account name: ")
balance = int(input("Enter initial balance: "))

acc = BankAccount(name, balance)

deposit_amount = int(input("Enter deposit amount: "))
acc.deposit(deposit_amount)

withdraw_amount = int(input("Enter withdraw amount: "))
acc.withdraw(withdraw_amount)

acc.display()
        