create database ldb06_join -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use ldb06_join;

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

create table pedido(
    codigo bigint primary key auto_increment,
    valorTotal  decimal(10,2),
	dataPedido  date, -- 'yyyy/mm/dd'
    codigoCliente bigint not null,
    foreign key (codigoCliente) references cliente (codigo)
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

select * from cliente;

select * from pedido;

select p.codigo, p.valorTotal, c.nome, c.email 
	from pedido p inner join cliente c 
		on c.codigo = p.codigoCliente
			order by p.codigo;
            
select c.nome, c.email, p.codigo, p.valorTotal
	from cliente c left outer join pedido p -- trás tudo o que tiver a esquerda, inclusive quem não possuí pedido.
		on c.codigo = p.codigoCliente
			order by c.nome;
            
select c.nome, c.email, p.codigo, p.valorTotal
	from cliente c left outer join pedido p
		on c.codigo = p.codigoCliente where p.valorTotal > 100
			order by c.nome;
            
select c.nome, c.email, p.codigo
	from cliente c right outer join pedido p
		on c.codigo = p.codigoCliente
			order by c.nome;
	
select c.nome, c.email, count(p.codigo)
	from cliente c left outer join pedido p
		on c.codigo=p.codigoCliente
			group by c.nome, c.email
				order by c.nome;
            
-- para dar apelido ao campo utiliza-se o 'as'
-- para dar apelido a tabela utiliza-se from tabela p1