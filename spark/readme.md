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

- docker logs jupyter-spark

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


#### Conceitos RDD

Resilient Distributed Datasets

- Resiliente: Recriar dado perdido na memória
- Distribuído: Processamento no cluster
- Datasets: Dados podem ser criados ou vir de fontes


- Coleção de objetos distribuídos entre os nós do cluster, armazena os dados em partições
- Imutáveis
- Tipos de operações: Ação e Transformação


#### RDD - Operações

Ação: Retorna um valor

- Collect
- Count
- First
- Take
- Reduce
- CountByKey
- Foreach

Transformação: Retorna um RDD

- Map
- Filter
- FlatMap
- GroupByKey
- ReduceByKey
- AggregateByKey


#### RDD - Leitura e visualização de dados

entrada1.txt | entrada2.txt

- rdd = sc.textFile("entrada*")

- rdd.count()

- rdd.first()

- rdd.take(5)

- rdd.collect()

- rdd.foreach(println)


#### RDD - FlatMap

Scala

- rdd.take(2) # Array[String] = Array(Big Data, Semantix SP)

- val palavras = rdd.flatMap(x => x.split(" "))

- val palavras = rdd.flatMap(_.split(" "))

- palavras.foreach(println) # 'Big', 'Data', 'Semantix', 'SP'


Python

- rdd.take(2) # ['Big Data', 'Semantix SP']

- palavras = rdd.flatMap(lambda x: x.split(" "))

- palavras.collect() # ['Big', 'Data', 'Semantix', 'SP']


#### Função Anônima

Python

- rdd.take(2) # ['Big Data', 'Semantix SP']

- p = rdd.flatMap(lambda x: x.split(" "))

- min = p.map(lambda linha: linha.loiwer())

- min.collect() # ['big', 'data', 'semantix', 'sp']

Poderia fazer assim, menos funcional:

def Func(linha):
  return linha.lower()

minuscula = p.map(Func)

minuscula.collect()


#### RDD - FlatMap e Map

- rdd.take(2) # ['Big Data'. 'Semantix SP']

- palavras = rdd.flatMap(lambda x: x.split(" "))

- palavras.collect() # ['Big', 'Data', 'Semantix', 'SP']

- palavras = rdd.map(lambda x: x.split(" "))

- palavras.collect() # [['Big', 'Data'], ['Semantix', 'SP']]


#### RDD - Transformações no Map

Scala

- val pMinuscula = palavras.map(_.toLowerCase)

- val pMaiscula = palavras.map(_.toUpperCase)

- val pChaveValor = pMinuscula.map((_,1))

- pChaveValor.take(4) # Array(('big', 1), ('data', 1), ('semantix', 1), ('sp', 1))


Python

- pMinuscula = palavras.map(lambda linha: linha.lower())

- pMaiuscula = palavras.map(lambda linha: linha.upper())

- pChaveValor = pMinuscula.map(lambda palavra: (palavra, 1))

- pChaveValor.take(4) # [('big', 1), ('data', 1), ('semantix', 1), ('sp', 1)]


#### RDD - Transformações de filter

Remover dados do RDD

Scala

- val filtroA = palavras.filter(_.startsWith('a'))

- val filtroB = palavras.filter(_.length > 5)

- val numPar = numeros.filter(_ % 2 == 0)


Python

- filtro_a = palavras.filter(lambda palavra: palavra.startsWith('a'))

- filtro_tamanho = palavra.filter(lambda palavra: len(palavra) > 5)

- num_par = numeros.filter(lambda numero: numero % 2 == 0)


#### RDD - Transformações de Reduce

Scala

- val pChaveValor = pMinuscula.map((_,1))

- pReduce = pChaveValor.reduceByKey(_+_)

- pReduce.take(3) # Array(('big', 1), (2019, 2), ('hadoop', 4))


Python

- p_chave_valor = pMinuscula.map(lambda palavra: (palavra, 1))

- p_reduce = p_chave_valor.reduceByKey(lambda x, y: x + y)

- p_reduce.take(3) # [('big', 1), (2019, 2), ('hadoop', 4)]


#### RDD - Transformação de Ordenação

Scala

- val pOrdena = pReduce.sortBy(-_._2) # [(String, Int)]

- pOrdena.take(4) # Array[('hadoop', 4), ('semantix', 3), ('data', 3), (2019, 2)]


Python

- p_ordena = p_reduce.sortBy(lambda palavra: palavra[1], False)

- p_ordena.take(4) # [('hadoop', 4), ('semantix', 3), ('data', 3), (2019, 2)]


#### RDD - Armazenamento e visualização

Scala

- pOrdena.foreach(y => println(y._1 + " - " + y._2)) # hadoop - 4 \n semantix - 3 \n data - 3


Python

- lista - p_ordena.collect()

- for row in lista:
  print(row[0], " - ", row[1]) # hadoop - 4, semantix - 3, data - 3


#### RDD - Salvar dados

- p_ordena.getNumPartitions

- p_ordena.saveAsTextFile("saida")

- hdfs dfs -ls /user/root/saida


#### Exercício RDD

1. Ler com RDD os arquivos localmente do diretório “/opt/spark/logs/” ("file:///opt/spark/logs/")

- !ls /opt/spark/logs
- !cat /opt/spark/logs/spark--org.apache.spark.deploy.master.Master-1-jupyter-notebook.out
- log = sc.textFile("file:///opt/spark/logs")

2. Com uso de RDD faça as seguintes operações

a) Contar a quantidade de linhas

- log.count()

b) Visualizar a primeira linha

- log.first()

c) Visualizar todas as linhas

- log.collect()

d) Contar a quantidade de palavras

- palavras = log.flatMap(lambda linha: linha.split(" "))
- palavras.count()

e) Converter todas as palavras em minúsculas

- logMin = palavras.map(lambda x: x.lower())

f) Remover as palavras de tamanho menor que 2

- logFilter = logMin.filter(lambda x: len(x) > 2)

g) Atribuir o valor de 1 para cada palavra

- logMap = logMin.map(lambda x: (x, 1))

h) Contar as palavras com o mesmo nome

- logCount = logMap.reduceByKey(lambda x, y: x + y)

i) Visualizar em ordem alfabética

- logCount.sortBy(lambda x: x[0], False)

j) Visualizar em ordem decrescente a quantidade de palavras

- logCount.sortBy(lambda x: x[1], False)

k) Remover as palavras, com a quantidade de palavras <> 1

- logCount.filter(lambda x: x[1] > 1)

l) Salvar o RDD no diretorio do HDFS /user/<seu-nome>/logs_count_word

- logCount.saveAsTextFile("hdfs:///user/ebraim/logs_count_word")


#### RDD - Partições

Spark armazena os dados do RDD em diferentes partições, no mínimo 2. É possível definir as partições manualmente na leitura e na redução do dado.

- rdd = sc.textFile("entrada*", 6)

- palavras = rdd.flatMap(lambda linha: linha.split(" "), 3)  # não vai alterar a partição para 3, ignora

- p_chave_valor = palavras.map(lambda palavra: (palavra, 1), 20) # não vai alterar a partição para 20, ignora

- p_reduce = p_chave_valor.reduceByKey(lambda x, y: x + y, 10) # aqui ele altera a partição para 10

- p_reduce_5 = p_reduce.repartition(5) # podemos forçar o reparticionamento em qualquer momento dessa foram

- p_reduce_5.getNumPartitions()


#### Exercício RDD - Partition

1. Ler com RDD os arquivos localmente do diretório “/opt/spark/logs/” ("file:///opt/spark/logs/") com 10 partições

- logs = sc.textFile("file:///opt/spark/logs", 10)

2. Contar a quantidade de cada palavras em ordem decrescente do RDD em 5 partições

- palavras = logs.flatMap(lambda linha: linha.split(" "))

- palavras_minusculas = palavras.map(lambda palavra: palavra.lower())

- p_chave_valor = palavras_minusculas.map(lambda palavra: (palavra, 1))

- p_reduce = p_chave_valor.reduceByKey(lambda x, y: x + y, 5)

- p_ordem = p_reduce.sortBy(lambda x: x[1], False)


3. Salvar o RDD no diretório do HDFS /user/<seu-nome>/logs_count_word_5

- p_ordem.saveAsTextFile("/user/ebraim/logs_count_word_5")


4. Refazer a questão 2, com todas as funções na mesma linha de um RDD

- p_ordem_5_2 = palavras.flatMap(lambda linha: linha.split(" ")).map(lambda palavra: (palavra, 1)).reduceByKey(lambda x, y: x + y).sortBy(lambda x: x[1], False)


#### Spark - Criação de Schema

Tipagem de Dados

Esquemas - Definição

Scala

Inferir esquema manualmente em dados com cabeçalho

- import org.apache.spark.sql.types._

- val columnsList = List(StructField("id", IntengerType), StructField("setor", StringType))

- val setorSchema = StructType(columnsList)

- val setorDF = spark.read.option("header", "true").schema(setorSchema).csv("setor.csv")


Python

``` python
from pyspark.sql.types import *

columns_list = [StructField("id", IntengerType()), StructField("setor", StringType())]

setor_schema = StructType(columns_list)

setor_df = spark.read.option("header", "true").schema(setor_schema).csv("setor.csv")
```


#### Dataframe - Testar Schema

```py
from pyspark.sql.types import *

columns_list = [StructField("id", IntengerType()), StructField("setor", StringType())]

setor_schema = StructType(columns_list)

dados_teste = [Row(1, "vendas"), Row(2, "TI"), Row(3, "RH")]

setor_df = spark.createDataFrame(data=dados_teste, schema=setor_schema)
```

```py
from pyspark.sql.import Row

Schema = Row("id", "setor")

dados_teste = [Schema(1, "vendas"), Schema(2, "TI"), Schema(3, "RH")]

teste_df = spark.createDataFrame(data=dados_teste)

teste_df.printSchema()
```


#### Exercício Spark Schemas

1. Criar o DataFrame names_us_sem_schema para ler os arquivos no HDFS “/user/<nome>/data/names”

- !hdfs dfs -ls /user/ebraim/data/names

- !hdfs dfs -cat /user/ebraim/data/names/ytob1880.txt

- names_us_sem_schema = spark.read.csv("/user/ebraim/data/names")

2. Visualizar o Schema e os 5 primeiros registos do names_us_sem_schema

- names_us_sem_schema.printSchema()

- names_us_sem_schema.show(5)

3. Criar o DataFrame names_us para ler os arquivos no HDFS “/user/<nome>/data/names” com o seguinte schema:

nome: String
sexo: String
quantidade: Inteiro

```py
from pyspark.sql.types import *

columns_list = [StructField("nome", StringType()), StructField("sexo", StringType()), StructField("quantidade", IntengerType())]

schema = StructType(columns_list)

names_us = pyspark.read.csv("/user/ebraim/data/names", schema=schema)

```

4. Visualizar o Schema e os 5 primeiros registos do names_us

```py
names_us.printSchema()

names_us.show(5)
```

5. Salvar o DataFrame names_us no formato orc no hdfs “/user/<nome>/names_us_orc”

- names_us.write.orc("/user/ebraim/names_us_orc")


#### DataSet - Conceitos

Coleção distribuída de objetos de tipagem forte

- Tipos primitivos: Int ou String
- Tipos Complexos: Array ou listas
- Product objects: Scala => case classes | Java => JavaBen objects
- Row objects

Mapeado para um schema relacional

- Schema é definido por um encoder
- Schema mapeia objeto de propriedades para tipos de colunas

Otimizada pelo Catalyst

Implementado apenas em Java e Scala


#### DataFrame x DataSet

Dataframes são conjuntos de dados de Row objects, representam dados tabulares, transformações não são tipadas.

- Linhas podem conter elementos de qualquer tipo
- Schemas definidos não são aplicados os tipos de coluna até o tempo de execução

Datasets representam dados tipados e orientados a objeto. As transformações são tipadas (Propriedades do objeto são tipadas em tempo de compilação)

Representação dos dados

- RDD - 2011
- Dataframe - 2013
- Dataset - 2015


#### Criação  de Dataset

Criar Dataset com case classes (recomendada)

- case class <NomeClasse>(<atributo>:<tipo>,...,<atributo>:<tipo>)

Exemplo:

```java
case class Name(id: Integer, name: String)

reg = Seq(Name(1, "Ebraim"), Name(2, "Carvalho"))

regDS = spark.createDataset(reg)

regDS.show

// Imprimir para cada linha só o name

regDS.foreach(n => println(n.name))
```

#### Criação de Dataset de Dataframe

Ler dados estruturados para um Dataframe

Criar um Dataset para ler os dados do Dataframe

Forçar para inserir um schema com o Encoder

```java
case class Name(id: Integer, name: String)

val regDF = spark.read.json("registros.json")

val regDS =  regDF.as[Name]

regDS.show


import org.apache.spark.sql.Encoders

val schema = Encoders.product[Name].schema

val regDS = spark.read.schema(schema).json("registros.json").as[Name]
```


#### Criação de Dataset de RDD

Ler dados não estruturados ou semi estsruturados para um RDD

Criar um Dataset para ler os dados do RDD

``` java
case class PcodeLatLon(pcode: String, latlon: Tuple2[Double, Double])

val pLatLonRDD = sc.textFile("latlon.tsv").map(_.split("\t")).map(fields => (PcodeLatLon(fields(0), (fields(1).toFloat, fields(2).toFloat))))

val pLatLonDS = spark.createDataset(pLatLonRDD)

pLatLonDS.printSchema

println(pLatLonDS.first)
```

#### Transformações de Dataset

Transformações tipadas criam um novo Dataset

- Filter
- Limit
- Sort
- flatMap
- Map
- ordereBy

Transformações não tipadas retornarm DataFrames ou colunas não tipadas

- Join
- groupBy
- Col
- Drop
- Select
- withColumn

#### Exemplo de transformações

- Tipadas: Dataset
- Não tipadas: Dataframe

``` java
val sortedDS = regDS.sort("name") // Dataset

val nameDF = regDS.select("name") // Dataframe

val combineDF = regDS.sort("name");where("id > 10").select("name") // Dataframe
```

Ao salvar dataset, será salvo como Dataframe

Exemplo: 

- regDS.write.save("hdfs://localhost/user/cloudera/registros/")

- regDS.write.json("registros")


#### Exercício - Dataset com Dataframe

1. Criar o DataFrame names_us para ler os arquivos no HDFS “/user/<nome>/data/names”

- docker exec -it jupyter-spark bash
- spark-shell

- names_us = spark.read.csv("/user/ebraim/data/names")

2. Visualizar o Schema do names_us

- names_us.printSchema()

3. Mostras os 5 primeiros registros do names_us

- names_us.show(5)

4. Criar um case class Nascimento para os dados do names_us

- case class Nascimento(nome: String, sexo: String, quantidade: Integer)

5. Criar o Dataset names_ds para ler os dados do HDFS “/user/<nome>/data/names”, com uso do case class Nascimento

- import org.apache.spark.sql.Encoders
- val schema_names = Encoders.product[Nascimento].schema
- val names_ds = spark.read.schema(schema_names).csv("/user/ebraim/data/names").as[Nascimento]

6. Visualizar o Schema do names_ds

- names_ds.printSchema()

7. Mostras os 5 primeiros registros do names_ds

- names_ds.show(5)

8. Salvar o Dataset names_ds no hdfs “/user/<nome>/ names_us_parquet” no formato parquet com compressão snappy

- names_ds.write.parquet("user/ebraim/names_us_parquet")

- spark.read.parquet("/user/ebraim/names_us_parquet").show(5)


#### Opções de Leitura e Escrita CSV

```py
data = spark.read.
        option("sep", "|").
        option("header", "true").
        option("quote", "\"").
        option("mode", "DROPMALFORMED").
        csv("hdfs:///user/teste/")


from pyspark.sql import Row

Name = ("cod", "nome")
data = [Name(1, "Ebraim"), Name(2, "Carvalho"), Name(3, "Brenda")]
data_frame = spark.createDataFrame(data)

data_frame.printSchema()
data_frame.show()

data_frame.write.csv("/user/ebraim/teste_csv", mode="overwrite", header="true", sep=";")

spark.read.csv("/user/ebraim/teste_csv", header="true", sep=";").show()
```

#### Função Withcolumn - Conceitos

```py
from pyspark.sql.functions import col

addColumn = dataframe.withColumn("Novo campo", col("id"))

# pode ser usado essas notações para referenciar coluna em python

col("campo")
dataframe["campo"]
datafram.campo
```

Em scala:

- col("campo")
- dataframe("campo")
- $"campo"


#### WitchColumn - Trabalhando com Timestamp

Converter Coluna para timestamp: unix_timestamp(col("<ColString>"), "<FormatoAtual>")

Alterar formato de Coluna de timestamp: from_unixtime(<ColTimestamp>, "<FormatoConversão>")

```py
from pyspark.sql.functions import unix_timestamp, from_unixtime

formato = data.select("data").show(1) # 2020/10/25

convUnix = formato.withColumn("timestamp", unix_timestamp(formato["data"], "yyyy/MM/dd"))

convUnixData = convUnix.withColumn("new data", from_unixtime("timestamp", "MM-dd-yyyy"))

# Fazendo em uma linha de comando
convDataDireto = formato.withColumn("mes-dia-ano", from_unixtime(unix_timestamp(formato["data"], "yyyy/MM/dd"),"MM-dd-yyyy"))
```


#### WithColumn - Trabalhando com Substring

Extrai dados de uma coluna de acordo com uma posição, muito usado com concat. Sintaxe:

- <dataframe>.withColumn("<nomeColuna>", substring("<Coluna>", <posicaoInicial>, <tamanho>))

```py
formato = data.select("data").show(1) # 2020/10/25

mes = formato.withColumn("mes", substring(formato["data"], 6, 2)) # mes = 10

colsDF = data.select("codigo") # codigo = AA150000CCS

resumoCod = colsDF.withColumn("pedido", concat(substring(colsDF["codigo"], 1, 2), lit("-"), substring(colsDF["codigo"], 9, 3))) # pedido = AA-CCS

```


#### WithColumn - Trabalhando com Split

Split serve para criar um array de acordo com um delimitar. Sintaxe:

- <dataframe>.withColumn("<nomeColuna>", split("<Coluna>", "<delimitador>"))

```py
nomesDF = data.select("nome").show(1) # Rodrigo Augusto Rebouças

sepNomeDF = nomesDF.withColumn("sepNome", split(data["nome"], " "))

valpNome = sepNomeDF.withColumn("pNome", nomesDF["sepNome"].getItem(0)).drop("sepNome")
```