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