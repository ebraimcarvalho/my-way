### Elastic Search

Objetivo é resolver problema de busca. É composto por:

1. Elasticsearch: Engine de search e analytics altamente escalável e banco de dados;

2. Logstash: Responsável por transporte entre origem e destino; Roda no lado do servidor

3. Beats: Pode ser utilizado como coletor de dados, distribuído e roda no lado do cliente, é mais leve que o logstash;

4. Kibana: GUI(Graphical User Interface) da Elastic para visualização dos dados e gerenciamento do Elasticsearch.


#### Relacional x ElasticSearch


Banco relacional  x   ElasticSearch

Banco de dados    x   Index

<s>Tabela</s>     x   <s>Type</s>

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



### Comunicação com Elasticsearch


Comunicação protocolo HTTP

- HEAD
- GET
- POST
- PUT
- DELETE

Requisições HTTP para a APi de elasticsearch por meio do envio de objetos JSON.

Estrutura de uma requisição HTTP:

- <ação> endereço_api:porta/indice/<opcoes>

- Ex: PUT localhost:9200/cliente/_create


### Interface Kibana - Comunicação HTTP

- http://localhost:5601

- Menu/Management/Dev Tools

- http://localhost:5601/app/dev_tools


### Operações Básicas CRUD


- Create
- Read
- Update
- Delete

#### HEAD

Retorna apenas o cabeçalho do HTTP para saber se o documento exsite

Exemplo:

- CURL: curl -XHEAD -v http://localhost:9200/cliente/_doc/1

Obs.: Curl é uma ferramenta de linha de comando, biblioteca para transferir dados com URLs.

- Kibana: HEAD cliente/_doc/1


#### PUT

Criar ou reindexar um documento inteiro (_version)

- PUT cliente/_doc/1  //Obs. se executar novamente, cria outro com um version diferente
{
  "nome": "Lucas",
  "idade": 20,
  "conhecimento": "Windows, Office, Hadoop, Elastic"
}

- PUT cliente/_create/1  or PUT cliente/_doc/1/_create //Obs.: só cria um, se executar novamente retorna erro
{
  "nome": "Lucas",
  "idade": 20,
  "conhecimento": "Windows, Office, Hadoop, Elastic, Sqoop"
}


#### POST

Criar um documento com _id ou atualizar um documetno parcial

- POST cliente/_update/1 // Atualiza o documento
{
  "doc": {
    "nome": "João"
  }
}

- POST cliente/_doc // Cria documento com id automatico
{
  "nome": "Marcos"
}


#### DELETE

Deletar um documento

- DELETE cliente/_doc/1

Deletar um índice

- DELETE cliente


#### GET

Informações sobre o nó do elasticsearch

- GET /

Buscar todos os documentos em um índice

- GET cliente/_search

Buscar um documento em um índice, retorna outras informações além dos dados do documento em si

- GET cliente/_doc/1

Buscar a quantidade de documentos em um índice

- GET cliente/_count

Buscar os dados de um documento em um índice, retorna os dados do documento. Mesmo que SQL-> SELECT * FROM cliente WHERE id = 1

- GET cliente/_source/1


#### Exercício CRUD Elasticsearch

CRUD

1. Criar o índice produto e inserir os seguintes documentos:

_id: 1, "nome": "mouse", "qtd": 50, "descricao": "com fio USB, compatível com Windows, Mac e Linux"
_id: 2, "nome": "hd", "qtd": 20, "descricao": "Interface USB 2.0, 500GB, Sistema: Windows 10, Windows 8, Windows 7 "
_id: 3, "nome": "memória ram", "qtd": 10, "descricao": "8GB, DDR4"
_id: 4, "nome": "cpu", "qtd": 15, "descricao": "i5, 2.5Ghz"

2. Verificar se existe o documento com  id 3

3. Alterar o valor do atributo qtd para 30 do documento com id 3

4. Buscar o documento com id 1

5. Deletar o documento com id 4

6. Contar quantos documentos tem o índice produto