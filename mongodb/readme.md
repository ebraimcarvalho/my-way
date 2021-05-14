## Mongo DB - Semantix Academy

#### Exercícios - Instalação

- Instalação do docker e docker-compose

- Acesso: https://docs.docker.com/get-docker/ (Links para um site externo.)

- Baixar as imagens do mongo e mongo-express

  1. docker pull mongo
  2. docker pull mongo-express

- Iniciar o MongoDB através do docker-compose

  1. docker-compose up -d

- Listas as imagens em execução

  1. docker ps

- Listar os bancos de dados do MongoDB

  1. docker exec -it mongo bash
  2. mongo
  3. or: mongo --host mongo -u mongoadmin -p root -authenticationDatabase admin

- Visualizar através do Mongo e Mongo Express os bancos de dados

  1. show dbs
  2. Ou acessando: http://localhost:8081/


#### Exercícios - Comandos Básicos

- Excluir Collection: db.<nomeCollection>.drop()
- Excluir Banco de dados: db.dropDatabase()
- Renomear Collection: db.<nomeCollection>.renameCollection('<novoNomeCollection>')


Comando Básicos para BD, Collections e Documentos

1. Criar o banco de dados com seu nome.

 - use ebraim

2. Listar os banco de dados.

  - show dbs

3. Criar a collection produto no bd com seu nome.

  - db.createCollection("produto")

4. Listar os banco de dados.

  - show dbs

5. Listar as collections.

  - show collections

6. Inserir os seguintes documentos na collection produto:

_id: 1, "nome": “cpu i5", "qtd": "15“
_id: 2, nome: “memória ram", qtd: 10, descricao: {armazenamento: “8GB”, tipo:“DDR4“}
_id: 3, nome: "mouse", qtd: 50, descricao: {conexao: “USB”, so: [“Windows”, “Mac”, “Linux“]}
_id: 4, nome: “hd externo", "qtd": 20, descricao: {conexao: “USB”, armazenamento: “500GB”, so: [“Windows 10”, “Windows 8”, “Windows 7”]}

  - db.produto.insertMany([
    {_id: 1, "nome": “cpu i5", "qtd": "15“},
    {_id: 2, nome: “memória ram", qtd: 10, descricao: {armazenamento: “8GB”, tipo:“DDR4“}},
    {_id: 3, nome: "mouse", qtd: 50, descricao: {conexao: “USB”, so: [“Windows”, “Mac”, “Linux“]}},
    {_id: 4, nome: “hd externo", "qtd": 20, descricao: {conexao: “USB”, armazenamento: “500GB”, so: [“Windows 10”, “Windows 8”, “Windows 7”]}}
  ])

7. Mostrar todos os documentos.

  - db.produto.find().pretty()
  - db.produto.find()


#### Exercício 3

Consulta básica em documentos

1. Mostrar todos os documentos da collection produto

- db.produto.find().pretty()

2. Pesquisar na collection produto, os documentos com os seguintes atributos:

a) Nome = mouse

- db.produto.find( {"nome": "mouse"} )

b) Quantidade = 20 e apresentar apenas o campo nome

- db.produto.find( {"qtd": 20}, {"nome": 1} )

c) Quantidade <= 20 e apresentar apenas os campos nome e qtd

- db.produto.find( {"qtd": { $lte: 20 }}, {"nome": 1, "qtd": 1} )

d) Quantidade entre 10 e 20

- db.produto.find( {"qtd": {$gte: 10, $lte: 20}} )
- db.produto.find( {"qtd": {$gte: 10}, "qtd": {$lte: 20}} )

e) Conexão = USB e não apresentar o campo _id e qtd

- db.produto.find({"descricao.conexao": "USB"}, {"_id": 0, "qtd": 0})

f) SO que contenha “Windows” ou “Windows 10”

- db.produto.find({"descricao.so": {$in: ["Windows", "Windows 10"]}})


### Exercício 4

Outras Opções com Consultas

1. Mostrar todos os documentos da collection produto

- db.produto.find().pretty()

2. Realizar as seguintes pesquisas na collection produto:

a) Mostrar os documentos ordenados pelo nome em ordem alfabética.

- db.produto.find().sort({"nome": 1})

b) Mostrar os 3 primeiros documentos ordenados por nome e quantidade.

- db.produto.find().sort({"nome": 1, "qtd": 1}).limit(3)

c) Mostrar apenas 1 documento que tenha o atributo Conexão = USB.

- db.produto.findOne({"descricao.conexao": "USB"})

d) Mostrar os documentos de tenham o atributo conexão = USB e quantidade menor que 25.

- db.produto.find({"descricao.conexao": "USB", "qtd": {$lt: 25}})

e) Mostrar os documentos de tenham o atributo conexão = USB ou quantidade menor que 25.

- db.produto.find({ $or: [
  {"descricao.conexao": "USB"}, {"qtd": {$lt: 25}}
]})

f) Mostrar apenas os id dos documentos de tenham o atributo conexão = USB ou quantidade menor que 25.

- db.produto.find({ $or: [
  {"descricao.conexao": "USB"}, {"qtd": {$lt: 25}}
]}, {"_id": 1})


## Métodos de atualizar documentos


#### Atualizar documentos

db.<nomeCollection>.updateOne(<filtro>, <atualizacao>)
db.<nomeCollection>.updateMany(<filtro>, <atualizacao>)

- Atualizar um atributo, caso não existe, é criado:
db.cliente.updateOne(
  {_id: 1},
  {$set: {idade: 25}}
)

- Remover o atributo
db.cliente.updateOne(
  {_id: 1},
  {$unset: {idade: ""}}
)

- Atualizar N Documentos
db.cliente.updateOne(
  {idade: {$gte: 27}},
  {$set: {seguro_carro: "baixo"}}
)

- Atualizar nome do atributo
db.cliente.updateMany(
  {},
  {$rename: {"nome": "nome_completo"}}
)

#### Documentos com Data

- Date(): Retorna a data atual como string
- new Date(): Retorna a data atual como objeto de data UTC em formanto ISODate
- new Date("<YYYY-mm-ddTHH:MM:ssZ>"): Retorna a data informada em formato ISODate
- new Timestamp(): retorna o timestamp atual

db.cliente.updateMany(
  {idade: {$gte: 27}},
  {
    $set: {seguro_carro: "baixo"},
    $currentDate: { atualizado: {$type: "timestamp"}}
  }
)

$type: "" or "true" or "date" para date


#### Atualizar array de documentos

db.cliente.updateOne(
  {_id: 2, "conhecimento": "Mongo"},
  {$set: {"conhecimento.$": "MongoDB"}}
)

- Operador pull: Remove elemento do array
- Operador push: Adiciona elemento no array

db.cliente.updateOne(
  {_id: 2},
  {$push: {conhecimento: "Redis"}}
)

db.cliente.updateOne(
  {_id: 2},
  {$pull: {conhecimento: "Redis"}}
)

### Exercício 5

Atualização de Documentos

1. Mostrar todos os documentos da collection produto do banco de dados seu nome

- docker-compose start
- docker exec -it mongo bash
- mongo
- use ebraim
- show collections
- db.produto.find()

2. Atualizar o valor do campo nome para “cpu i7” do id 1

- db.produto.updateOne(
  {_id: 1},
  {$set: {nome: "cpu i7"}}
)

3. Atualizar o atributo quantidade para o tipo inteiro do id: 1

- db.produto.updateOne(
  {_id: 1},
  {$set: {qtd: 15}}
)

4. Atualizar o valor do campo qtd para 30 de todos os documentos, com o campo qtd >= 30

- db.produto.updateMany(
  {qtd: {$gte: 30}},
  {$set: {qtd: 30}}
)

5. Atualizar o nome do campo “descricao.so” para “descricao.sistema” de todos os documentos

- db.produto.updateMany(
  {},
  {$rename: {"descricao.so": "descricao.sistema"}}
)

6. Atualizar o valor do campo descricao.conexao para “USB 2.0” de todos os documentos, com o campo descricao.conexão = “USB”

- db.produto.updateMany(
  {"descricao.conexao": "USB"},
  {$set: {"descricao.conexao": "USB 2.0"}}
)

7. Atualizar o valor do campo descricao.conexao para “USB 3.0” de todos os documentos, com o campo descricao.conexao = “USB 2.0” e adicionar o campo “data_modificacao”, com a data da atualização dos documentos

- db.produto.updateMany(
  {"descricao.conexao": "USB 2.0"},
  {
    $set: {"descricao.conexao": "USB 3.0"}, 
    $currentDate: {"data_modificacao": {$type: "date"}}
  }
)

8. Atualizar um dos elementos do array descricao.sistema de “Windows” para “Windows 10” do id 3

- db.produto.updateOne(
  {_id: 3, "descricao.sistema": "Windows"},
  {$set: {"descricao.sistema.$": "Windows 10"}}
)

9. Acrescentar o valor “Linux” no array descricao.sistema do id 4

- db.produto.updateOne(
  {_id: 4},
  {$push: {"descricao.sistema": "Linux"}}
)

10. Remover o valor “Mac” no array descricao.sistema do id 3 e adicionar o campo “ts_modificacao”, com o timestamp da atualização dos documentos

- db.produto.updateOne( 
  {_id: 3}, 
  {  
    $pull: {"descricao.sistema": "Mac"},  
    $currentDate: {"ts_modificacao": {$type: "timestamp"}} 
  } 
)


### Exercício 6

CRUD de Documentos

1. Criar a collection teste no banco de dados seu nome

- use ebraim
- db.createCollection("teste")

2. Inserir o seguinte documento:

Campo: usuario, valor: Semantix
Campo: data_acesso, valor: data atual no formato ISODate

- db.teste.insertOne(
  {
    usuario: "Semantix",
    data_acesso: new Date()
  }
)

3. Buscar todos os documentos do ano >= 2020

- db.teste.find(
  {data_acesso : {$gte: ISODate("2020-01-01T00:00:00Z")}}
)

4. Atualizar o campo “data_acesso” para timestamp com o valor da atualização do usuario Semantix

- db.teste.updateMany(
  {},
  {$currentDate: {data_acesso: {$type: "timestamp"} }}
)

5. Buscar todos os documentos

- db.teste.find()

6. Deletar o documento criado pelo id

- db.teste.deleteOne({_id: 1})

7. Deletar a collection

- db.teste.drop()


## Index MongoDB

Index são estruturas de dados especiais que armazena o valor de um atributo específico ou conjunto de atributos, ordenado pelo valor do atributo. Usa a estrutura de dados B-Tree. É uma forma eficiente de executar as consultas do MongoDB

- Index default: o MongoDB cria um index exclusivo no atributo _id, recomenda-se sempre usar esse default. A aplicação deve garantir a exclusividade dos valores no atributo _id para evitar erros

#### Criação de Index

- Método createIndex: Cria um índice se ainda não existir um índice com a mesma especificação, sintaxe:

- db.<nomeCollection>.createIndex( {<key>, <opções>} )
- Key: <atributo>:<valor>
- valor: 1 = Ordenação Ascendente | 2 = Descendente


- Exemplo criação de index: db.cliente.createIndex({nome: 1})

- Visualizar indexes: db.cliente.getIndexes()

- Nome padrão do index: <atributo>_<valor>_<atributo>_<valor>...
- Exemplo: db.cliente.createIndex({nome: 1, item: -1}) = nome_1_item_-1
- db.cliente.createIndex(
  {nome: 1, item: -1},
  {name: "query itens"}
)

- Index exclusivo: db.cliente.createIndex({user_id: 1}, {unique: true})
- Index exclusivo: db.cliente.createIndex({user_id: 1, nome: 1}, {unique: true})


#### Remover Index

- Excluir um index: db.cliente.dropIndex({nome: 1})
- Excluir todos os indexes de uma collection: db.cliente.dropIndexes()
- Alterar um index: Remove e cria novamente


#### Método Hint

Serve para forçar o otimizador de consultas do MongoDB fazer uso de um índice específico

- Sintaxe: db.cliente.find().hint({nome: 1})


#### Método Explain

Plano de execução, serve para compreender e otimizar consultas. Verificar stage queryPlanner.winningPlan

- COLLSCAN: Collection Scan
- IXSCAN: Scan com Index keys
- FETCH: Recuperar documentos
- SHARD_MERGE: Junção de shards
- SHARDING_FILTER: Filtrar documentos órfãos em shards

- db.cliente.find().explain()


### Exercício 7

Index e plano de execução

1. Mostrar todos os documentos da collection produto do banco de dados seu nome

- use ebraim
- show collections
- db.produto.find()

2. Criar o index “query_produto” para pesquisar o campo nome do produto em ordem alfabética

- db.produto.createIndex({nome: 1}, {name: "query_produto"})

3. Pesquisar todos os índices da collection produto

- db.produto.getIndexes()

4. Pesquisar todos os documentos da collection produto

- db.produto.find()

5. Visualizar o plano de execução do exercício 4

- db.produto.find().explain()

6. Pesquisar todos os documentos da collection produto, com uso da index “query_produto”

- db.produto.find().hint({nome: 1})

7. Visualizar o plano de execução do exercício 7

- db.produto.find().hint({nome: 1}).explain()

8. Remover o index “query_produto”

- db.produto.dropIndex({nome: 1})

9. Pesquisar todos os índices da collection produto

- db.produto.getIndexes()


### Método REGEX

i: ignorar case-sensitive

m: Combinar várias linhas

#### Retornar os clientes com nome Lucas de forma não case-sensitive

- db.cliente.find({nome: {$regex: "lucas", $options: "i"}})
- db.cliente.find({nome: {$regex: /lucas/, $options: "i"}})
- db.cliente.find({nome: {$regex: /lucas/i}})


#### Retornar os clientes da cidade de São Paulo, pesquisando por sao paulo

- db.cliente.find({cidade: {$regex: /s.o paulo/i}})

#### Retornar os clientes da cidade que começam com "São"

- db.cliente.find({cidade: {$regex: /^são/i}})

#### Retornar os cpf que contenham letras

- db.cliente.find({cpf: {$regex: /\w*/im}})


#### Exercício 8

Consultas com Regex

1. Mostrar todos os documentos da collection produto do banco de dados seu nome

- db.produto.find({})

2. Buscar os documentos com o atributo nome,  que contenham a palavra “cpu”

- db.produto.find({nome: {$regex: /cpu/i}})

3. Buscar os documentos  com o atributo nome, que começam por “hd” e apresentar os campos nome e qtd

- db.produto.find({nome: {$regex: /^hd/i}}, {nome: 1, qtd: 1})

4. Buscar os documentos  com o atributo descricao.armazenamento, que terminam com “GB” ou “gb” e apresentar os campos nome e descricao

- db.produto.find({"descricao.armazenamento": {$regex: /gb$/i}}, {nome: 1, descricao: 1})

5. Buscar os documentos  com o atributo nome, que contenha a palavra memória, ignorando a letra “o”

- db.produto.find({nome: {$regex: /mem.ria/i}})

6. Buscar os documentos  com o atributo qtd  que contenham valores com letras, ao invés de números.

- db.produto.find({qtd: {$regex: /[a-z]/i}})

7. Buscar os documentos com o atributo descricao.sistema, que tenha exatamente a palavra “Windows”

- db.produto.find({"descricao.sistema": {$regex: /^Windows$/}})



### Exercício Mongo Express

CRUD através do Mongo Express 

Todas as questão devem ser realizadas através do Mongo Express 

1. Criar a collection cliente no banco de dados seu nome

2. Inserir os seguintes documentos:

nome: Rodrigo, cidade: São José dos Campos, data_cadastro: 10/08/2020
nome: João, cidade: São Paulo, data_cadastro: 05/08/2020
3. Renomear a collection para clientes

4. Buscar os documentos da cidade de São Paulo

5. Buscar os documentos da cidade de São Paulo e apresentar apenas o nome e a cidade

6. Atualizar o documento com nome João para cidade: Rio de Janeiro

7. Criar um index para o campo cidade em ordem alfabética

8. Deletar o documento com o nome João

9. Deletar a collection clientes


### Exercício: Mongo Compass

CRUD através do MongoDB Compass


Todas as questão devem ser realizadas através do MongoDB Compass


1. Criar a collection cliente no banco de dados seu nome

2. Inserir os seguintes documentos:

nome: Rodrigo, cidade: São José dos Campos, data_cadastro: 10/08/2020
nome: João, cidade: São Paulo, data_cadastro: 05/08/2020
3. Renomear a collection para clientes

4. Buscar os documentos da cidade de São Paulo

5. Buscar os documentos da cidade de São Paulo e apresentar apenas o nome e a cidade

6. Atualizar o documento com nome João para cidade: Rio de Janeiro

7. Criar um index para o campo cidade em ordem alfabética

8. Deletar o documento com o nome João

9. Deletar a collection clientes


### Introdução a Agregação

Maneiras de realizar agregações:

1. Agregação de propósito único: Mais simples, porém limitadas

2. Função map-reduce: Forma tradicional de realizar agregações em Big Data, faz uso de funções Javascript, tem mais opções de manipulação de dados porém é difícil a implementação

3. Pipeline de agregação: Melhor desempenho que o map-reduce, MongoDB adiciona operadores novos a cada versão: 4.4 lançou o $accumulator e o $function


#### Agregação de propósito único

Agregam documentos em uma única coleção. Métodos:
Count

Distinct

EstimatedDocumentCount // Não usa um filtro de consulta, usa metadados para retornar a contagem de uma coleção


##### Sintaxe

- db.<nomeCollection>.count()
- db.<nomeCollection>.count({<filtro>}) ou db.<nomeCollection>.find( {<filtro>} ).count()

- db.<nomeCollection>.distinct("<atributo>")

- db.<nomeCollection>.estimatedDocumentCount()


#### Agregação pipeline


Agrupar valores de vários documentos e executar operações nos dados agrupados para retornar um único resultado

##### Sintaxe

- db.<nomeCollection>.aggregate(
  [
    {$<estagio>:<parametros>},
    {$<estagio>:<operadoresExpressao>},
    {$<estagio>:<parametro>, <operadoresExpressao>},
  ]
)

Exemplo:

- db.funcionarios.aggregate([
  {$match: {status: "Ativo"}},
  {$group: {
    _id: "$setor",
    total: {$sum: "$vendas"},
    media: {$avg: "$vendas"},
    quantidade: {$sum: 1}
  }},
  {$sort: {_id: 1}},
  {$limit: 10}
])


#### Exercício Agregação Mongo


Agregações de Match, Group, Sort e Limit

 

1. Crie o banco de dados escola

2. Crie a collection alunos no banco de dados escola

3. Importe o arquivo “dataset/alunos.csv” para a collection alunos, com os seguintes atributos:

id_discente: Number
nome: String
ano_ingresso: Number
nivel: String
id_curso: Number
Arquivos para Dataset

4. Visualizar os valores únicos do “nivel” de cada “ano_ingresso”

- db.alunos.aggregate([ {$group: {  _id: "$ano_ingresso",  niveis: {$addToSet: "$nivel"} }} ])

5. Calcular a quantidade de alunos matriculados por cada “id_curso”

- db.alunos.aggregate([ {$group: {  _id: "$id_curso",  matriculados: {$sum: 1} }}, {$sort: {matriculados: -1}} ])

6. Calcular a quantidade de alunos matriculados por “ano_ingresso” no "id_curso“: 1222

- db.alunos.aggregate([
  {$match: {id_curso: 1222}},
  {$group: {
    _id: "$ano_ingresso",
    matriculados: {$sum: 1}
  }} 
])

7. Visualizar todos os documentos do “nível”: “M”

- db.alunos.aggregate([
  {$match: {nivel: "M"}}
])

8. Visualizar o último ano que teve cada curso (id_curso) dos níveis “M”

- db.alunos.aggregate([
  {$match: {nivel: "M"}},
  {$group: {
    _id: "$id_curso",
    ultimo_ano: {$max: "$ano_ingresso"}
  }}
])

9. Visualizar o último ano que teve cada curso (id_curso) dos níveis “M”, ordenados pelos anos mais novos de cada curso

- db.alunos.aggregate([
  {$match: {nivel: "M"}},
  {$group: {
    _id: "$id_curso",
    ultimo_ano: {$last: "$ano_ingresso"}
  }},
  {$sort: {ultimo_ano: -1}}
])

10. Visualizar o último ano que teve os 5 últimos cursos (id_curso) dos níveis “M”, ordenados pelos anos mais novos

- db.alunos.aggregate([
  {$match: {nivel: "M"}},
  {$group: {
    _id: "$id_curso",
    ultimo_ano: {$last: "$ano_ingresso"}
  }},
  {$sort: {ultimo_ano: -1}},
  {$limit: 5}
])


#### LOOKUP MongoDB


##### Agregação Lookup

db.funcionario.aggregate([
  {$lookup: {
    from: "vendas"
    localField: "cod_func"
    foreignField: "cod_func"
    as: "vendasFuncionario"
  }},
  {$project: {"_id": 0, "cod_func": 1, "vendasFuncionario.cod_cliente": 1}}
])

db.alunos.aggregate([    
  {$lookup: {
    from: "cursos",
    localField: "id_curso",          foreignField: "id_curso",          
    as: "JoinIdCurso"
  }}
])

db.alunos.aggregate([ 
  {$lookup: {  
    from: "cursos",  
    localField: "id_curso",  
    foreignField: "id_curso",  
    as: "curso" 
  }}, 
  {$project: {
    "_id": 0,
    "id_discente": 1, 
    "nivel": 1, 
    "curso.id_curso": 1, 
    "curso.id_unidade": 1, 
    "curso.nome": 1
  }} 
])


##### Exercicio mongo DB Aggregation Lookup


Agregação com Lookup e project
 

1. Crie a collection cursos no banco de dados escola

- use escola
- db.createCollection("escola")

2. Importe o arquivo “dataset\cursos.csv” para a collection cursos, com os seguintes atributos:

id_curso: Number
id_unidade: Number
nome: String
nivel: String
Arquivos do Dataset

- fazer importação pelo compass

3. Realizar o left outer join da collection alunos e cursos, quando o id_curso dos 2 forem o mesmo.

- db.alunos.aggregate([    
  {$lookup: {
    from: "cursos",
    localField: "id_curso",          foreignField: "id_curso",          
    as: "JoinIdCurso"
  }}
])

4. Realizar o left outer join da collection alunos e cursos, quando o id_curso dos 2 forem o mesmo e visualizar apenas os seguintes campos

Alunos: id_discente, nivel
Cursos: id_curso, id_unidade, nome

- db.alunos.aggregate([ 
  {$lookup: {  
    from: "cursos",  
    localField: "id_curso",  
    foreignField: "id_curso",  
    as: "curso" 
  }}, 
  {$project: {
    "_id": 0,
    "id_discente": 1, 
    "nivel": 1, 
    "curso.id_curso": 1, 
    "curso.id_unidade": 1, 
    "curso.nome": 1
  }} 
])