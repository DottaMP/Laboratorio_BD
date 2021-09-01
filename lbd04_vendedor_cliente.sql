/*Crie duas tabelas, vendedor e cliente. Insira 3 registros em cada uma.
Altere o campo comissao da tabela vendedor aumentando em 10%
Altere o campo idade da tabela cliente somando + 1 quando a cidade for são paulo
Remova um registro de cada tabela usando a chave
Utilize os comandos de DTL*/

create database ldb04 -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use ldb04;

start transaction;
drop table vendedor;
create table vendedor(
    codigo bigint primary key auto_increment ,
    vendedor varchar(100),
    telefone varchar(30) default 'SEM TELEFONE',
    comissao decimal(10,2) default 0.05
) default charset = utf8mb4;

insert into vendedor values 
(default, "Claúdio", "9999-9999", 99.00),
(default, "Pedro", "8888-8888", 87.00),
(default, "Janaina", "7777-7777", 75.40);

set sql_safe_updates=0;

update vendedor set comissao = comissao+(comissao * 0.10);
select * from vendedor;

create table cliente(
    codigo bigint primary key auto_increment,
	nome varchar (100) not null,
	senha varchar (100) not null,
	email varchar (100) not null,
    idade varchar (3) not null,
    telefone varchar (30) default 'Sem Telefone',
    cidade varchar (30) not null,
	ativo bigint default 0
)default charset = utf8mb4;

insert into cliente values
(default, "Mario", md5('123999'), "mario@gmail.com", 36, '4444-7777',"São Paulo", '1'),
(default, "José", md5('654321'), "jose@gmail.com", 55, '9898-9898', "Santa Catarina", '1'),
(default, "Josefina", md5('987654'), "jo@hotmail.com", 47, '9797-9797', "Guarulhos", '1');

update cliente set cidade = upper(cidade); -- upper maiusculo e  lower minusculo
update cliente set idade = idade + 1 where cidade = "São Paulo";
select * from cliente;

delete from vendedor where codigo = 1;
delete from cliente where codigo = 2;

rollback; -- cancela comandos da transação
commit; -- efetiva comandos da transação