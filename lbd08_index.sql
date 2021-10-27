create database lbd08_index -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use lbd08_index;
-- Index
-- quando se cria uma pk em uma tabela, automaticamente será criado o index.
-- pode-se também criar index adicionais:
-- Exemplos:
	-- create index idx_lastname on Persons (lastName);
	-- create index idx_pname on Persons (lastName, firstName);
-- para remover index: alter table table_name drop index index_name;

create table produto(
    codigo bigint primary key auto_increment, -- o campo código por ser uma pk também é um index.
    nome varchar(100),
	valor decimal(10,2) default 0.01,
    qtdEstoque int default 0
) default charset = utf8mb4;

insert into produto values 
(default, 'TV', 2500.00, 9),
(default, 'X-Box One Series X', 3700.00, 11),
(default, 'Cama Box Queen', 3100.00, 5),
(default, 'Laptop Acer', 4900.00, 2),
(default, 'Cel Xiaomi', 1700.00, 5);
select * from produto;

-- criar mais um index:
create index idx_produto_nome on produto (nome); -- criando o index idx_produto_nome da tabela produto para o campo nome.
-- para pesquisar
select * from produto where nome like '%acer%';

create table cliente(
    codigo bigint primary key auto_increment, -- o campo código por ser uma pk também é um index.
	nome varchar (100) not null,
    sexo varchar (1) not null,
	senha varchar (100) not null,
	email varchar (100) not null,
    idade varchar (3) not null,
    telefone varchar (30) default 'Sem Telefone',
    cidade varchar (30) not null,
	ativo bigint default 0
)default charset = utf8mb4;

insert into cliente values
(default, "Mario", "M" ,  md5('123999'), "mario@gmail.com", 36, '4444-7777',"São Paulo", '1'),
(default, "Josefina", "F" , md5('987654'), "jo@hotmail.com", 47, '9797-9797', "Guarulhos", '1'),
(default, "José", "M" , md5('654321'), "jose@gmail.com", 55, '9898-9898', "Santa Catarina", '1'),
(default, "Fernanda", "F" , md5('578961'), "fe@hotmail.com", 27, '9696-9696', "São Paulo", '1'),
(default, "Mariana", "F" , md5('202021'), "mari@hotmail.com", 29, '7897-7897', "Santo André", '1'),
(default, "Valentina", "F" , md5('123896'), "val@gmail.com", 17, '5566-7788', "Guarulhos", '1');

select * from cliente; 

-- criar mais um index:
create index idx_cliente_nome on cliente (nome, email); -- criando o index idx_cliente_nome da tabela pcliente para o campo nome e email.
-- para pesquisar
select * from cliente where nome like '%Jo%';

