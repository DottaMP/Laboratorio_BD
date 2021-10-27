/*1-Utilizando a tabela pedido liste o valor quando a data do
pedido estiver entre 01/03/2021 e 31/03/2021 use o operador BETWEEN
2-Liste todos os registros da tabela cliente que contiver a letra A
no nome use o operador LIKE
3-Liste todos os clientes cuja a cidade for SÃO PAULO, CAMPINAS use o operador IN
4-liste todos os clientes que ainda nao fizeram pedidos use o operador NOT IN
5-Liste todos os clientes com a idade entre 18 e 30 anos use o operador BETWEEN
6-utilizando o campo DataPedido da tabela Pedido some 7 dias para simular a data de entrega do mesmo*/

create database ldb09_atividade
default character set utf8mb4 
default collate utf8mb4_unicode_ci;

use ldb09_atividade;

create table cliente(
    codigoCliente bigint primary key auto_increment, -- o campo código por ser uma pk também é um index.
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
(default, "Afonso", "M" , md5('765412'), "afonso@gmail.com", 39, '9999-1111', "Campinas", '1'),
(default, "Fernanda", "F" , md5('578961'), "fe@hotmail.com", 27, '9696-9696', "São Paulo", '1'),
(default, "Mariana", "F" , md5('202021'), "mari@hotmail.com", 29, '7897-7897', "Santo André", '1'),
(default, "Valentina", "F" , md5('123896'), "val@gmail.com", 18, '5566-7788', "Guarulhos", '1');

create table pedido(
    codigo bigint primary key auto_increment,
    codigoCliente bigint,
	dataPedido date,
    totalPedido decimal(10,2),
	foreign key (codigoCliente) references cliente (codigoCliente)
) default charset = utf8mb4;

insert into pedido values 
(default, 1, '2021/03/25', 2100.00),
(default, 2, '2021/10/24', 2000.00),
(default, 5, '2021/10/25', 1700.00),
(default, 4, '2021/03/23', 1726.00),
(default, 6, '2021/10/25', 3700.00),
(default, 2, '2021/10/23', 1780.00),
(default, 3, '2021/03/25', 1200.00);

/*Utilizando a tabela pedido liste o valor quando a data do
pedido estiver entre 01/03/2021 e 31/03/2021 use o operador BETWEEN*/
select p.totalPedido as valorPedido, p.dataPedido as dataPedido from pedido p where dataPedido between 
'2021-03-01' and '2021-03-31';

/*Liste todos os registros da tabela cliente que contiver a letra A
no nome use o operador LIKE*/
select * from cliente where nome like '%a%';

/*Liste todos os clientes cuja a cidade for SÃO PAULO, CAMPINAS use o operador IN*/
select * from cliente where cidade in ('São Paulo','Campinas');

/*Liste todos os clientes que ainda nao fizeram pedidos use o operador NOT IN*/
select * from cliente where codigoCliente not in (select codigocliente from pedido);

/*Liste todos os clientes com a idade entre 18 e 30 anos use o operador BETWEEN*/
select * from cliente c where idade between 
'18' and '30' order by c.idade;

/*Utilizando o campo DataPedido da tabela Pedido some 7 dias para simular a data de entrega do mesmo*/
-- Considerando a data atual (hoje)
select DATE_ADD(curdate(), INTERVAL 7 DAY) as dataEntrega from pedido;

-- Considerando a data do Pedido.
select dataPedido as dataPedido, ADDDATE(dataPedido, INTERVAL 7 DAY) as dataEntrega from pedido;
