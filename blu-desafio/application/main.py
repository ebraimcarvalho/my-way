from flask import Flask, request, jsonify
from datetime import datetime
import requests
import sqlite3
import pandas as pd

app = Flask(__name__)

def get_db_connection():
    conn = sqlite3.connect('database.db')
    conn.row_factory = sqlite3.Row
    return conn

def insert_data(req, conn):
    if req.status_code == 200:
        data = req.json()
        sql = "INSERT INTO personagens (gender, hair_color, height, homeworld, mass, name, skin_color) VALUES (?,?,?,?,?,?,?)"
        for item in data['results']:
            cursor = conn.execute(sql, (item['gender'], item['hair_color'], item['height'], item['homeworld'], item['mass'], item['name'], item['skin_color']))
            conn.commit()
    return data

@app.route('/personagens', methods=['GET', 'POST'])
def hello():
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == 'GET':
        cursor = conn.execute('SELECT * FROM personagens')
        result = [dict(id=row[0], author=row[1], gender=row[2], hair_color=row[3], height=row[4], homeworld=row[5], mass=row[6], name=row[7], skin_color=row[8]) for row in cursor.fetchall()]
        if result is not None:
            conn.close()
            return jsonify(result)
        conn.close()
    conn.close()
    return {'message': f'''
                <h1>Hello World!</h1>
                <p>Ebraim Carvalho</p>
                <small>{datetime.now()}</small>
         '''
    }

@app.route('/send_data', methods=['GET'])
def post_data():
    conn = get_db_connection()
    cursor = conn.cursor()
    if request.method == 'GET':
        r = requests.get('https://swapi.dev/api/people')
        output = []
        data = insert_data(r, conn)
        output.append(data['results'])
        while data['next']:
            r = requests.get(data['next'])
            data = insert_data(r, conn)
            output.append(data['results'])
        flat_list = [item for sublist in output for item in sublist]
        
        df = pd.read_sql_query("SELECT * FROM personagens", conn)
        df.to_parquet('personagens.parquet', index = False)
        conn.close()
        return f"""
            <h3>{len(flat_list)} registros adicionados</h3>
            <p>Visite este <a href="http://127.0.0.1:5000/personagens" target="_blank">link</a> para visualizar todos os registros</p>
        """
    conn.close()
    return {'erro': 'Erro ao carregar dados...'}

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)