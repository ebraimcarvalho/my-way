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


- PUT produto/_create/1
{
  "nome": "mouse",
  "qtd": 50, 
  "descricao": "com fio USB, compatível com Windows, Mac e Linux"
}

- PUT produto/_create/2
{
  "nome": "hd",
  "qtd": 20, 
  "descricao": "Interface USB 2.0, 500GB, Sistema: Windows 10, Windows 8, Windows 7 "
}

- PUT produto/_create/3
{
  "nome": "memória ram",
  "qtd": 10, 
  "descricao": "8GB, DDR4"
}

- PUT produto/_create/4
{
  "nome": "cpu",
  "qtd": 15, 
  "descricao": "i5, 2.5Ghz"
}



2. Verificar se existe o documento com  id 3

- HEAD produto/_doc/3

3. Alterar o valor do atributo qtd para 30 do documento com id 3

- POST produto/_update/3
{
  "doc": {
    "qtd": 30
  }
}

4. Buscar o documento com id 1

- GET produto/_doc/1

5. Deletar o documento com id 4

- DELETE produto/_doc/4

6. Contar quantos documentos tem o índice produto

- GET produto/_count


### Múltiplas Operações Simultâneas


Bulk API, permite a execução de várias operações de indexação / exclusão em uma única chamada da API. Permite também aumentar a velocidade de indexação.


#### Comandos

POST_bulk
{"index": {"_index": "test", "_id": "1"} }
{"field1": "value1"}
{"delete": {"_index": "test", "_id": "2"} }
{"create": {"_index": "test", "_id": "3"} }
{"field1": "value3"}
{"update": {"_index": "test", "_id": "1"} }
{"doc": {"field2": "value2"} }

POST concessionaria/_bulk
{"create": {"_id": "1"} }
{"nome": "carro"}
{"create": {"_id": "2"} }
{"nome": "automóvel"}
{"create": {"_id": "3"} }
{"nome": "caminhão"}
{"create": {"_id": "4"} }
{"nome": "caminhonete"}
{"create": {"_id": "5"} }
{"nome": "veículo"}



#### Importação de dados com Kibana

Homw/Menu/Kibana/Machine Learning/Import Data/Upload File


##### Exercício Bulk API e Importação

1. Importar os dados na Guia Arquivos para os índices

Índice: concessionaria2
dataset/cars.bulk
Índice: populacao
dataset/populacaoLA.csv


2. Executar as consultas

Contar o número de documentos de cada um dos novos índices
Mostrar todos os documentos de cada um dos novos índices

- GET concessionaria2/_count

- GET populacao/_count

- GET concessionaria2/_search

- GET populacao/_search


#### Api de Pesquisa

Buscar todos os documentos

- GET cliente/_search


Pesquisar algo em todos os documentos, faz o uso do campo "_all"

- GET cliente/_search?q=hadoop


Pesquisar em um atributo específico

- GET cliente/_search?q=nome:João

- GET cliente/_search?q:João&q=idade:20


##### Definição de consultas

Query DSL (Domain Specific Language), baseada em JSON

Exemplo:

- GET cliente/_search?q=Hadoop

- GET cliente/_search?q=Hadoop
{
  "query": {
    "match_all": {}
  }
}


##### Pesquisa Cabeçalho

Estrutura do json de busca

- Took: Tempo em milissegundo
- Timed_out: Tempo de limite excedido
- _shards: Quantidade de limite excedido
- Hits: Informação do resultado
  Total: Quantidade de documentos encontrados
  Max_score: Valor de semelhança da consulta (0 à 1)

O score é calculado com uso do algoritmo BM25


##### Pesquisa Múltiplos índices

Pesquisar em todos os índices, cuidado para não fazer consultas lentas

- GET _all/_search?q=Windows


Pesquisar em índices específicos

- GET produto,cliente/_search?q=Windows
- GET produto,cliente/_count?q=Windows

Caso o índice não exista: index_not_found_exception


##### Pesquisa Limitação e paginação

Para pesquisas com muitos documentos e com difícil visualização, podemos usar para limitar a quantidade de documentos o atributo size para definir o número de documentos e o from para a paginação que será exibida.

Por padrão a resposta máxima são 10.000 documentos, logo, o from + size tem que ser menor ou igual a 10.000 (index.max_result_window). Caso precise visualizar mais documentos, usar o atributo scroll


Exemplo para limitar o número de documentos

- GET cliente/_search?q=hadoop&size=100

Paginação, visualizar n documentos por paginação

- GET cliente/_search?q=hadoop&size=100&from=500


Paginação na estrutura na busca
- GET cliente/_search
{
  "from": 0, 
  "size": 10,
  "query": {}
}

Mostrar os 10 primeiros documentos da 1ª página

- GET cliente/_search&from=0&size=10
{
  "query": {
    "match_all": {}
  }
}

Mostrar os documentos de 31 a 40 (4ª página)

-GET cliente/_search&from=30&size=10
{
  "query": {
    "match_all": {}
  }
}


Exemplo com paginação de 10 documentos

- 1ª Página: size = 10, from = 0 (default)
- 2ª Página: size = 10, from = 10
- 10ª Página: size = 10, from = 90

Fórmula

Primeiro documento da busca = from + 1

Último documento da busca: from + size

Página: from / size + 1


#### Exercício Pesquisa e Paginação

1. Pesquisar no índice produto os documentos com os seguintes atributos:

a) Nome = mouse

b) Quantidade = 30

c) Descrição = USB

d) Nome = hd e descrição = windows

e) Nome = memória e descrição = GB


- GET produto/_search?q=nome:mouse

- GET produto/_search
{
  "from": 0, 
  "size": 10,
  "query": {
    "nome": "mouse"
  }
}

- GET produto/_search?q=qtd:30

- GET produto/_search?q=descricao:USB

- GET produto/_search?q=nome:hd&q=descricao:windows

- GET produto/_search?q=nome:memória&descricao:GB


2. Pesquisar todos os índices, limitando a pesquisa em 5 documentos em cada página e visualizar a 4 página (Documentos entre 16 á 20 )

- GET _all/_search&from=15&size=5


#### Api de Índices

Gerenciamento de índices

##### Criação

Configuração básica:

PUT teste
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 1
    }
  },
  "mappings": {},
  "aliases": {}
}

Obs.: Cada shard ter entre 20GB a 50GB (não é uma regra), precisa testar o índice para saber o valor ideal


##### Busca índice

Consulta índice

- GET teste
- GET teste/_search
- GET teste/_settings
- GET teste/_mapping
- GET teste/_alias
- GET teste/_stats

Verificar se o índice existe

- HEAD teste


Deletar um índice

- PUT teste1
- DELETE teste 1

Deletar múltiplos índices

- PUT indice1
- PUT indice2
- PUT indice3
- PUT indice4
- GET ind*

- DELETE ind*

- HEAD ind*


##### Fechamento e abertura de índice

Fechar índice para diminuir a sobrecarga no cluster, mas mantem os metadados. Bloqueia a leitura e gravação.

Não manter por muito tempo, quando um nó deixar o cluster as cópias serão perdidas, a solução é usar Frozen index

Exemplo abertura

- POST teste/_open
- POST test*/_open

Exemplo fechamento

- POST teste/_close
- POST test*/_close



#### Mapeamento

Elasticsearch define automaticamente no índice, os tipos dos campos, mesmo que o schema da tabela no SQL.

Exemplo:

- GET cliente/_mapping

Atenção, não é possível alterar o tipo do dado, para isso será necessário reindexar o documento com as informações corretas. É possível criar novos atributos.


#### Mapeamento Pesquisa

Mapeamento pelo índice

- GET cliente/_mapping
- GET client*/_mapping

Mapeamento pelo atributo

- GET/_mapping/field/conhecimento
- GET/_mapping/field/conhe*
- GET/_mapping/field/nome,conhecimento

Mapeamento de todos os índices

- GET _mapping


#### Exemplo de Criação de Mapeamento

- PUT cliente1
{}

- PUT cliente1/_mapping
{
  "properties": {
    "nome": {"type": "text"},
    "idade": {"type": "long"},
    "conhecimento": {"type": "keyword"},
  }
}


#### Reindex

Para alterar o mapeamento, a forma básica para reindexar é configurar o novo índice, indexando o índice de entrada (source) para o destino (dest)

Exemplo:

- POST _reindex
{
  "source": {
    "index": "teste1"
  },
  "dest": {
    "index": "new_teste"
  }
}


#### Exercício Mapeamento e Reindex

Índices

1. Visualizar as configurações do índice produto

- GET produto/_settings

2. Visualizar o mapeamento do índice produto

- GET produto/_mapping

3. Visualizar o mapeamento do atributo nome do índice produto

- GET produto/_mapping/field/nome

4. Inserir o campo data do tipo date no índice produto

- PUT produto/_mapping
{
  "properties": {
    "data": {"type": "date"}
  }
}

5. Adicionar o documento:

_id: 6, "nome": "teclado", "qtd": 100, "descricao": "USB", "data":"2020-09-18"

- PUT produto/_doc/6
{
  "nome": "teclado",
  "qtd": 100,
  "descricao": "USB",
  "data": "2020-09-18"
}


6. Reindexar o índice produto para produto2, com o campo quantidade para o tipo short

- PUT produto2/_mapping
{
  "properties": {
    "nome": {"type": "text"},
    "qtd": {"type": "short"},
    "descricao": {"type": "keyword"},
    "data": {"type": "date"}
  }
}

- POST _reindex
{
  "source": {
    "index": "produto"
  },
  "dest": {
    "index": "produto2"
  }
}

7. Visualizar o mapeamento do índice produto2

- GET produto2/_mapping

8. Fechar o índice produto

- POST produto/_close

9. Pesquisar todos os documentos no índice produto

- GET produto/_search

10. Abrir o índice produto

- POST produto/_open 


#### Entendimento de Query


Queries e Filtros

Queries: Quão bem a busca corresponde com o documento, tem caracteristicas de ter score e não são armazenadas em cache

Filtros:  A busca corresponde com o documento do tipo, sim ou não atende ao match. Tem caracteristica não possuir score (order by) e são armzanenados em cache automaticamente para acelerar o desempenho.

Índice invertido

Query DSL: Todas as queries calculam o "_score", se não, utilizar o "constant_score". Serve para filtrar os dados antes da busca textual, para ganhar desempenho.


Exemplo Query - Term

- GET cliente/_search
{
  "query": {
    "term": {
      "nome": "joão"
    }
  }
}

Busca exatamente como está no index invertido.


Exemplo query - Term com constant_score

- GET cliente/_search
{
  "query": {
    "constant_score": {
      "filter": {
        "term": {
          "nome": "joão"
        }
      }
    }
  }
}


Exemplo query - Terms

- GET cliente/_search
{
  "query": {
    "terms": {
      "idade": [30,20]
    }
  }
}


#### Bool Query

Para filtrar um dataset grande, com estrutura flexível.

Atributos:

- Must: And
- Should: OR
- Must_not: Not and
- Filter: Filtrar mais dados antes de atender as outras cláusulas


- GET cliente/_search
{
  "query":{
    "bool": {
      "must": [{}],
      "must_not": [{}],
      "should": [{}],
      "filter": [{}]
    }
  }
}

##### Exemplo

- 1 Consulta booleana com 1 atributo

- GET cliente/_search
{
  "query": {
    "bool": {
      "should": {
        "term": {
          "idade": "30"
        }
      }
    }
  }
}


- 1 Consulta booleana com N Atributos

- GET cliente/_search
{
  "query": {
    "bool": {
      "must": [
        {"must": {"estado": "sp"}},
        {"must": {"ativo": "sim"}},
      ]
    }
  }
}


- N consultas booleanas com N atributos

- GET cliente/_search 
{
  "query": {
    "bool": {
      "must": {"match": {"setor": "vendas"}},
      "should": [
        {"match": {"tags": "imutabilidade"}},
        {"match": {"tags": "larga escala"}},
      ],
      "must_not": {"match": {"nome": "inativo"}}
    }
  }
}


#### Exercícios Query e Filtros

Query e Filtros

Realizar todas as buscas a seguir no índice produto

1. Buscar no termo nome o valor mouse

2. Buscar no termo nome os valores mouse e teclado

3. Realizar a mesma busca do item 1 e 2, desconsiderando o score

4. Buscar os documentos que contenham a palavra “USB” no atributo descrição

5. Buscar os documentos que contenham a palavra “USB” e não contenham a palavra “Linux” no atributo descrição

6. Buscar os documentos que podem ter a palavra “memória” no atributo nome ou contenham a palavra “USB” e não contenham a palavra “Linux” no atributo descrição