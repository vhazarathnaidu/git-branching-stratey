import re

text = "venkateshroyal123_@gmail.com"

print(re.findall("\w+@\w+\.\w+", text))