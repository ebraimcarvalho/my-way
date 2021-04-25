Hadoop é um software open source para computação distribuída confiável e escalável!

- Modelo de programação simples
- Processamento distribuído
- Grandes conjuntos de dados
- Clusters de computadores: (Hardware commodity) Você não precisa do melhor hardware, arquitetura é pensada que o hardware pode falhar, isso ajuda em relação a custo, podendo montar uma arquitetura distribuída com um custo menor.

Esse projeto hadoop propõe soluções para sistemas distribuídos em um único framework

Em fevereiro de 2003, o google queria melhorar o mecanismo de busca, eles criaram então a tecnologia mapReduce, divide o processamento em vários pedaços e distribui em diversos computadores.

Em outubro de 2003, Google cria um sistema de arquivos distribuídos para armazenar e processar grande colume de dados da Google por meio de MapReduce, isso foi chamado de HDFS.

Então o Hadoop funciona em duas partes

1. Map/Reduce: Aplicação é dividade em vários pequenos fragmentos de jobs e cada um pode ser executado ou reexecutado em qualquer nó do cluster

2. HDFS: Sistema de arquivo distribuído que armazena dados nos nós, fornecendo uma largura de banda agregada muito alta em todo cluster Map Reduce e é projetado para que as falhas de nó sejam tratadas automaticamente pelo framework

### HDFS

Hadoop distributed File System - Sistema de Arquivos Distribuídos do Hadoop

Vantagens: 

- Baixo custo: Hardwares com custo menor
- Toleranta a falhas: sistema já é pensado para cobrir falhas
- Escalável: Aumenta poder de armazenamento, aumentando os nós

O sistema divide os arquivos em conjuntos de blocos individuais, 128mb é o padrão, e armazena esses blocos em vários nós nos cluster Hadoop.

O HDFS assume que todo nó não é confiável 100%, então ele faz 3 cópias dos blocos que são armazenados.

Arquitetura Mestre Namenode / DataNode

- Namenode: Armazenar metadados dos arquivos, Componente central do HDFS, responsável por saber o que são e onde estão seus dados;
- Datanode: Armazenar os dados

### Estrutura do HDFS

O client envia o job para o nó mestre (NameNode), aqui ficará as informações de metadados e enviará 3 cópias, uma para cada DataNode.

### MapReduce - Introdução

Framework que organiza as tarefas de processamento complexas através de clusters de computadores, divide o trabalho em conjunto de tarefas independentes

4 processos: 
- Split
- Map
- Shuffle
- Reduce

#### Funcionamento do MapReduce

Ele recebe os dados do HDFS, usa o split para pegar o que precisa, mapeia o conteúdo dando saída em formato chave-valor, com os dados em chave-valor, faz o shuffle para mergear chaves iguais, gerando uma lista com os valores para aquela chave e então faz o reduce dessa lista para cada chave e gera o output com o resultado final também em formato chave-valor.

![alt text](mapreduce.jpg 'Funcionamento do MapReduce')


#### Estrutura do MapReduce

- Daemon para executar um job, divido em dois tipos:

1. 1 JobTracker: Coordena todas as tarefas executadas, agendando tarefas para serem executadas em tasktrackers, monitora as tasktrackers, reagenda se necessário e armazena o histórico de tarefasc oncluídas.

2. N TaskTracker: Executam as tarefas e enviam relatórios de progresso para o jobtracker

Então em cada Nó Mestre (NameNode), além do nameNode existe o Jobtracker, como se fosse um cpu e uma memória de um computador.

Ao nível de Datanode, estará também o tasktracker.

O HDFS responde pelo armazenamento e o MapReduce responde pelo processamento.

### YARN

Yet another resource negotiator

Outro negociador de recursos: Oferece paralelismo de tarefas e divide as funcionalidades de gerenciamento de recursos e agendamento/monitoramento de tarefas em daemons separadas

Versão do mapReduce 2 = MapReduce 1 + YARN

#### Modos do Sistema

1. Modo local: Standalone
2. Modo pseudo distribuído: Single Node Cluster
3. Modo distribuído: Multi Node Cluster (mais comum em meio de produção)

#### Estrutura do Yarn

- Daemons para executar um job
- 1 Resource Manager (RM): Coordenar todas as tarefas executadas no sistema, agenda tarefas para serem executadas nos Nodes Managers
- 1 Application Master (AM): Monitora os Node Manager para reagendar em caso de falha ou lentidão
- 1 Timeline Server: Armazenar o histórico de aplciativos
- N Node Manager: Executam as tarefas nos conteiners e enviam relatorios de progresso para o RM

#### Arquitetura do Yarn

1. Envia o job para o Resource Manager
2. Solicita o container para o Node Manager
3. Dentro desse container inicial abre um Application Master
4. Application Master solicita para o Resource manager mais containers para o Job
5. Todo processamento do MapReduce será executado nos containers criados após o Application Master solicitar


### Outros nós

#### Secondary node

- Namenode: Contem dois arquivos, FsImage (armazena informações estruturais dos blocos) e EditLog (armazena todas as alterações ocorridas no metadados dos arquivos)

- Cria checkpoints no Namenode: FsImage.ckpt = FsImage + EditLog

- Em caso de fallover do namenode: precisa recuperar manualmente os dados do namenode secundario

#### Standby Namenode

- Se comunica diretamente com o Namenode através do Journalnode
- Também é um Namenode, só que em espera
- em caso de fallover do Namenode, o standby entra automaticamente no seu lugar. O Datanode se comunica com o namenode e standby namenode.

#### Edge Node

- Conhecido como Gateway node tambem
- interface entre o cluster do Hadoop e sua rede externa
- Diminuir o uso de recurso do Namenode
- Executa aplicativos de clientes externos
- Transferidos os dados para o cluster hadoop
- Ferramenta de gerenciamento

#### Arquitetura do cliente Hadoop

O Job é enviado primeiramente pro Edge node (Sqoop, Hive, Hue...);

É enviado o job para o master node, que está comunicando com seu standby namenode através dos journalnode, se esse no mestre falhar, o standby é ativo.

O secondary node é usado em alguns ambientes, onde é criado checkpoints do master node. Esse secondary node será usado em caso de falha do master node, porém esse é um processo de configuração manual. Não é recomendado, melhor usar standby namenode e master node

### Docker

Comandos Docker:

- docker ps