CREATE DATABASE DW_MARIO_KART;

USE DW_MARIO_KART;

/*==============================================================*/
/* Table: DIM_CONSTRUTOR                                        */
/*==============================================================*/
CREATE TABLE DIM_CONSTRUTOR (
   ID_CONSTRUTOR        INTEGER              NOT NULL,
   PAIS                 VARCHAR(40)          NOT NULL,
   FABRICANTE_MOTOR     VARCHAR(40)          NOT NULL,
   NOME_CONSTRUTOR      VARCHAR(40)          NOT NULL,
   CONSTRAINT PK_DIM_CONSTRUTOR PRIMARY KEY (ID_CONSTRUTOR)
);

/*==============================================================*/
/* Table: DIM_CORRIDA                                           */
/*==============================================================*/
CREATE TABLE DIM_CORRIDA (
   ID_CORRIDA           INTEGER               NOT NULL,
   NOME_CORRIDA         VARCHAR(40)           NOT NULL,
   NOME_CIRCUITO        VARCHAR(40)           NOT NULL,
   ANO                  INTEGER               NOT NULL,
   ORDEM_CORRIDA        INTEGER,
   PAIS                 VARCHAR(40)           NOT NULL,
   CONSTRAINT PK_DIM_CORRIDA PRIMARY KEY (ID_CORRIDA)
);

/*==============================================================*/
/* Table: DIM_PILOTO                                            */
/*==============================================================*/
CREATE TABLE DIM_PILOTO (
   ID_PILOTO            INTEGER              NOT NULL,
   PAIS                 VARCHAR(40)          NOT NULL,
   NOME_CONSTRUTOR      VARCHAR(40)          NOT NULL,
   REF_PILOTO           VARCHAR(25)          NOT NULL,
   SIGLA_PILOTO         VARCHAR(3)           NOT NULL,
   NOME_PILOTO          VARCHAR(40)          NOT NULL,
   SOBRENOME_PILOTO     VARCHAR(40)          NOT NULL,
   DATA_NASCIMENTO      DATE,
   CONSTRAINT PK_DIM_PILOTO PRIMARY KEY (ID_PILOTO)
);

-- /*==============================================================*/
-- /* Table: DIM_TEMPO                                             */
-- /*==============================================================*/
-- CREATE TABLE DIM_TEMPO (
--    DATA                 DATE                     NOT NULL,
--    DIA                  INTEGER                  NOT NULL,
--    SEMANA               INTEGER                  NOT NULL,
--    MES                  INTEGER                  NOT NULL,
--    TRIMESTRE            INTEGER                  NOT NULL,
--    SEMESTRE             INTEGER                  NOT NULL,
--    ANO                  INTEGER                  NOT NULL,
--    CONSTRAINT PK_DIM_TEMPO PRIMARY KEY (DATA)
-- );

/*==============================================================*/
/* Table: FATO_RESULTADO                                        */
/*==============================================================*/
CREATE TABLE FATO_RESULTADO (
   ID_RESULTADO         INTEGER              NOT NULL,
   ID_CORRIDA           INTEGER              NOT NULL,
   ID_PILOTO            INTEGER              NOT NULL,
   ID_CONSTRUTOR        INTEGER              NOT NULL,
   POS_LARGADA          INTEGER              NOT NULL,
   POS_FINAL            INTEGER              NOT NULL,
   PONTOS_CORRIDA       INTEGER,
   RANK_VOLTA_RAPIDA    INTEGER,
   PONTO_VOLTA_RAPIDA   INTEGER,
   STATUS               VARCHAR(40)          NOT NULL,
   CONSTRAINT PK_FATO_RESULTADO PRIMARY KEY (ID_RESULTADO),
   CONSTRAINT FK_FATO_RESULTADO_DIM_CORRIDA FOREIGN KEY (ID_CORRIDA) REFERENCES DIM_CORRIDA (ID_CORRIDA),
   CONSTRAINT FK_FATO_RESULTADO_DIM_PILOTO FOREIGN KEY (ID_PILOTO) REFERENCES DIM_PILOTO (ID_PILOTO), 
   CONSTRAINT FK_FATO_RAULTADO_DIM_CONSTRUTOR FOREIGN KEY (ID_CONSTRUTOR) REFERENCES DIM_CONSTRUTOR (ID_CONSTRUTOR)
);