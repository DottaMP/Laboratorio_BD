-- 1-Crie as tabelas pedido e cliente e insira os valores:
-- 2-Faça o inner join entre as tabelas PEDIDO e CLIENTE, mostrando o codigo do pedido, data do pedido, nome do cliente;
-- 3-Faça o LEFT JOIN  entre as tabelas PEDIDO e CLIENTE para mostrar os pedidos que não tem cadastro de cliente;
-- 4-Faça o RIGHT JOIN  entre as tabelas PEDIDO e CLIENTE para mostrar os clientes que não tem pedido;
-- 5-Faça uma consulta do plano cartesiano das duas tabelas.

create database ldb06_atividade -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;
use ldb06_atividade;

start transaction;

create table cliente(
    codigo bigint primary key auto_increment,
	nome varchar (100) not null,
	contato varchar (100) default 'Sem Contato',
	lagradouro varchar (100) not null,
	cidade varchar (100) not null,
	cep varchar (9) not null,
	pais varchar (100) not null
)default charset = utf8mb4;

insert into cliente values
(default, "Alfreds", "Maria" , "AndersObere Str. 57", "Berlin", "12209", "Germany"),
(default, "na Julia", "Ana Julia" ,  "Av. Nazare 2222", "SP", "5021", "Brasil"),
(default, "Fred", "Fernanda" , "St Antony Str. 69", "London", "13110", "England"),
(default, "Luiz", "Julia" ,  "Av. Jose 21", "SP", "5526", "Brasil"),
(default, "Antonio Moreno", "Antonio Moreno" ,  "Rua Bom Pastor", "SP", "5023", "Brasil");

update cliente set nome = "Ana Julia" where codigo=2;

create table pedido(
    codigo bigint primary key auto_increment,
	codigoCliente bigint default null,
	codigoVendedor bigint default null,
	dataPedido  date default null, -- 'yyyy/mm/dd'
    codigoEntrega int (5),
    foreign key (codigoCliente) references cliente (codigo)
) default charset = utf8mb4;

insert into pedido values 
(default, 1, 2, '2021/09/14', 20211),
(default, default, 1, '2021/09/14', 20212),
(default, default, 1, '2021/09/14', 20213),
(default, 2, 3, '2021/09/14', 20214),
(default, default, 3, '2021/09/14', 20215),
(default, 1, 2, '2021/09/14', 20216),
(default, 3, 1, '2021/09/14', 20217),
(default, 2, 2, '2021/09/14', 20218);

select * from cliente;
select * from pedido;

-- 2-Faça o inner join entre as tabelas PEDIDO e CLIENTE, mostrando o codigo do pedido, data do pedido, nome do cliente
select p.codigo, p.dataPedido, c.nome
	from pedido p inner join cliente c 
		on c.codigo = p.codigoCliente;

-- 3-Faça o LEFT JOIN  entre as tabelas PEDIDO e CLIENTE para mostrar os pedidos que não tem cadastro de cliente
select p.codigo, c.nome
	from pedido p left outer join cliente c
		on c.codigo = p.codigoCliente
			order by p.codigo;
            
-- 4-Faça o RIGHT JOIN entre as tabelas PEDIDO e CLIENTE para mostrar os clientes que não tem pedido
select p.codigo, c.nome
	from pedido p right outer join cliente c
		on c.codigo = p.codigoCliente
			order by c.nome;
            
-- 5-Faça uma consulta do plano cartesiano das duas tabelas	
select p.*, c.*
	from pedido p, cliente c;
    
rollback; -- cancela comandos da transação
commit; -- efetiva comandos da transação