def loan_details(name, amount, interest=5, years=1):
    total = amount + (amount * interest * years / 100)
    
    print("Name:", name)
    print("Loan Amount:", amount)
    print("Interest:", interest, "%")
    print("Years:", years)
    print("Total Amount to Pay:", total)


 
name = input("Enter name: ")
amount = float(input("Enter loan amount: "))
interest = float(input("Enter interest rate: "))
years = int(input("Enter years: "))

 
loan_details(name=name, amount=amount, interest=interest, years=years)