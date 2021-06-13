alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RAULTADO__DIM_CONS;

alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RESULTADO_DIM_CORR;

alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RESULTADO_DIM_PILO;

alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RESULTADO_DIM_TEMP;

drop table DIM_CONSTRUTOR cascade constraints;

drop table DIM_CORRIDA cascade constraints;

drop table DIM_PILOTO cascade constraints;

drop table DIM_TEMPO cascade constraints;

drop table FATO_RESULTADO cascade constraints;

/*==============================================================*/
/* Table: DIM_CONSTRUTOR                                        */
/*==============================================================*/
create table DIM_CONSTRUTOR (
   ID_CONSTRUTOR        INTEGER               not null,
   PAIS                 VARCHAR(30)           not null,
   FABRICANTE_MOTOR     VARCHAR(40)           not null,
   NOME_CONSTRUTOR      VARCHAR(40)           not null,
   constraint PK_DIM_CONSTRUTOR primary key (ID_CONSTRUTOR)
);

/*==============================================================*/
/* Table: DIM_CORRIDA                                           */
/*==============================================================*/
create table DIM_CORRIDA (
   ID_CORRIDA           INTEGER               not null,
   NOME_CORRIDA         VARCHAR(0)            not null,
   NOME_CIRCUITO        VARCHAR(2)            not null,
   DATA_CORRIDA         DATE                  not null,
   ANO                  INTEGER               not null,
   HORARIO_INICIO       DATE,
   ORDEM_CORRIDA        INTEGER,
   PAIS                 VARCHAR(40),
   constraint PK_DIM_CORRIDA primary key (ID_CORRIDA)
);

/*==============================================================*/
/* Table: DIM_PILOTO                                            */
/*==============================================================*/
create table DIM_PILOTO (
   ID_PILOTO            INTEGER               not null,
   PAIS                 VARCHAR(30)           not null,
   ID_CONSTRUTOR        INTEGER               not null,
   REF_PILOTO           VARCHAR(15),
   SIGLA_PILOTO         VARCHAR(3),
   NOME_PILOTO          VARCHAR(30)           not null,
   SOBRENOME_PILOTO     VARCHAR(30),
   DATA_NASCIMENTO      DATE,
   constraint PK_DIM_PILOTO primary key (ID_PILOTO)
);

/*==============================================================*/
/* Table: DIM_TEMPO                                             */
/*==============================================================*/
create table DIM_TEMPO (
   DATA                 DATE                  not null,
   DIA                  INTEGER               not null,
   SEMANA               INTEGER               not null,
   MES                  INTEGER               not null,
   TRIMESTRE            INTEGER               not null,
   SEMESTRE             INTEGER               not null,
   ANO                  INTEGER               not null,
   constraint PK_DIM_TEMPO primary key (DATA)
);

/*==============================================================*/
/* Table: FATO_RESULTADO                                        */
/*==============================================================*/
create table FATO_RESULTADO (
   ID_RESULTADO         INTEGER               not null,
   DATA                 DATE                  not null,
   ID_CORRIDA           INTEGER               not null,
   ID_PILOTO            INTEGER               not null,
   ID_CONSTRUTOR        INTEGER               not null,
   POS_LARGADA          INTEGER               not null,
   POS_FINAL            INTEGER               not null,
   PONTOS_CORRIDA       INTEGER,
   RANK_VOLTA_RAPIDA    INTEGER,
   TEMPO_VOLTA_RAPIDA   INTEGER,
   PONTO_VOLTA_RAPIDA   INTEGER,
   STATUS               VARCHAR(30)           not null,
   constraint PK_FATO_RESULTADO primary key (ID_RESULTADO)
);

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RAULTADO__DIM_CONS foreign key (ID_CONSTRUTOR)
      references DIM_CONSTRUTOR (ID_CONSTRUTOR);

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RESULTADO_DIM_CORR foreign key (ID_CORRIDA)
      references DIM_CORRIDA (ID_CORRIDA);

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RESULTADO_DIM_PILO foreign key (ID_PILOTO)
      references DIM_PILOTO (ID_PILOTO);

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RESULTADO_DIM_TEMP foreign key (DATA)
      references DIM_TEMPO (DATA);
