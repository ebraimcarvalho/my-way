USE DW_MARIO_KART;

INSERT INTO DIM_CONSTRUTOR(ID_CONSTRUTOR, PAIS, FABRICANTE_MOTOR, NOME_CONSTRUTOR)
SELECT construtor.ID_CONSTRUTOR, pais.NOME_PAIS, fabricante.NOME_FABRICANTE, construtor.NOME_CONSTRUTOR
FROM db_mario_kart.tb_construtor construtor
	JOIN db_mario_kart.tb_pais pais ON construtor.ID_PAIS = pais.ID_PAIS
	JOIN db_mario_kart.tb_fabricante_motor fabricante ON construtor.ID_FABRICANTE = fabricante.ID_FABRICANTE;