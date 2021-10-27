-- Nome: Mayara Pereira Dotta
-- Matrícula (RA): 2040482023049
-- Curso: ADS 204-20202 (Noite)

-- 1-Crie as tabelas com os respectivos relacionamentos
-- 2-insira ao menos 5 registros em todas as tabelas

create database ldbrec1_atividade -- Criar a base de dados
default character set utf8mb4 -- Suportar caracter especial
default collate utf8mb4_unicode_ci;

use ldbrec1_atividade;

-- 3-Mostre a media de notas das avaliações agrupado por materia
select  m.nome as NomeMateria, AVG(a.nota) as MediaAvaliações
	from avaliacao a inner join materias m 
		on m.CodigoMaterias = a.codigoMaterias
        group by m.nome
		order by AVG(a.nota) desc;

-- 4-Mostre a media de notas das avaliações agrupado por aluno
select  n.codigoAluno as CodigoALuno, n.nome as NomeAluno, AVG(a.nota) as MediaAvaliações
	from avaliacao a inner join aluno n
		on n.CodigoAluno = a.CodigoAluno
        group by n.nome
		order by AVG(a.nota) desc;

-- 5-Mostre o total de alunos agrupado por professor
select  p.nome as NomeProfessor, count(a.codigoALuno) as TotalALunos
	from avaliacao a
		inner join materias m on m.CodigoMaterias = a.codigoMaterias
        inner join professor p on p.CodigoProfessor = m.CodigoProfessor
        group by p.nome;

create table professor(
	CodigoProfessor bigint primary key auto_increment,
    nome varchar (100) not null,
    email varchar (40) not null
)default charset = utf8mb4;

insert into professor values 
(default, "Norton Silva", "norton@email.com"),
(default, "Rita de Cássia",	"rita@email.com"),
(default, "Paulo José", "paulo@email.com"),
(default, "Maria Cristina", "maria@email.com"),
(default, "Fernando Santos", "fernando@email.com");

create table curso(
	CodigoCurso bigint primary key auto_increment,
    nome varchar (100) not null
)default charset = utf8mb4;

insert into curso values 
(default, "Letras"),
(default, "Administração"),
(default, "Gestão Empresarial"),
(default, "Biotecnociência"),
(default, "Historiador");

create table materias(
	CodigoMaterias bigint primary key auto_increment,
    nome varchar (100) not null,
    descritivo varchar(200) not null, 
	codigoCurso bigint,
	CodigoProfessor bigint,
	foreign key (codigoCurso) references curso (codigoCurso), -- matéria possuí curso
	foreign key (CodigoProfessor) references professor (CodigoProfessor) -- matéria possuí professor
)default charset = utf8mb4;

insert into materias values 
(default, "Matemática", "Aritmética, álgebra, geometria, trigonometria, estatística e cálculo", 2, 1), -- Administração / Norton Silva"
(default, "Língua Portuguesa", "Interpretação de texto, literatura, gêneros textuais, linguística e gramática.", 1, 2), -- Letras / Rita de Cássia
(default, "Biologia", "Origem, a evolução, o funcionamento e a estrutura dos organismos.", 4, 3), -- Biotecnociência / Paulo José
(default, "Ética Social", "A importância da Ética na Sociedade", 3, 4), -- Gestão Empresarial / Maria Cristina
(default, "Química", "Transformações que envolvem a matéria e a energia. ", 4, 3), -- Biotecnociência / Paulo José
(default, "História", "Antropologia, História do Brasil e Direitos Humanos", 5, 5); -- Historiador / Fernando Santos

create table aluno(
	CodigoALuno bigint primary key auto_increment,
    nome varchar (100) not null,
    email varchar(40) not null, 
	idade bigint(2) not null,
	codigoCurso bigint,
    foreign key (codigoCurso) references curso (codigoCurso) -- aluno deve ter curso
)default charset = utf8mb4;

insert into aluno values 
(default, "Lorenzo Guilhermino", "lorenza@email.com", 18, 1),
(default, "Joaquim",	"joaquim@email.com", 17, 1),
(default, "Larissa", "larissa@email.com", 20, 1),
(default, "Marisa Silveira", "marisa@email.com", 19, 2),
(default, "Guilherme Rodrigues", "guilherme@email.com",25, 3),
(default, "Letícia Rodrigues", "leticia@email.com", 30, 3),
(default, "Brian Silva", "brian@email.com", 19, 3),
(default, "Lucas Santos", "lucas@email.com", 24, 4),
(default, "Luciane Santos", "luciane@email.com", 29, 4),
(default, "Luana Silva", "luana@email.com", 18, 5),
(default, "Luane Santos", "luane@email.com", 18, 5);

create table avaliacao(
	CodigoAvaliacao bigint primary key auto_increment,
    nota decimal (4,2) not null,
    dataAvaliacao timestamp,
	codigoMaterias bigint,
	codigoAluno bigint,
	foreign key (codigoMaterias) references materias (codigoMaterias), -- avaliação deve ter matéria
    foreign key (codigoAluno) references aluno (codigoAluno) -- avaliação deve ter aluno
)default charset = utf8mb4;

insert into avaliacao values 
(default, 8.0, curdate(), 2, 1),
(default, 9.0, curdate(), 2, 2),
(default, 7.0, curdate(), 2, 3),
(default, 8.0, curdate(), 1, 4),
(default, 7.0, curdate(), 4, 5),
(default, 6.0, curdate(), 4, 6),
(default, 7.0, curdate(), 4, 7),
(default, 6.0, curdate(), 3, 8),
(default, 5.0, curdate(), 3, 9),
(default, 8.0, curdate(), 5, 8),
(default, 9.0, curdate(), 5, 9),
(default, 10.0, curdate(), 6, 10),
(default, 10.0, curdate(), 6, 11);