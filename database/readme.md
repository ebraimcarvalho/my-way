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