/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     15/06/2021 14:54:48                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FATO_RESULTADO') and o.name = 'FK_FATO_RES_RAULTADO__DIM_CONS')
alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RAULTADO__DIM_CONS
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FATO_RESULTADO') and o.name = 'FK_FATO_RES_RESULTADO_DIM_CORR')
alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RESULTADO_DIM_CORR
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FATO_RESULTADO') and o.name = 'FK_FATO_RES_RESULTADO_DIM_PILO')
alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RESULTADO_DIM_PILO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FATO_RESULTADO') and o.name = 'FK_FATO_RES_RESULTADO_DIM_TEMP')
alter table FATO_RESULTADO
   drop constraint FK_FATO_RES_RESULTADO_DIM_TEMP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_CONSTRUTOR')
            and   type = 'U')
   drop table DIM_CONSTRUTOR
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_CORRIDA')
            and   type = 'U')
   drop table DIM_CORRIDA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_PILOTO')
            and   type = 'U')
   drop table DIM_PILOTO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIM_TEMPO')
            and   type = 'U')
   drop table DIM_TEMPO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FATO_RESULTADO')
            and   type = 'U')
   drop table FATO_RESULTADO
go

/*==============================================================*/
/* Table: DIM_CONSTRUTOR                                        */
/*==============================================================*/
create table DIM_CONSTRUTOR (
   ID_CONSTRUTOR        int                  not null,
   PAIS                 varchar(30)          not null,
   FABRICANTE_MOTOR     varchar(40)          not null,
   NOME_CONSTRUTOR      varchar(40)          not null,
   constraint PK_DIM_CONSTRUTOR primary key (ID_CONSTRUTOR)
)
go

/*==============================================================*/
/* Table: DIM_CORRIDA                                           */
/*==============================================================*/
create table DIM_CORRIDA (
   ID_CORRIDA           int                  not null,
   NOME_CORRIDA         varchar(0)           not null,
   NOME_CIRCUITO        varchar(2)           not null,
   DATA_CORRIDA         datetime             not null,
   ANO                  int                  not null,
   HORARIO_INICIO       datetime             null,
   ORDEM_CORRIDA        int                  null,
   PAIS                 varchar(40)          null,
   constraint PK_DIM_CORRIDA primary key (ID_CORRIDA)
)
go

/*==============================================================*/
/* Table: DIM_PILOTO                                            */
/*==============================================================*/
create table DIM_PILOTO (
   ID_PILOTO            int                  not null,
   PAIS                 varchar(30)          not null,
   ID_CONSTRUTOR        int                  not null,
   REF_PILOTO           varchar(15)          null,
   SIGLA_PILOTO         varchar(3)           null,
   NOME_PILOTO          varchar(30)          not null,
   SOBRENOME_PILOTO     varchar(30)          null,
   DATA_NASCIMENTO      datetime             null,
   constraint PK_DIM_PILOTO primary key (ID_PILOTO)
)
go

/*==============================================================*/
/* Table: DIM_TEMPO                                             */
/*==============================================================*/
create table DIM_TEMPO (
   DATA                 datetime             not null,
   DIA                  int                  not null,
   SEMANA               int                  not null,
   MES                  int                  not null,
   TRIMESTRE            int                  not null,
   SEMESTRE             int                  not null,
   ANO                  int                  not null,
   constraint PK_DIM_TEMPO primary key (DATA)
)
go

/*==============================================================*/
/* Table: FATO_RESULTADO                                        */
/*==============================================================*/
create table FATO_RESULTADO (
   ID_RESULTADO         int                  not null,
   DATA                 datetime             not null,
   ID_CORRIDA           int                  not null,
   ID_PILOTO            int                  not null,
   ID_CONSTRUTOR        int                  not null,
   POS_LARGADA          int                  not null,
   POS_FINAL            int                  not null,
   PONTOS_CORRIDA       int                  null,
   RANK_VOLTA_RAPIDA    int                  null,
   TEMPO_VOLTA_RAPIDA   int                  null,
   PONTO_VOLTA_RAPIDA   int                  null,
   STATUS               varchar(30)          not null,
   constraint PK_FATO_RESULTADO primary key (ID_RESULTADO)
)
go

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RAULTADO__DIM_CONS foreign key (ID_CONSTRUTOR)
      references DIM_CONSTRUTOR (ID_CONSTRUTOR)
go

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RESULTADO_DIM_CORR foreign key (ID_CORRIDA)
      references DIM_CORRIDA (ID_CORRIDA)
go

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RESULTADO_DIM_PILO foreign key (ID_PILOTO)
      references DIM_PILOTO (ID_PILOTO)
go

alter table FATO_RESULTADO
   add constraint FK_FATO_RES_RESULTADO_DIM_TEMP foreign key (DATA)
      references DIM_TEMPO (DATA)
go

