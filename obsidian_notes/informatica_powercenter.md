#### Informatica PowerCenter

ETL tool provided by Informatica, is used for Data integration, offers the capacbility to connect and fetch data from differente source and processing data.

Typical use cases:

* Migrating data from existing legacy system like mainframe to a new database sytem;
* Setting up data warehouse that require an ETL tool to move data from production system to warehouse;
* Integration of data from various heterogeneous system like multiple databases and file-based systems;
* For data cleansing tool;

Informatica offers real time data integration, web services integration, business to business data integration, bi data edition, master data management and connectors for social media and Salesforce.

#### Informatica PowerCenter Architecture

1. Repository Service: Responsible for maintaining Informatica metadata and providing access of saame to other services;
2. Integration Service: Responsible for the movement of data from sources to targets;
3. Reporting Service: Enables the generation of reports;
4. Nodes: Computing platform where the above services are executed;
5. Powercenter Designer: User for creation of mappings between source and target;
6. Workflow Manager: Used to create workflows and other task and their execution;
7. Workflow Monitor: Used to monitor the execution of workflows;
8. Repository Manager: Used to manage objects in repository

![PowerCenter Architecture)](powercenter_architecture.png "PowerCenter")

#### Informatica Domain

It is a collection of nodes and services that can be categorized into folders and sub-folders based on the administration requirement.

Node is a logical representation of a machine insede the domain, Node is required to run services and processes for Informatica. You can have multiple node in a domain.

In a domain, you will also find a gateway node, that is responsible for receiving requests from different client tools and routing those requests to different nodes and services.

There are two types of services in Domain:

* Service manager: Maanages authentication, aauthorization and logging. Also runs application services on the nodes as well as manages users and groups;
* Application services: Represents the server specific like integration service, repository service and reporting service, these services run on differente nodes based upon the configuration

#### Informatica PowerCenter Repository

Is a Relational Database, like Oracle, Sybase, SQL Server and it is managed by repository service, tht consists of dtabase tables that stores metadata.

There are three Informatica Client tools availaable:

1. Designer
2. Workflow Monitor
3. Workflow Manager

These clientes can access to the repository using repository service only.

A single repository service handles only one repository. Also, a repository service can execute on multiple nodes to increase the performance.

The repository service use locks on the objects, so multiple users cannot modify the same object same time. You can enable version control in the repository.

Objects created in the repository can have three state:

* Valid: Syntax is correct according to Informatica, can be used in the execution of workflows;
* Invalid: Those who does not adhere to the standard or rules specified.
* Impacted: Those whose child objects are invalid.


The mappings and objects that we create in these cliente tools are saved in the informatica repository which resides on the informatica server. So the cliente tools must have network connectivity to the server. PowerCenter client tools must have connectivity to the source/target systems

* To connect to the integration service and repository service, PowerCenter client uses TCP/IP protocols and
* To connect to the sources/targets PowerCenter client uses ODBC drivers.


#### Repository Service

Maintains the connections from PowerCenter clients to the PowerCenter repository. It is a separate multi-threaaded process, and it fetches, inserts and updates the metadata inside the repository, also responsible for maintaining consistency inside the repository metadata.

#### Integration Service

Is the executing engine for the Informatica, this is the entity which executes the tasks that we create in Informatica. This is how it works:

-  A user executes a workflow    
-   Informatica instructs the integration service to execute the workflow    
-   The integration service reads workflow details from the repository 
-   Integration service starts execution of the tasks inside the workflow    
-   Once execution is complete, the status of the task is updated i.e. failed, succeeded or aborted.    
-   After completion of execution, session log and workflow log is generated.    
-   This service is responsible for loading data into the target systems 
-   The integration service also combines data from different sources

So, in summary, Informatica integration service is a process residing on the Informatica server waiting for tasks to be assigned for the execution. When we execute a workflow, the integration service receives a notification to execute the workflow. Then the integration service reads the workflow to know the details like which tasks it has to execute like mappings & at what timings. Then the service reads the task details from the repository and proceeds with the execution.

#### Source Definition

Is an entity from where you pull the records, and then you store these records in temporary tables (staging tables) or Informatica transformation caches. Mapping design make a change in these data records and then load the transformed data in another tables structures, called target tables. In every Informatica mapping, there will always be a source and a target. To manager different sources and targets in Informatica, you have to use source analyzer and target designer.

The source or target created/imported in Informatica can be reused any no of times in different mappings. Every mapping must have at least on loadable target. Otherwise mapping will be invalid. 

**Performance tip** – To improve the performance of Relational Source tables, use indexes on the source database tables. On the target, tables disable or remove constraints and indexes for performance.

#### Stage Mapping

A stage mapping is a mapping in where we create the replica of the source table. For Example, in a production system if you have an “employee” table then you can create an identical table “employee_stage” in ETL schema.

Having a local stage table offers various advantages, like production downtime, won’t affect your ETL system because you have your own “employee_stage” table, instead of referring to production “employee” table. In a Production system, there can be other operations and processes which affect the performance. However, when you have replica staging table, only ETL processes will access it. This offers performance benefits.

A Mapping must have at least a **source and a target**, you will add sources and targets to the mapping.

**Note** – When you import any relational (database) table in a mapping, an additional object of source qualifier type will also be created. This source qualifier transformation is necessary and helps Informatica integration service to identify the source database table and its properties. Whenever you import a source table, source qualifier transformation will also be created. You should never delete a source qualifier object in a mapping.

**Note** – mapping parameter and variable names always begin with `$$`.

A session task in Informatica is required to run a mapping.

Without a session task, you cannot execute or run a mapping and a session task can execute only a single mapping. So, there is a one to one relationship between a mapping and a session. A session task is an object with the help of which Informatica gets to know how and where to execute a mapping and at which time. Sessions cannot be executed independently, a session must be added to a workflow. In session object cache properties can be configured and also advanced performance optimization configuration.

#### Joiner Transformation

-   Always prefer to perform joins in the database if possible, as database joins are faster than joins created in Informatica joiner transformation.
    
-   Sort the data before joining if possible, as it decreases the disk I/O performed during joining.
    
-   Make the table with less no of rows as master table.
    

#### Lookup Transformation

-   Create an index for the column in a lookup table which is used in lookup condition. Since the lookup table will be queried for looking up the matching data, adding an index would increase the performance.
    
-   If possible, instead of using lookup transformation use join in the database. As database joins are faster, performance will be increased.
    
-   Delete unnecessary columns from the lookup table and keep only the required columns. This will bring down the overhead of fetching the extra columns from the database.
    

#### Filter Transformation

-   Use filter transformation as early as possible inside the mapping. If the unwanted data can be discarded early in the mapping, it would increase the throughput.’
    
-   Use source qualifier to filter the data. You can also use source qualifier [SQL](https://www.guru99.com/sql.html) override to filter the records, instead of using filter transformation.
    

#### Aggregator Transformation

-   Filter the data before aggregating it. If you are using filter transformation in the mapping, then filter the data before using aggregator as it will reduce the unnecessary aggregation operation.
    
-   Limit the no of ports used in the aggregator transformation. This will reduce the volume of data that aggregator transformation stores inside the cache.
    

#### Source Qualifier  Transformation

-   Bring only the required columns from the source. Most of the times not all the columns of the source table are required, so bring only the required fields by deleting the unnecessary columns.
    
-   Avoid using order by clause inside the source qualifier [SQL](https://www.guru99.com/sql.html) override. The order by clause requires additional processing and performance can be increased by avoiding it.