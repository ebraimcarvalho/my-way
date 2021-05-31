## Kafka

É uma plataforma de Streaming distribuída Open Source, que publica e assina streams de registros e tem fluxos de registros com processamento em tempo real e armazenamento tolerante a falhas.

Surgiu em 2010 pelo Linkedin com a necessidade de integração massima de dados. O conceito do Kafka surgiu com Jay Kreps e sua equipe. Em 2011 foi liberado como um projeto open-source e em 2012 foi para Apache.

É desenvolvido em Scala e Java, o Kafka é executado como um cluster em um ou mais servidores que podem abranger varios datacenters. O cluster Kafka armazena fluxos de registros em categorias denominadas tópicos. Cada registro consiste em uma chave, um valor e um registro de data e hora. 

Apache kafka é um sistema para gerenciamento de fluxos de dados em tempo real, gerados a partir de web sites, aplicações e sensores.

1. Producer API: Permite que um aplicativo publique um fluxo de registros em um ou mais tópicos do Kafka

2. Consumer API: Permite que um aplicativo assine um ou mais tópicos e processe o fluxo de registros produzidos para eles

3. Streams API: Permite que um aplicativo transforme os fluxos de entrada em fluxos de saída

4. Connector API: Permite criar e executar produtores ou consumidores reutilizáveis que conectam tópicos do Kafka e aplicativos ou sistemas de dados existentes


### Confluent


Surgiu para facilitar a construção de pipelines de dados, aplicativos de streaming em tempo real e a integração de dados de várias fontes e locais.
Buscando simplificar a conexão de fontes de dados ao Kafka, a criação de aplicativos com o Kafka e oferece proteção, monitoramento e gerenciamento.


##### Instalação Cluster Kafka

1. Criar a pasta kafka e inserir o arquivo docker-compose.yml da Guia Arquivos do treinamento

- mkdir kafka
- nano docker-compose.yml

2. Instalação do docker e docker-compose

Docker: https://docs.docker.com/get-docker/ (Links para um site externo.)
Docker-compose: https://docs.docker.com/compose/install/ (Links para um site externo.)

3. Inicializar o cluster Kafka através do docker-compose

- docker-compose up -d

4. Listas as imagens em execução

- docker ps

5. Visualizar o log dos serviços broker e zookeeper

- docker logs zookeeper
- docker logs broker

6. Visualizar a interface do Confluent Control Center

Acesso: http://localhost:9021/


#### Confluent CLI

Serve para instalar, administrar a plataforma Confluent. É uma aplicação para uso de desenvolvimento não adequeado para ambiente de produção.


##### Execução

<path-confluent>/bin/confluent <comando>

Exemplo: <path-confluent>/bin/confluent list


##### Comandos CLI

confluent <comando>

- consume <topico>
- produce <topico>

- config <conector>
- load <conector>
- unload <conector>

- Version <serviço>
- help <comando>

- list
- start <serviço>
- stop <serviço>
- status <serviço>
- top <serviço>
- log <serviço>
- current



#### Brokers e Tópicos


##### Tópicos

Fluxo de registros similar a uma tabela SQL dividido em partições. A partição é o local onde as mensagens são gravadas em sequencia ordenada e imutável de registro. Cada registro na partição é atribuído a um id sequencial (offset) exclusivamente do registro na partição. O tópico pode ter multi-assinantes, 0, 1 ou N para consumir os dados gravados.


##### Brokers

Também chamados de corretores ou servidores, armazenam os tópicos. O Cluster Kafka é composto por múltiplos corretores, em ambiente de produção o ideal é ter no mínimo 3. Cada corretor/servidor é identificado por um id.


##### Replicação dos tópicos

Boa prática para cada partição é:

- 1 Corretor líder (Leader): responsável por receber os dados

- 2 Corretores de réplica do líder (ISR - in-sync replica): responsável por sincronizar os dados.


#### Producers

Responsável por enviar os dados, publicar os dados nos tópicos de sua escolha. Escolhe qual registro atribuir a qual partição dentro do tópico para balancear a carga através de uma chave de registro


###### Confirmação de escrita

Existem 3 tipos de confirmação de escrita (acks) para o produtor:

- 0: Sem confirmação de escrita
- 1: Confirmação de escrita no líder (Padrão)
- All: Confirmação de escrita no líder e nas réplicas (ISR)


#### Consumers

Os consumidores são responsáveis por receber os dados, onde cada registro publicado em um tópico será entregue aos consumidores dentro de um grupo de consumidores.

###### Grupo de consumidores

Se todas as instâncias do consumidor estiverem no mesmo grupo de consumidores os registros serão balanceados por carga.

Se todas as instâncias do consumidor estiverem em grupos de consumidores diferentes, cada registro será transmitido para todos os processos.


#### Gerenciar tópicos - Console

- docker exec -it broker bash
- kafka-topics --version


###### Comandos básicos

- Listar tópicos: 

kafka-topics --bootstrap-server localhost:9092 --list

kafka-topics --zookeeper zookeeper:2181 --list


- Criar tópico:

kafka-topics --bootstrap-server localhost:9092 --topic <nomeTópico> --create --partitions 3 --replication-factor 1


- Descrever tópico

kafka-topics --bootstrap-server localhost:9092 --topic <nomeTópico> --describe


- Deletar tópico

kafka-topics --bootstrap-server localhost:9092 --topic <nomeTópico> --delete


##### Producer Console

- Enviar dados:

kafka-console-producer --broker-list localhosto:9092 --topic <nomeTópico>


- Enviar dados para todos reconhecerem (Leader e ISR)

kafka-console-producer --broker-list localhost:9092 --topic <nomeTópico> --producer-property acks=all



##### Consumer Console

- Receber mensagens em tempo real:

kafka-console-consumer --bootstrap-server localhost:9092 --topic <nomeTópico>


- Receber mensagens desde a criação do tópico

kafka-console-consumer --bootstrap-server localhost:9092 --topic <nomeTópico> --from-beginning


- Criar grupo de consumidores

kafka-console-consumer --bootstrap-server localhost:9092 --topic <nomeTópico> --group <nomeGrupo>



##### Grupos de consumidores - Console

- Listar grupos: 

kafka-consumer-groups --bootstrap-server localhost:9092 --list


- Descrever grupo:

kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group <nomeGrupo>


- Redefinir o deslocamento do mais antigo:

kafka-consumer-groups --bootstrap-server localhost:9092 --group <nomeGrupo> --reset-offsets --to-earliest --execute --topic <nomeTópico>


- Alterar o deslocamento:

kafka-consumer-groups --bootstrap-server localhost:9092 --group <nomeGrupo> --reset-offsets --shift-by 2 --execute --topic <nomeTópico>



### Exercício Kafka por linha de comando


1. Criar o tópico msg-cli com 2 partições e 1 réplica

- docker exec -it broker bash
- kafka-topics --version
- kafka-topics --bootstrap-server localhost:9092 --topic msg-cli --create --partitions 2 --replication-factor 1

2. Descrever o tópico msg-cli

- kafka-topics --bootstrap-server localhost:9092 --topic msg-cli --describe

3. Criar o consumidor do grupo app-cli

- kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app-cli

4. Enviar as seguintes mensagens do produtor

Msg 1
Msg 2

- kafka-console-producer --broker-list localhost:9092 --topic msg-cli

5. Criar outro consumidor do grupo app-cli

- kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app-cli

6. Enviar as seguintes mensagens do produtor

Msg 4
Msg 5
Msg 6
Msg 7

- kafka-console-producer --broker-list localhost:9092 --topic msg-cli


7. Criar outro consumidor do grupo app2-cli

- kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app2-cli

8. Enviar as seguintes mensagens do produtor

Msg 8
Msg 9
Msg 10
Msg 11

- kafka-console-producer --broker-list localhost:9092 --topic msg-cli


9. Parar o app-cli

- ctrl + c

10. Definir o deslocamento para -2 offsets do app-cli

- kafka-consumer-groups --bootstrap-server localhost:9092 --group app-cli --reset-offsets --shift-by -2 --execute --topic msg-cli

11. Descrever grupo

- kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group app-cli

12. Iniciar o app-cli

- kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app-cli

13. Redefinir o deslocamento o app-cli

- kafka-consumer-groups --bootstrap-server localhost:9092 --group app-cli --reset-offsets --to-earliest --execute --topic msg-cli

14. Iniciar o app-cli

- kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-cli --group app-cli

15. Listar grupo

- kafka-consumer-groups --bootstrap-server localhost:9092 --list



#### Exercício control Center


Control Center

1. Criar um tópico com o nome msg-rapida com 4 partições, 1 replicação e deletar os dados após 5 minutos de uso.

- control center

2. Produzir e consumir 2 mensagens para o tópico msg-rapida

- Procuer: kafka-console-producer --bootstrap-server localhost:9092 --topic msg-rapida
- Consumer: kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-rapida --group msg-group 

3. Qual o nome do cluster?

- controlcenter.cluster

4. Quantos tópicos existem no cluster?

- 60

5. Quantas partições existem o tópico msg-cli?

- 2

6. Todas as réplicas estão sincronizadas no tópico msg-cli?

- sim

7. Qual a política de limpeza do tópico msg-cli?

- cleanup.policydelete, retention.ms 604800000 | 1 semana

8. Alterar a política de limpeza do tópico msg-cli para deletar depois de um ano.

- 31540000000

9. Qual o diretório de armazenamento de logs do cluster?

- /var/lib/kafka/data

10. Por padrão os dados são mantidos por quantos dias no Kafka?

- 7

11. Visualizar os gráficos de produção e consumo de dados do tópico msg-rapida.

- ok


### KSQL


É um engine de Streaming SQL do kafka com uma interface SQL interativa que permite facildiade de uso, focada para o processamento streaming no kafka sem a necessidade de escrever código em Java ou Python. 

É escalável, tolerante a falhas, em tempo real, suporta várias operações de streaming, como Filtragem de dados, Transformações e Agregações.


##### Comandos básicos

Visualizar tópicos: 
- list topics;

Mostrar conteúdo do tópico em temp real: 
- print "<nomeTopico>" <propriedades>;

Propriedades: from beginning; interval; limit;

- print "topic-produto" from beginning interval 5 limit 10;


#### KSQL Stream

Sequencia de dados estruturados, tem características de ser imutáveis (Possível apenas inserir dados, não atualizar ou excluir) e podem ser criados a partir de um topico do kafka ou derivados de um stream exsitente, para isso precisa fornecer o formato dos valores armzanados no tópico, pois não infere o formato de dados do tópico.

Comando para visualizar Streams:

- list streams;


##### Criação de stream


Criar Stream

- create stream <nomeStream> (<campo> <tipo>, ..., <campo> <tipo>) with (kafka_topic='<nomeTopico>', value_format='<formato>', KEY='<campoChave>', TIMESTAMP='<campoTimestamp>');

Formatos: DELIMITED (, CSV), JSON, AVRO


Tópico CSV:

Informação do tópico cadastro:

Rodrigo, São José dos Campos

Augusto, São Paulo


- create stream cad_str_csv (nome varchar, cidade varchar) with (Kafka_topic='cadastro', value_format='delimited');


Tópico JSON:

Informação do tópico cadastrojson:

{"nome": "Rodrigo", "cidade": "São José dos Campos"}

{"nome": "Rodrigo", "cidade": "São Paulo"}


- create stream cad_str_json (nome varchar, cidade varchar) with (Kafka_topic='cadastrojson', value_format='json');


Alterar formato de serialização de CSV/JSON para Avro:

Criar um Stream no formato avro que cria um novo tópico com os dados do stream no formato csv/json. 

CSV para Avro:

- create stream cad_avro_csv (kafka_topic='cadastro-avro', value_format='avro') as select * from cad_str;


Json para Avro:

- create stream cad_str_json (kafka_topic='cadastro-avro', value_format='avro') as select * from cad_str;



#### Operaçoes com Stream


Visualizar conteúdo do Stream

- select * from cad_str limit 10;


Visualizar estrutura do stream

- describe <nomeStream>
- describe extended <nomeStream>


Setar propriedades

- set <propriedades> = <valor>


Desfazer propriedades

- unset <propriedade>


ex: Setar para visualizar os dados desde o inicio:

- set 'auto.offset.reset'='earliest';

Desfazer configuração

- unset 'auto.offset.reset';


Inserção

- insert into <stream_name | table_name> (<column_name>, <...>) values (<value>, '<value>', <...>);

ex: insert into foo (rowtime, rowkey, key_col, col_a) values (1234, 'key', 'key1', 'a');


Deletar uma stream

- drop stream <nomeStream>;

Deletar uma stream e seu topico

- drop stream <nomeStream> delete topic;

- drop stream if exists <nomeStream> delete topic;


### Agregação com Stream


Contar a quantidade de linhas de um campo Stream

- select <campo> count(*) from <nomeStream> group by <campo>;


ex: select cidade, count(*) from cad_str group by cidade;


Contar a quantidade de linhas de todo o tópico, o count sempre precisa do group by, para isso precisaremos criar um campo setado para 1 em todos os registros.


- CREATE STREAM <novoStream> AS SELECT 1 AS unit FROM <nomeStreamParaContar>;

- select count(unit) from <novoStream> group by unit;


#### Exercício KSQL


KSQL

1. Criar o tópico msg-usuario-csv

- control center

- kafka-topics --bootstrap-server localhost:9092 --topic msg-usuario-csv --create --partitions 3 --replication-factor 1

2. Criar um produtor para enviar 3 mensagens contendo id e nome separados por virgula para o tópico msg-usuario-csv

- kafka-console-producer --bootstrap-server localhost:9092 --topic msg-usuario-csv


3. Visualizar os dados do tópico msg-usuario-csv

- kafka-console-consumer --bootstrap-server localhost:9092 --topic msg-usuario-csv

- ksql> print 'msg-usuario-csv' from beginning;


4. Criar o Stream usuario_csv para ler os dados do tópico msg-usuario-csv

- create stream usuario_csv(id int, nome varchar) with(kafka_topic='msg-usuario-csv', value_format='delimited');

5. Visualizar o Stream usuario_csv

- select * from usuario_csv emit changes limit 10;

6. Visualizar apenas o nome do Stream usuario_csv

- select nome from usuario_csv emit changes limit 10;



### KSQL Datagen


Ferramenta de CLI para gerar dados de teste etestar ambientes de desenvolvimento. Para isso, existem diferentes tópicos, orders, users e pageviews em diferentes formatos: avro, json, delimited. Ainda podemos controlar a produção de mensagens, definindo a quanidade e taxa/s.

Acessar:

- docker exec -it ksql-datagen bash

- > ksql-datagen <argumento>

exemplo: > ksql-datagen help


##### Propriedades com containers


cat docker-compose.yml

...
broker:
  ...
  enviroment:
    kafka_advertised_listener:
      plaintext://broker:29092,
      plaintext_host://localhost:9092


Argumentos Datagen - Cluster em Docker

- > ksql-datagen \
  bootstrap-server=broker:29092 \
  quickstart=<orders, users, pageviews> \
  schema=<ArquivoAvro> \
  schemaRegistryUrl=schema-registry:8081 \
  key-format=<avro, json, Kafka ou delimited> \
  value-format=<avro, json ou dedlimited> \
  topic=<nomeTopicoParaCriar> \
  key=<campoChave> \
  iterations=<númeroLinhas> \
  msgRate=<TaxaMsg/segundo>


#### Exemplo Datagen


Criação de dados no tópico orders_topic

- ksql> ksql-datagen bootstrap-server=broker:29092 schemaRegistryUrl=schema-registry:8081 quickstart=orders topic=orders_topic


Visualizar dados no tópico orders_topic

- ksql> print "orders_topic";


Criação de Stream

- CREATE STREAM orders_filtrada(orderid INT, orderunits DOUBLE, address STRUCT<city VARCHAR, zipcode INT>, ordertime VARCHAR) WITH(KAFKA_TOPIC='orders_topic', VALUE_FORMAT='JSON');


Visualização de dados Stream

- ksql> select * from orders_filtrada;



#### Exercício KSQL Datagen

Abrir dois terminais:

- docker exec -it ksql-datagen bash
- docker exec -it ksqldb-server bash > ksql


1. Criar o tópico users com os dados do ksql-datagen

quickstart=users
topic=users

- ksql-datagen> ksql-datagen bootstrap-server=broker:29092 schemaRegistryUrl=schema-registry:8081 quickstart=users topic=users iterations=50

2. Visualizar os dados do tópico no Ksql

- ksql> print "users" from beginning limit 10;

3. Criar o stream users_raw com os dados do tópico users com as seguintes propriedades

kafka_topic='users’
value_format='JSON’
key = 'userid’
timestamp='viewtime’


- ksql> create stream users_raw(userid VARCHAR, regionid VARCHAR, gender VARCHAR) with(kafka_topic='users', value_format='json', key='userid');

Obs.: Não existe a coluna viewtime no topico users, existe a coluna registertime. Para usá-la como timestamp, precisamos incluir essas coluna na definição do schema, ficando dessa forma:

- ksql> create stream users_raw(userid VARCHAR, regionid VARCHAR, gender VARCHAR, registertime BIGINT) with(kafka_topic='users', value_format='json', key='userid', TIMESTAMP='registertime');

4. Visualizar a estrutura da Stream users_raw

- ksql> describe users_raw;

5. Visualizar os dados da Stream users_raw

- set 'auto.offset.reset'='earliest';

- ksql> select * from users_raw emit changes limit 10;

6. Repetir todo o proceso para o tópico pageviews

- ksql-datagen> ksql-datagen bootstrap-server=broker:29092 schemaRegistryUrl=schema-registry:8081 quickstart=pageviews topic=pageviews iterations=50

- print "pageviews" from beginning limit 10;

- ksql> create stream pageviews_raw(userid VARCHAR, pageid VARCHAR, viewtime BIGINT) with(kafka_topic='pageviews', value_f
ormat='json', key='userid', TIMESTAMP='viewtime');

- ksql> describe pageviews_raw;

- ksql> select * from pageviews_raw emit changes limit 10;