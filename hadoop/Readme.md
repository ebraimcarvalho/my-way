Hadoop é um software open source para computação distribuída confiável e escalável!

- Modelo de programação simples
- Processamento distribuído
- Grandes conjuntos de dados
- Clusters de computadores: (Hardware commodity) Você não precisa do melhor hardware, arquitetura é pensada que o hardware pode falhar, isso ajuda em relação a custo, podendo montar uma arquitetura distribuída com um custo menor.

Esse projeto hadoop propõe soluções para sistemas distribuídos em um único framework

Em fevereiro de 2003, o google queria melhorar o mecanismo de busca, eles criaram então a tecnologia mapReduce, divide o processamento em vários pedaços e distribui em diversos computadores.

Em outubro de 2003, Google cria um sistema de arquivos distribuídos para armazenar e processar grande colume de dados da Google por meio de MapReduce, isso foi chamado de HDFS.

Então o Hadoop funciona em duas partes

1. Map/Reduce: Aplicação é dividade em vários pequenos fragmentos de jobs e cada um pode ser executado ou reexecutado em qualquer nó do cluster

2. HDFS: Sistema de arquivo distribuído que armazena dados nos nós, fornecendo uma largura de banda agregada muito alta em todo cluster Map Reduce e é projetado para que as falhas de nó sejam tratadas automaticamente pelo framework

### HDFS

Hadoop distributed File System - Sistema de Arquivos Distribuídos do Hadoop

Vantagens: 

- Baixo custo: Hardwares com custo menor
- Toleranta a falhas: sistema já é pensado para cobrir falhas
- Escalável: Aumenta poder de armazenamento, aumentando os nós

O sistema divide os arquivos em conjuntos de blocos individuais, 128mb é o padrão, e armazena esses blocos em vários nós nos cluster Hadoop.

O HDFS assume que todo nó não é confiável 100%, então ele faz 3 cópias dos blocos que são armazenados.

Arquitetura Mestre Namenode / DataNode

- Namenode: Armazenar metadados dos arquivos, Componente central do HDFS, responsável por saber o que são e onde estão seus dados;
- Datanode: Armazenar os dados

### Estrutura do HDFS

O client envia o job para o nó mestre (NameNode), aqui ficará as informações de metadados e enviará 3 cópias, uma para cada DataNode.

### MapReduce - Introdução

Framework que organiza as tarefas de processamento complexas através de clusters de computadores, divide o trabalho em conjunto de tarefas independentes

4 processos: 
- Split
- Map
- Shuffle
- Reduce

#### Funcionamento do MapReduce

Ele recebe os dados do HDFS, usa o split para pegar o que precisa, mapeia o conteúdo dando saída em formato chave-valor, com os dados em chave-valor, faz o shuffle para mergear chaves iguais, gerando uma lista com os valores para aquela chave e então faz o reduce dessa lista para cada chave e gera o output com o resultado final também em formato chave-valor.

![alt text](mapreduce.jpg 'Funcionamento do MapReduce')


#### Estrutura do MapReduce

- Daemon para executar um job, divido em dois tipos:

1. 1 JobTracker: Coordena todas as tarefas executadas, agendando tarefas para serem executadas em tasktrackers, monitora as tasktrackers, reagenda se necessário e armazena o histórico de tarefasc oncluídas.

2. N TaskTracker: Executam as tarefas e enviam relatórios de progresso para o jobtracker

Então em cada Nó Mestre (NameNode), além do nameNode existe o Jobtracker, como se fosse um cpu e uma memória de um computador.

Ao nível de Datanode, estará também o tasktracker.

O HDFS responde pelo armazenamento e o MapReduce responde pelo processamento.

### YARN

Yet another resource negotiator

Outro negociador de recursos: Oferece paralelismo de tarefas e divide as funcionalidades de gerenciamento de recursos e agendamento/monitoramento de tarefas em daemons separadas

Versão do mapReduce 2 = MapReduce 1 + YARN

#### Modos do Sistema

1. Modo local: Standalone
2. Modo pseudo distribuído: Single Node Cluster
3. Modo distribuído: Multi Node Cluster (mais comum em meio de produção)

#### Estrutura do Yarn

- Daemons para executar um job
- 1 Resource Manager (RM): Coordenar todas as tarefas executadas no sistema, agenda tarefas para serem executadas nos Nodes Managers
- 1 Application Master (AM): Monitora os Node Manager para reagendar em caso de falha ou lentidão
- 1 Timeline Server: Armazenar o histórico de aplciativos
- N Node Manager: Executam as tarefas nos conteiners e enviam relatorios de progresso para o RM

#### Arquitetura do Yarn

1. Envia o job para o Resource Manager
2. Solicita o container para o Node Manager
3. Dentro desse container inicial abre um Application Master
4. Application Master solicita para o Resource manager mais containers para o Job
5. Todo processamento do MapReduce será executado nos containers criados após o Application Master solicitar


### Outros nós

#### Secondary node

- Namenode: Contem dois arquivos, FsImage (armazena informações estruturais dos blocos) e EditLog (armazena todas as alterações ocorridas no metadados dos arquivos)

- Cria checkpoints no Namenode: FsImage.ckpt = FsImage + EditLog

- Em caso de fallover do namenode: precisa recuperar manualmente os dados do namenode secundario

#### Standby Namenode

- Se comunica diretamente com o Namenode através do Journalnode
- Também é um Namenode, só que em espera
- em caso de fallover do Namenode, o standby entra automaticamente no seu lugar. O Datanode se comunica com o namenode e standby namenode.

#### Edge Node

- Conhecido como Gateway node tambem
- interface entre o cluster do Hadoop e sua rede externa
- Diminuir o uso de recurso do Namenode
- Executa aplicativos de clientes externos
- Transferidos os dados para o cluster hadoop
- Ferramenta de gerenciamento

#### Arquitetura do cliente Hadoop

O Job é enviado primeiramente pro Edge node (Sqoop, Hive, Hue...);

É enviado o job para o master node, que está comunicando com seu standby namenode através dos journalnode, se esse no mestre falhar, o standby é ativo.

O secondary node é usado em alguns ambientes, onde é criado checkpoints do master node. Esse secondary node será usado em caso de falha do master node, porém esse é um processo de configuração manual. Não é recomendado, melhor usar standby namenode e master node

### Data lake

- Entrada (XML, CSV, SQL, JSON...)

1. Ingestão de dados (Sqoop, Flume, Kafka, Beats, Logstash)
2. Armazenamento (HDFS, HBase, Kudu, Cassandra, Redis, MongoDB, ElasticSearch)
3. Processamento (MapReduce, Spark, Flink)
4. Análise de dados (Hive, Impala)

- Saída (Grafana, Kibana...)

### Docker

Comandos Docker:

- docker --version
- docker-compose --version
- docker ps // visualizar todos os containers ativos
- docker ps -a // visualizar todos os containers
- docker-compose pull // baixar as imagens
- docker image ls // listar imagens
- docker-compose up -d // subir o container em background
- docker container ls // listar os containers
- docker-compose stop // parar os serviços
- docker-compose start // iniciar os serviços
- docker-compose down // matar os serviços
- docker volume prune // apagar todos os volumes sem uso
- docker system prune --all // apagar tudo (imagem, volume, network)
- docker exec -it namenode bash // Acessar namenode
- docker exec -it hive-server bash // Acessar o hive-server
- docker exec -it <container> <comando> // Executar comandos no container
- docker logs <container> // Visualizar os logs
- docker logs -f <container> // Visualizar os logs atualizando em tempo real
- docker-compose logs // visualizar os logs
- docker-compose logs -f // visualizar os logs atualizando quando ocorrer algo
- docker cp <diretório> <container> :/ <diretorio> // Enviar arquivos


#### Exercício

1. Instalação do docker e docker-compose

Docker: https://docs.docker.com/get-docker/
Docker-compose: https://docs.docker.com/compose/install/

2. Executar os seguintes comandos, para baixar as imagens do Cluster de Big Data:

git clone https://github.com/rodrigo-reboucas/docker-bigdata.git
cd docker-bigdata
docker-compose pull

3. Iniciar o cluster Hadoop através do docker-compose

docker-compose up -d

4. Listas os containers em execução

- docker ps

5. Verificar os logs dos containers do docker-compose em execução

- docker-compose logs

6. Verificar os logs do container namenode

- docker logs namenode

7.  Acessar o container namenode

- docker exec -it namenode bash

8. Listar  os diretórios do container namenode

- docker exec -it namenode ls /

9. Parar os containers do Cluster de Big Data

- docker-compose stop

### Sitema HDFS e diretórios

##### Comandos

- hadoop fs
- hdfs dfs
- hdfs dfs -<comando> [argumentos]
- hdfs dfs -help
- hdfs dfs -help ls
- hdfs dfs -mkdir <diretorio> // criar um diretorio
- hdfs dfs -mkdir -p <diretorio>/<diretorio>/<diretorio> // Criar arvore de diretórios
- hdfs dfs -ls // Lista os diretórios
- hdfs dfs -ls -R // Lista os diretórios recursivamente
- hdfs dfs -rm <src> // excluir um arquivo
- hdfs dfs -rm -r <src> // excluir um diretório
- hdfs dfs -rm -r -skipTrash <src> // excluir um diretório permanentemente, sem enviar para a lixeira

##### Local para HDFS
- hdfs dfs -put <src> <destino> // Enviar arquivo ou diretorio
- -f (sobrescreve o destino se existir)
- -l (Força um fator de replicação)
- hdfs dfs -copyFromLocal <src> <destino> //  Envia arquivo ou diretorio
- hdfs dfs -moveFromLocal <src> <destino> // Mover o arquivo ou diretorio

##### HDFS para Local
- hdfs dfs -get <src> <destino> // Receber arquivo ou diretorio 
- hdfs dfs -getmerge <src> <destino> // Cria um unico arquivo mesclado
- hdfs dfs -moveToLocal <src> <destino> // Get que deleta a copia da origem HDFS

##### HDFS para HDFS
- hdfs dfs -cp <src> <destino> // Copia arquivo ou diretorio
- hdfs dfs -mv <src> <destino> // Mover arquivo ou diretorio
- hdfs dfs -mv <arquivo1> <arquivo2> <arquivo3> <destino> // Mover vários arquivos

*Não é permitido copiar ou mover arquivos entre sistemas de arquivos*

##### Informações de arquivos e sistema HDFS
- hdfs dfs -du -h <diretorio> // Mostrar uso do disco
- hdfs dfs -df -h <diretorio> // Exibe o espaço livre
- hdfs dfs -stat [%r | %o] <diretorio|arquivo> // Mostrar as informações do diretório
- hdfs dfs -count -h <diretorio> // Conta o número de diretórios, número de arquivos e tamanho do arquivo
- hdfs dfs -expunge // Esvazia a lixeira
- hdfs dfs -cat <arquivo> // Ver conteúdo do arquivo
- hdfs dfs -setrep <número de repetições> <arquivo> // Alterar o fator de replicação do arquivo
- hdfs dfs -touchz <diretorio> // Criar um arquivo de registro comd data e hora
- hdfs dfs -checksum <arquivo> // Retornar as informações da soma de verificação de um arquivo
- hdfs dfs -tail <arquivo> // Mostrar o último kb do arquivo no console
- hdfs dfs -cat <arquivo> | head -n 2 // Mostrar as 2 primeiras linhas do arquivo
- hdfs dfs -find / -iname Data -print // Procura no diretorio raiz arquivos com nome data case insensitive
- hdfs dfs -find input/ -name \*.txt -print // Procura no diretorio input arquivos com final .txt


#### Exercício

1. Iniciar o cluster de Big Data

cd docker-bigdata
docker-compose up -d

2. Baixar os dados dos exercícios do treinamento

cd input
sudo git clone https://github.com/rodrigo-reboucas/exercises-data.git

3. Acessar o container do namenode

- docker exec -it namenode bash

4. Criar a estrutura de pastas apresentada a baixo pelo comando: $ hdfs dfs -ls -R /

user/aluno/

<nome>

data

recover

delete

- hdfs dfs -mkdir -p /user/aluno/ebraim/data
- hdfs dfs -mkdir /user/aluno/ebraim/recover
- hdfs dfs -mkdir /user/aluno/ebraim/delete

5. Enviar a pasta “/input/exercises-data/escola” e o arquivo “/input/exercises-data/entrada1.txt” para  data

- hdfs dfs -put /input/exercises-data/escola /user/aluno/ebraim/data
- hdfs dfs -put /input/exercises-data/entrada1.txt /user/aluno/ebraim/data

6. Mover o arquivo “entrada1.txt” para recover

- hdfs dfs -mv /user/aluno/ebraim/data/entrada1.txt /user/aluno/ebraim/recover

7. Baixar o arquivo do hdfs “escola/alunos.json” para o sistema local /

- hdfs dfs -get /user/aluno/ebraim/data/escola/alunos.json /

8. Deletar a pasta recover

- hdfs dfs -rm -r /user/aluno/ebraim/recover

9. Deletar permanentemente o delete

- hdfs dfs -rm -r -skipTrash /user/aluno/ebraim/delete

10. Procurar o arquivo “alunos.csv” dentro do /user

- hdfs dfs -find /user -name alunos.csv

11. Mostrar o último 1KB do arquivo “alunos.csv”

- hdfs dfs -tail /user/aluno/ebraim/data/escola/alunos.csv

12. Mostrar as 2 primeiras linhas do arquivo “alunos.csv”

- hdfs dfs -cat /user/aluno/ebraim/data/escola/alunos.csv | head -n 2

13. Verificação de soma das informações do arquivo “alunos.csv”

- hdfs dfs -checksum /user/aluno/ebraim/data/escola/alunos.csv

14. Criar um arquivo em branco com o nome de “test” no data

- hdfs dfs -touchz /user/aluno/ebraim/data/test.txt

15. Alterar o fator de replicação do arquivo “test” para 2

- hdfs dfs -setrep 2 /user/aluno/ebraim/data/test.txt

16. Ver as informações do arquivo “alunos.csv”

- hdfs dfs -stat %r /user/aluno/ebraim/data/escola/alunos.csv

17. Exibir o espaço livre do data e o uso do disco

- hdfs dfs -df -h /user/aluno/ebraim/data


### Hive

Criado pelo Facebook em 2007 porque o processamento era lento para as consultas diárias, além de que criar tarefas mapreduce consumia tempo e precisava de pessoas especializadas.

É uma ferramenta que permite fácil acesso aos dados via SQL, é um datawarehouse em cima do hadoop, é uma camada de acesso aos dados armazenados no HDFS. Os dados são armazenados no HDFS.

Possui recursos avançados de particionamento, subdividir os dados, organizando através de colunas, porém, não é usado para fornecer repostas em tempo real, ao contrário do Impala, Spark, Presto.

##### Componentes do Hive

- HCatalog: Camada de gerenciamento de armazenamento para o Hadoop, permite que usuários com diferentes ferramentas de processamento de dados leiam e gravem os dados
- WebHCat: Servidor web para se conectar com o Metastore Hive
- HiveServer2: Serviço que permite aos clientes executar consultas Hive, exemplo: beeline
- Metastore: Todos os metadados das tabelas e partições do hive são acessados através do hive metastore, existem diferentes maneiras de configurar o servidor metastore, como embedded Metastore, Local ou Remote Metastore
- Beeline: Cliente Hive, faz uso do JDBC para se conectar ao HiveServer2

##### formato e Estrutura dos Dados

Não existe um formato Hive, existe conector para vários formatos, exemplo CSV, Parquet, AVRO, JSON...

Você pode salvar os dados estruturados ou semi-estrutudaos

###### Hierarquia dos dados

- Database/Table/Partition/Bucket

Partition: Coluna de armazenamento dos dados no sistema de arquivos (diretorios)
Bucket: Dados são dividos em uma coluna através de uma Função Hash

- Exemplo de caminho:
/user/hive/warehouse/banco.db/tabela/data=01012019/0000000_0

Através da Hive Query Language (HiveQL) são instruções SQL que são transformadas internamente em Jobs de MapReduce

##### Banco de dados e tabelas

- show databases; // Listar todos os BD
- desc database <nomeBD>; // Estrutura sobre o BD
- show tables; // Listar as tabelas
- desc <nomeTabela>; // Estrutura da tabela
- desc formatted <nomeTabela>; // Estrutura da tabela formatada
- desc extended <nomeTabela>; // Estrutura da tabela extendida
- create database <nomedoBanco>; // Criar BD
- create database <nomedoBanco> location "/diretorio"; //Local diferente do conf. Hive ao criar um BD
- create database <nomeBanco> comment "descrição"; // Adicionar comentário
- exemplo: create database test location "/user/hive/warehouse/test" comment "banco de dados para treinamento";

##### Tabelas

Tipos interna e Externas

Partição: Não particionada, Particionada: Dinâmico e estático

- Interna:

create table user(cod int, name string); // Cria tabela interna

drop table user; // Apaga os dados e metadados

- Externa:

create external table e_user(cod int, name string) location "/user/semantix/data_users"; // Cria tabela externa mapeando dados do diretorio user/semantix/data_user

drop table e_user; // Apaga apenas os metadados, os dados ficam armazenados no sistema de arquivos, usada para compartilhar os dados com outras ferramentas.


###### Atributos para criação de tabelas

- Leitura de dados

Definir delimitadores:

- row format delimited fields terminated by '<delimitador>' lines terminated by '<delimitador>'
- tblproperties("skip.header.line.count"="1") // Pular um numero de linhas de leitura do arquivo
- location '/user/cloudera/data/client'; // Definir localização dos dados (Tabela Externa)

Exemplo:

create external table user(
  id int,
  name String,
  age int
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile
location '/user/cloudera/data/client'


###### Acessar o Hive

- docker exec -it hive-server bash
- beeline --help
- beeline -u jdbc:hive2://localhost:10000
- show databases;

###### Exercícios

1. Enviar o arquivo local “/input/exercises-data/populacaoLA/populacaoLA.csv” para o diretório no HDFS “/user/aluno/<nome>/data/populacao”

- hdfs dfs -mkdir -p /user/aluno/ebraim/data/populacao
- hdfs dfs -put '/input/exercises-data/populacaoLA/populacaoLA.csv' '/user/aluno/ebraim/data/populacao'

2. Listar os bancos de dados no Hive

- show databases;

3. Criar o banco de dados <nome>

- create database ebraim;

4. Criar a Tabela Hive no BD <nome>

Tabela interna: pop
Campos:
zip_code - int
total_population - int
median_age - float
total_males - int
total_females - int
total_households - int
average_household_size - float
Propriedades
Delimitadores: Campo ‘,’ | Linha ‘\n’
Sem Partição
Tipo do arquivo: Texto
tblproperties("skip.header.line.count"="1")’

- use ebraim;
- create table pop(
    zip_code int,
    total_population int,
    median_age float,
    total_males int,
    total_females int,
    total_households int,
    average_household_size float
  )
  row format delimited
  fields terminated by ','
  lines terminated by '\n'
  stored as textfile
  tblproperties("skip.header.line.count"='1');

5. Visualizar a descrição da tabela pop

- desc formatted pop;


#### Inserrir e carregar dados na tabela

- insert into <nomedaTabela> partition(<partition>='<value>') values(<campo>, <value>),(<campo>, <value>), (<campo>, <value>); // Inserir dados na tabela
- insert into users select * from cliente; // Inserir dados selecionados da tabela cliente na tabela users
- load data inpath <diretorio> into table <nomedaTabela>; // Carregar dados no sistema de arquivos local
- load data local inpath '/home/cloudera/data/test' into table alunos; Carrega dados do local
- load data inpath '/user/cloudera/data/test' overwrite into table alunos partition(id) // Carrega dados do hdfs numa partição específica

#### Seleção de dados

- select * from <nomedaTabela>
  <where>
  <group by>
  <having>
  <order by>
  <limit n>;
- select * from client where state='sp' group by city having population > 100 order by client limit 10; // Exemplo de uma query
- select * from a join b on a.valor = b.valor; // Usando join entre duas tabelas
- create view <nomedaView> as select * from <nomedaTabela>; // Salvar consultas e trata como tabelas, esquema é fixo e se alterar a tabela não altera a view

#### Exercício

1.Visualizar a descrição da tabela pop do banco de dados <nome>

- use ebraim;
- desc formatted pop;

2.Selecionar os 10 primeiros registros da tabela pop

- select * from pop limit 10;

3.Carregar o arquivo do HDFS “/user/aluno/<nome>/data/população/populacaoLA.csv” para a tabela Hive pop

- load data inpath '/user/aluno/ebraim/data/populacao/populacaoLA.csv' into table pop

4.Selecionar os 10 primeiros registros da tabela pop

- select * from pop limit 10;

5.Contar a quantidade de registros da tabela pop

- select count(*) from pop;


#### Exercício Partição Hive

Hive - Criação de Tabela Particionada

1. Criar o diretório “/user/aluno/<nome>/data/nascimento” no HDFS

- hdfs dfs -mkdir /user/aluno/ebraim/data/nascimento

2. Criar e usar o Banco de dados <nome>

- create database ebraim;
- use ebraim;

3. Criar uma tabela externa no Hive com os parâmetros:

a) Tabela: nascimento

b) Campos: nome (String), sexo (String) e frequencia (int)

c) Partição: ano

d) Delimitadores:

i) Campo ‘,’

ii)  Linha ‘\n’

e) Salvar

i) Tipo do arquivo: texto

ii) HDFS: '/user/aluno/<nome>/data/nascimento’

- create external table nascimento(
    nome string,
    sexo string,
    frequencia int  
  )
  partitioned by (ano int)
  row format delimited
  fields terminated by ','
  lines terminated by '\n'
  stored as textfile
  location '/user/aluno/ebraim/data/nascimento';

4.Adicionar partição ano=2015

- alter table nascimento add partition(ano=2015);
- alter table nascimento add partition(ano=2016);
- alter table nascimento add partition(ano=2017);

5.Enviar o arquivo local “input/exercises-data/names/yob2015.txt” para o HDFS no diretório /user/aluno/<nome>/data/nascimento/ano=2015

- hdfs dfs -put /input/exercises-data/names/yob2015.txt /user/aluno/aluno/data/nascimento/ano=2015
- hdfs dfs -put /input/exercises-data/names/yob2016.txt /user/aluno/aluno/data/nascimento/ano=2016
- hdfs dfs -put /input/exercises-data/names/yob2017.txt /user/aluno/aluno/data/nascimento/ano=2017

6.Selecionar os 10 primeiros registros da tabela nascimento no Hive

- select * from nascimento limit 10;
- select * from nascimento where ano=2016 limit 10;
- select * from nascimento where ano=2017 limit 10;

7.Repita o processo do 4 ao 6 para os anos de 2016 e 2017.


### Exercício

1. Usar o banco de dados <nome>

- use ebraim;

2. Selecionar os 10 primeiros registros da tabela pop

- select * from pop limit 10;

3. Criar a tabela pop_parquet no formato parquet para ler os dados da tabela pop

- create table pop_parquet(
    zip_code int, 
    total_population int, 
    median_age float, 
    total_males int, 
    total_females int, 
    total_households int, 
    average_household_size float
  ) stored as parquet;

4. Inserir os dados da tabela pop na pop_parquet

- insert into pop_parquet select * from pop;

5. Contar os registros da tabela pop_parquet

- select count(*) from pop_parquet;

6. Selecionar os 10 primeiros registros da tabela pop_parquet

- select * from pop_parquet limit 10;

7. Criar a tabela pop_parquet_snappy no formato parquet com compressão Snappy para ler os dados da tabela pop

- create table pop_parquet_snappy(
    zip_code int, 
    total_population int, 
    median_age float, 
    total_males int, 
    total_females int, 
    total_households int, 
    average_household_size float
  ) 
  stored as parquet
  tblproperties('parquet.compress'='SNAPPY');

8. Inserir os dados da tabela pop na pop_parquet_snappy

- insert into pop_parquet_snappy select * from pop;

9. Contar os registros da tabela pop_parquet_snappy

- select count(*) from pop_parquet_snappy;

10. Selecionar os 10 primeiros registros da tabela pop_parquet_snappy

- select * from pop_parquet_snappy limit 10;

11. Comparar as tabelas pop, pop_parquet e pop_parquet_snappy no HDFS.

- hdfs dfs -du -h /user/hive/warehouse/ebraim.db


### Exercicio SQOOP


MySQL - Verificar e Instalar os Banco de Dados de testes

1. Copiar os dados do local para o contêiner database

$ docker cp input/exercises-data/db-sql/ database:/

2. Acessar o contêiner database

$ docker exec -it database bash

3. Instalar Banco de Dados de testes

Diretório /db-sql - BD employees (Já existe)
  $ cd /db-sql  

  $ mysql -psecret < employees.sql

Diretório /db-sql/sakila - BD sakila
$ cd /db-sql/sakila/

$ mysql -psecret < sakila-mv-schema.sql
$ mysql -psecret < sakila-mv-data.sql



### Exercicio SQOOP 2


Sqoop -  Pesquisa e Criação de Tabelas

Todos os comandos precisam ser executados pelo Sqoop.

1. Mostrar todos os databases

- docker exec -it namenode bash
- sqoop list-databases --connect jdbc:mysql://database --username root --password secret

2. Mostrar todas as tabelas do bd employees

- sqoop list-tables --connect jdbc:mysql://database/employees --username root --password secret

3. Inserir os valores ('d010', 'BI') na tabela departments do bd employees

- sqoop eval --connect jdbc:mysql://database/employees --username root --password secret --query "insert into departments values('d010', 'BI')"

4. Pesquisar todos os registros da tabela departments

- sqoop jdbc:mysql://database/employees --username root --password secret --query "select * from departments"

5. Criar a tabela benefits(cod int(2)  AUTO_INCREMENT PRIMARY KEY, name varchar(30)) no bd employees

- sqoop eval --connect jdbc:mysql://database/employees --username root --password secret --query "create table benefits(cod int(2) AUTO_INCREMENT PRIMARYKEY, name varchar(30))"

6. Inserir os valores (null,'food vale') na tabela benefits

- sqoop eval --connect jdbc:mysql://database/employees --username root --password secret --query "insert into benefits values(null, 'food vale')"

7. Pesquisar todos os registros da tabela benefits

- sqoop eval --connect jdbc:mysql://database/employees --username root --password secret --query "select * from benefits"


### Exercícios SQOOP 3

Sqoop - Importação BD Employees

1. Pesquisar os 10 primeiros registros da tabela employees do banco de dados employees

- docker exec -it namenode bash
- sqoop eval --connect jdbc:mysql://database/employees --username root --password secret --query "select * from employees limit 10"

2. Realizar as importações referentes a tabela employees e para validar cada questão,  é necessário visualizar no HDFS*

Importar a tabela employees, no warehouse  /user/hive/warehouse/db_test_a

- sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --warehouse-dir /user/hive/warehouse/db_test_a
- hdfs dfs -cat /user/hive/warehouse/db_test_a/employees/part-m-00000 | head -n 5

Importar todos os funcionários do gênero masculino, no warehouse  /user/hive/warehouse/db_test_b

- sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --where "gender='M'" --warehouse-dir /user/hive/warehouse/db_test_b
- hdfs dfs -cat /user/hive/warehouse/db_test_b/employees/part-m-00000 | head -n 5

importar o primeiro e o último nome dos funcionários com os campos separados por tabulação, no warehouse  /user/hive/warehouse/db_test_c

- sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --columns "first_name, last_name" --fields-terminated-by '\t' --warehouse-dir /user/hive/warehouse/db_test_c
- hdfs dfs -cat /user/hive/warehouse/db_test_c/employees/part-m-00000 | head -n 5

Importar o primeiro e o último nome dos funcionários com as linhas separadas por “ : ” e salvar no mesmo diretório da questão 2.C

- sqoop import --table employees --connect jdbc:mysql://database/employees --username root --password secret --columns "first_name, last_name" --lines-terminated-by ':' --warehouse-dir /user/hive/warehouse/db_test_c -delete-target-dir
- hdfs dfs -cat /user/hive/warehouse/db_test_c/employees/part-m-00000 | head -n 5

* Dica para visualizar no HDFS:

$ hdfs dfs -cat /.../db_test/nomeTabela/part-m-00000 | head -n 5