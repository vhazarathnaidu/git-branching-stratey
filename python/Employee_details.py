class Employee:

    def __init__(self, name, salary):
        self.name = name
        self.salary = salary

    def increment(self, percent):
        self.salary += self.salary * percent / 100
        self.salary = int(self.salary)

    def tax(self, percent):
        self.salary -= self.salary * percent / 100
        self.salary = int(self.salary)

    def display(self):
        print("Name:", self.name)
        print("Salary:", self.salary)
        print("-----------")


employees = []

n = int(input("How many employees: "))

for i in range(n):
    name = input("Enter name: ")
    salary = int(input("Enter salary: "))
    emp = Employee(name, salary)
    employees.append(emp)

increment_value = int(input("Enter increment %: "))
tax_value = int(input("Enter tax %: "))

for emp in employees:
    emp.increment(increment_value)
    emp.tax(tax_value)
    emp.display()
