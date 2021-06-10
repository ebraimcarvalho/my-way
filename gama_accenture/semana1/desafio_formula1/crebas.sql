/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     10/06/2021 18:30:15                          */
/*==============================================================*/


alter table TB_CIRCUITO
   drop constraint FK_TB_CIRCU_RELATIONS_TB_PAIS;

alter table TB_CONSTRUTOR
   drop constraint FK_TB_CONST_RELATIONS_TB_PAIS;

alter table TB_CONSTRUTOR
   drop constraint FK_TB_CONST_RELATIONS_TB_FABRI;

alter table TB_CORRIDA
   drop constraint FK_TB_CORRI_CIRCUITO__TB_CIRCU;

alter table TB_PILOTO
   drop constraint FK_TB_PILOT_RELATIONS_TB_PAIS;

alter table TB_PILOTO
   drop constraint FK_TB_PILOT_RELATIONS_TB_CONST;

alter table TB_PIT_STOPS
   drop constraint FK_TB_PIT_S_RELATIONS_TB_CORRI;

alter table TB_PIT_STOPS
   drop constraint FK_TB_PIT_S_RELATIONS_TB_PILOT;

alter table TB_RESULTADO
   drop constraint FK_TB_RESUL_RELATIONS_TB_PILOT;

alter table TB_RESULTADO
   drop constraint FK_TB_RESUL_RELATIONS_TB_CONST;

alter table TB_RESULTADO
   drop constraint FK_TB_RESUL_RELATIONS_TB_CORRI;

alter table TB_RESULTADO
   drop constraint FK_TB_RESUL_RELATIONS_TB_STATU;

alter table TB_TEMPO_VOLTA
   drop constraint FK_TB_TEMPO_CORRIDA_T_TB_CORRI;

alter table TB_TEMPO_VOLTA
   drop constraint FK_TB_TEMPO_RELATIONS_TB_PILOT;

drop table TB_CIRCUITO cascade constraints;

drop table TB_CONSTRUTOR cascade constraints;

drop table TB_CORRIDA cascade constraints;

drop table TB_FABRICANTE_MOTOR cascade constraints;

drop table TB_PAIS cascade constraints;

drop table TB_PILOTO cascade constraints;

drop index RELATIONSHIP_23_FK;

drop index RELATIONSHIP_22_FK;

drop table TB_PIT_STOPS cascade constraints;

drop index RELATIONSHIP_24_FK;

drop index RELATIONSHIP_16_FK;

drop index RELATIONSHIP_15_FK;

drop index RELATIONSHIP_14_FK;

drop table TB_RESULTADO cascade constraints;

drop table TB_STATUS cascade constraints;

drop index RELATIONSHIP_13_FK;

drop index RELATIONSHIP_12_FK;

drop table TB_TEMPO_VOLTA cascade constraints;

/*==============================================================*/
/* Table: TB_CIRCUITO                                           */
/*==============================================================*/
create table TB_CIRCUITO (
   ID                   INTEGER               not null,
   ID_PAIS              INTEGER               not null,
   LOCALIDADE           CHAR(30)              not null,
   NOME                 CHAR(30)              not null,
   LATITUDE             FLOAT,
   LONGITUDE            FLOAT,
   ALTITUDE             INTEGER,
   constraint PK_TB_CIRCUITO primary key (ID)
);

/*==============================================================*/
/* Table: TB_CONSTRUTOR                                         */
/*==============================================================*/
create table TB_CONSTRUTOR (
   ID_CONSTRUTOR        INTEGER               not null,
   ID_PAIS              INTEGER               not null,
   ID_FABRICANTE        INTEGER               not null,
   NOME_CONSTRUTOR      CHAR(30)              not null,
   constraint PK_TB_CONSTRUTOR primary key (ID_CONSTRUTOR)
);

/*==============================================================*/
/* Table: TB_CORRIDA                                            */
/*==============================================================*/
create table TB_CORRIDA (
   ID_CORRIDA           INTEGER               not null,
   ID_CIRCUITO          INTEGER               not null,
   ANO                  INTEGER               not null,
   NOME                 CHAR(30)              not null,
   DATA_CORRIDA         DATE                  not null,
   HORARIO_INICIO_CORRIDA DATE,
   ORDEM_CORRIDA        INTEGER,
   constraint PK_TB_CORRIDA primary key (ID_CORRIDA)
);

/*==============================================================*/
/* Table: TB_FABRICANTE_MOTOR                                   */
/*==============================================================*/
create table TB_FABRICANTE_MOTOR (
   ID_FABRICANTE        INTEGER               not null,
   NOME_FABRICANTE      CHAR(30)              not null,
   constraint PK_TB_FABRICANTE_MOTOR primary key (ID_FABRICANTE)
);

/*==============================================================*/
/* Table: TB_PAIS                                               */
/*==============================================================*/
create table TB_PAIS (
   ID                   INTEGER               not null,
   NOME_PAIS            CHAR(30)              not null,
   constraint PK_TB_PAIS primary key (ID)
);

/*==============================================================*/
/* Table: TB_PILOTO                                             */
/*==============================================================*/
create table TB_PILOTO (
   ID_PILOTO            INTEGER               not null,
   ID_PAIS              INTEGER               not null,
   ID_CONSTRUTOR        INTEGER               not null,
   REF_PILOTO           CHAR(15)              not null,
   SIGLA_PILOTO         CHAR(3)               not null,
   NOME_PILOTO          CHAR(30)              not null,
   SOBRENOME_PILOTO     CHAR(30)              not null,
   DATA_NASCIMENTO      DATE,
   constraint PK_TB_PILOTO primary key (ID_PILOTO)
);

/*==============================================================*/
/* Table: TB_PIT_STOPS                                          */
/*==============================================================*/
create table TB_PIT_STOPS (
   ID_PIT_STOP          INTEGER               not null,
   ID_CORRIDA           INTEGER               not null,
   ID_PILOTO            INTEGER               not null,
   TEMPO_PIT_STOP       DATE                  not null,
   NO_VOLTA             INTEGER               not null,
   constraint PK_TB_PIT_STOPS primary key (ID_PIT_STOP)
);

/*==============================================================*/
/* Index: RELATIONSHIP_22_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_22_FK on TB_PIT_STOPS (
   ID_CORRIDA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_23_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_23_FK on TB_PIT_STOPS (
   ID_PILOTO ASC
);

/*==============================================================*/
/* Table: TB_RESULTADO                                          */
/*==============================================================*/
create table TB_RESULTADO (
   ID_RESULTADO         INTEGER               not null,
   ID_CORRIDA           INTEGER               not null,
   ID_PILOTO            INTEGER               not null,
   ID_CONSTRUTOR        INTEGER               not null,
   ID_STATUS            INTEGER               not null,
   POS_LARGADA          INTEGER               not null,
   POS_FINAL            INTEGER               not null,
   PONTOS_CORRIDA       INTEGER               not null,
   RANK_VOLTA_RAPIDA    INTEGER               not null,
   TEMPO_VOLTA_RAPIDA   DATE                  not null,
   PONTO_VOLTA_RAPIDA   INTEGER               not null,
   constraint PK_TB_RESULTADO primary key (ID_RESULTADO)
);

/*==============================================================*/
/* Index: RELATIONSHIP_14_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_14_FK on TB_RESULTADO (
   ID_PILOTO ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_15_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_15_FK on TB_RESULTADO (
   ID_CONSTRUTOR ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_16_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_16_FK on TB_RESULTADO (
   ID_CORRIDA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_24_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_24_FK on TB_RESULTADO (
   ID_STATUS ASC
);

/*==============================================================*/
/* Table: TB_STATUS                                             */
/*==============================================================*/
create table TB_STATUS (
   ID_STATUS            INTEGER               not null,
   DESCRICAO            CHAR(30),
   constraint PK_TB_STATUS primary key (ID_STATUS)
);

/*==============================================================*/
/* Table: TB_TEMPO_VOLTA                                        */
/*==============================================================*/
create table TB_TEMPO_VOLTA (
   ID                   INTEGER               not null,
   ID_CORRIDA           INTEGER               not null,
   ID_PILOTO            INTEGER               not null,
   NO_VOLTA             INTEGER               not null,
   POSICAO_PILOTO       INTEGER,
   TEMPO_VOLTA          DATE                  not null,
   constraint PK_TB_TEMPO_VOLTA primary key (ID)
);

/*==============================================================*/
/* Index: RELATIONSHIP_12_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_12_FK on TB_TEMPO_VOLTA (
   ID_CORRIDA ASC
);

/*==============================================================*/
/* Index: RELATIONSHIP_13_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_13_FK on TB_TEMPO_VOLTA (
   ID_PILOTO ASC
);

alter table TB_CIRCUITO
   add constraint FK_TB_CIRCU_RELATIONS_TB_PAIS foreign key (ID)
      references TB_PAIS (ID);

alter table TB_CONSTRUTOR
   add constraint FK_TB_CONST_RELATIONS_TB_PAIS foreign key (ID_CONSTRUTOR)
      references TB_PAIS (ID);

alter table TB_CONSTRUTOR
   add constraint FK_TB_CONST_RELATIONS_TB_FABRI foreign key (ID_FABRICANTE)
      references TB_FABRICANTE_MOTOR (ID_FABRICANTE);

alter table TB_CORRIDA
   add constraint FK_TB_CORRI_CIRCUITO__TB_CIRCU foreign key (ID_CORRIDA)
      references TB_CIRCUITO (ID);

alter table TB_PILOTO
   add constraint FK_TB_PILOT_RELATIONS_TB_PAIS foreign key (ID_PILOTO)
      references TB_PAIS (ID);

alter table TB_PILOTO
   add constraint FK_TB_PILOT_RELATIONS_TB_CONST foreign key (ID_CONSTRUTOR)
      references TB_CONSTRUTOR (ID_CONSTRUTOR);

alter table TB_PIT_STOPS
   add constraint FK_TB_PIT_S_RELATIONS_TB_CORRI foreign key (ID_CORRIDA)
      references TB_CORRIDA (ID_CORRIDA);

alter table TB_PIT_STOPS
   add constraint FK_TB_PIT_S_RELATIONS_TB_PILOT foreign key (ID_PILOTO)
      references TB_PILOTO (ID_PILOTO);

alter table TB_RESULTADO
   add constraint FK_TB_RESUL_RELATIONS_TB_PILOT foreign key (ID_PILOTO)
      references TB_PILOTO (ID_PILOTO);

alter table TB_RESULTADO
   add constraint FK_TB_RESUL_RELATIONS_TB_CONST foreign key (ID_CONSTRUTOR)
      references TB_CONSTRUTOR (ID_CONSTRUTOR);

alter table TB_RESULTADO
   add constraint FK_TB_RESUL_RELATIONS_TB_CORRI foreign key (ID_CORRIDA)
      references TB_CORRIDA (ID_CORRIDA);

alter table TB_RESULTADO
   add constraint FK_TB_RESUL_RELATIONS_TB_STATU foreign key (ID_STATUS)
      references TB_STATUS (ID_STATUS);

alter table TB_TEMPO_VOLTA
   add constraint FK_TB_TEMPO_CORRIDA_T_TB_CORRI foreign key (ID_CORRIDA)
      references TB_CORRIDA (ID_CORRIDA);

alter table TB_TEMPO_VOLTA
   add constraint FK_TB_TEMPO_RELATIONS_TB_PILOT foreign key (ID_PILOTO)
      references TB_PILOTO (ID_PILOTO);

