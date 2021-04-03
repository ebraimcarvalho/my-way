import sys

def firstn(n):
  nums = []
  num = 0
  while num < n:
    nums.append(num)
    num += 1
  return nums

def firstn_generator(n):
  nums = []
  num = 0
  while num < n:
    yield num
    nums.append(num)
    num += 1
  return nums

def fibonacci(limit):
  a, b = 0, 1
  while a < limit:
    yield a
    a, b = b, a + b

fib = fibonacci(30)
# for i in fib:
#   print(i)

# print(sys.getsizeof([i for i in fib]))
# print(sys.getsizeof(list((i for i in fib))))

# a = firstn(1000000)
# b = firstn_generator(1000000)

# print(sys.getsizeof(firstn(1000000)))
# print(sys.getsizeof(firstn_generator(1000000)))

gen = (i for i in range(10) if i % 2 == 0)
for i in gen:
  print(i)

print(sys.getsizeof([i for i in range(1000000) if i % 2 == 0]))
print(sys.getsizeof((i for i in range(1000000) if i % 2 == 0)))
print(gen)
