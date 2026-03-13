import sys

def print_tree_pattern(a):
    for i in range(1, a + 1):
        for k in range(a - i):
            print(end=' ')
        for j in range(i):
            print('*', end=' ')
        print()

def print_reverse_pattern(a):
    for i in range(a, 0, -1):
        for k in range(a - i):
            print(end=' ')
        for j in range(i):
            print('*', end=' ')
        print()

def main():
    if len(sys.argv) < 2:
        print("Usage: python treepattern.py <number> [normal/reverse]")
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
        print_tree_pattern(number)
    elif pattern_type == "reverse":
        print_reverse_pattern(number)
    else:
        print("Invalid type. Use 'normal' or 'reverse'.")

if __name__ == "__main__":
    main()
