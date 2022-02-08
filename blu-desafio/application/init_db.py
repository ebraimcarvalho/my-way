import sqlite3

connection = sqlite3.connect('database.db')

with open('schema.sql') as f:
    connection.executescript(f.read())

cur = connection.cursor()

cur.execute("INSERT INTO personagens (gender, hair_color, height, homeworld, mass, name, skin_color) VALUES (?,?,?,?,?,?,?)",('male', 'brown', '180', 'sim', '90', 'Ebraim', 'white'))

connection.commit()
connection.close()