#### Spark


##### Exercício instalação

1. Instalação do docker e docker-compose

2. Executar os seguintes comandos, para baixar as imagens do Cluster de Big Data:

- git clone https://github.com/rodrigo-reboucas/docker-bigdata.git spark
- cd spark
- docker-compose –f docker-compose-parcial.yml pull

3. Iniciar o cluster Hadoop através do docker-compose

- docker-compose –f docker-compose-parcial.yml up -d

4. Listas as imagens em execução

- docker ps

5. Verificar os logs dos containers do docker-compose em execução

- docker-compose logs

6. Verificar os logs do container jupyter-spark

docker jupyter-spark logs
7. Acessar pelo browser o Jupyter, através do link:

http://localhost:8889


#### Sessão no Spark e API Catalog

Setar o nível do log: spark.sparkContext.setLogLevel("INFO")

Listar banco de dados: spark.catalog.listDatabases()

Setar database atual: spark.catalog.setCurrentDatabase(nomeBD)

Listar tabelas: spark.catalog.listTables()

Listar colunas da tabela: spark.catalog.listColumns(nomeTabela)

Dropar uma view: spark.catalog.dropTempView(nomeView)

Exemplo query sql: tab_df = spark.sql("select * from user").show(10)


##### Exercício Preparar ambiente

1. Configurar o jar do spark para aceitar o formato parquet em tabelas Hive

- curl -O https://repo1.maven.org/maven2/com/twitter/parquet-hadoop-bundle/1.6.0/parquet-hadoop-bundle-1.6.0.jar

- docker cp parquet-hadoop-bundle-1.6.0.jar jupyter-spark:/opt/spark/jars

2. Baixar os dados dos exercícios do treinamento no diretório spark/input (volume no Namenode)

- cd input
- sudo git clone https://github.com/rodrigo-reboucas/exercises-data.git .

3. Verificar o envio dos dados para o namenode

- docker exec -it namenode ls /input

4. Criar no hdfs a seguinte estrutura: /user/rodrigo/data

- hdfs dfs -mkdir -p /user/ebraim/data

5. Enviar todos os dados do diretório input para o hdfs em /user/rodrigo/data

- hdfs dfs -put /input/* /user/ebraim/data


##### Exercicio jupyter notebook

Exercícios – Testar o Jupyter Notebook

1. Criar o arquivo do notebook com o nome teste_spark.ipynb

2. Obter as informações da sessão de spark (spark)

- spark

3. Obter as informações do contexto do spark (sc)

- sc

4. Setar o log como INFO.

- spark.sparkContext.setLogLevel("INFO")

5. Visualizar todos os banco de dados com o catalog

- spark.catalog.listDatabases()

6. Ler os dados "hdfs://namenode:8020/user/rodrigo/data/juros_selic/juros_selic.json“ com uso de Dataframe

- juros = spark.read.json("hdfs://namenode:8020/user/rodrigo/data/juros_selic/juros_selic.json")
- juros.show(5)

7. Salvar o Dataframe como juros no formato de tabela Hive

- juros.write.saveAsTable("juros")

8. Visualizar todas as tabelas com o catalog

- spark.catalog.listTables()

9. Visualizar no hdfs o formato e compressão que está a tabela juros do Hive

- !hdfs dfs -ls /user/hive/warehouse

10. Ler e visualizar os dados da tabela juros, com uso de Dataframe no formato de Tabela Hive

- spark.read.table("juros").show(5)

11. Ler e visualizar os dados da tabela juros , com uso de Dataframe no formato Parquet

- spark.read.parquet("user/hive/warehouse/juros/").show(5)