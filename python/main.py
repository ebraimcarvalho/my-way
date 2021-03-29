# name = input('Enter with your name: ')
# age = input('Your age: ')
# print(f"Hello {name}. You are {age} years old!")

# from functools import reduce
# text = input("Enter text: ")
# a = [1,2,3,4,5]
# print(f"dale {text}")
# b = reduce(lambda x, y: x + y, a,1)
# print(b)
try:
  a = 5 / 0
  print(a)
except Exception as e:
  print(f'Error: {e}')