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
- rpop chave


#### Redis Lista


Recuperar um elemento e eliminálo da lista, bloqueando se a lista estiver vazia até o tempo especificado, serve para evitar respostas null e para implementar uma fila de lpush e rpop, por exemplo.

- blop <chave> <tempo>

- brpop <chave> <tempo>

Retornará null quando não existir elementos e o tempo se esgotar

Definir um novo intervalo para a lista, removendo todos os elementos fora do intervalo

- ltrim <chave> <novoinicio> <novofim>

Visualizar o tamanho da lista

- llen <chave>


### Redis Exercícios 2 - Listas


1. Criar a chave “views:ultimo_usuario" e insira nesta ordem os seguintes valores como lista:

Final da lista “Joao”
Final da lista “Ana”
Inicio da lista “Carlos”
Final da lista “Carol”

- rpush views:ultimo_usuario Joao Ana
- lpush views:ultimo_usuario Carlos
- rpush views:ultimo_usuario Carol

2. Visualizar todos os elementos da lista

- lrange views:ultimo_usuario 0 -1

3. Visualizar todos os elementos da lista, com exceção do último

- lrange views:ultimo_usuario 0 -2

4. Visualizar o tamanho da lista

- llen views:ultimo_usuario

5. Redefinir o tamanho da lista, removendo o primeiro elemento (Sem usar o pop)

- ltrim views:ultimo_usuario 1 -1

6. Visualizar o tamanho da lista

- llen views:ultimo_usuario

7. Recuperar os elementos da lista da seguinte ordem:

Primeiro
Último
Primeiro com bloqueio de 5 segundos se a lista estiver vazia
Primeiro com bloqueio de 5 segundos se a lista estiver vazia

- lpop views:ultimo_usuario
- rpop views:ultimo_usuario
- blpop views:ultimo_usuario 5
- blpop views:ultimo_usuario 5


### REDIS Sets

Sets são coleções não ordenadas de strings, serve para expressar relações entre objetos

Adicionar elementos
- sadd <chave> <valor1> <valor2> ...

Retornar todos os elementos
- smembers <chave>

Recuperar um elemento aleatório e removê-lo do set
- spop <chave>

Verificar se um elemento existe
- sismember <chave> <valor>

Visualizar o número de elementos
- scard <chave>

Remover um elemento
- srem <chave> <valor>


#### Múltiplos Sets

Interseção de vários sets
- sinter <chave1> <chave2>

Diferença de vários sets
- sdiff <chave1> <chave2>

União de vários Sets
- sunion <chave1> <chave2>


Para armazenar os múltiplos sets em outra chave

- sinterstore <chaveArmazenamento> <chave1> <chave2>
- sdiffstore <chaveArmazenamento> <chave1> <chave2>
- sunionstore <chaveArmazenamento> <chave1> <chave2>


#### Exercícios - Sets

1. Deletar a chave “pesquisa:produto”

- del pesquisa:produto

2. Criar a chave "pesquisa:produto" do tipo set com os seguintes valores: monitor, mouse e teclado

- sadd pesquisa:produto monitor mouse teclado

3. Visualizar a quantidade de valores da chave

- scard pesquisa:produto

4. Retornar todos os elementos da chave

- smembers pesquisa:produto

5. Verificar se existe o valor monitor

- sismember pesquisa:produto monitor

6. Remover o valor monitor

- srem pesquisa:produto monitor

7. Recuperar um elemento e remove-lo do set

- spop pesquisa:produto

8. Criar a chave "pesquisa:desconto“ do tipo set com os seguintes valores: memória RAM, monitor, teclado, HD

- sadd pesquisa:desconto "Memória RAM" monitor teclado HD

9. Próximas questões fazem uso dos sets pesquisa:produto e pesquisa:desconto

Visualizar a interseção entre os 2 sets
Visualizar a diferença entre os 2 sets
Criar o set "pesquisa:produto_desconto" com a união entre os 2 sets

- sinter pesquisa:produto pesquisa:desconto
- sdiff pesquisa:produto pesquisa:desconto
- sunionstore pesquisa:produto_desconto pesquisa:produto pesquisa:desconto


#### Sets Ordenados

Sorted sets são compostos de elementos de string únicos e não repetitivos, combinação de Set e Hash. Cada elemento é associado a um score, semelhante ao Hash

Adicionar elementos
- zadd <chave> <score1> <valor1> <score2> <valor2>

Visualizar elementos em um intervalo na lista

Crescente
- zrange <chave> <inicio> <fim> [withscores]

Descrescente
- zrevrange <chave> <inicio> <fim> [withscores]


#### Outras funções

Recuperar um elemento e remove-lo do set

Maior score
- zpopmax <chave>

Menor score
- zpopmin <chave>

Bloquear se o set estiver vazio até um determinado tempo t

Maior score
- bzpopmax <chave> <t>

Menor score
- bzpopmin <chave> <t>

Visualizar a posição de um elemento
- zrank <chave> <valor>
- zrevrank <chave> <valor>

Visualizar o score de um elemento
- zscore <chave> <valor>

Visualizar o número de elementos
- zcard <chave>

Remover um elemento específico
- zrem <chave> <valor>


#### Exercício REDIS - Sets Ordenados

1. Deletar a chave "pesquisa:produto"

- del pesquisa:produto

2. Criar a chave "pesquisa:produto" do tipo set ordenado com os seguintes valores:

Valor: monitor, Score: 100
Valor: HD, Score: 20
Valor: mouse, Score: 10
Valor: teclado, Score: 50
O score representa a quantidade de pesquisas feitas para aquele produto na aplicação

- zadd pesquisa:produto 100 monitor 20 HD 10 mouse 50 teclado

1. Visualizar a quantidade de produtos

- zcard pesquisa:produto

2. Visualizar todos os produtos do mais pesquisado ao menos pesquisado

- zrevrange pesquisa:produto 0 -1

3. Visualizar o rank do produto teclado

- zrank pesquisa:produto teclado

4. Visualizar o score do produto teclado

- zscore pesquisa:produto teclado

5. Remover o valor HD da chave

- zrem pesquisa:produto HD

6. Recuperar e remover do set o produto mais pesquisado

- zpopmax pesquisa:produto

7. Recuperar e remover do set o produto menos pesquisado

- zpopmin pesquisa:produto

8. Visualizar todos os produtos

- zrange pesquisa:produto 0 -1 withscores