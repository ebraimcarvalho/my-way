### Database

Databases: A database is a structured repository or collection of data that is stored and retrieved electronically for use in applications. Data can be stored, updated, or deleted from a database.

Database Management System (DBMS): The software used to access the database by the user and application is the database management system. Check out these few links describing a DBMS in more detail.

### Data Modeling

An abstraction that organizes elementes of data and how they will relate to each other.

- Data Organization: The organization of the data for your applications is extremely important and makes everyone's life easier.
- Use cases: Having a well thought out and organized data model is critical to how that data can later be used. Queries that could have been straightforward and simple might become complicated queries if data modeling isn't well thought out.
- Starting early: Thinking and planning ahead will help you be successful. This is not something you want to leave until the last minute.
- Iterative Process: Data modeling is not a fixed process. It is iterative as new requirements and data are introduced. Having flexibility will help as new information becomes available.

### Intro to Relational Databases

This model organizes data into one or more tables of columns and rows, with a unique key identifying each row. Generaly, each table represents one 'entity type' (such as customer or product).

Is a digital database based on the relational model of data... a software system use to maintain relational databases is a relational database management system (RDBMS)

SQL (Structured Query Language) is the language use across almost all relational database system for querying and maintaining the database.

Database/Schema is a collection of tables;
Tables/Relation is a group of rows sharing the same labeled elements.

Column/Attribute is a labeled element
Rows/Tuple is a single item.

#### When To Use A Relational Databases PROS-

*Advantages of Using a Relational Database*

- Flexibility for writing in SQL queries: With SQL being the most common database query language.

- Modeling the data not modeling queries

- Ability to do JOINS

- Ability to do aggregations and analytics

- Secondary Indexes available : You have the advantage of being able to add another index to help with quick searching.

- Smaller data volumes: If you have a smaller data volume (and not big data) you can use a relational database for its simplicity.

- ACID Transactions: Allows you to meet a set of properties of database transactions intended to guarantee validity even in the event of errors, power failures, and thus maintain data integrity.

- Easier to change to business requirements

#### ACID TRANSACTIONS

ACID Transactions
Properties of database transactions intended to guarantee validity even in the event of errors or power failures.

Atomicity: The whole transaction is processed or nothing is processed. A commonly cited example of an atomic transaction is money transactions between two bank accounts. The transaction of transferring money from one account to the other is made up of two operations. First, you have to withdraw money in one account, and second you have to save the withdrawn money to the second account. An atomic transaction, i.e., when either all operations occur or nothing occurs, keeps the database in a consistent state. This ensures that if either of those two operations (withdrawing money from the 1st account or saving the money to the 2nd account) fail, the money is neither lost nor created. Source Wikipedia for a detailed description of this example.

Consistency: Only transactions that abide by constraints and rules are written into the database, otherwise the database keeps the previous state. The data should be correct across all rows and tables. Check out additional information about consistency on Wikipedia.

Isolation: Transactions are processed independently and securely, order does not matter. A low level of isolation enables many users to access the data simultaneously, however this also increases the possibilities of concurrency effects (e.g., dirty reads or lost updates). On the other hand, a high level of isolation reduces these chances of concurrency effects, but also uses more system resources and transactions blocking each other. Source: Wikipedia

Durability: Completed transactions are saved to database even in cases of system failure. A commonly cited example includes tracking flight seat bookings. So once the flight booking records a confirmed seat booking, the seat remains booked even if a system failure occurs.
Source: Wikipedia.

#### When Not To Use A Relational Database

- Have large amounts of data: Relational Databases are not distributed databases and because of this they can only scale vertically by adding more storage in the machine itself. You are limited by how much you can scale and how much data you can store on one machine. You cannot add more machines like you can in NoSQL databases.

- Need to be able to store different data type formats: Relational databases are not designed to handle unstructured data.

- Need high throughput -- fast reads: While ACID transactions bring benefits, they also slow down the process of reading and writing data. If you need very fast reads and writes, using a relational database may not suit your needs.

- Need a flexible schema: Flexible schema can allow for columns to be added that do not have to be used by every row, saving disk space.

- Need high availability: The fact that relational databases are not distributed (and even when they are, they have a coordinator/worker architecture), they have a single point of failure. When that database goes down, a fail-over to a backup system occurs and takes time.

- Need horizontal scalability: Horizontal scalability is the ability to add more machines or nodes to a system to increase performance and space for data.

### NoSQL Databases

Has a simpler design, simpler horizontal scaling, and finer control of availability. Data structures used are different than those in Relational Database are make some operations faster.

Not Only SQL

Common Types of NoSQL Databases
Apache Cassandra (Partition Row Store)
MongoDB (Document Store)
DynamoDB (Key-Value Store)
Apache HBase (Wide Column Store)
Neo4J (Graph Database)

#### When To Use NoSQL Database PROS

- Need to be able to store different data type formats: NoSQL was also created to handle different data configurations: structured, semi-structured, and unstructured data. JSON, XML documents can all be handled easily with NoSQL.

- Large amounts of data: Relational Databases are not distributed databases and because of this they can only scale vertically by adding more storage in the machine itself. NoSQL databases were created to be able to be horizontally scalable. The more servers/systems you add to the database the more data that can be hosted with high availability and low latency (fast reads and writes).

- Need horizontal scalability: Horizontal scalability is the ability to add more machines or nodes to a system to increase performance and space for data

- Need high throughput: While ACID transactions bring benefits they also slow down the process of reading and writing data. If you need very fast reads and writes using a relational database may not suit your needs.

- Need a flexible schema: Flexible schema can allow for columns to be added that do not have to be used by every row, saving disk space.

- Need high availability: Relational databases have a single point of failure. When that database goes down, a failover to a backup system must happen and takes time.


#### When NOT To Use A NoSQL Database

- When you have a small dataset: NoSQL databases were made for big datasets not small datasets and while it works it wasn’t created for that.

- When you need ACID Transactions: If you need a consistent database with ACID transactions, then most NoSQL databases will not be able to serve this need. NoSQL database are eventually consistent and do not provide ACID transactions. However, there are exceptions to it. Some non-relational databases like MongoDB can support ACID transactions.

- When you need the ability to do JOINS across tables: NoSQL does not allow the ability to do JOINS. This is not allowed as this will result in full table scans.

- If you want to be able to do aggregations and analytics

- If you have changing business requirements : Ad-hoc queries are possible but difficult as the data model was done to fix particular queries

- If your queries are not available and you need the flexibility : You need your queries in advance. If those are not available or you will need to be able to have flexibility on how you query your data you might need to stick with a relational database

*REMEMBER*

NoSQL databases and Relational databases do not replace each other for all tasks.

Both do different tasks extremely well, and should be utilized for the use cases they fit best.

### Let's to learn the fundamentals of how to do relational data modeling by focusing on normalization, denormalization, fact/dimension tables, and different schema models.

#### Importance of Relational Databases:

- Standardization of data model: Once your data is transformed into the rows and columns format, your data is standardized and you can query it with SQL

- Flexibility in adding and altering tables: Relational databases gives you flexibility to add tables, alter tables, add and remove data.

- Data Integrity: Data Integrity is the backbone of using a relational database.

- Standard Query Language (SQL): A standard language can be used to access the data with a predefined language.

- Simplicity : Data is systematically stored and modeled in tabular format.

- Intuitive Organization: The spreadsheet format is intuitive but intuitive to data modeling in relational databases.


### OLAP vs OLTP

Online Analytical Processing (OLAP):

Databases optimized for these workloads allow for complex analytical and ad hoc queries, including aggregations. These type of databases are optimized for reads.

Online Transactional Processing (OLTP):

Databases optimized for these workloads allow for less complex queries in large volume. The types of queries for these databases are read, insert, update, and delete.

The key to remember the difference between OLAP and OLTP is analytics (A) vs transactions (T). If you want to get the price of a shoe then you are using OLTP (this has very little or no aggregations). If you want to know the total stock of shoes a particular store sold, then this requires using OLAP (since this will require aggregations).

### Normalization

The process of structuring a relational database in accordance with a series of normal forms in order to reduce data redundancy and increase data integrity

**Normalization** is about trying to increase data integrity by reducing the number of copies of the data. Data that needs to be added or updated will be done in as few places as possible.

Objectives of Normal Form:

- To free the database from unwanted insertions, updates, & deletion dependencies. Update in one place.

- To reduce the need for refactoring the database as new types of data are introduced

- To make the relational model more informative to users

- To make the database neutral to the query statistics

#### How to reach First Normal Form (1NF):

Atomic values: each cell contains unique and single values
Be able to add data without altering tables
Separate different relations into different tables
Keep relationships between tables together with foreign keys

#### Second Normal Form (2NF):

Have reached 1NF
All columns in the table must rely on the Primary Key

#### Third Normal Form (3NF):
Must be in 2nd Normal Form
No transitive dependencies

Remember, transitive dependencies you are trying to maintain is that to get from A-> C, you want to avoid going through B.
When to use 3NF:

When you want to update data, we want to be able to do in just 1 place. We want to avoid updating the table in the Customers Detail table (in the example in the lecture slide).

### Denormalization

Must be done on read heavy workloads to increase peformance, isn't natural, copy data in differents tables, adding redundant copies of data;

**Denormalization** is trying to increase performance by reducing the number of joins between tables (as joins can be slow). Data integrity will take a bit of a potential hit, as there will be more copies of the data (to reduce JOINS).

Reads will be faster (select)
Writes will be slower (insert, update, delete)

JOINS on the database allow for outstanding flexibility but are extremely slow. If you are dealing with heavy reads on your database, you may want to think about denormalizing your tables. You get your data into normalized form, and then you proceed with denormalization. So, denormalization comes after normalization.


### FACT AND DIMENSION TABLES

Fact tables consists of the measurements, metrics or facts of a business process.

Dimension tables is a structure that categorizes facts and measures in order to enable users to answer business questions.
Dimensions are people, products, place and time.

it helps to think about the Dimension tables providing the following information:

Where the product was bought? (Dim_Store table)
When the product was bought? (Dim_Date table)
What product was bought? (Dim_Product table)
The Fact table provides the metric of the business process (here Sales).

How many units of products were bought? (Fact_Sales table)

#### Implementing Different Schemas

Two of the most popular data mart schema for data warejouses are:

1. Star Schema
2. Snowflake Schema

#### Star Schema

Is the simples style of data mart schema. The star schema consists og one of more fact tables referencinf any number of dimensions tables. 

A fact table is at its center and Dimension tables surrounds the fact table representing the star's points.

Benefits:

- Denormalized
- Simplifies queries
- Fast Aggregations

Drawbacks:

- Issues that come with denormalization
- Data Integrity
- Decrease query flexibility
- Many to many relationships