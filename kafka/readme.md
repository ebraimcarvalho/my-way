## Kafka




Instalação Cluster Kafka

1. Criar a pasta kafka e inserir o arquivo docker-compose.yml da Guia Arquivos do treinamento

- mkdir kafka
- nano docker-compose.yml

2. Instalação do docker e docker-compose

Docker: https://docs.docker.com/get-docker/ (Links para um site externo.)
Docker-compose: https://docs.docker.com/compose/install/ (Links para um site externo.)

3. Inicializar o cluster Kafka através do docker-compose

- docker-compose up -d

4. Listas as imagens em execução

- docker ps

5. Visualizar o log dos serviços broker e zookeeper

- docker logs zookeeper
- docker logs broker

6. Visualizar a interface do Confluent Control Center

Acesso: http://localhost:9021/insta