# name = input('Enter with your name: ')
# age = input('Your age: ')
# print(f"Hello {name}. You are {age} years old!")


from functools import reduce
a = [1,2,3,4,5]

b = reduce(lambda x, y: x + y, a,2)
print(b)