USE DW_MARIO_KART;

INSERT INTO DIM_PILOTO(ID_PILOTO, PAIS, NOME_CONSTRUTOR, REF_PILOTO, SIGLA_PILOTO, NOME_PILOTO, SOBRENOME_PILOTO, DATA_NASCIMENTO)
SELECT piloto.ID_PILOTO, pais.NOME_PAIS, construtor.NOME_CONSTRUTOR, piloto.REF_PILOTO, piloto.SIGLA_PILOTO, piloto.NOME_PILOTO, piloto.SOBRENOME_PILOTO, piloto.DATA_NASCIMENTO
FROM db_mario_kart.tb_piloto piloto
	JOIN db_mario_kart.tb_pais pais ON piloto.ID_PAIS = pais.ID_PAIS
    JOIN db_mario_kart.tb_construtor construtor ON piloto.ID_CONSTRUTOR = construtor.ID_CONSTRUTOR;