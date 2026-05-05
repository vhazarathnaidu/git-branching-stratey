plugins = ["git","workflow-aggregator","credentials","ssh-slaves",matrix-auth]

# write plugins to a file
with open("plugins.txt", "w") as f:
    for p in plugins:
        f.write(p + "\n")