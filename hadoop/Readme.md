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