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
        {"match": {"estado": "sp"}},
        {"match": {"ativo": "sim"}},
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

- GET produto/_search
{
  "query": {
    "term": {
      "nome": "mouse"
    }
  }
}

2. Buscar no termo nome os valores mouse e teclado

- GET produto/_search
{
  "query": {
    "terms": {
      "nome": ["mouse", "teclado"]
    }
  }
}

3. Realizar a mesma busca do item 1 e 2, desconsiderando o score

- GET produto/_search
{
  "query": {
    "constant_score": {
      "filter": {
        "term": {
          "nome": "mouse"
        }
      }
    }
  }
}


- GET produto/_search
{
  "query": {
    "constant_score": {
      "filter": {
        "terms": {
          "nome": ["mouse", "teclado"]
        }
      }
    }
  }
}

- GET produto/_search
{
  "query": {
    "bool": {
      "should": {
        "term": {
          "nome": "mouse"
        }
      }
    }
  }
}

- GET produto/_search
{
  "query": {
    "bool": {
      "should": [
        {"match": {"nome": "mouse"}},
        {"match": {"nome": "teclado"}}
      ]
    }
  }
}

4. Buscar os documentos que contenham a palavra “USB” no atributo descrição

- GET produto/_search
{
  "query": {
    "match": {
      "descricao": "USB"
    }
  }
}

- GET produto/_search
{
  "query": {
    "bool": {
      "should": {
        "term": {
          "descrição": "USB"
        }
      }
    }
  }
}

5. Buscar os documentos que contenham a palavra “USB” e não contenham a palavra “Linux” no atributo descrição

- GET produto/_search
{
  "query": {
    "bool": {
      "must": [
        {"match": {"descrição": "USB"}}
      ],
      "must_not": [
        {"match": {"descrição": "Linux"}}
      ]
    }
  }
}

6. Buscar os documentos que podem ter a palavra “memória” no atributo nome ou contenham a palavra “USB” e não contenham a palavra “Linux” no atributo descrição

- GET produto/_search
{
  "query": {
    "bool": {
      "should": [
        {"match": {"nome": "memória"}},
        {"match": {"descrição": "USB"}}
      ],
      "must_not": [
        {"match": {"descrição": "Linux"}}
      ]
    }
  }
}


#### Ordem de busca

- Quantas vezes o termo aparece no atributo
- Tamanho do atributo
- Tamanho do termo
- Quantaz vezes o termo aparece em todos os documentos

Exemplo:

- GET cliente/_search
{
  "query": {
    "match": {
      "conhecimento": "sqoop hive impala elk"
    }
  }
}

O padrão é "or", para alterar, usar o "operator": "and"

- GET cliente/_search
{
  "query": {
    "match": {
      "conhecimento": {
        "query": "sqoop hive",
        "operator": "and"
      }
    }
  }
}


Para definir o mínimo % que estejam na consulta, usar o "minimum_should_match": "valor em %"


- GET cliente/_search
{
  "query": {
    "match": {
      "hobby": {
        "query": "sqoop hive impala",
        "minimum_should_match": "50%"
      }
    }
  }
}

Para definir o mínimo de quantidade que estejam na consulta, usar o "minimum_should_match": numero


- GET cliente/_search
{
  "query": {
    "match": {
      "hobby": {
        "query": "sqoop hive impala",
        "minimum_should_match": 2
      }
    }
  }
}


##### Múltiplos atributos

{
  "query": {
    "bool": {
      "should": [
        {"match": {"endereco": "pinheiros"}},
        {"match": {"cidade": "pinheiros"}},
        {"match": {"estado": "pinheiros"}},
      ]
    }
  }
}


{
  "query": {
    "multi_match": {
      "query": "pinheiros",
      "type": "most_fields",
      "fields": ["endereco", "cidade", "estado"]
    }
  }
}

Obs.: Não pode usar junto com operator e minimum_should_match


#### Exercício ordem de busca

Ordem de Busca

Realizar todas as buscas a seguir no índice produto

1. Buscar os documentos que contenham as palavras “Windows” e “Linux” no atributo descrição

- GET produto/_search
{
  "query": {
    "match": {
      "descricao": {
        "query": "Windows Linux",
        "operator": "and"
      }
    }
  }
}

2. Buscar os documentos que contenham as palavras “Windows”, “Linux” ou “USB” no atributo descrição

- GET produto/_search
{
  "query": {
    "match": {
      "descricao": "Windows Linux USB"
    }
  }
}

3. Buscar os documentos que contenham pelo menos 2 palavras da seguinte lista de palavras: “Windows”, “Linux” e “USB” no atributo descrição

- GET produto/_search
{
  "query": {
    "match": {
      "descricao": {
        "query": "Windows Linux USB",
        "minimum_should_match": 2
      }
    }
  }
}

4. Buscar os documentos que contenham pelo menos 50 % da seguinte lista de palavras: “Windows”; “Linux” e “USB” no atributo descrição

- GET produto/_search
{
  "query": {
    "match": {
      "descricao": {
        "query": "Windows Linux USB",
        "minimum_should_match": "50%"
      }
    }
  }
}


#### Consulta por intervalo

Atributos para controlar o intervalo:

- gte: Maior ou igual
- gt: Maior que
- lte: Menor ou igual
- lt: Menor que


Ex: Consultar o campo idade maior ou igual a 10

- GET cliente/_search
{
  "query": {
    "range": {
      "idade": {
        "gte": 10
      }
    }
  }
}


Ex: Consultar o campo idade entre 10 e 25

- GET cliente/_search
{
  "query": {
    "range": {
      "idade": {
        "gte": 10,
        "lte": 25
      }
    }
  }
}


#### Consultas por intervalo de tempo

Propriedades com data

- "format": "dd/MM/yyyy||yyyy"
- "time_zone": "+03:00"
- Now: Agora
- +1d: Adiciona 1 dia
- -1M: Subtrai 1 Mês

- y: Anos
- M: Meses
- w: Semanas
- d: Dias
- H: Horas
- h: Horas
- m: Minutos
- s: Segundos


- Exemplo com diferentes formatos

- GET cliente/_search
{
  "query": {
    "range": {
      "data": {
        "gte": "01/01/2012",
        "lte": "2013",
        "format": "dd/MM/yyyy||yyyy"
      }
    }
  }
}

- GET cliente/_search
{
  "query": {
    "range": {
      "data": {
        "gte": "now-1d",
        "lt": "now"
      }
    }
  }
}

- GET cliente/_search
{
  "query": {
    "range": {
      "timestamp": {
        "gte": "2015-01-01 00:00:00",
        "lte": "now",
        "time_zone": "+03:00"
      }
    }
  }
}

- GET cliente/_search
{
  "query": {
    "range": {
      "@timestamp": {
        "gte": "2015-08-04T11:00:00",
        "lt": "2015-08-04T12:00:00"
      }
    }
  }
}



#### Exercícios Consulta por Intervalo

Consultas por Intervalo

1. Verificar se existe o índice populacao

- HEAD populacao

2. Executar as consultas no índice populacao

a) Mostrar os documentos com o atributo "Total Population" menor que 100

- GET populacao/_search
{
  "query": {
    "range": {
      "Total Population": {
        "lt": 100
      }
    }
  }
}

b) Mostrar os documentos com o atributo "Median Age" maior que 70

- GET populacao/_search
{
  "query": {
    "range": {
      "Median Age": {
        "gt": 70
      }
    }
  }
}

c) Mostrar os documentos 50 (Zip Code: 90056) à 60 (Zip Code: 90067) do índice de populacao

- GET populacao/_search
{
  "query": {
    "range": {
      "Zip Code": {
        "gte": 90056,
        "lte": 90067
      }
    }
  }
}

3. Importar através do Kibana o arquivo weekly_MSFT.csv. Pré-visualizar o documento (Guia Arquivos/dataset/weekly_MSFT.csv) com o índice bolsa

- machine learngin/upload files

4. Executar as consultas no índice bolsa

a) Visualizar os documentos do dia 2019-01-01 à 2019-03-01. (hits = 9)

- GET bolsa/_search
{
  "query": {
    "range": {
      "timestamp": {
        "gte": "2019-01-01",
        "lte": "2019-03-01",
        "format": "yyyy-MM-dd"
      }
    }
  }
}

b) Visualizar os documentos do dia 2019-04-01 até agora. (hits = 3)

- GET bolsa/_search
{
  "query": {
    "range": {
      "timestamp": {
        "gte": "2019-04-01",
        "lte": "now",
        "format": "yyyy-MM-dd"
      }
    }
  }
}


#### Analyzer

Busca exata: Sim e não

Busca FullText: Quanto a busca casa (_score), Analisadores servem para testar, aplicar em atributos específicos e criar analyzer personalizado

Índice invertido: Quebra em tokens e insere numa tabela. Exemplo: _search?cidade="São Paulo" -> Tokens: são paulo

Principais Analyzer

- Espaço em branco: whitespace: Separa as palavras por espaço

- Simples: simple: Remove números, remove espaços e pontuação, somente texto em lowercase.

- Padrão: standard: Remove espaços e pontuação, texto em lowercase

- Idioma: Brazilian, English: Remove acentos, gênero, plural.


##### Exemplo de Analyzer

Analyzer Standard ou Simple

- POST _analyze
{
  "analyzer": "standard",
  "text": "Elasticsearch e Hadoop são ferramentas de Big Data"
}

- POST _analyze
{
  "analyzer": "simple",
  "text": "Elasticsearch e Hadoop são ferramentas de Big Data"
}

Obs.: Vão colocar as palavras em lowercase, remover espações e pontuação. Simple remove números.

- POST _analyze
{
  "analyzer": "whitespace",
  "text": "Elasticsearch e Hadoop são ferramentas de Big Data"
}

Obs.: Separa as palavras pelos espaços

- POST _analyze
{
  "analyzer": "brazilian",
  "text": "Elasticsearch e Hadoop são ferramentas de Big Data"
}

Obs.: Remove acentos, plurao e genero, palavras em lowercase, English é melhor formatado o dicionário.


##### Aplicação de Analyzer em atributos

- PUT cliente1
{
  "mapping": {
    "properties": {
      "conhecimento": {
        "type": "text",
        "analyzer": "standard"
      }
    }
  }
}


##### Boas práticas

Indexar o mesmo campo de maneiras diferentes para fins diferentes

- Tipo Keyword: Para Classificação e Agregação

- Tipo Text: Pesquisa Fulltext

Manter 2 versões do atributo como analyzer

- Tipo Keyword: Dado original

- Tipo Text: Dado com analisador


##### Exemplo de Campo de 2 tipos

- PUT cliente2
{
  "mapping": {
    "properties": {
      "conhecimento": {
        "type": "text",
        "analyzer": "standard",
        "fields": {"raw": {"type": "keyword"}}
      }
    }
  }
}

- PUT cliente3
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  },
  "mapping": {
    "properties": {
      "nome": {"type": "text"},
      "conhecimento": {
        "type": "text",
        "analyzer": "whitespace",
        "fields": {
          "raw": {"type": "keyword"}
        }
      }
    }
  }
}


#### Exercício Analyzer

Analyzer

1. Criar os Analyzer simple, standard, brazilian e portuguese para a seguinte frase:

O elasticsearch surgiu em 2010

- POST _analyze
{
  "analyzer": "simple",
  "text": "O elasticsearch surgiu em 2010"
}

- POST _analyze
{
  "analyzer": "standard",
  "text": "O elasticsearch surgiu em 2010"
}

- POST _analyze
{
  "analyzer": "brazilian",
  "text": "O elasticsearch surgiu em 2010"
}

- POST _analyze
{
  "analyzer": "portuguese",
  "text": "O elasticsearch surgiu em 2010"
}

2. Realizar os passos no índice produto

a) Criar um analyzer brazilian para o atributo descricao

- PUT produto1
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  },
  "mapping": {
    "properties": {
      "descricao": {
        "type": "text",
        "analyzer": "brazilian"
      }
    }
  }
}

- POST _reindex
{
  "source": {
    "index": "produto"
  },
  "dest": {
    "index": produto1"
  }
}

b) Para o atributo descricao aplicar o analzyer brazilian para o tipo de campo text e criar o atributo descricao.original com o dado do tipo keyword

- DELETE produto

- PUT produto
{
  "settings": {
    "index": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  },
  "mapping": {
    "properties": {
      "descricao": {
        "type": "text",
        "analyzer": "brazilian",
        "fields": {
          "original": {"raw": {"type": "keyword"}}
        }
      }
    }
  }
}

- POST _reindex
{
  "source": {
    "index": "produto1"
  },
  "dest": {
    "index": produto
  }
}

c) Buscar a palavra “compativel” no campo descricao.original (hits = 0)

- GET produto/_search
{
  "query": {
    "match": {
      "descricao.original": "compativel"
    }
  }
}

d) Buscar a palavra “compativel” no campo descricao

- GET produto/_search
{
  "query": {
    "match": {
      "descricao": "compativel"
    }
  }
}


#### Conceitos de Agregações

Forma de analisar os dados indexados. Estrutura:

- GET <index>/_search
{
  "aggs": {
    "<nomeAgregação>": {
      "<tipoAgregação>": {}
    }
  }
}


##### Tipos de Agregações

- Bucket: Combinam os documentos resultantes em buckets. Buckets são criados.

- Metric: Cálculos matemáticos feitos nos campos de documentos. São calculados em buckets

- Matrix: Operam em diversos campos produzindo uma matriz de resultado (matrix_stats)

- Pipeline: Agrega a saída de outras agregações


##### Buckets

Conjunto de documento formado por critérios de Data, Intervalo ou Atributo. Ex:

- Range
- Date_range
- Ip_ranges
- Geo_distance
- Significant_terms


##### Metricas

Operações matemáticascom um valor de saída. Ex:

- Avg
- Sum
- Min
- Max
- Cardinality
- Value_count
- Etc


Operações matemáticas com N valores de saída

- Stats
- Percentiles
- Percentile_ranks


##### Exemplos

Média do campo qtd

- GET cliente/_search
{
  "query": {},
  "aggs": {
    "media": {
      "avg": {
        "field": "qtd"
      }
    }
  }
}


#### Sum com limitação de escopo, visualizar apenas o resultado da agregação, ou uma parte dos resultados, usar o size.

- GET cliente/_search
{
  "query": {},
  "size": 0,
  "aggs": {
    "soma": {
      "sum": {
        "field": "qtd"
      }
    }
  }
}


#### Várias estatísticas com apenas uma requisição. Estatísticas: count, min, max, avg e sum

- GET cliente/_search
{
  "query": {},
  "aggs": {
    "estatisticas": {
      "stats": {
        "field": "qtd"
      }
    }
  }
}


Valores mínimo e máximo

- GET cliente/_search
{
  "query": {},
  "aggs": {
    "minimo": {
      "min": {
        "field": "qtd"
      }
    },
    "maximo": {
      "max": {
        "field": "qtd"
      }
    }
  }
}


#### Exemplo de cardinalidade, para contar valores únicos. O resultado pode não ser preciso para grandes datasets. Faz uso do algoritmo HyperLogLog++ que faz um calculo de velocidade vs precisao

- GET cliente/_search
{
  "size": 0,
  "aggs": {
    "quantidade_cidades": {
      "cardinality": {
        "field": "cidade.keyword"
      }
    }
  }
}


#### Exemplo para separar em percentis, e assim encontrar a mediana.

- GET cliente/_search
{
  "aggs": {
    "mediana": {
      "percentiles": {
        "field": "qtd"
      }
    }
  }
}

- GET cliente/_search
{
  "aggs": {
    "percentil": {
      "percentiles": {
        "field": "qtd",
        "percents": [25,50,75,100]
      }
    }
  }
}


#### Exemplo com tempo para agrupar valores por um intervalo: date_histogram

- GET log_servico/_search
{
  "size": 0,
  "aggs": {
    "logs_por_dia": {
      "date_histogram": {
        "field": " @timestamp",
        "calendar_interval": "day"
      }
    }
  }
}

obs.: "calendar_interval": "month" | "fixed_interval": "10m"

Medidas: ms, s, m, h, d, w, M, q, y

- GET log_servico/_search
{
  "size": 0,
  "aggs": {
    "logs_cada_100ms": {
      "histogram": {
        "field": " runtime_ms",
        "interval": 100
      }
    }
  }
}


##### Exemplo Intervalo

- GET cliente/_search
{
  "query": {},
  "aggs": {
    "intervalo": {
      "range": {
        "field": "qtd",
        "ranges": [
          {"to": 5},
          {"from": 5, "to": 20},
          {"from": 20}
        ]
      }
    }
  }
}


##### Exemplo Intervalo de Data

- GET cliente/_search
{
  "query": {},
  "aggs": {
    "intervalo_data": {
      "date_range": {
        "field": "data",
        "ranges": [
          {"from": 2019-01-01, "to": 2019-05-01}
        ]
      }
    }
  }
}


##### Exemplo Atributo

Especificar o campo e a quantidade de valores com a maior relevancia. Ex: As 5 maiores cidades que visitaram o site

- GET logs_servico/_search
{
  "size": 0,
  "aggs": {
    "cidades_views": {
      "terms": {
        "field": "cidade.keyword",
        "size": 5
      }
    }
  }
}


#### Exercício Agregações

Agregações

Realizar os exercícios no índice bolsa

1. Calcular a média do campo volume

- GET bolsa/_search
{
  "size": 0,
  "aggs": {
    "media": {
      "avg": {
        "field": "volume"
      }
    }
  }
}

2. Calcular a estatística do campo close

- GET bolsa/_search
{
  "size": 0,
  "aggs": {
    "estatisticas": {
      "stats": {
        "field": "close"
      }
    }
  }
}

3. Visualizar os documentos do dia 2019-04-01 até agora. (hits = 3)

- GET bolsa/_search
{
  "query": {
    "range": {
      "@timestamp": {
        "gte": "2019-04-01",
        "lte": "now"
      }
    }
  }
}

4. Calcular a estatística do campo open do período do dia 2019-04-01 até agora

- GET bolsa/_search
{
  "query": {
    "range": {
      "@timestamp": {
        "gte": "2019-04-01",
        "lte": "now"
      }
    }
  },
  "aggs": {
    "estatisticas": {
      "stats": {
        "field": "open"
      }
    }
  }
}

5. Calcular a mediana do campo open

- GET bolsa/_search
{
  "size": 0,
  "aggs": {
    "mediana": {
      "percentiles": {
        "field": "open",
        "percents": [50]
      }
    }
  }
}

6. Contar a quantidade de documentos agrupados por ano

- GET bolsa/_search
{
  "size": 0,
  "aggs": {
    "docs_por_ano": {
      "date_histogram": {
        "field": "@timestamp",
        "calendar_interval": "year"
      }
    }
  }
}

7. Contar a quantidade de documentos de 2 anos atrás até hoje

- GET bolsa/_search
{
  "size": 0,
  "aggs": {
    "qtd_2anos": {
      "date_range": {
        "field": "@timestamp",
        "ranges": [
          {"from": "now-2y", "to": "now"}
        ]
      }
    }
  }
}



#### Beats

Beats enviam dados de centenas ou milhares de máquinas e sistemas para o Logstach ou Elasticsearch.

- Filebeat: Arquivos de log;
- Metricbeat: Métricas;
- Packetbeat: Dados de rede;
- Winlogbeat: Logs de evento do Windows;
- Auditbeat: Dados de auditoria;
- Heartbeat: Monitoramento de disponibilidade;
- Funcionbeat: Agente de envio sem servidor


##### Instalação e Configuração

- curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.2-linux-x86_64.tar.gz

- tar xzvf filebeat-7.9.2-linux-x86_64.tar.gz

- ./filebeat modules list
- ./filebeat modules enable <modulo>
- ./filebeat test config
- ./filebeat test output

- Configurar o arquivo: filebeat.yml

- filebeat.prospectors:
  - type: log
    enabled: true
    paths: - /var/log/*.log

  output.elasticsearch:
    hosts: ["<es_url>"]
    username: "<user>"
    password: "<password>"

  # output.logstash:


##### Filebeat Inicialização

Inicializar de modo simples:

- sudo chown root filebeat.yml
- sudo chown root modules.d/system.yml 
  Apenas para os módulos habilitados
- sudo ./filebeat -e
  Exibir a configuração e saída do beat


Inicializar como serviço

- sudo service filebeat start
- sudo service filebeat status
- sudo service filebeat stop
- sudo service filebeat restart


#### Exercício Filebeat

Beats

- sudo sysctl -w vm.max_map_count=262144
- docker-compose up -d

1. Enviar o arquivo <local>/paris-925.logs com uso do Filebeat

- curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.9.2-linux-x86_64.tar.gz
- tar xzvf filebeat-7.9.2-linux-x86_64.tar.gz
- cd filebeat-7.9.2-linux-x86_64/
- ./filebeat modules list -strict.perms=false
- cd ../data/datasets
- pwd #and copy path
- vi ../filebeat-7.9.2-linux-x86_64/filebeat.yml
- enable: true
- path: past pwd paris-925.logs
- ./filebeat test config -strict.perms=false
- ./filebeat test output -strict.perms=false
- sudo chown root filebeat.yml
- sudo ./filebeat -e -strict.perms=false
- http://localhost:5601/app/dev_tools#/console


- curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.9.2-linux-x86_64.tar.gz
- tar xzvf metricbeat-7.9.2-linux-x86_64.tar.gz
- cd metricbeat-7.9.2-linux-x86_64/
- ./metricbeat modules list -strict.perms=false
- ./metricbeat test config -strict.perms=false
- ./metricbeat test output -strict.perms=false
- cd modules.d/
- sudo find / -name docker.sock
- copy /mnt/wsl/docker-desktop/shared-sockets/guest-services/docker.sock
- vi docker.yml
- paste path docker
- uncomment metrics and save
- sudo chown root modules.d/docker.yml
- sudo chown root metricbeat.yml
- sudo ./metricbeat -e -strict.perms=false


- curl -L -O https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-7.9.2-linux-x86_64.tar.gz
- tar xzvf heartbeat-7.9.2-linux-x86_64.tar.gz
- cd heartbeat-7.9.2-linux-x86_64/
- vi heartbeat.yml
- ./heartbeat test config -strict.perms=false
- ./heartbeat test output -strict.perms=false
- sudo chown root heartbeat.yml
- sudo ./heartbeat -e -strict.perms=false


2. Verificar a quantidade de documentos do índice criado pelo Filebeat e visualizar seus 10 primeiros documentos

- GET filebeat-7.9.2-2021.06.19-000001/_count
- GET filebeat-7.9.2-2021.06.19-000001/_search

3. Monitorar as métricas do docker

Referência:
https://www.elastic.co/guide/en/beats/metricbeat/current/metricbeat-module-docker.html (Links para um site externo.)

Encontrar o socket do Docker
$ sudo find / -name docker.sock

4. Verificar a quantidade de documentos do índice criado pelo Metricbeat e visualizar seus 10 primeiros documentos

- GET metricbeat-7.9.2-2021.06.19-000001/_count

5. Monitorar o site https://www.elastic.co/pt/ (Links para um site externo.) com uso do Heartbeat

6. Verificar a quantidade de documentos do índice criado pelo Heartbeat e visualizar seus 10 primeiros documentos

- GET heartbeat-7.9.2-2021.06.19-000001/_count
- GET heartbeat-7.9.2-2021.06.19-000001/_search


#### Logstash

- Input
- Filter
- Output


Beats > Logstash (Input > Filter > Output) > Elasticsearch

Editar pipeline/logstash.conf


##### Plugins de entrada

Permite que uma fonte específica de eventos seja lida pelo Logstash


Entrada - Exemplo

- pipeline/logstash.conf

input {
  file {
    id=> "test_log_sem_gz"
    path => "/var/log/*.log"
    exclude => "*.gz"
  }
}