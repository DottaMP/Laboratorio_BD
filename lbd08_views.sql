create database ldb08_views-- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use ldb08_views;
-- Utiliza-se apenas para consultas. Transforma um select em uma view.

-- Exemplo:
-- create view vw_produtos as
-- select idProduto as Codigo,
--        nome as Produto,
--        Fabricante,
--        Quantidade,
--        VlUnitario as [ValorUNitario],
-- 		  Tipo
-- from Produtos

-- para consultar os dados na view:
-- select * from vw_Produtos;

-- alterar: alter view vw_produtos...
-- deletar: drop view vw_produtos

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
(default, "Mariana", "F" , md5('202021'), "mari@hotmail.com", 29, '7897-7897', "Santo André", '1'),
(default, "Valentina", "F" , md5('123896'), "val@gmail.com", 17, '5566-7788', "Guarulhos", '1');

create table pedido(
    codigoPedido bigint primary key auto_increment,
    codigoCliente bigint,
	dataPedido date,
    totalPedido decimal(10,2),
	foreign key (codigoCliente) references cliente (codigoCliente)
) default charset = utf8mb4;

insert into pedido values 
(default, 1, '2021/10/25', 2100.00),
(default, 2, '2021/10/24', 2000.00),
(default, 5, '2021/10/25', 1700.00),
(default, 1, '2021/10/23', 1726.00),
(default, 1, '2021/10/25', 3700.00),
(default, 2, '2021/10/23', 1780.00),
(default, 3, '2021/10/25', 1200.00);

-- Criando view.
create view vw_clientesPedidos as
select c.nome, c.email, c.telefone, sum(p.totalPedido) as Total,
count(p.codigo) as Qtd
from cliente c left outer join pedido p on c.codigoCliente = p.codigoCliente
group by c.nome, c.email, c.telefone;

-- serve para simplicaficar um select, sendo assim, não faz necessário realizar todo o select, basta fazer da view criada.
select * from vw_clientesPedidos