-- 1-Criar todas as tabelas das entidades propostas no mer, adicionando as PKs e FKs e valores DEFAULT
-- 2-Insira ao menos 5 registros para cada tabela criada, respeitando os relacionamentos

create database lbdp1_atividade -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use lbdp1_atividade;

start transaction;

-- 3-Extraia a informação de quantos pedidos os clientes fizeram, a soma dos pedidos e o valor medio gasto, caso o 
-- cliente ainda não tenha feito nenhum pedido, mostre estes campos de sumarização zerados.
select c.nome as nomeCliente, sum(p.total) as somaDosPedidos, 
avg(p.total) as valorMedioGasto -- if(p.total is not null, avg(p.total), 0.0) as ValorMedioGasto
	from cliente c
		left outer join pedido p on c.codigoCliente = p.codigoCliente
			group by c.nome;

-- 4-Extraia o total dos pedidos entregues, e a comissao calculada (comissão x total de pedidos) dos entregadores
select e.nome as nomeEntregador, sum(p.total) as somaDosPedidos, 
sum(p.total*e.comissao) as comissao, count(*) as TotalEntregas
	from entregador e
		left outer join pedido p on e.codigoEntregador = p.codigoEntregador
			group by e.nome;

-- 5-Exiba quais produtos são mais vendidos
select p.nome as NomeProduto, count(i.qtd) as MaisVendidos
	from produto p 
		inner join item i on p.CodigoProduto = i.CodigoProduto 
			group by p.nome
            order by MaisVendidos desc;

 -- 6-Exiba quais ingredientes são mais utilizados nos pedidos, mostrando o total utilizado nos pedidos e o valor gasto
select i.nome as NomeIngrediente, count(it.qtd) as MaisVendidos, sum(i.valor*it.qtd) as valorGasto
	from produto p 
		inner join item it on p.CodigoProduto = it.CodigoProduto 
        inner join ingredienteProduto ip on ip.CodigoProduto = p.CodigoProduto 
		inner join ingrediente i on i.CodigoIngrediente = ip.CodigoIngrediente 
			group by i.nome
		union -- unindo com a tabela do ingrediente extra
        select i.nome as NomeIngrediente, count(*) as MaisVendidos, sum(i.valor) as valorGasto
		from ingredientePizza ip
			inner join ingrediente i on ip.CodigoIngrediente = i.CodigoIngrediente 
            group by i.nome
            order by MaisVendidos desc;

create table cliente(
    codigoCliente bigint primary key auto_increment,
	nome varchar (100) not null,
	endereco varchar (100) not null,
    telefone varchar (30) default 'Sem Telefone'
)default charset = utf8mb4;

insert into cliente values
(default, "Alfredo Santos", "Av Otavio Braga, 543. Centro. Guarulhos-SP", "99987-4256"),
(default, "Maria Aparecida", "Rua tres, 21. Jd Cumbica. Guarulhos-SP", "97766-6644"),
(default, "Julio SIlva", "Rua Jose da Silva, 28. Bom Sucesso. Guarulhos-SP", "99876-1122"),
(default, "Juliana Pereira", "Av Pedro de Souza, 07. Praça 8. Guarulhos-SP", default),
(default, "Juliana Rodrigues", "Rua Jose da Silva, 67. Bom Sucesso. Guarulhos-SP", "2222-1111"),
(default, "Fernanda Silva", "Av dos Cardosos, 66. Centro. Guarulhos-SP", "98765-4523"),
(default, "Fernando", "Av Otavio Braga, 1000. Centro. Guarulhos-SP", "99101-0000");

create table entregador(
    codigoEntregador bigint primary key auto_increment,
	nome varchar (100) not null,
    telefone varchar (30) default 'Sem Telefone',
	comissao decimal(10,2) default 0.05
)default charset = utf8mb4;

insert into entregador values
(default, "Erick José", "9988-0000", 0.01),
(default, "Joelma Fernandes", "97654-9111", 0.01),
(default, "Marge Santos", "9988-1111", 0.01),
(default, "Joel Fagundes", "97654-0000", 0.01),
(default, "Giovane José", "97198-4321", 0.01);

create table ingrediente(
    codigoIngrediente bigint primary key auto_increment,
    nome varchar(100),
	peso decimal(10,3) default 0.01,
	valor decimal(10,3) default 0.01
) default charset = utf8mb4;

insert into ingrediente values 
(default, 'mussarela',0.100,5),
(default, 'massa',0.100,7),
(default, 'molho',0.100,3),
(default, 'presunto',0.100,5),
(default, 'tomate',0.100,2),
(default, 'bacon',0.050,2);

create table pedido(
    codigoPedido bigint primary key auto_increment,
	data timestamp,
    total decimal(10,2),
    status int, -- 1-feito, 2-entregue, 3-cancelado ok
	codigoCliente bigint,
    codigoEntregador bigint,
	foreign key (codigoCliente) references cliente (codigoCliente),
	foreign key (codigoEntregador) references entregador (codigoEntregador)
) default charset = utf8mb4;

insert into pedido values 
(default, current_date(), 100, 1, 2, 3), -- 1-feito
(default, current_date(), 50, 2, 1, 2), -- 2-entregue
(default, current_date(), 80, 3, 4, 1), -- -cancelado
(default, current_date(), 100, 1, 3, 1), -- 1-feito
(default, current_date(), 50, 2, 6, 3), -- 2-entregue
(default, current_date(), 70, 2, 5, 3), -- 2-entregue
(default, current_date(), 100, 2, 2, 2), -- 2-entregue
(default, current_date(), 50, 1, 1, 2), -- 1-feito
(default, current_date(), 70, 2, 5, 2), -- 2-entregue
(default, current_date(), 100, 2, 6, 1), -- 2-entregue
(default, current_date(), 60, 1, 2, 3), -- 1-feito
(default, current_date(), 90, 2, 2, 2); -- 2-entregue


create table produto(
    codigoProduto bigint primary key auto_increment,
    nome varchar(100),
	valor decimal(10,2) default 0.01
) default charset = utf8mb4;

insert into produto values 
(default, 'Pizza Mussarela', 30),
(default, 'Pizza Bauru', 30),
(default, 'Cerveja', 5),
(default, 'Refrigerante', 6);

create table ingredienteProduto(
	codigoProduto bigint,
    codigoIngrediente bigint
) default charset = utf8mb4;

insert into ingredienteProduto values
-- O produto 1.Pizza Mussarela possuí os ingredientes 1.mussarela, 2.massa, 3.molho, 5.tomate
(1, 1),
(1, 2),
(1, 3),
(1, 5),
-- O produto 2.Pizza Bauru possuí os ingredientes 1.mussarela, 2.massa, 3.molho, 4.presunto, 5.tomate
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5);

create table item(
    codigoItem bigint primary key auto_increment,
    qtd int not null,
	valorUnitario decimal(10,2) not null,
	valorTotal decimal(10,2) not null,
	codigoPedido bigint,
	codigoProduto bigint,
	foreign key (codigoPedido) references pedido (codigoPedido),
	foreign key (codigoProduto) references produto (codigoProduto)
) default charset = utf8mb4;

insert into item values 
-- pedido 1 comprou 2 produtos 1 e 3
(default, 1, 30, 30, 1, 1),
(default, 2, 5, 10, 1, 3),
-- pedido 2 comprou 2 produtos 1 e 4
(default, 1, 30, 30, 2, 1),
(default, 1, 6, 6, 2, 4),
-- demais pedidos compras simples com 1 produto apenas e qtds diversas
(default, 1, 30, 30, 3, 1),
(default, 2, 6, 12, 4, 2),
(default, 1, 30, 30, 5, 1),
(default, 1, 30, 30, 6, 2),
(default, 3, 5, 15, 7, 3),
(default, 1, 6, 6, 8, 4),
(default, 1, 30, 30, 9, 1),
(default, 1, 30, 30, 10, 1),
(default, 1, 30, 30, 11, 2),
(default, 4, 5, 20, 12, 3);

-- tabela para extra
create table ingredientePizza(
    codigoItem bigint,
    codigoIngrediente bigint,
	valorExtra decimal(10,2)
) default charset = utf8mb4;

-- o Item 7 add ingrediente 6 (Bacon) no valor de 2 reais.
insert into ingredientePizza values (7, 6, 2);

