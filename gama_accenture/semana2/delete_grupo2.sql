-- Realizar atualização dos nomes dos clientes colocando ao final do nome o status de "Ativo" ou Inativo, usando como filtro o campo IC_SITUACAO

-- Atualizar a data de saldo para amanha (sysdate + 1) todas as agencias cujo codigo seja menor que 30

-- Excluir clientes que possuem situação diferente de "Ativo", IC_SITUACAO <> "A"

UPDATE TB03_CLIENTE SET NO_CLIENTE = SUBSTR(NO_CLIENTE, 1, 92) || ' (Ativo)' WHERE IC_SITUACAO = 'A' or IC_SITUACAO = '1' or IC_SITUACAO = 'S';

UPDATE TB03_CLIENTE SET NO_CLIENTE = CONCAT(SUBSTR(NO_CLIENTE, 1, 85), ' (Inativo)') WHERE IC_SITUACAO = 'I' or IC_SITUACAO = ' ' or IC_SITUACAO = '0';

UPDATE TB04_SALDO SET DH_SALDO = (sysdate + 1) WHERE NU_AGENCIA < 30;

SELECT * FROM TB04_SALDO;

DELETE TB03_CLIENTE WHERE IC_SITUACAO <> 'A';

UPDATE TB01_AGENCIA SET NO_AGENCIA = 'Agência Shopping Norte' WHERE NU_AGENCIA = 22;

DELETE TB04_SALDO WHERE NU_AGENCIA = 41;

DELETE TB02_CONTA WHERE NU_AGENCIA = 41;

DELETE TB01_AGENCIA WHERE NU_AGENCIA = 41;