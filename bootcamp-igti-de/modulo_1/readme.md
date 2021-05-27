### trabalho Prático Módulo 1

Bootcamp IGTI: Engenheiro de Dados

Trabalho Prático

Módulo 1 Fundamentos em Engenharia de Dados

Objetivos

Exercitar os seguintes conceitos trabalhados no Módulo:
✔ Criar um modelo relacional dado um requisito de dados;
✔ Criar o banco de dados no MySQL Server, a partir de um modelo relacional;
✔ Praticar os comandos da linguagem SQL para definição (DDL), manipulação (DML) e consulta (DQL) de dados.

#### Enunciado


Considere uma biblioteca que deseja melhorar seus serviços, como manter o cadastro 
de usuários e o controle de seu acervo.

Quanto ao acervo, a biblioteca precisa manter informações sobre suas obras físicas 
(impresso). A biblioteca mantém apenas livros. Todas as obras devem possuir um código 
único de identificação, além do título, ano de publicação, autor(es), editora, nº de edição, 
área de conhecimento do livro, ISBN (que é único para cada obra), mas nem toda obra 
tem um ISBN.

No caso das editoras, elas são descritas por um código de identificação, o seu nome, 
além da cidade (opcional) e do país (obrigatório) de localização. Uma obra é editada por 
uma única editora, que por sua vez pode possuir diversas obras editadas. Para os 
autores das obras, deseja-se manter uma identificação, o seu nome completo e, opcionalmente, o país de sua nacionalidade. Cabe salientar que um autor pode ter várias 
obras de sua autoria, assim como uma obra pode ser escrita por vários autores.

As obras podem ser das seguintes áreas de conhecimento: matemática, física, história, 
filosofia, economia, administração e negócios, engenharia, sociologia, literatura (nacional 
ou estrangeira), artes, entretenimento, medicina, tecnologia da informação etc. É 
atribuída apenas uma área de conhecimento para cada obra.

A biblioteca pode possuir vários exemplares de cada obra, sendo no mínimo um. É 
importante saber a situação em que se encontra cada exemplar, ou seja, disponível, 
emprestado, extraviado, em manutenção etc. Além disso, é preciso saber que cada 
exemplar é identificado pelo ISBN do livro, pelo número sequencial dado ao exemplar e 
pela data da sua aquisição pela biblioteca.

A biblioteca permite o empréstimo de livros somente aos usuários cadastrados. O 
cadastro de usuários mantém informações, como nome, data de nascimento, CPF, RG, 
gênero, e-mail, endereço (Logradouro, número/complemento, bairro, CEP, Cidade e 
País), escolaridade, estado civil e telefones de contato (fixo e celular). Os dados mínimos 
para que um usuário seja cadastrado são: nome, CPF, e-mail, endereço e, no mínimo, 
um telefone. O usuário ainda pode ser suspenso por atraso na devolução da obra, assim 
é necessário saber o status do usuário, ativo ou suspenso

Para cada empréstimo, é necessário identificar o usuário e o exato exemplar emprestado 
ao mesmo. Também, é preciso armazenar a data e o horário do empréstimo, a data 
máxima prevista para devolução e a data em que o exemplar foi efetivamente devolvido. 
Deve-se manter o histórico de empréstimos dos usuários. Cada obra/exemplar poderá 
ser emprestada mais de uma vez ao mesmo usuário.

Considerando essa descrição de requisitos, considere seu papel como profissional de 
engenharia de dados, realize as seguintes atividades e, em seguida, responda às 
questões.


#### Atividades


Os alunos deverão desempenhar as seguintes atividades:1. Elabore um modelo conceitual que melhor represente esses requisitos. Sugerese a utilização do software brModelo para esta atividade;

2. Elabore um modelo físico que melhor represente esses requisitos. Sugere-se a 
utilização do software MySQL Workbench para esta atividade;

3. Crie seu banco de dados no SGBD MySQL Server (on-premise ou em nuvem, a 
seu critério de escolha). Sugere-se a utilização do software MySQL Workbench para esta 
atividade;

4. Altere seu banco de dados para atender às seguintes demandas:

a) A biblioteca deseja saber incluir uma nova característica para descrever os livros: 
o idioma no qual ele foi escrito. O idioma é informado pelo seu nome descritivo, por 
exemplo, “Inglês”, “Português”, “Espanhol” etc;

b) A biblioteca deseja saber qual o nome do representante da editora, assim como o 
seu telefone de contato;

c) Após analisar os requisitos, ficou decidido que não será mais necessário saber 
qual é o país de nacionalidade do autor, sendo assim, deve-se excluir esse atributo da 
estrutura de cadastro de autores.

5. Faça a carga de dados conforme descrito nos requisitos e os datasets disponíveis 
junto deste enunciado. (Ver arquivo datasetsTP.zip).

6. Utilizando a linguagem SQL, execute consultas que possam responder às 
seguintes questões:

a) Quantos livros cada autor escreveu?

b) Qual o nome/título dos livros que possuem mais de um autor?

c) Quantos usuários cadastrados possuem nome iniciando com a letra P?

d) Qual o número de exemplares de cada obra existente na biblioteca? Quantos 
estão disponíveis, emprestados, extraviados e em manutenção?

e) Atualmente, quantos usuários estão suspensos na biblioteca?f) Considerando os números de empréstimos realizados por cada usuário, qual(is) 
o(s) nome(s) do(s) usuário(s) que mais fez(fizeram) empréstimos na biblioteca?

g) Existe algum idioma no qual os usuários nunca fizeram empréstimos? Qual?

h) Qual o nome do livro e o(s) nome(s) de seu(s) respectivo(s) autor(es) para o livro 
mais emprestado da biblioteca