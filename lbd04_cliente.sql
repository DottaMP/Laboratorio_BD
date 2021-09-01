create database ldb04 -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use ldb04;
create table cliente(
    codigo bigint not null auto_increment,
	nome varchar (100) not null,
	senha varchar(100) not null,
	email varchar(100) not null,
    telefone varchar(30) default 'Sem Telefone',
	ativo int default 0,
	primary key (codigo)
)default charset = utf8mb4;

insert into cliente (nome, senha, email) values -- Inserção de alguns dados da tabela
("Claúdio", "99999999", "claudio@gmail.com"),
("Pedro", "88888888", "pedro@hotmail.com"),
("Janaina", "77777777", "janaina@yahoo.com");

insert into cliente (nome, senha, email, telefone, ativo) values 
("Maria", md5('123456'), "maria@gmail.com", '5555-8888','1'), -- md5 função para criptografar a senha
("João", md5('654321'), "joao@gmail.com", '6666-9999', '1'),
("Joana", md5('987654'), "joana@hotmail.com", '5555-4444','1');

insert into cliente values -- Se a inserção de dados for na ordem, não é necessário informar os campos.
(default, "Mario", md5('123999'), "mario@gmail.com", '4444-7777','1'), -- md5 função para criptografar a senha
(default, "José", md5('654321'), "jose@gmail.com", '9898-9898', default),
(default, "Josefina", md5('987654'), "jo@hotmail.com", '9797-9797', default);

select * from cliente;

delete from cliente where codigo=4;
set sql_safe_updates=0; -- Para alteração e/ou exclusão de info o mySQL possui uma 'trava de segurança'. Esse comando 'destrava' isso.
delete from cliente where ativo=0 and nome='Julia';
update cliente set ativo=1, senha='123456' where ativo=0;

update cliente set senha = md5(senha) where codigo=3;

start transaction; -- Inicia a transação, ou seja, todos os comandos feitos depois do start, se houver rollback ou commit ele irá efetivar. Sempre que houver rollback e commit necessário efetivar o start novamente.
rollback; -- cancela comandos da transação
commit; -- efetiva comandos da transação