/*==============================================================*/
/* DBMS name:      ORACLE Version 12c                           */
/* Created on:     07/06/2021 20:18:21                          */
/*==============================================================*/


alter table TB02_CONTA
   drop constraint FK_TB02_CON_REFERENCE_TB01_AGE;

alter table TB02_CONTA
   drop constraint FK_TB02_CON_REFERENCE_TB03_CLI;

alter table TB04_SALDO
   drop constraint FK_TB04_SAL_REFERENCE_TB02_CON;

alter table TB05_ENDERECO
   drop constraint FK_TB05_END_REFERENCE_TB03_CLI;

drop table TB01_AGENCIA cascade constraints;

drop table TB02_CONTA cascade constraints;

drop table TB03_CLIENTE cascade constraints;

drop table TB04_SALDO cascade constraints;

drop table TB05_ENDERECO cascade constraints;

/*==============================================================*/
/* Table: TB01_AGENCIA                                          */
/*==============================================================*/
create table TB01_AGENCIA (
   NU_AGENCIA           INT                   not null,
   NO_AGENCIA           VARCHAR2(100)         not null,
   DT_ABERTURA          DATE                  not null,
   IC_SITUACAO          CHAR(1)               not null,
   constraint PK_TB01_AGENCIA primary key (NU_AGENCIA)
);

comment on table TB01_AGENCIA is
'Tabela de Agencias';

/*==============================================================*/
/* Table: TB02_CONTA                                            */
/*==============================================================*/
create table TB02_CONTA (
   NU_AGENCIA           INT                   not null,
   NU_CONTA             INT                   not null,
   CO_CLIENTE_CPF_CNPJ  VARCHAR2(14)          not null,
   DT_ABERTURA          DATE                  not null,
   constraint PK_TB02_CONTA primary key (NU_CONTA, NU_AGENCIA)
);

comment on table TB02_CONTA is
'Tabela de Conta Bancária';

/*==============================================================*/
/* Table: TB03_CLIENTE                                          */
/*==============================================================*/
create table TB03_CLIENTE (
   CO_CLIENTE_CPF_CNPJ  VARCHAR2(14)          not null,
   CO_CLIENTE           integer               not null,
   NO_CLIENTE           VARCHAR2(100)         not null,
   TP_CLIENTE           CHAR(1)               not null,
   IC_SITUACAO          CHAR(1)               not null,
   constraint PK_TB03_CLIENTE primary key (CO_CLIENTE_CPF_CNPJ)
);

comment on table TB03_CLIENTE is
'Tabelas de clientes simplificada';

/*==============================================================*/
/* Table: TB04_SALDO                                            */
/*==============================================================*/
create table TB04_SALDO (
   NU_CHAVE_BURRA       INTEGER               not null,
   NU_CONTA             INT                   not null,
   NU_AGENCIA           INT                   not null,
   DH_SALDO             DATE                  not null,
   VR_SALDO             DECIMAL(16,2)         not null,
   constraint PK_TB04_SALDO primary key (NU_CHAVE_BURRA)
);

comment on table TB04_SALDO is
'Tabela de saldos';

/*==============================================================*/
/* Table: TB05_ENDERECO                                         */
/*==============================================================*/
create table TB05_ENDERECO (
   CO_ENDERECO          integer               not null,
   CO_CLIENTE_CPF_CNPJ  VARCHAR2(14)          not null,
   TP_ENDERECO          CHAR(1),
   NO_LOGRADOURO        VARCHAR2(100)         not null,
   NO_NUMERO            VARCHAR2(14)          not null,
   NO_CIDADE            VARCHAR2(50)          not null,
   NO_ESTADO            CHAR(2)               not null,
   CO_CEP               VARCHAR2(8),
   constraint PK_TB05_ENDERECO primary key (CO_ENDERECO)
);

comment on table TB05_ENDERECO is
'Tabela de endeceços simplificado';

alter table TB02_CONTA
   add constraint FK_TB02_CON_REFERENCE_TB01_AGE foreign key (NU_AGENCIA)
      references TB01_AGENCIA (NU_AGENCIA);

alter table TB02_CONTA
   add constraint FK_TB02_CON_REFERENCE_TB03_CLI foreign key (CO_CLIENTE_CPF_CNPJ)
      references TB03_CLIENTE (CO_CLIENTE_CPF_CNPJ);

alter table TB04_SALDO
   add constraint FK_TB04_SAL_REFERENCE_TB02_CON foreign key (NU_CONTA, NU_AGENCIA)
      references TB02_CONTA (NU_CONTA, NU_AGENCIA);

alter table TB05_ENDERECO
   add constraint FK_TB05_END_REFERENCE_TB03_CLI foreign key (CO_CLIENTE_CPF_CNPJ)
      references TB03_CLIENTE (CO_CLIENTE_CPF_CNPJ);

