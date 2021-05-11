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