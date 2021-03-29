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
  test_value(2)
except ValueTooHigher as e:
  print(e)
except ValueTooSmaller as e:
  print(f'{e.message}: {e.value}')
