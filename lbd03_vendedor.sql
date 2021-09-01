create database loja -- Criar a base de dados loja
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use loja;

create table vendedor ( -- Criando uma table
codigo int not null auto_increment,
vendedor varchar (30) not null,
telefone varchar (9) default 'Sem Telefone',
comissao decimal (5,2) default 0.05,
primary key (codigo) -- Para não haver repetições de tuplas é fundamental utilizar a primary key
)default charset = utf8mb4;

insert into vendedor values /*Inserindo dados na tabela, basta seguir a mesma sequencia dos dados e ir inserindo as informações*/
(default, "Claúdio", "9999-9999", 99.0),
(default, "Pedro", "8888-8888", 87),
(default, "Janaina", "7777-7777", 75.4);

alter table vendedor add email varchar (50); -- Alterar a tabela e add a coluna email
alter table vendedor drop column email; -- Alterar a tabela e excluir a coluna email

drop table vendedor; -- Apagar tabela


select * from vendedor; -- select todo mundo from, mostra o conteúdo da tabela
show databases; -- Listar o banco de dados
show tables; -- Listar as tabelas do banco de dados
describe vendedor; -- Visualizar estrutura da tabela
desc vendedor; 
drop database loja; -- Apagar toda a base de dados

