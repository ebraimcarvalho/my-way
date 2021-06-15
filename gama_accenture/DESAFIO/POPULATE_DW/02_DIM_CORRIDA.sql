USE DW_MARIO_KART;

INSERT INTO DIM_CORRIDA(ID_CORRIDA, NOME_CORRIDA, NOME_CIRCUITO, ANO, ORDEM_CORRIDA, PAIS)
SELECT corrida.ID_CORRIDA, corrida.NOME, circuito.NOME, corrida.ANO, corrida.ORDEM_CORRIDA, pais.NOME_PAIS
FROM db_mario_kart.tb_corrida corrida
	JOIN db_mario_kart.tb_circuito circuito ON corrida.ID_CIRCUITO = circuito.ID_CIRCUITO
	JOIN db_mario_kart.tb_pais pais ON circuito.ID_PAIS = pais.ID_PAIS;