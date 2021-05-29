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