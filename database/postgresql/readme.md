### Comandos PostgreSQL

Open source object relational database system;

Uses and builds on SQL language

``` python
# For use in jupyter notebook
import psycopg2

conn = psycopg2.connect("host=localhost dbname=postgres user=postgres password=2020")

cur = conn.cursor()

conn.set_session(autocommit=True)

cur.execute("SELECT * FROM test")

cur.close()

conn.close()
```

``` sql
CREATE DATABASE udacity
CREATE TABLE test (col1, col2, col3);
SELECT COUNT(*) FROM test;
print(cur.fetchall())
DROP TABLE test;

CREATE TABLE IF NOT EXISTS music_library (album_name varchar, artist_name varchar, year int);

INSERT INTO music_library (album_name, artist_name, year) VALUES ("Let It Be", "The Beatles", 1970)
```