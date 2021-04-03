import copy

# org = [0,1,2,3,4]
# cpy = copy.copy(org)
# cpy[0] = -10

# org2 = [0,1,2,3,4]
# cpy2 = org2
# cpy2[0] = -10

# print(org)
# print(cpy)

# print(org2)
# print(cpy2)

# org = [[1,2,3,4], [4,5,6,7,8]]
# cpy = copy.deepcopy(org)
# cpy[0][1] = -210

# print(org)
# print(cpy)

class Person:
  def __init__(self, name, age):
    self.name = name
    self.age = age

class Company:
  def __init__(self, boss, employee):
    self.boss = boss
    self.employee = employee

p1 = Person('Ebraim', 29)
p2 = Person('Brenda', 27)

company = Company(p1, p2)
copy_company = copy.deepcopy(company)
copy_company.boss.age = 55
print(copy_company.boss.age)
print(company.boss.age)