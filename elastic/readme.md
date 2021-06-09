### Elastic Search

Objetivo é resolver problema de busca. É composto por:

1. Elasticsearch: Engine de search e analytics altamente escalável e banco de dados;

2. Logstash: Responsável por transporte entre origem e destino; Roda no lado do servidor

3. Beats: Pode ser utilizado como coletor de dados, distribuído e roda no lado do cliente, é mais leve que o logstash;

4. Kibana: GUI(Graphical User Interface) da Elastic para visualização dos dados e gerenciamento do Elasticsearch.


#### Relacional x ElasticSearch


Banco relacional  x   ElasticSearch

Banco de dados    x   Index

Tabela            x   Type

Schema            x   Mapping

Registro          x   Documento

Coluna            x   Atributo


Obs.: A partir da versao 7 do Elastic, os documentos são todos do tipo _doc


#### Índice


Índice é onde ficam os dados, e é composto de:

- shards: índice é dividido por shards, armazenam os dados

- alias: Link virtual para um índice real (apelido), e associa um alias a mais de um índice (grupos)

- Analyzer: Buscar por full text e valores exatos

- Mapping: Definição de estrutura do seu índice


#### Acessar container

- docker exec -it elastic_elasticsearch_1 bash

- docker exec -it elastic_kibana_1 bash

- docker exec -it elastic_logstash_1 bash


#### Verificar funcionamento do cluster Elastic

- Verificar se os nós estão funcioinando: $ curl -X GET "localhost:9200/_cat/nodes?v&pretty"

- Acessar os serviços pela web: Kibana: http://localhost:5601/ or elasticsearch: http://localhost:9200/


#### Instalação Elastic

1. Baixar a pasta elastic na Guia Arquivos do treinamento

2. Instalação do docker e docker-compose

Docker: https://docs.docker.com/get-docker/ (Links para um site externo.)
Docker-compose: https://docs.docker.com/compose/install/ (Links para um site externo.)
3. Executar os seguintes comandos, para baixar as imagens de Elastic:

- docker-compose pull

4. Setar na máquina o vm.max_map_count com no mínimo 262144

- open powershell
- wsl -d docker-desktop
- sysctl -w vm.max_map_count=262144

5. Iniciar o cluster Elastic através do docker-compose

- docker-compose up -d

6. Listas as imagens em execução

- docker ps

7. Verificar os logs dos containers em execução

- docker-compose logs

8. Verificar as informações do cluster através do browser:

http://localhost:9200/ (Links para um site externo.)

9. Acessar o Kibana através do browser:

http://localhost:5601/