create database lbd08_trigger-- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use lbd08_trigger;
-- Triggers
-- É uma função associada a uma tabela e uma ação dessa tabela inserção, exclusão e atualização de dados (insert, delete e update).
-- Principais motivos para uso:
	-- geração automática de valores de colunas derivados;
    -- prevenção de transações inválidas;
    -- reforçar regras de negócio complexas;
    -- prover auditoria;
    -- gerar estatísticas sobre acesso às tabelas;
    -- prover log de transações.

-- Elementos:
	-- Componentes			Descrição 		                             Valores
    -- ------------------------------------------------------------------------------------
    -- Tempo				Quando o trigger dispara em relação         - Before
    --                      ao evento de acionamento (DML).             - After
    -- ------------------------------------------------------------------------------------
    -- Evento de            Quais operações de manipulação de           - Insert 
    -- acionamento          tabela (DML) disparam a trigger.			- Update
	-- 																	- Delete
    -- ------------------------------------------------------------------------------------
	-- Abrangência da       Quantas vezes o corpo da trigger            - de linha 
    -- trigger              será executado		                        (for each wor)
	-- 																	- de instrução (*)
    -- ------------------------------------------------------------------------------------
	-- Corpo da trigger     Quais ações serão executadas (comandos)     - Bloco PL/SQL
    -- ------------------------------------------------------------------------------------
	-- ------------------------------------------------------------------------------------
 	-- DML			  :old 		          :new
	-- ------------------------------------------------------------------------------------
    -- Insert         NULO            Valores Novos
    -- Delete     Valores antigos         NULO
	-- Update	  Valores antigos     Valores Novos	
    -- ------------------------------------------------------------------------------------

-- Sintaxe
-- CREATE TRIGGER nome_da_trigger
-- ON nome_tabela
-- FOR EACH ROW
-- BEGIN
-- 		/*corpo do código*/
-- END

CREATE TABLE Produtos(
	Codigo	bigint primary key auto_increment, 
	Descricao varchar (50),
	Estoque	int default 0
) default charset = utf8mb4;

INSERT INTO Produtos VALUES (default, 'Feijão', 10);
INSERT INTO Produtos VALUES (default, 'Arroz', 5);
INSERT INTO Produtos VALUES (default, 'Farinha', 15);

create table auditlog(
	nomeTabela varchar(100),
	codigo bigint,
    dataDelete date,
    dataUpdate date
); 

-- Criando as Triggers
DELIMITER $
create trigger trd_produto after delete on Produtos 
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataDelete)
    values('Produto', old.codigo, sysdate());
end$
DELIMITER ;

DELIMITER $
create trigger tru_produto before update on Produtos 
for each row
begin
    insert into auditlog(nomeTabela, codigo, dataUpdate)
    values('Produto', old.codigo, sysdate());
end$
DELIMITER ;

delete from Produtos where Codigo = 2;
update Produtos set Descricao = 'Aveia' where codigo = 1;	

show index from Produtos; -- comando para mostrar a quantidade de indices relacionados a tabela produto.
explain select * from Produtos where Descricao = 'Aveia'; -- comando explain explica o comando seguinte, nesse caso, o select. Mostrando assim 
-- por quantas linhas (rows) percorreu até encontrar o índice.

select * from auditlog;

select * from Produtos;

-- exibe as triggers que foram criadas
SHOW TRIGGERS;

-- exclusão de uma trigger: 
DROP TRIGGER tru_produto;

