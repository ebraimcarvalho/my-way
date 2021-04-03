# def foo(a, b, *args, **kwargs):
#   print(a, b)
#   for x in args:
#     print(x)
#   for key in kwargs:
#     print(key, kwargs[key])

# foo(1,2,3,4,5,six=6, seven=7)

def foo(a, b, c):
  print(a, b, c)

my_list = [1,2,3]
my_dict = {'a': 22, 'b': 33, 'c': 44}
# foo(*my_list)
# foo(**my_dict)

# def func():
#   global number
#   number = 3

# number = 0
# func()
# print(number)

# def func(x):
#   global var
#   var = 3

# var = 10
# func(var)
# print(var)

def changeList(a_list):
  a_list.append(4)
  a_list[0] = -100

my_list = [1,2,3]
changeList(my_list)
print(my_list)