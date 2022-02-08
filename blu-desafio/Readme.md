### Primeiros passos

1. Se certifique que o Docker está instalado em sua máquina. 
`docker --version`
`docker-compose --version`

2. Clone esse repositório e vá para o diretório criado.

3. Construa a imagem da aplicação
`docker build -t blu_challenge .`

4. Rode a imagem da aplicação
`docker run -p 5000:5000 blu_challenge`

Ao executar o container, abra o seu navegador na rota: http://127.0.0.1:5000/personagens para listar os personagens
e na rota: http://127.0.0.1:5000/send_data para consumir a api do Starwars e popular o banco de dados e salvar a tabela personagens em formato parquet.

O banco é inicializado com um registro e a ingestão dos dados da api ocorre ao acessar o endpoint /send_data, onde a aplicação insere todos os 82 registros de personagens disponíveis na api.


```
py -m venv venv

.\venv\Scripts\activate
```