# name = input('Enter with your name: ')
# age = input('Your age: ')
# print(f"Hello {name}. You are {age} years old!")

# from functools import reduce
# text = input("Enter text: ")
# a = [1,2,3,4,5]
# print(f"dale {text}")
# b = reduce(lambda x, y: x + y, a,1)
# print(b)
# try:
#   a = 5 / 0
#   print(a)
# except Exception as e:
#   print('Error: {}'.format(e))

# Online Python compiler (interpreter) to run Python online.
# Write Python 3 code in this online editor and run it.
# a = -5
# assert (a > 0), 'should be a integer postive!!'
# if a<0:
#     raise Exception('variable "a" must be a positive')
    
# from functools import reduce
# def myFunc(e):
#   return e[1]
  
# points = [(1,2), (15,1), (5,-1), (10,4)]
# points_sorted = sorted(points, key=lambda x: x[1])
# points.sort(key=myFunc)
# # print(points)
# # print(points_sorted)

# a = [1,2,3,4,5]
# b = filter(lambda x: x % 2 == 0, a)
# c = [x for x in a if x % 2 == 0]
# # print(list(b))
# # print(c)

# d = reduce(lambda x, y: x + y, a, 1)
# print(d)

# val = 3.56987
# print(f"My name is {val:.2f}")
# from collections import Counter
# a = 'aaaaabbbbccc'
# my_counter = Counter(a)
# print(list(my_counter.elements()))
# time = int(input('Enter your time: '))
# print(f'Time is {time} and your type is {type(time).__name__}')
# import random
# from timeit import default_timer as timer

# chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%¨&*()_+=-?/:;>.<,]}~^[{´`0123456789'
# number = int(input('Amount of passwords to generate: '))
# length = int(input('Lenght of passwords: '))

# print('\nHere are your passwords...')

# passwords = []
# start = timer()
# for pwd in range(number):
#     password = ''
#     for c in range(length):
#         password += random.choice(chars)
#     print(password)
#     passwords.append(password)
# stop = timer()

# print(f'Total time spend in this operation: {stop - start}')

# try:
#   a = 5 // 0
#   b = a + 'as'
# except ZeroDivisionError as e:
#   print(f'Zero division error: {e}')
# except TypeError as e:
#   print(f'Error Type: {e}')
# else:
#   print('Everithing is fine!')
# finally:
#   print('Cleaning all')

import logging
# logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', datefmt='%m/%d/%Y %H:%M:%S')
logging.basicConfig()
logging.root.setLevel(logging.NOTSET)

logging.info('I told you so')

class ValueTooHigher(Exception):
  pass

class ValueTooSmaller(Exception):
  def __init__(self, message, value):
    self.message = message
    self.value = value

def test_value(x):
  if x > 100:
    raise ValueTooHigher("Value is too bigger")
  if x < 5:
    raise ValueTooSmaller("Value is too smaller", x)

try:
  logging.warning('I told you so')
  test_value(2)
except ValueTooHigher as e:
  logging.debug('I told you so')
  print(e)
except ValueTooSmaller as e:
  logging.debug('I told you so')
  print(f'{e.message}: {e.value}')