### Redis

Remote Dictionary Server


Criado por Salvatore Sanfilippo que foi contratado pela Vmware, teve a primeira versão liberada em 2009. Em seguida recebeu patrocinio da Pivotal Software e a partir de 2015 mudou para Redis Labs 
Banco de dados NoSQL chave-valor mas popular do mundo. O valor suporta diversas estrutura de dados.
Seu armazenamento é em memória, o que lhe permite um acesso rápido aos dados tanto para leitura quanto para escrita. Porém é possível persistir os dados fisicamente, lembrando que não se trata de um banco de dados para armenar todos os dados, seu uso é comum para cache, por exemplo.


Utiliza um modelo cliente-servidor para troca de informações, onde um cliente envia um comando para um servidor, que retorna uma resposta em seguida.
Enquanto a resposta não é enviada, aquela porta de entrada é fechada, o que caracteriza uma aplicação single-threaded, um comando por vez e atômicos.
Seu uso é feito através de uma aplicação, escrita em diversas linguagens ou pelo Redis CLI


#### Instalação via docker

- criar estrutura de pastas redis/docker-compose.yml


// docker-compose.yml
version: '3.1'

services:

  redis:
    container_name: redis
    image: redis
    ports:
      - 6379:6379
    volumes:
      - data:/data
    entrypoint: redis-server --appendonly yes
    restart: always      

volumes:
  data:


- docker pull redis
- docker-compose up -d
- docker exec -it redis bash
- redis-server --version
- redis-cli --version


#### Redis String

Único tipo de dados Memchached: cache para páginas web

Chaves também são string

Sintaxe:

Definir um valor de string
- SET <chave> <valor>

Recuperar um valor de string
- GET <chave>

###### Opções para chave String

Falhar se a chave existir
- SET chave novoValor nx
// (nil) a chave já foi definida anteriormente

Substituir o valor da chave - Default
- SET chave novoValor xx
// OK

Verificar o tamanho do valor
- STRLEN chave
// (intenger) 9

String como um inteiro

- INCR chave
- DECR chave
- INCRBY chave <incremento>
- DECRBY chave <incremento>

### Observação: INCR Atômico

Se ao mesmo tempo 2 clientes lerem a chave 10 e ambos incrementarem para 11 o valor final é 12. Por ser aômico, cada comando é executado de uma vez.

### Reduzir latência

Podemos definir e recuperar várias chaves em um comando, reduzindo a latencia, exemplo:

- MSET <chave1> <valor1> <chave2> <valor2> <chave3> <valor3>

- MGET <chave1> <chave2> <chave3>


#### Opções com chaves

Verificar se a chave existe
- exists <chave>

Deletar a chave
- del <chave>

Tipo da chave
- type <chave>


#### Persistencia de chaves

Definir tempo para a chave expirar.

- expire <chave> <tempo segundos>

- pexpire <chave> <tempo milisegundos>

- set <chave> <valor> ex <tempo segundos>

- set <chave> <valor> px <tempo milisegundos>

Verificar o tempo restante de vida da chave

- ttl <chave> // reposta em segundos
- pttl <chave> // resposta em milisegundos

Remover tempo para a chave expirar

- persist <chave>


#### Exercício Redis 1


1. Criar a chave "usuario:nome" e atribua o valor do seu nome

- set usuario:nome ebraim

2. Criar a chave "usuario:sobrenome" e atribua o valor do seu sobrenome

- set usuario:sobrenome carvalho

3. Busque a chave "usuario:nome“

- get usuario:nome

4. Verificar o tamanho da chave "usuario:nome“

- strlen usuario:nome

5. Verificar o tipo da chave "usuario:sobrenome"

- type usuario:sobrenome

6. Criar a chave "views:qtd" e atribua o valor 100

- set views:qtd 100

7. Incremente o valor em 10 da chave "views:qtd"

- incrby views:qtd 10

8. Busque a chave "views:qtd"

- get views:qtd

9. Deletar a chave "usuario:sobrenome"

- del usuario:sobrenome

10. Verificar se a chave "usuario:sobrenome" existe

- exists usuario:sobrenome

11. Definir um tempo de 3600 segundos para a chave "views:qtd" ser removida

- expire views:qtd 3600

12. Verificar quanto tempo falta para a chave "views:qtd" ser removida

- ttl views:qtd

13. Verificar a persistência da chave "usuario:nome"

- ttl usuario:nome

14. Definir para a chave "views:qtd" ter persistência para sempre

- persist views:qtd

15. Clicar no botão de Enviar Tarefa, e enviar o texto: ok


### Redis Lista


Lista é uma sequencia de elementos ordenados, linked list, tem tempo constante de inserção

Adicionar um elemento no inicio

- lpush <chave> <valor>

Adicionar um elemento no final

- rpush <chave> <valor>

Extrair elementos em um intervalor na lista

- lrange <chave> <inicio> <fim>

Recuperar um elemento e eliminá-lo.

Do início da lista
- lpop chave

Do final da lista
-rpop chave