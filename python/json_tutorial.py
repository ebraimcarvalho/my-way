import json

person = {
  'name': 'Ebraim',
  'age': 29,
  'city': 'João Pessoa',
  'hasChildren': False,
  'titles': ['engineer', 'programmer']
}

personJSON = json.dumps(person, sort_keys=True, indent=2, ensure_ascii=False)
print(personJSON)

with open('person.json', 'w', encoding='utf8') as file:
  json.dump(person, file, ensure_ascii=False, indent=4, sort_keys=True)