/*1-Faça uma consulta de todos os campos na tabela cliente
2- Consulte os campos nome e idade da tabela cliente onde o sexo=’F’
3- Consulte os campos da tabela de cliente quando o sexo=’F’ e a idade for >=18, ordenando pela idade e nome
4- Consulte os campos produto, valor e quantidade da tabela produto e estoque ordenando pela quantidade em estoque decrescente
5- Agrupe os pedidos por vendendor, mostrando o numero de pedidos , total dos pedidos e media dos pedidos.
6- Verifique no banco de dados o menor e o maior valor de pedido*/

create database ldb05_selects -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use ldb05_selects;

start transaction;

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

select * from cliente; -- Consultando todos os campos da tabela cliente

select nome, idade from cliente where sexo = 'F'; -- Consulte os campos nome e idade da tabela cliente onde o sexo=’F’

select nome, idade from cliente where sexo = 'F' and idade >= 18 order by idade, nome; -- Consulte os campos da tabela de cliente quando o sexo=’F’ e a idade for >=18, ordenando pela idade e nome

create table vendedor(
    codigo bigint primary key auto_increment ,
    vendedor varchar(100),
    telefone varchar(30) default 'SEM TELEFONE',
	comissao decimal(10,2) default 0.05
) default charset = utf8mb4;

insert into vendedor values 
(default, "Claúdio", "9999-9999", default),
(default, "Pedro", "8888-8888", default),
(default, "Janaina", "7777-7777", default);

create table produto(
    codigo bigint primary key auto_increment,
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

select nome, valor, qtdEstoque from produto order by qtdEstoque desc; -- Consulte os campos produto, valor e quantidade em estoque da tabela produto, ordenando pela quantidade em estoque decrescente
select * from pedido;
create table pedido(
    codigo bigint primary key auto_increment,
    valorTotal  decimal(10,2),
	dataPedido  date, -- 'yyyy/mm/dd'
    codigoVendedor bigint not null,
    foreign key (codigoVendedor) references vendedor (codigo)
) default charset = utf8mb4;

insert into pedido values 
(default, 3000.00, '2021/08/31', 1),
(default, 2700.00, '2021/08/31', 3),
(default, 5700.00, '2021/08/31', 2),
(default, 1000.00, '2021/08/31', 2),
(default, 2500.00, '2021/08/31', 1),
(default, 2900.00, '2021/08/31', 1),
(default, 3999.00, '2021/08/31', 3),
(default, 1600.00, '2021/08/31', 2);

select * from pedido;

select 	v.vendedor as Vendedor, count(p.codigo) as TotalPedidos, sum(p.valorTotal) as ValorTotal, avg(p.valorTotal) as MediaPedidos 
	from pedido p, vendedor v where p.codigoVendedor = v.codigo group by codigoVendedor; -- -- Agrupe os pedidos por vendendor, mostrando o numero de pedidos, total dos pedidos e media dos pedidos.

select 	min(valorTotal) as menorPedido, max(valorTotal) as maiorPedido from pedido; -- Verifique no banco de dados o menor e o maior valor de pedido

rollback; -- cancela comandos da transação
commit; -- efetiva comandos da transação