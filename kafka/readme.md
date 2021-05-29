## Kafka

É uma plataforma de Streaming distribuída Open Source, que publica e assina streams de registros e tem fluxos de registros com processamento em tempo real e armazenamento tolerante a falhas.

1. Producer API: Permite que um aplicativo publique um fluxo de registros em um ou mais tópicos do Kafka

2. Consumer API: Permite que um aplicativo assine um ou mais tópicos e processe o fluxo de registros produzidos para eles

3. Streams API: Permite que um aplicativo transforme os fluxos de entrada em fluxos de saída

4. Connector API: Permite criar e executar produtores ou consumidores reutilizáveis que conectam tópicos do Kafka e aplicativos ou


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