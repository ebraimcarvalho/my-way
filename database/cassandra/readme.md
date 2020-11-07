### Apache Cassandra

Keyspace: Collection of Tables
Table: A Group of partitions
Rows: A Single item

Partition: Fundamental unit of access, Collection of Rows, How data is distributed

Primary key: Primary key is made up of a partition key and clustering columns

Columns: Clustering and Data, Labeled element.

Apache Cassandra provides scalability and high availability without compromising performance. Linear Scalability and proven fault-tolerance on commodity hardware or cloud infrastructure make it the perfect platform for mission-critical data.

``` python
# for run in jupyter notebook
!pip install cassandra-driver
import cassandra

from cassandra.cluster import Cluster

cluster = Cluster(['127.0.0.1'])
session = cluster.connect()

session.execute("""SELECT * FROM music_library""")

session.execute("""
CREATE KEYSPACE IF NOT EXISTS udacity
WITH REPLICATION = 
{ 'class' : 'SimpleStrategy'. 'replication_factor' : 1 }
""")

session.set_keyspace('udacity)
query = "CREATE TABLE IF NOT EXISTS music_library"
query = query + "(year int, artist_name text, album_name text, PRIMARY KEY (year, artist_name))"
session.execute(query)

query = "INSERT INTO music_library (year, artist_name, album_name)"
query = query + " VALUES(%s, %s, %s)"

session.execute(query, (1970, "The Beatles", "Let It Be"))

session.execute(query, (1965, "The Beatles", "Rubber Soul"))

session.shutdown()
cluster.shutdown()
```

``` sql
SELECT COUNT(* FROM music_library)
SELECT * FROM music_library
SELECT * FROM music_library WHERE YEAR=1970
DROP TABLE music_library
```