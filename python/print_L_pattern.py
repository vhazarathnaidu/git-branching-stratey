import sys

def print_L_pattern(a):
    for i in range(1, a + 1):
        for j in range(i):
            print('*', end=' ')
        print()

def print_reverse_L_pattern(a):
    for i in range(a, 0, -1):
        for j in range(i):
            print('*', end=' ')
        print()

def main():
    if len(sys.argv) < 2:
        print("Usage: python Lpattern.py <number> [normal/reverse]")
        return

    try:
        number = int(sys.argv[1])
    except ValueError:
        print("Please enter a valid number.")
        return

    if number <= 0:
        print("Please enter a positive number.")
        return

    # Default pattern = normal
    pattern_type = "normal"
    if len(sys.argv) == 3:
        pattern_type = sys.argv[2].lower()

    if pattern_type == "normal":
        print_L_pattern(number)
    elif pattern_type == "reverse":
        print_reverse_L_pattern(number)
    else:
        print("Invalid type. Use 'normal' or 'reverse'.")

if __name__ == "__main__":
    main()    