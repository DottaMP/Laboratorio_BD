create database lbdp2
default character set utf8mb4 
default collate utf8mb4_unicode_ci;
use lbdp2;

-- 1-Crie as tabelas no banco de dados relacional e insira registros em todas as tabelas (2,0)

-- Cria tabela PACIENTE
create table PACIENTE(
    codigoPaciente bigint primary key auto_increment,
	nome varchar (100) not null,
    telefone varchar (30) default 'Sem Telefone',
    genero varchar (1) not null,
	idade int (2) not null  -- M ou F
)default charset = utf8mb4;
-- Inserinado dados na tabela PACIENTE
insert into PACIENTE values
(default, "Alfredo Santos", "99987-4256", "M", 42),
(default, "Maria Aparecida", "97766-6644", "F", 53),
(default, "Julio Silva", "99876-1122", "M", 36),
(default, "Juliana Pereira", default, "F", 17),
(default, "Juliana Rodrigues", "2222-1111", "F", 27),
(default, "Fernanda Silva", "98765-4523", "F", 31),
(default, "Fernando", "99101-0000", "M", 29);        
-- Confere como ficou tabela
SELECT * FROM PACIENTE;

-- Cria tabela MEDICO
create table MEDICO(
    codigoMedico bigint primary key auto_increment,
	nome varchar (100) not null,
    telefone varchar (30) default 'Sem Telefone',
    crm int (10) not null,
	especialidade varchar (30) not null
)default charset = utf8mb4;
-- Inserinado dados na tabela MEDICO
insert into MEDICO values
(default, "José Helbert", "92288-1156", 1212, "Clínico Geral"),
(default, "Paola Fernandes", "97000-0000", 1314, "Ginecologista"),
(default, "Julius Aparecido", "79000-1234", 1516, "Oftalmologia"),
(default, "Marcia Pereira", "67788-9900", 1919, "Pediatria"),
(default, "Juliane Rosa", "91100-0011", 2123, "Ortopedia");      
-- Confere como ficou tabela
SELECT * FROM MEDICO;

-- Cria tabela CONSULTA
create table CONSULTA(
    codigoConsulta bigint primary key auto_increment,
	dataConsulta date,
    historico varchar (100),
    status int, -- 1-agendado, 2-realizado, 3-cancelado
	codigoMedico bigint,
    codigoPaciente bigint,
	foreign key (codigoMedico) references medico (codigoMedico),
	foreign key (codigoPaciente) references paciente (codigoPaciente)
) default charset = utf8mb4;
-- Inserinado dados na tabela CONSULTA
insert into CONSULTA values 
(default, '2021/06/14', "Consulta de Rotina", 1, 1,3),  -- Clínico Geral - Pac: Julio SIlva
(default, '2021/04/25', "Retorno Exame", 2, 1, 2), -- Clínico Geral - Pac: Maria Aparecida
(default, '2021/06/18', "Gravidez", 1, 2, 5), -- Ginecologista, - Pac: Juliana Rodrigues
(default, '2021/05/12', "Gravidez", 1, 2, 6), -- Ginecologista, - Pac: Fernanda Silva
(default, '2021/06/18', "Consulta de Rotina", 2, 3, 7), -- Oftalmologia, - Pac: "Fernando", 
(default, '2021/05/21', "Hernia de Disco", 1, 5, 1), -- Ortopedia, - Pac: Alfredo Santos
(default, '2021/07/02', "Consulta de Rotina", 1, 4, 4); -- Pediatria, - Pac: Juliana Pereira
-- Confere como ficou tabela
SELECT * FROM CONSULTA;

-- Cria tabela RECEITA
create table RECEITA(
    codigoReceita bigint primary key auto_increment,
	data timestamp,
    descritivo varchar (100),
    codigoConsulta bigint,
	foreign key (codigoConsulta) references CONSULTA (codigoConsulta)
) default charset = utf8mb4;
-- Inserinado dados na tabela RECEITA
insert into RECEITA values 
-- a data da receita terá validade de 30 dias a partir da data da consulta.
(default, '2021/07/14', "1cx de Cefaliv - Tomar 1cp quando sentir dor - de 6 em 6h", 1),
(default, '2021/05/25', "1cx de Omeprazol - Tomar 1cp de 12 em 12h", 2),
(default, '2021/07/18', "Suplemento Vitâminico até o fim da gravidez - tomar 1cp junto ao café da manhã", 3),
(default, '2021/06/12', "Paracetamol quando sentir dor - tomar de 4 em 4h", 4),
(default, '2021/07/18', "Pingar colírio quando sentir os olhos secos e levar com shampoo neutro johnson", 5),
(default, '2021/06/21', "2cx Prednisona - Tomar de 6 em 6h", 6),
(default, '2021/08/02', "Tomar Suplementação de vitamína B12 por 3 meses", 7);
-- Confere como ficou tabela
SELECT * FROM RECEITA;

-- 2-Crie um Índice na tabela paciente, utilizando o campo nome (0,5)
CREATE INDEX idx_paciente_nome on PACIENTE (nome);
-- Confere como ficou o INDEX
show index from PACIENTE; 

-- 3-Crie um Índice na tabela consulta, utilizando o campo data (0,5)
CREATE INDEX idx_consulta_data on CONSULTA (dataConsulta);
-- Confere como ficou o INDEX
show index from CONSULTA; 

-- 4-Utilizando o operador BETWEEN mostre todas as consultas do dia 14/06/2021 ate 19/06/2021 (0,5)
select c.codigoConsulta as codigoConsulta, c.dataConsulta as dataConsulta from CONSULTA c where dataConsulta between 
'2021-06-14' and '2021-06-19';

-- 5-Utilizando o operador LIKE liste todos os pacientes que tenham o sobrenome SILVA (0,5)
SELECT * FROM PACIENTE WHERE nome LIKE '%Silva%';

-- 6-Crie uma view com os dados das CONSULTAS agendadas trazendo os dados dos pacientes e dos médicos (1,0)
create view vw_dadosConsultas as
select c.codigoConsulta, c.dataConsulta, c.historico as historicoConsulta, m.codigoMedico, m.nome as nomeMedico, m.telefone as telefoneMedico,
m.crm as crmMedico, m.especialidade as especialidadeMedico, p.codigoPaciente, p.nome as nomePaciente, p.telefone as telefonePaciente,
p.genero as generoPaciente, p.idade as idadePaciente
from CONSULTA c
left outer join MEDICO m on c.codigoMedico = m.codigoMedico
left outer join PACIENTE p on c.codigoPaciente = p.codigoPaciente
group by c.dataConsulta;

-- Confere como ficou a view
select * from vw_dadosConsultas
