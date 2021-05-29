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

