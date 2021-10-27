-- 1-Faça o union das tabelas cliente e vendedor extraia os campos nome e email ordernando pelo nome de forma crescente
-- 2-Faça o union all das tabelas cliente e vendedor extraia os campos nome e email
-- 3-Faça o except das tabelas cliente e vendedor extraia os campos nome e email
-- 4-Faça o intersect das tabelas cliente e vendedor extraia os campos nome e email

create database lbd07_atividade -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use lbd07_atividade;

create table cliente(
    codigo bigint primary key auto_increment,
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

create table vendedor(
    codigo bigint primary key auto_increment,
	nome varchar (100) not null,
	email varchar (100) not null,
    telefone varchar(30) default 'SEM TELEFONE',
	comissao decimal(10,2) default 0.05
)default charset = utf8mb4;

insert into vendedor values
(default, "Fernando", "fe@gmail.com", '3322-6644', default),
(default, "Juliana", "ju@hotmail.com", '1122-1234', default),
(default, "Leonardo", "le@gmail.com", '1224-3531', default),
(default, "Mariana", "mari@hotmail.com", '7897-7897', default),
(default, "Luiz", "lu@hotmail.com", '3421-4321', default),
(default, "Fernanda", "fe@hotmail.com", '9696-9696', default),
(default, "Juliana", "ju@hotmail.com", '1122-1234', default);

select * from cliente;

-- 1-Faça o union das tabelas cliente e vendedor extraia os campos nome e email ordernando pelo nome de forma crescente
select nome, email, 'vendedor' as tipo from vendedor
	union -- nessa união remove os duplicados caso haja
		select nome, email, 'cliente' as tipo from cliente
			order by nome asc;
            
-- 2-Faça o union all das tabelas cliente e vendedor extraia os campos nome e email
select nome, email, 'vendedor' as tipo  from vendedor
	union all -- nessa união não é removido duplicados
		select nome, email, 'cliente' as tipo from cliente;
        
-- 3-Faça o except das tabelas cliente e vendedor extraia os campos nome e email
select nome, email from vendedor 
	where (nome, email) not in -- Traz todos da tabela A que não fazem parte da tabela B
		(select nome, email from cliente);
    
-- 4-Faça o intersect das tabelas cliente e vendedor extraia os campos nome e email
select nome, email from vendedor 
	where (nome, email) in -- Somente traz os registros que as duas tabelas têm em comum.
		(select nome, email from cliente);