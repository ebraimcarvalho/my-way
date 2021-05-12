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
