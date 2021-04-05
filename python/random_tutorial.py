import random
import secrets
import numpy as np

myList = list('ABCDEFGH')
# a = random.choice(myList)
# random.shuffle(myList)
# print(myList)

# random.seed(2)
# print(random.random())
# print(random.randint(1, 10))

# random.seed(1)
# print(random.random())
# print(random.randint(1, 10))

# random.seed()
# print(random.random())
# print(random.randint(1, 10))

# a = secrets.randbelow(10)
# b = secrets.randbits(5)
# c = secrets.choice(myList)
# print(c)

a = np.random.rand()
b = np.random.rand(3, 3)
c = np.random.randint(0,10, (3, 4))

arr = np.array([[1,2,3], [4,5,6], [7,8,9]])
np.random.shuffle(arr)
# print(arr)

np.random.seed(1)
print(np.random.rand(3,3))

np.random.seed(2)
print(np.random.rand(3,3))