### Redis

Remote Dictionary Server


Criado por Salvatore Sanfilippo que foi contratado pela Vmware, teve a primeira versão liberada em 2009. Em seguida recebeu patrocinio da Pivotal Software e a partir de 2015 mudou para Redis Labs 
Banco de dados NoSQL chave-valor mas popular do mundo. O valor suporta diversas estrutura de dados.
Seu armazenamento é em memória, o que lhe permite um acesso rápido aos dados tanto para leitura quanto para escrita. Porém é possível persistir os dados fisicamente, lembrando que não se trata de um banco de dados para armenar todos os dados, seu uso é comum para cache, por exemplo.


Utiliza um modelo cliente-servidor para troca de informações, onde um cliente envia um comando para um servidor, que retorna uma resposta em seguida.
Enquanto a resposta não é enviada, aquela porta de entrada é fechada, o que caracteriza uma aplicação single-threaded, um comando por vez e atômicos.
Seu uso é feito através de uma aplicação, escrita em diversas linguagens ou pelo Redis CLI