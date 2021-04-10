import json

# dumps: get json and generate string
# loads: get a string and generate a json
# load: read json into a python dict
# dump: write object as json into a file

person = {
  'name': 'Ebraim',
  'age': 29,
  'city': 'João Pessoa',
  'hasChildren': False,
  'titles': ['engineer', 'programmer']
}

personString = """{
  "name": "Ebraim",
  "method": "dump"
}
"""

personDictionary = {
  "name": "Ebraim",
  "method": "dump"
}

personStringDump = json.dumps(personDictionary, sort_keys=True, indent=2, ensure_ascii=False) #get dictionary and convert into string
personDict = json.loads(personString) #get a string and converto into a json object
print(type(personStringDump)) #string
print(type(personDict)) #dict

## Next line we are write in a file person_with_dump.json with our string like a json
with open('person_with_dump.json', 'w', encoding='utf8') as file:
  json.dump(personString, file, ensure_ascii=False, indent=4, sort_keys=True)

getStringFileAndConvertToJson = json.loads(personString)
print(getStringFileAndConvertToJson == personDictionary) #true

with open('person_with_dump.json', 'r', encoding='utf8') as file:
  person2 = json.load(file) #loading like json
  print(person2)

personGetStringIntoDict = json.loads(person2) #get string and convert into a Dict
print(type(personGetStringIntoDict)) # dict

print('---------------- NEXT LEVEL -----------------')

# Create a clas generator user with name and age
class User:
  def __init__(self, name, age):
    self.name = name
    self.age = age

user = User('Ebraim', 29)

# Function to serialize our User, called in dumps
def encode_user(o):
  if isinstance(o, User):
    return {'name': o.name, 'age': o.age, o.__class__.__name__:True}
  else:
    raise TypeError('Object of type User is not JSON serializable!')

userJsonIntoString = json.dumps(user, default=encode_user)
print(userJsonIntoString) # {"name": "Ebraim", "age": 29, "User": true}

userStringIntoJson = json.loads(userJsonIntoString)
print(type(userStringIntoJson)) # dict

# Let's write in a user.json our userStringIntoJson
with open('user.json', 'w', encoding='utf8') as file:
  json.dump(userStringIntoJson, file, ensure_ascii=False, indent=4, sort_keys=True)