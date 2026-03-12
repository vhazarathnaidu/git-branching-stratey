from abc import ABC, abstractmethod

class Vehicle(ABC):

    def __init__(self, brand):
        self.brand = brand

    @abstractmethod
    def start(self):
        pass


class Car(Vehicle):
    def start(self):
        print(self.brand, "Car Started")


class Bike(Vehicle):
    def start(self):
        print(self.brand, "Bike Started")



choice = input("Enter vehicle type (car/bike): ").lower()
brand = input("Enter brand name: ")

if choice == "car":
    v = Car(brand)
elif choice == "bike":
    v = Bike(brand)
else:
    print("❌ Error: Invalid vehicle type! Please enter car or bike.")
    exit()

v.start()