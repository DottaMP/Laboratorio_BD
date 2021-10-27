-- 1-Crie um index na tabela produto(nome)
-- 2-Crie um index na tabela cliente(nome,email)
-- 3-Crie uma trigger na tabela pedido, cliente, produto para o evento
-- DELETE e UPDATE que guarde na tabela AUDITLOG os dados removidos ou alterados
-- 4- crie uma view chamada vw_comissaoVendedor que calcule a comissao dos vendedores de acordo com 
-- o valor total dos pedidos feitos, mostre o codigo do vendedor, nome vendedor, valorComissao.

create database ldb08_atividade
default character set utf8mb4 
default collate utf8mb4_unicode_ci;

use ldb08_atividade;

create table produto(
    codigo bigint primary key auto_increment, -- o campo código por ser uma pk também é um index.
    nome varchar(100),
	valor decimal(10,2) default 0.01,
    qtdEstoque int default 0
) default charset = utf8mb4;

insert into produto values 
(default, 'TV Samsung', 3100.00, 9),
(default, 'X-Box One Series X', 3700.00, 11),
(default, 'Cama Box Queen', 3100.00, 5),
(default, 'Laptop Acer', 4900.00, 2),
(default, 'Celular Xiaomi', 1700.00, 9),
(default, 'Celular LG', 1100.00, 10),
(default, 'TV LG', 3700.00, 7);

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

create table vendedor(
    codigoVendedor bigint primary key auto_increment,
	nome varchar (100) not null,
    telefone varchar (30) default 'Sem Telefone',
	comissao decimal(10,2) default 0.05
)default charset = utf8mb4;

insert into vendedor values
(default, "Erick José", "9988-0000", 0.01),
(default, "Joelma Fernandes", "97654-9111", 0.01),
(default, "Marge Santos", "9988-1111", 0.01),
(default, "Joel Fagundes", "97654-0000", 0.01),
(default, "Giovane José", "97198-4321", 0.01);

create table pedido(
    codigo bigint primary key auto_increment,
	codigoVendedor bigint,
    codigoCliente bigint,
	dataPedido date,
    totalPedido decimal(10,2),
	foreign key (codigoCliente) references cliente (codigoCliente),
	foreign key (codigoVendedor) references vendedor (codigoVendedor)
) default charset = utf8mb4;

insert into pedido values 
(default, 1, 2, '2021/10/25', 2100.00),
(default, 2, 2, '2021/10/24', 2000.00),
(default, 5, 4, '2021/10/25', 1700.00),
(default, 1, 5, '2021/10/23', 1726.00),
(default, 1, 1, '2021/10/25', 3700.00),
(default, 2, 2, '2021/10/23', 1780.00),
(default, 3, 4, '2021/10/25', 1200.00);

create table auditlog(
	nomeTabela varchar(100),
	codigo bigint,
    dataDelete date,
    dataUpdate date
);
select * from auditlog;
-- 1-Crie um index na tabela produto(nome)
create index idx_produto_nome on produto (nome); -- criando o index idx_produto_nome da tabela produto para o campo nome.
-- para pesquisar
select * from produto where nome like '%TV%';
show index from produto; 

-- 2-Crie um index na tabela cliente(nome,email)
create index idx_cliente_nome on cliente (nome, email); -- criando o index idx_cliente_nome da tabela pcliente para o campo nome e email.
-- para pesquisar
select * from cliente where nome like '%Jo%' and email like '%jo%';
show index from cliente;

-- 3-Crie uma trigger na tabela pedido, cliente, produto para o evento
-- DELETE e UPDATE que guarde na tabela AUDITLOG os dados removidos ou alterados
DELIMITER $
create trigger trg_pedido_delete after delete on pedido
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataDelete)
    values('pedido', old.codigo, sysdate());
END $

DELIMITER $
create trigger trg_pedido_update after update on pedido
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataUpdate)
    values('pedido', old.codigo, sysdate());
END $

DELIMITER $
create trigger trg_cliente_delete after delete on cliente
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataDelete)
    values('cliente', old.codigoCliente, sysdate());
END $

DELIMITER $
create trigger trg_cliente_update after update on cliente
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataUpdate)
    values('cliente', old.codigoCliente, sysdate());
END$

DELIMITER $
create trigger trg_produto_delete after delete on produto
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataDelete)
    values('produto', old.codigo, sysdate());
END$

DELIMITER $
create trigger trg_produto_update after update on produto
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataUpdate)
    values('produto', old.codigo, sysdate());
END$

delete from pedido where codigo = 2;
delete from cliente where codigoCliente = 5;
delete from produto where codigo = 4;

update pedido set dataPedido = '2021/10/25' where codigo = 4;
update produto set nome = 'TV LG' where codigo = 1;	
update produto set nome = 'X-Box One Series S' where codigo = 2;	

select * from auditlog;

select * from pedido;
select * from cliente;
select * from produto;

/* 4- crie uma view chamada vw_comissaoVendedor que calcule a comissao dos
vendedores de acordo com o valor total dos pedidos feitos, mostre o codigo
do vendedor, nome vendedor, valorComissao*/
create view vw_comissaoVendedor as
select v.codigoVendedor as codigo, v.nome, sum(p.totalPedido) as somaValorDosPedidos, 
sum(p.totalPedido*v.comissao) as comissao, count(*) as totalDePedidos
from vendedor v
left outer join pedido p on v.codigoVendedor = p.codigoVendedor
group by v.nome
order by v.codigoVendedor;

-- outro jeito

create or replace  view vw_comissaoVendedor as
select v.codigo, v.nome,v.comissao * sum(nvl(valortotal,0)) as valorComissao
from vendedor v left outer join 
pedido p on v.codigo=p.codigovendedor group by v.codigo, v.nome, v.comissao;

select * from vw_comissaoVendedor;