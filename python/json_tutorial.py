import json

# person = {
#   'name': 'Ebraim',
#   'age': 29,
#   'city': 'João Pessoa',
#   'hasChildren': False,
#   'titles': ['engineer', 'programmer']
# }

# personJSON = json.dumps(person, sort_keys=True, indent=2, ensure_ascii=False)
# print(personJSON)

# with open('person.json', 'w', encoding='utf8') as file:
#   json.dump(person, file, ensure_ascii=False, indent=4, sort_keys=True)
# print(person)
# print('----------------------------------')
# person1 = json.loads(personJSON)
# print(person1 == person)

# with open('person.json', 'r', encoding='utf8') as file:
#   person2 = json.load(file)
#   print(person2)

class User:
  def __init__(self, name, age):
    self.name = name
    self.age = age

user = User('Ebraim', 29)

def encode_user(o):
  if isinstance(o, User):
    return {'name': o.name, 'age': o.age, o.__class__.__name__:True}
  else:
    raise TypeError('Object of type User is not JSON serializable!')

userJSON = json.dumps(user, default=encode_user)
print(type(userJSON))
user2 = json.loads(userJSON)
print(type(user2))

# with open('user.json', 'w', encoding='utf8') as file:
#   json.dump(user2, file, ensure_ascii=False, indent=4, sort_keys=True)