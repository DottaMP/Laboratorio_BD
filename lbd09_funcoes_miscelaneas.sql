-- script, algumas funções miscelâneas:

select * from produto where nome like 'Relogio%';
select * from produto where nome like '%or%';

select * from produto where  valor between 150 and 1500;

select * from pedido where dataPedido between 
'2021-09-01' and '2021-09-30';

select * from cliente where nome in ('Ana','ed');

select * from cliente where codigo not in (select codigocliente from pedido);
select * from cliente where codigo  in (select codigocliente from pedido);

select * from vendedor where exists (select codigo from pedido where
valortotal>20 and vendedor.codigo=pedido.codigovendedor);

select * from vendedor;

select trim('Rua xpto,34                            ') from dual;

select upper(nome), lower(nome) from vendedor;

select concat(codigo, ';', nome, ';', cidade) from vendedor;

select curdate() ;
SELECT DATE_ADD(curdate(), INTERVAL 11 month);
SELECT DATE_ADD(curdate(), INTERVAL 7 DAY);
