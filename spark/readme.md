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

val combineDF = regDS.sort("name").where("id > 10").select("name") // Dataframe
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


#### Exercício WithColumn 1/2

1. Criar um dataframe para ler o arquivo no HDFS /user/<nome/data/juros_selic/juros_selic

- !hdfs dfs -ls /user/ebraim/data/juros_selic/juros_selic
- juros = spark.read.json("/user/ebraim/data/juros_selic/juros_selic")

2. Alterar o formato do campo data para “MM/dd/yyyy”

- from pyspark.sql.functions import unix_timestamp, from_unixtime

- juros.show(1)
- jurosFormat = juros.withColumn("mes-dia-ano", from_unixtime(unix_timestamp(juros["data"], "dd/MM/yyyy"), "MM/dd/yyyy"))

3. Com uso da função from_unixtime crie o campo “ano_unix”, com a informação do ano do campo data

- jurosFormat.withColumn("ano_unix", from_unixtime(unix_timestamp(jurosFormat["data"], "dd/MM/yyyy"), "yyyy"))

4. Com uso de substring crie o campo “ano_str”, com a informação do ano do campo data

- jurosFormat.withColumn("ano_str", substring(jurosFormat["data"], 7, 4))

5. Com uso da função split crie o campo “ano_str”, com a informação do ano do campo data

- jurosFormat.withColumn("ano_str", split(jurosFormat["data"], "/").getItem(2))

6. Salvar no hdfs /user/rodrigo/juros_selic_americano no formato CSV, incluindo o cabeçalho

- jurosFormat.write.csv("/user/ebraim/juros_selic_americano", header="true")


#### WithColumn - Trabalhando com Cast

Cast: Alterar o tipo do dado. Sintaxe:

- <dataFrame>.withColumn("<nomeColuna>", <coluna>.cast("Tipo"))

Alterar as casas decimais:

- format_number("<coluna>", <numeroCasasDecimais>)

```py
medida = data.select("total").show(1) # 1000.00 (String)

from pyspark.sql.types import *

converter = medida.withColumn("Total Real", medida["total"].cast(FloatType()))

converter2c = converter.withColumn("Total Real", format_number(converter["Total Real"].cast(FloatType()), 2))
```

#### WitchColumn - Trabalhando com Cast e regexp_replace

Regexp serve para alterar um padrão com uso de regex, sintaxe:

- regexp_replace("<coluna>", "<padrao_atual>", "<novo_padrao>")

Exemplo para fazer cast de decimais para substituir "," por "."

```py
medida = data.select("total").show(1) # 1.000,00 (String)

medida = medida.witchColumn("total", regexp_replace(medida["total"], "\.", "")) # 1000,00 (String)

medida = medida.withcolumn("total", regexp_replace(medida["total"], "\,", ".")) # 1000.00 (String)

from pyspark.sql.types import *

converter = medida.witchColumn("Total Real", medida["total"].cast(FloatType())) # 1000.00 (Float)
```

#### WitchColumn - Trabalhando com When

Responsável por fazer condicional em colunas. Sintaxe:

- <dataFrame>.withColum("<nomeColuna>", when(<condição>, <valorVerdadeiro>).otherwise(<valorFalso>))

```py
codigos = data.select("cod").take(5) # AABB, ACBB, 00ABCC

remover_zeros = codigos.withColumn("cod_sem_zero", when(length(codigos["cod"]) > 4, substring(codigos["cod"], 3, 6)).otherwise(codigos["cod"])) # AABB, ACBB, ABCC
```


#### WithColumn - Trabalhando com Agregações

- <dataFrame>.groupBy(<coluna>).agg(<f_agg>)

- count
- avg
- sum
- min
- max
- first
- last
- countDistinct
- approx_count_distinct
- stddev
- var_sample
- var_pop
- covar_samp
- covar_pop
- corr

```py
peopleDF.groupBy("setor").sum("gastos").sort(desc("gastos"))

peopleDF.groupBy("setor").agg(avg("gastos"), sum("gastos").alias("total_gastos"))
```

#### Exercício WithColumn 2/2

1. Criar um dataframe para ler o arquivo no HDFS /user/<nome/data/juros_selic/juros_selic

- juros = spark.read.csv("/user/ebraim/data/juros_selic/juros_selic")
- juros.show(3)

2. Agrupar todas as datas pelo ano em ordem decrescente e salvar a quantidade de meses ocorridos, o valor médio, mínimo e máximo do campo valor com a seguinte estrutura:

- juros.groupBy("Anual").agg(count("Meses"), avg("valor"), min("valor"), max("valor")).sort(desc("Anual"))

3. Salvar no hdfs:///user/<nome>/relatorioAnual com compressão zlib e formato orc

- juros.write.orc("hdfs:///user/ebraim/relatorioAnual", compression="zlib")


```py
# 1. Criar um dataframe para ler o arquivo no HDFS /user/<nome/data/juros_selic/juros_selic

juros = spark.read.csv("/user/ebraim/data/juros_selic/juros_selic", header="true", sep=";")
juros.show(3)

# 2. Agrupar todas as datas pelo ano em ordem decrescente e salvar a quantidade de meses ocorridos, o valor médio, mínimo e máximo do campo valor com a seguinte estrutura:

from pyspark.sql.functions import *
from pyspark.sql.types import *

relatorio = juros.withColumn("ano", substring(juros["data"], 7, 4).cast(IntegerType()))
relatorio.show(2)

relatorio = relatorio.withColumn("mes", substring(relatorio["data"], 4, 2).cast(IntegerType()))
relatorio.show(2)

relatorio2 = relatorio.withColumn("valor", regexp_replace(relatorio["valor"], "\,", "\.").cast(FloatType()))
relatorio2.show(2)

relatorio2.printSchema()

juros_relatorio = relatorio2.groupBy("ano").agg(count("mes").alias("Meses"), format_number(avg("valor"), 2).alias("Valor Médio"), min("valor").alias("Valor Mínimo"), max("valor").alias("Valor Máximo")).sort(desc("ano"))
juros_relatorio.show()

#!hdfs dfs -ls /user/ebraim

# 3. Salvar no hdfs:///user/<nome>/relatorioAnual com compressão zlib e formato orc

juros_relatorio.write.orc("hdfs:///user/ebraim/relatorioAnual", compression="zlib")
```

### Spark Application

- spark submit --class NameList MyJarFile.jar people.json namelist/

Opções submit:

- master: Local, yarn, mesos ou spark standalone
- jars: adicionar arquivos jar
- py-files: lista de arquivos em .py, .zip, .egg
- driver-java-options: parametros para o driver JVM
- deploy-mode: client ou cluster
- driver-memory: Memória alocada para o spark driver (1G)
- executor-memory: Memória alocada para a aplicação
- num-executors: Número de executores para iniciar uma aplicação
- driver-cores: Número de core's alocados para o spark driver
- queue: Rodar na fila do Yarn
- help


#### Build Spark - Pycharm

- Create a project, file main.py
- isntall pyspark

```py
from pyspark.sql import SparkSession
from time import sleep

spark = SparkSession.builder.appname("Projeto Python").getOrCreate()

juros = spark.read.json("hdfs://namenode:8020/user/ebraim/data/juros_selic/juros_selic.json")

juros.collect()

juros.write.parquet("hdfs://namenode:8020/user/ebraim/projeto_python", mode="overwrite")

sleep(100)

spark.stop()
```

- enviar arquivo do projeto main.py para o serviço pyspark

- docker cp /mnt/c/Users/ebraim.carvalho/PythonProject/projeto_python/main.py jupyter-spark:/home

- rodar comando spark-submit: 
- docker exec -it jupyter-spark bash
- spark-submit --master local /home/main.py
- docker exec -it jupyter-spark hdfs dfs -ls /user/ebraim/projeto_python


### Spark Streaming - conceitos

1. Spark: ETL e processamento em batch

2. Spark SQL: Consultas em dados estruturados

3. Spark Streaing: Processamento de stream

4. Spark MLib: Machine Learning

5. Spark GraphX: Processamento de grafos


#### Spark Streaming

Abstração de alto nível, Dstreams (Discretized Streaming), representa um Strema contínuo de dados.

Extensão da API core do Spark com processamento escalonável, alta taxa de transferência e tolerante a falhas de stream de dados.

Recebe fluxos de dados de entrada e divide os dados em lotes processados pela engine do spark para gerar o stream final de resultados em batch. DStream é representado como uma sequencia de RDDs.


#### DStream - Leitura Básica

- Criar um Contexto com intervalo de 2 segundos

Scala:

```scala
import org.apache.spark._
import org.apache.spark.streaming._

val conf = new SparkConf().setMaster("local")
val sc = new SparkContext(conf)
val ssc = new StreamingContext(sc, Seconds(2))

val dstr = ssc.socketTextStream("localhost", 9999)
```

Python:

```python
from pyspark import SparkContext
from pyspark.streaming import StreamingContext

conf = SparkConf().setMaster("local")
sc = SparkContext.getOrCreate(conf)
ssc = StreamingContext(sc, 2)

dstr = ssc.socketTextStream("localhost", 9999)
```

#### DStream - Leitura e exibição de uma porta

Exemplo de leitura na porta 9999 no localhost

```python
from pyspark.streaming import StreamingContext

ssc = StreamingContext(sc, 2)

readStr = ssc.socketTextStream("localhost", 9999)

readStr.pprint()

# Usar netcat para enviar dados na porta 9999
# Rodar o comando no serviço do localhost jupyter-spark

# $nc -lp 9999

ssc.start()
```

#### Exercicio spark streaming

1. Instalar o NetCat no container do spark

- docker exec -it jupyter-spark bash
- apt update
- apt install netcat

2. Criar uma aplicação para ler os dados da porta 9999 e exibir no console

```python
from pyspark import SparkContext
from pyspark.streaming import StreamingContext
from time import sleep

conf = SparkConf().setAppName("DStream Python").setMaster("local[*]")
sc = SparkContext.getOrCreate(conf)

ssc = StreamingContext(sc, 5)

readStr = ssc.socketTextStream("localhost", 9999)

readStr.pprint()

# run: $ docker exec -it jupyter-spark bash
# run: $ nc -lp 9999

ssc.start()
sleep(20)
ssc.stop()
```


#### Spart Streaming - Operações

Ação: retorna um valor

- Count
- CountByValue
- Reduce
- Print
- ForeachRDD

Transformação: retorna um DStream

- Map
- Filter
- FlatMap
- ReduceByKey

```python
from pyspark import SparkContext
from pyspark.streaming import StreamingContext

conf = SparkConf().setAppName("DStreaming Python").setMaster("local[*]")
sc = SparkContext.getOrCreate(conf)

ssc = StreamingContext(sc, 5)

readStr = ssc.socketTextStream("localhost", 9999)

# Flatmap
palavras = readStr.flatMap(lambda linha: linha.split(" "))
palavras.saveAsTextFile("hdfs://localhost/linha")

# Map
pMinuscula = palavras.map(lambda palavra: palavra.lower())
pMaiuscula = palavras.map(lambda palavra: palavra.upper())
pChaveValor = pMinuscula.map(lambda palavra: (palavra, 1))
pReduce = pChaveValor.reduceByKey(lambda x, y: x + y)
pReduce.pprint()

# Filter
filtro_a = palavras.filter(lambda palavra: palavra.startswith("a"))
filtro_tamanho = palavras.filter(lambda palavra: len(palavra) > 5)
num_par = numeros.filter(lambda numero: numero % 2 == 0)

# nc -lp 9999

ssc.start()
```

#### Exercício 2 DStream - Word Count

1. Criar o diretório no hdfs “/user/rodrigo/stream”

- !hdfs dfs -mkdir /user/ebraim/stream

2. Criar uma aplicação para contar palavras a cada 10 segundos da porta 9998 e exibir no console durante 50 segundos

3. Criar uma aplicação para contar palavras a cada 10 segundos da porta 9998 e salvar os dados no namenode no diretório “hdfs://namenode/user/rodrigo/stream/word_count” durante 50 segundos


#### Integração do Spark Streaming com Kafka

Formas de integrar Kafka no Spark:

- Spark Streaming (Dstreams): spark >= 0.7.0
- Structured Streaming: spark >= 2.0.0 (2.3)

|                            | spark-streaming-kafka-0-8 | spark-streaming-kafka-0-10 |
|----------------------------|---------------------------|----------------------------|
| Broker Version             | 0.8.2.1 or higher         | 0.10.1 or higher           |
| Api maturity               | Deprecated spark 2.3      | stable                     |
| Language Support           | Scala, Java, Python       | Scala, Java                |
| Receiver DStream           | Yes                       | No                         |
| Direct DStream             | Yes                       | Yes                        |
| SSL/TSL Support            | No                        | Yes                        |
| Offset Commit API          | No                        | Yes                        |
| Dynamic Topic Subscription | No                        | Yes                        |


#### Spark Streaming (Dstreams)

- Scala e Java: versão >= 0.7.0 Spark
- Python: versão >= 1.2 Spark e <= 2.3

- Receber dados de um ou mais tópicos do kafka

1. Configurar os parametros do StreamContext
2. Configurar os parametros do kafka
3. Configurar o Dstreams para leitura dos tópicos


#### Revisão comandos Kafka

Acessar o container do kafka:
- docker exec -it kafka bash

Criação do tópico
- kafka-topics --bootstrap-server kafka:9092 --topics topicTeste --create --partitions1 --replication-factor 1

Criação do produtor
- kafka-console-producer --broker-list kafka:9092 --topic topicTeste

Criação do consumidor
- kafka-console-consumer --bootstrap-server kafka:9092 --topic topicTeste

Criação do produtor com chave/valor
- kafka-console-producer --broker-list kafka:9092 --topic topicTeste --property parse.key=true --property key.separator=,

Criação do produtor enviando um arquivo
- kafka-console-producer --broker-list kafka:9092 --topic topicTeste < file.log

Criação do produtor enviando um arquivo com chave/valor
- kafka-console-producer --broker-list kafka:9092 --topic topicTeste --property parse.key=true --property key.separator=, < file.log


#### Dependencias do spark streaming com kafka

Necessário adicionar pacote do kafka:

- --packages org.apache.spark:spark-streaming-kafka-0.10_<versãoScala>:<versãoSpark>

- Encontrar versão do kafka, no serviço do kafka, rodar: kafka-topics --version => 2.3.0
- Encontrar versão do Scala e do Spark, no serviço do spark, rodar: spark-shell => Scala: 2.11.12 e Spark: 2.4.1

- Comando no serviço do spark para adicionar dependencia:

spark-shell --packages org.apache.spark:spark-streaming-kafka-0.10_2.11:2.4.1


#### Estrutura do código e importações - Scala

Processos básicos para leitura de dados do kafka

```scala
import...
val ssc = new StreamingContext(...)
val kafkaParams = Map[String, Object](...)
val dstream = kafkaUtils.createDirectStream[String, String](...)
dstream.map(...)
ssc.start()

import org.apache.kafka.clients.consumer.ConsumerRecord
import org.apache.kafka.common.serialization.StringDeserializer
import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.streaming.kafka010._
import org.apache.spark.streaming.kafka010.LocationStrategies.PreferConsistent
import org.apache.spark.streaming.kafka010.ConsumerStrategies.Subscribe

```

#### Parâmetros do Kafka

Usar API Kafka para configuração:

```scala
val kafkaParams = Map[String, Object](
  "bootstrap.servers" -> "localhost:9092",
  "key.deserializer" -> classOf[StringDeserializer],
  "value.deserializer" -> classOf[StringDeserializer],
  "group.id" -> "app-teste",
  "auto.offset.reset" -> "earliest",
  "enable.auto.commit" -> (false: java.lang.Boolean)
)
```


#### Criação e visualização do Dstream

- Location Strategies:

1. PreferConsistent: Distribuir partições uniformemente entre os executores disponíveis

2. PreferBrokers: Se seus executores estiverem nos mesmos hosts que seus corretores kafka

3. PreferFixed: Especifique um mapeamento explícito de partições para hosts

- Consumer Strategies:

1. Subscribe: Inscrever-se em uma coleção fixa de tópicos

2. SubscribePattern: Use um regex para especificar tópicos de interesse

3. Assign: Especificar uma coleção fixa de partições


#### Criação do Dstream

Usar estratégia do Kafka

```scala
val ssc - new StreamingContext(sc, Seconds(10))
val topics = Array("topicA")
val dstream = KafkaUtils.createDirectStream[String, String](
  ssc,
  LocationStrategies.PreferConsistent,
  ConsumerStrategies.Subscribe[String, String](topics, kafkaParams)
)
```

#### Visualizar DStream

Mapear a estrutura do Tópico

```scala
val info_dstream = dstream.map(record => (
  record.topic,
  record.partition,
  record.key,
  record.value
))

info_dstream.print()
```

#### Exercício Spark e Kafka

##### kafka

1. Preparação do ambiente no Kafka

a) Criar o tópico “topic-spark” com 1 partição e o fator de replicação = 1

- docker exec -it kafka bash
- kafka-topics.sh --bootstrap-server kafka:9092 --topic topic-spark --create --partitions 1 --replication-factor 1

b) Inserir as seguintes mensagens no tópico:

- Msg1

- Msg2

- Msg3

- kafka-console-producer --broker-list kafka:9092 --topic topic-spark

Observação: Se quiser usar chave e valor no producer do kafka, adicionar os parametros --property parse.key=true --property key.separator=, no comando do kafka-console-producer

c) Criar um consumidor no Kafka para ler o “topic-spark”

- kafka-console-consumer --bootstrap-server kafka:9092 --topic topic-spark

##### Spark

1. Criar um consumidor em Scala usando Spark Streaming para ler o “topic-spark” no cluster Kafka ”kafka:9092”

- docker exec -it jupyter-spark bash
- spark-shell --packages org.apache.spark:spark-streaming-kafka-0-10_2.11:2.4.1

```scala
import org.apache.kafka.clients.consumer.ConsumerRecord
import org.apache.kafka.common.serialization.StringDeserializer
import org.apache.spark.streaming.kafka010._
import org.apache.spark.streaming.kafka010.LocationStrategies.PreferConsistent
import org.apache.spark.streaming.kafka010.ConsumerStrategies.Subscribe
import org.apache.spark.streaming.{StreamingContext, Seconds}

val kafkaParams = Map[String, Object](
  "bootstrap.servers" -> "kafka:9092",
  "key.deserializer" -> classOf[StringDeserializer],
  "value.deserializer" -> classOf[StringDeserializer],
  "group.id" -> "aplicacao1",
  "auto.offset.reset" -> "earliest",
  "enable.auto.commit" -> (false: java.lang.Boolean))

val ssc = new StreamingContext(sc, Seconds(5))
val topic = Array("topic-spark")
val dstream = KafkaUtils.createDirectStream[String, String](
  ssc,
  LocationStrategies.PreferConsistent,
  ConsumerStrategies.Subscribe[String, String](topic, kafkaParams)
)

```


2. Visualizar o tópico com as seguintes informações

Nome do tópico
Partição
Valor

```scala
val info_dstream = dstream.map(record => (
  record.topic,
  record.partition,
  record.value
))

info_dstream.print()

info_dstream.saveAsTextFiles("/user/ebraim/kafka/dstream")

```

3. Salvar o tópico no diretório hdfs://namenode:8020/user/<nome>/kafka/dstream

- info_dstream.saveAsTextFiles("/user/ebraim/kafka/dstream")

- ssc.start()


#### Struct Streaming - Conceitos

Engine de processamento de stream construído na engine do Spark SQL. 

Consultas do Spark Streaming são processadas usando uma engine de processamento de micro lote:
- Processar stream de dados como uma série de pequenos Jobs em Batch
- Latências de ponta a ponta de até 100 milissegundos
- Tolerância de uma falha

Novo modelo de Stream: Continuous processing
- Spark >= 2.3
- Latências de ponta a ponta tão baixas quanto a 1 milissegundos
- Tolerância de uma falha
- Sem alterar as operações Dataset / Dataframe em suas consultas

Struct Streaming trata um stream de dados como uma tabela que está sendo continuamente anexada. Modelo de processamento de stream muito semelhante a um modelo de processamento em lote.

New data in the data stream = new rows appended to a unbounded table


#### Struct Streaming - Exemplo Socket

Exemplo de leitura na porta 9999 no localhost

```python
read_str = spark.readStream.format("socket").option("host", "localhost").option("port", 9999).load()

write_str = read_str.writeStream.format("console").start()

```

### Struct Streaming - Exemplo CSV

Leitura de um arquivo CSV, obrigatório a definição do Schema e a leitura é do diretório e não do arquivo

```python
user_schema = StructType().add("nome", "string").add("idade", "integer")
read_csv_df = spark.readStream.schema(user_schema).csv("/user/nomes/")

read_csv_df.printSchema()

read_csv_df.writeStream.format("csv").option("checkpointLocation", "/tmp/checkpoint").option("path", "/home/data/").start()

```


#### Exercício Struct Stream

1. Criar uma aplicação em scala usando o spark para ler os dados da porta 9999 e exibir no console

- docker exec -it jupyter-spark bash
- pyspark
- read_str = spark.readStream.format("socket").option("host", "localhost").option("port", 9999).load()
- nc -lp 9999 in other terminal
- write_str = read_str.writeStream.format("console").start()

2. Ler os arquivos csv “hdfs://namenode:8020/user/<nome>/data/iris/*.data” em modo streaming com o seguinte schema:

sepal_length float
sepal_width float
petal_length float
petal_width float
class string

```python
user_schema = StructType().add("sepal_length", "float").add("sepal_width", "float").add("petal_length", "float").add("petal_width", "float").add("class", "string")
read_csv_df = spark.readStream.schema(iris_schema).csv("/user/ebraim/data/iris/*.data")

read_csv_df.printSchema()

read_csv_df.writeStream.format("csv").option("checkpointLocation", "/user/ebraim/stream_iris/check").option("path", "/user/ebraim/stream_iris/path").start()

```

3. Visualizar o schema das informações

4. Salvar os dados no diretório “hdfs://namenode:8020/user/<nome>/stream_iris/path” e o checkpoint em “hdfs://namenode:8020/user/<nome>/stream_iris/check”

5. Verificar a saida no hdfs e entender como os dados foram salvos

hdfs dfs -ls /user/ebraim/stream_iris

6. Bônus: Contar as palavras do exercício 1.


#### Structured Streaming com Kafka

- Structured Streaming: versao spark >= 2.0.0 (2.3)
- Spark Streaming:

1. Configuirar os parametros do streamContext
2. Configurar os parametros do Kafka
3. Configurar o Dstreams para leitura dos topicos

- Structured Streaming
1. configurar o Dataframe para leitura dos tópicos


#### Leitura de dados do kafka em batch

Criação do kafka Source para consultas batch

```python
kafka_df = spark.read.format("kafka").option("kafka.bootstrap.servers", "host1:port1, host2:port2").option("subscribe", "topic1").load()

kafka_df = spark.readStream.format("kafka").option("kafka.bootstrap.servers", "host1:port1, host2:port2").option("subscribe", "topic1").option("startingOffsets", "earliest").load()
```


#### Visualizar dados do kafka em batch

```python
kafka_df.printSchema
# root
# |-- key: binary (nullable = true)
# |-- value: binary (nullable = true)
# ...

kafka_df.select(col("key").cast(StringType), col("value").cast(StringType)).show()
```

#### Visualizar dados do kafka em stream

```python
kafka_df.printSchema
# root
# |-- key: binary (nullable = true)
# |-- value: binary (nullable = true)
# ...

kafka_df.select(col("key").cast(StringType), col("value").cast(StringType))

kafka_df.writeStream.format("console").start
```

#### Enviar dados Stream para o kafka

Fazer uso do Continuous Processing (Experimental)
- Registrar o progresso da consulta a cada x tempo com o Trigger Continuous
- O número de tarefas exigidas pela consulta depende de quantas partições a consulta pode ler das fontes em paralelo (Núcleos >= partições)

```python
kafka_df.writeStream.format("kafka").option("kafka.bootstrap.servers", "host1:port1, host2:port2").option("topic", "topic_teste2").trigger(Trigger.Continuous("1 second")).start()
```

#### Enviar dados Batch para o kafka

obrigatório ter o campo value, opcional ter o campo key

```python
dataframe.withColumnRenamed("id", "key").withColumnRenamed("nome", "value")

dataframe.write.format("kafka").option("kafka.bootstrap.servers", "host1:port1, host2:port2").option("topic", "topic_teste2").save()

```


#### Exercício Structured Streaming com Kafka

1. Ler o tópico do kafka “topic-kvspark” em modo batch

```python
from pyspark.sql.functions import *

kafka_df = spark.read.format("kafka").option("kafka.bootstrap.servers", "kafka:9092").option("subscribe", "topic-kvspark").load()

```

2. Visualizar o schema do tópico

```python
kafka_df.printSchema()
```

3. Visualizar o tópico com o campo key e value convertidos em string

```python
kafka_df.select(col("key").cast(StringType), col("value").cast(StringType)).show()
```

4. Ler o tópico do kafka “topic-kvspark” em modo streaming

```python
kafka_df = spark.readStream.format("kafka").option("kafka.bootstrap.servers", "kafka:9092").option("subscribe", "topic-spark").option("startingOffsets", "earliest").load()
```

5. Visualizar o schema do tópico em streaming

```python
kafka_df.printSchema
```

6. Alterar o tópico em streaming com o campo key e value convertidos para string

```python
kafka_df_stream_str = kafka_df_stream.select(col("key").cast("string"), col("value").cast("string"))
# kafka_df.withColumnRenamed("id", "key").withColumnRenamed("nome", "value")

kafka_df.write.format("kafka").option("kafka.bootstrap.servers", "kafka:9092").option("topic", "topic-spark").save()
```

7. Salvar o tópico em streaming no tópico topic-kvspark-output a cada 5 segundos

```python
kafka_df.writeStream.format("kafka").option("kafka.bootstrap.servers", "kafka:9092").option("topic", "topic-kvspark-output").trigger(Trigger.Continuous("5 second")).start()
```

8. Salvar o tópico na pasta hdfs://namenode:8020/user/<nome>/Kafka/topic-kvspark-output

```python
kafka_df.saveAsTextFiles("/user/ebraim/kafka/topic-kvspark-output")
```

#### Spark - Variáveis compartilhadas

Quando uma função é passada para o Spark, a operação é executada em um nó de cluster remoto.

- Trabalha em cópias separadas de todas as variáveis usadas na função
- As variáveis são copiadas para cada máquina e nenhuma atualização nas variáveis na máquina remota é propaganda de volta ao programar do driver
- A leitura e gravação entre tarefas é ineficiente

O spark fornece dois tipos limitados de variáveis compartilhadas> Broadcast e Accumulators

#### Broadcast

Para cada máquina no cluster terá uma variável somente para leitura em cache, não é necessário enviar uma cópia dela para as tarefas.

Variáveis de broadcast é útil quando tarefas em vários estágios precisam dos mesmos dados e quando há importância de armazenar em cache os dados na forma desserializada.

##### Métodos

- id: Identificador único
- Value: Valor
- Unpersist: Exclui assincronamente cópias em cache da variável broadcast nos executores
- Destroy: Destrói todos os dados e metadados relacionados a variável de broadcast
- toString: Representação de String

##### Exemplo

Sintaxe: <variavelBroadcast> = sc.broadcast([1,2,3])

```python
broadcastVar = sc.broadcast([1,2,3])
type(broadcastVar) # pyspark.broadcast.Broadcast
broadcastVar.Value # [1,2,3]
broadcastVar.destroy
```

#### Accumulators

Acumuladores são variáveis que são apenas "adicionadas" a uma operação associativa e comutativa e tem características:

- Paralelismo eficiente
- Podem ser usados para implementar contadores
- Suporta acumuladores de tipos numericos, e podem adicionar outros

O Spark exibe o valor para cada acumulador modificado por uma tarefa na tabela "Tasks"

O rastreamento de acumuladores na interface do usuario pode ser util para entender o progresso dos estagios em execução

- Para criar o acumulador: sc.long/doubleAccumulator(valor, "<nomeAcumulador>") # em Scala e view Spark's UI
- sc.Accumulator(valor) # Em python
- Adicionar tarefas: <acumulator>.add(Long/Double)

```python
# Em scala
val accum = sc.longAccumulator(0, "My Accumulator")
sc.parallelize(Array(1,2,3,4)).foreach(x => accum.add(x))
accum.value # 10

# Em python
accum = sc.Accumulator(0)
sc.parallelize([1,2,3,4]).foreach(lambda x: accum.add(x))
accum.value # 10
```

#### Cache de tabelas

Armazenar tabela em cache na memoria:

- spark.catalog.cacheTable("tableName")
- dataFra,e.cache()

Remover tabela da memória

- spark.catalog.uncacheTable("tableName")

```python
spark.catalog.cacheTable("src")
broadcast(spark.table("src")).join(spark.table("records"), "key")
spark.catalog.uncacheTable("src")
```