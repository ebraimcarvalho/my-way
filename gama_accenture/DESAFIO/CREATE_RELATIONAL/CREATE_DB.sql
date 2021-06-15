CREATE DATABASE DB_MARIO_KART;

USE DB_MARIO_KART;

/*==============================================================*/
/* Table: TB_PAIS                                               */
/*==============================================================*/
CREATE TABLE TB_PAIS (
   ID_PAIS INTEGER NOT NULL auto_increment, 
   NOME_PAIS VARCHAR(40) NOT NULL UNIQUE,
   CONSTRAINT PK_TB_PAIS PRIMARY KEY (ID_PAIS)
);

/*==============================================================*/
/* Table: TB_FABRICANTE_MOTOR                                   */
/*==============================================================*/
CREATE TABLE TB_FABRICANTE_MOTOR (
   ID_FABRICANTE INTEGER NOT NULL auto_increment,
   NOME_FABRICANTE VARCHAR(40) NOT NULL,
   CONSTRAINT PK_TB_FABRICANTE_MOTOR PRIMARY KEY (ID_FABRICANTE)
);

/*==============================================================*/
/* Table: TB_STATUS                                             */
/*==============================================================*/
CREATE TABLE TB_STATUS (
   ID_STATUS  INTEGER NOT NULL,
   DESCRICAO  VARCHAR(40),
   CONSTRAINT PK_TB_STATUS PRIMARY KEY (ID_STATUS)
);

/*==============================================================*/
/* Table: TB_CONSTRUTOR                                         */
/*==============================================================*/
CREATE TABLE TB_CONSTRUTOR (
   ID_CONSTRUTOR INTEGER  NOT NULL,
   ID_PAIS INTEGER NOT NULL,
   ID_FABRICANTE INTEGER NOT NULL,
   NOME_CONSTRUTOR VARCHAR(40) NOT NULL,
   CONSTRAINT PK_TB_CONSTRUTOR PRIMARY KEY (ID_CONSTRUTOR),
   CONSTRAINT FK_TB_CONSTRUTOR_TB_PAIS FOREIGN KEY (ID_PAIS) REFERENCES TB_PAIS (ID_PAIS),
   CONSTRAINT FK_TB_CONSTRUTOR_TB_FABRICANTE_MOTOR FOREIGN KEY (ID_FABRICANTE) REFERENCES TB_FABRICANTE_MOTOR (ID_FABRICANTE)   
);

/*==============================================================*/
/* Table: TB_PILOTO                                             */
/*==============================================================*/
CREATE TABLE TB_PILOTO (
   ID_PILOTO            INTEGER               NOT NULL,
   ID_PAIS              INTEGER               NOT NULL,
   ID_CONSTRUTOR        INTEGER               NOT NULL,
   REF_PILOTO           VARCHAR(25)           NOT NULL,
   SIGLA_PILOTO         VARCHAR(3)            NOT NULL,
   NOME_PILOTO          VARCHAR(40)           NOT NULL,
   SOBRENOME_PILOTO     VARCHAR(40)           NOT NULL,
   DATA_NASCIMENTO      DATE,
   CONSTRAINT PK_TB_PILOTO PRIMARY KEY (ID_PILOTO),
   CONSTRAINT FK_TB_PILOTO_TB_PAIS FOREIGN KEY (ID_PAIS) REFERENCES TB_PAIS (ID_PAIS),
   CONSTRAINT FK_TB_PILOTO_TB_CONSTRUTOR FOREIGN KEY (ID_CONSTRUTOR) REFERENCES TB_CONSTRUTOR (ID_CONSTRUTOR) 
);

/*==============================================================*/
/* Table: TB_CIRCUITO                                           */
/*==============================================================*/

CREATE TABLE TB_CIRCUITO (
   ID_CIRCUITO          INTEGER					 NOT NULL,
   ID_PAIS              INTEGER					 NOT NULL,
   LOCALIDADE           VARCHAR(40)              NOT NULL,
   NOME                 VARCHAR(40)              NOT NULL,
   LATITUDE             FLOAT,
   LONGITUDE            FLOAT,
   ALTITUDE             INTEGER,
   CONSTRAINT PK_TB_CIRCUITO PRIMARY KEY (ID_CIRCUITO),
   CONSTRAINT FK_TB_CIRCUITO_TB_PAIS FOREIGN KEY (ID_PAIS) REFERENCES TB_PAIS (ID_PAIS)
);

/*==============================================================*/
/* Table: TB_CORRIDA                                            */
/*==============================================================*/
CREATE TABLE TB_CORRIDA (
   ID_CORRIDA             INTEGER               NOT NULL,
   ID_CIRCUITO            INTEGER               NOT NULL,
   ANO                    INTEGER               NOT NULL,
   NOME                   VARCHAR(40)           NOT NULL,
   ORDEM_CORRIDA          INTEGER,
   CONSTRAINT PK_TB_CORRIDA PRIMARY KEY (ID_CORRIDA),
   CONSTRAINT FK_TB_CORRIDA_TB_CIRCUITO FOREIGN KEY (ID_CIRCUITO) REFERENCES TB_CIRCUITO (ID_CIRCUITO)
);

/*==============================================================*/
/* Table: TB_PIT_STOPS                                          */
/*==============================================================*/
CREATE TABLE TB_PIT_STOPS (
   ID_PIT_STOP          INTEGER               NOT NULL          auto_increment,
   ID_CORRIDA           INTEGER               NOT NULL,
   ID_PILOTO            INTEGER               NOT NULL,
   TEMPO_PIT_STOP       INTEGER               NOT NULL,
   NO_VOLTA             INTEGER               NOT NULL,
   CONSTRAINT PK_TB_PIT_STOPS PRIMARY KEY (ID_PIT_STOP),
   CONSTRAINT FK_TB_PIT_STOPS_TB_CORRIDA FOREIGN KEY (ID_CORRIDA) REFERENCES TB_CORRIDA (ID_CORRIDA),
   CONSTRAINT FK_TB_PIT_STOPS_TB_PILOTO FOREIGN KEY (ID_PILOTO) REFERENCES TB_PILOTO (ID_PILOTO) 
);

-- /*==============================================================*/
-- /* Table: TB_TEMPO_VOLTA                                        */
-- /*==============================================================*/
-- CREATE TABLE TB_TEMPO_VOLTA (
--    ID_TEMPO_VOLTA       INTEGER               NOT NULL			auto_increment,
--    ID_CORRIDA           INTEGER               NOT NULL,
--    ID_PILOTO            INTEGER               NOT NULL,
--    NO_VOLTA             INTEGER               NOT NULL,
--    POSICAO_PILOTO       INTEGER,
--    TEMPO_VOLTA          INTEGER               NOT NULL,
--    CONSTRAINT PK_TB_TEMPO_VOLTA PRIMARY KEY (ID_TEMPO_VOLTA),
--    CONSTRAINT FK_TB_TEMPO_VOLTA_TB_CORRIDA FOREIGN KEY (ID_CORRIDA) REFERENCES TB_CORRIDA (ID_CORRIDA),
--    CONSTRAINT FK_TB_TEMPO_VOLTA_TB_PILOTO FOREIGN KEY (ID_PILOTO) REFERENCES TB_PILOTO (ID_PILOTO)
-- );


/*==============================================================*/
/* Table: TB_RESULTADO                                          */
/*==============================================================*/
CREATE TABLE TB_RESULTADO (
   ID_RESULTADO         INTEGER               NOT NULL,
   ID_CORRIDA           INTEGER               NOT NULL,
   ID_PILOTO            INTEGER               NOT NULL,
   ID_CONSTRUTOR        INTEGER               NOT NULL,
   ID_STATUS            INTEGER               NOT NULL,
   POS_LARGADA          INTEGER               NOT NULL,
   POS_FINAL            INTEGER               NOT NULL,
   PONTOS_CORRIDA       INTEGER,
   RANK_VOLTA_RAPIDA    INTEGER,
   PONTO_VOLTA_RAPIDA   INTEGER               NOT NULL,
   CONSTRAINT PK_TB_RESULTADO PRIMARY KEY (ID_RESULTADO),
   CONSTRAINT FK_TB_RESULTADO_TB_CORRIDA FOREIGN KEY (ID_CORRIDA) REFERENCES TB_CORRIDA (ID_CORRIDA),
   CONSTRAINT FK_TB_RESULTADO_TB_PILOTO FOREIGN KEY (ID_PILOTO) REFERENCES TB_PILOTO (ID_PILOTO),
   CONSTRAINT FK_TB_RESULTADO_TB_CONSTRUTOR FOREIGN KEY (ID_CONSTRUTOR) REFERENCES TB_CONSTRUTOR (ID_CONSTRUTOR), 
   CONSTRAINT FK_TB_RESULTADO_TB_STATUS FOREIGN KEY (ID_STATUS) REFERENCES TB_STATUS (ID_STATUS)
);



/*==============================================================*/
/* Index: TB_PIT_STOPS                                    */
/*==============================================================*/
CREATE INDEX IDX_TB_PITSTOPS ON TB_PIT_STOPS (ID_PILOTO, ID_CORRIDA);


/*==============================================================*/
/* Index: TB_RESULTADO                                    */
/*==============================================================*/
CREATE INDEX IDX_TB_RESULTADO ON TB_RESULTADO (ID_CORRIDA, ID_PILOTO, ID_CONSTRUTOR, ID_STATUS);


-- /*==============================================================*/
-- /* Index: TB_TEMPO_VOLTA                                    */
-- /*==============================================================*/
-- CREATE INDEX IDX_TB_TEMPO_VOLTA ON TB_TEMPO_VOLTA (ID_CORRIDA, ID_PILOTO);


-- alter table TB_TEMPO_VOLTA
-- drop constraint FK_TB_TEMPO_VOLTA_TB_PILOTO;

-- alter table TB_TEMPO_VOLTA
-- drop constraint FK_TB_TEMPO_VOLTA_TB_CORRIDA;

-- alter table TB_TEMPO_VOLTA
-- drop constraint PK_TB_TEMPO_VOLTA;

-- ALTER TABLE TB_TEMPO_VOLTA
-- DROP INDEX IDX_TB_TEMPO_VOLTA;

-- DROP TABLE TB_TEMPO_VOLTA;