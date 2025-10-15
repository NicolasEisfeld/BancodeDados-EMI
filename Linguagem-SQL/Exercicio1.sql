/*Exercício Imobiliária*/
/*Nicolas Eisfeld 2 INFO*/

CREATE DATABASE Imobiliaria; /*Cria o Banco de Dados*/


USE Imobiliaria; /*Acessa o Banco de Dados*/

CREATE TABLE Cidade (
    id_cidade INT PRIMARY KEY NOT NULL AUTO_INCREMENT, /*Chave Primária da Tabela*/
    nome_cidade VARCHAR(50) NOT NULL, /*O Not Null serve para tornar um campo obrigatório*/
    uf VARCHAR(2) NOT NULL
);


CREATE TABLE Imovel ( /*Cria a tabela imóvel dentro do Banco de Dados*/
    id_imovel INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    desc_imovel VARCHAR(250) NOT NULL,
    endereco_imovel VARCHAR(150) NOT NULL,
	id_cidade INT NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade), /*Conecta o atributo id_cidade da tabela imóvel com o id_cidade da tabela cidade, ou seja, uma chave estrangeira*/
    cep INT NOT NULL,
    tipo_imovel VARCHAR(50) NOT NULL, 
    situacao_imovel VARCHAR(50) NOT NULL
);


CREATE TABLE Proprietario (
    id_proprietario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_imovel INT,
    FOREIGN KEY(id_imovel) REFERENCES Imovel(id_imovel),
    percent_propriedade INT
);

CREATE TABLE Pessoa (
    id_pessoa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome_pessoa VARCHAR(45) NOT NULL,
    endereco_pessoa VARCHAR(250) NOT NULL,
    id_cidade INT,
    FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade),
    cep INT,
    tipo_pessoa VARCHAR(8),
    telefone BIGINT,
    cpf_pessoa_pessoa VARCHAR(11) NOT NULL
);


ALTER TABlE Pessoa
CHANGE Column id_cidade id_cidade BIGINT NOT NULL AUTO_INCREMENT,
ADD CONSTRAINT fk_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade); 

CREATE TABLE Contrato (
	id_contrato INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_imovel INT NOT NULL,
    CONSTRAINT Imovel_id_imovel_fk
    FOREIGN KEY (id_imovel) REFERENCES Imovel(id_imovel),
    data_contrato DATE NOT NULL,
    valor_aluguel DOUBLE NOT NULL,
    dia_vencimento DATE NOT NULL,
    periodo_aluguel INT

);

DROP TABLE Contrato;

ALTER TABLE contrato ENGINE=InnoDB;

CREATE TABLE Contrato(
	id_contrato INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_imovel INT NOT NULL,
    CONSTRAINT imovel_idimovel_fk
    FOREIGN KEY (id_imovel) REFERENCES Imovel(id_imovel),
    
    id_inquilino INT NOT NULL,
    CONSTRAINT pessoas_idinquilino_fk
    FOREIGN KEY (id_inquilino) REFERENCES Pessoa(id_pessoa),
    
	id_fiador INT NOT NULL,
    CONSTRAINT pessoas_idfiador_fk
    FOREIGN KEY (id_fiador) REFERENCES Pessoa(id_pessoa),
    
    data_contrato DATE NOT NULL,
    valor_aluguel DOUBLE NOT NULL,
    dia_vencimento INT (2) NOT NULL ,
    periodo_aluguel INT(2)
) ;

CREATE TABLE Recebimento_Aluguel (
	id_contrato INT NOT NULL,
    FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato),
    data_recebimento DATE PRIMARY KEY NOT NULL AUTO_INCREMENT,
    valor_recebimento DOUBLE NOT NULL,
    juros_recebimento DOUBLE NOT NULL,
    multas_recebimento DOUBLE
);

CREATE TABLE Pagamento_Proprietario (
	id_contrato INT NOT NULL,
    FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato),
    id_proprietario INT NOT NULL,
    FOREIGN KEY (id_proprietario) REFERENCES Proprietario(id_proprietario),
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (data_pagamento) REFERENCES Recebimento_Aluguel(data_recebimento),
    valor_pagamento DOUBLE NOT NULL
);

INSERT INTO Cidade (nome_cidade, uf) VALUES /*Adiciona os dados de cidades da região*/
('Erechim', 'RS'),
('Getúlio Vargas', 'RS'),
('Estação', 'RS'),
('Ipiranga do Sul', 'RS'),
('Aratiba', 'RS'),
('Três Arroios', 'RS'),
('Barão de Cotegipe', 'RS'),
('Ponte Preta', 'RS'),
('Áurea', 'RS'),
('Paulo Bento', 'RS'),
('Itatiba do Sul', 'RS'),
('Quatro Irmãos', 'RS');

SELECT * from Cidade;

SELECT * from Pessoa; /*Seleciona todos os dados da tabela de dados para visualizar*/

INSERT INTO Pessoa (nome_pessoa, endereco_pessoa, id_cidade, cep, tipo_pessoa, telefone) values
('André Maciag', 'Rua João II, 360', 1, 76859049, 'Física', 54924035461), 
('Matheus de Vargas', 'Papa Leão IX', 3, 99930000, 'Júridica', 2024309271), 
('Nicolas Eisfeld', 'Av. Comandante Kraemer', 1, 99701690, 'Física', 54992230442), 
('Phelipe Schmidt', 'Rua Atlanta 2066', 6, 53315845, 'Física', 54934025197), 
('Eloísa Bolís', 'Rua João II, 360', 1, 96326078, 'Jurídica', 54914055429);

SELECT * from Imovel;

ALTER TABLE Imovel ADD Column Cor Varchar(10) AFTER tipo_imovel;

INSERT INTO Imovel(desc_imovel, endereco_imovel, id_cidade, cep, tipo_imovel, situacao_imovel) values
('Mansão com 5 quartos e 2 suítes, 3 banheiros e 7 cozinhas com espaço ao ar livre', 'Rua Matheus Pinto de Souza, 23456', 8, 99560734, 'mansão','não-alugado'),
('Casa Rústica na Avenida, com dois quartos e um banheiro ao ar livre', 'Av. Zacaria de Freitas, 993', 1, 99462791, 'casa','alugado'),
('Apartamento Coberdura do Edíficio Guarujá, Duplex com 4 quartos e 3 banheiros', 'Av. São Paulo, 1001', 2, 91468027, 'apartamento','não-alugado');

ALTER TABLE Pessoa add Column cpf_pessoa Varchar(11) Not Null; /* Adicionando o atributo cpf_pessoa em uma tabela já existente*/

INSERT INTO Pessoa(nome_pessoa, endereco_pessoa, id_cidade, cep, tipo_pessoa, telefone, cpf_pessoa_pessoa) values
('Maria Paula Brock', 'Av. 5 de Maio - 923', 1, 96291071, 'Física', 54924812431, 07518492834);

UPDATE Imovel set Cor='Azul' where tipo_imovel='casa';
UPDATE Imovel set Cor='Cinza' where tipo_imovel='apartamento';
UPDATE Imovel set Cor='Marrom' where tipo_imovel='mansão';

UPDATE Pessoa set cpf_pessoa=03527392450 where nome_pessoa='André Maciag';
UPDATE Pessoa set cpf_pessoa=02325121463 where nome_pessoa='Matheus de Vargas ';
UPDATE Pessoa set cpf_pessoa=01923497412 where nome_pessoa='Phelipe Schmidt';
UPDATE Pessoa set cpf_pessoa=12354813171 where nome_pessoa='Eloísa Bolís';
UPDATE Pessoa set id_cidade=30 where id_cidade=1;

ALTER Table Cidade
Change Column id_cidade id_cidade BIGINT NOT NULL AUTO_INCREMENT;

ALTER TABLE Pessoa -- Altera o tipo de dado
Change Column id_cidade id_cidade BIGINT NOT NULL,
ADD CONSTRAINT Cidade_idcidade_fk -- Usa a Chave Estrangeira
FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade);

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'Pessoa';


ALTER TABLE pessoa
ADD CONSTRAINT cidade_idcidade_fk
FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade);

INSERT INTO Contrato (
    id_contrato, id_imovel, id_inquilino, id_fiador, data_contrato,
    valor_aluguel, dia_vencimento, periodo_aluguel
)
VALUES
(1, 1, 2, 3, '2025-01-10', 1200, 5, 12),
(2, 1, 2, 3, '2025-01-10', 1200, 5, 12),
(3, 2, 4, 5, '2025-02-15', 950, 10, 24),
(4, 3, 6, 7, '2025-03-01', 1100, 8, 18),
(5, 4, 8, 9, '2025-03-25', 1350, 15, 36),
(6, 5, 10, 11, '2025-04-05', 1000, 12, 6),
(7, 6, 12, 13, '2025-04-20', 1150, 7, 24),
(8, 7, 14, 15, '2025-05-10', 980, 9, 12),
(9, 8, 16, 17, '2025-05-22', 1250, 3, 30),
(10, 9, 18, 19, '2025-06-01', 890, 6, 18),
(11, 10, 20, 21, '2025-06-15', 1050, 11, 24);




SELECT * from Cidade;
SELECT * from Imovel;
SELECT * from Contrato;
SELECT * f'rom Pessoa;


DROP TABLE Pessoa;

INSERT INTO Pessoa (
    nome_pessoa, endereco_pessoa, id_cidade, cep,
    tipo_pessoa, telefone, cpf_pessoa
)
VALUES
('Ana Souza', 'Rua das Acácias, 123', 1, 99010000, 'inquilino', 54991234567, '12345678901'),
('Carlos Lima', 'Av. Brasil, 456', 2, 99020000, 'fiador', 54991335678, '23456789012'),
('Mariana Dias', 'Rua Bela Vista, 789', 3, 99030000, 'inquilino', 54991446789, '34567890123'),
('Eduardo Gomes', 'Travessa Central, 321', 4, 99040000, 'fiador', 54991557890, '45678901234'),
('Luciana Alves', 'Rua das Palmeiras, 654', 5, 99050000, 'inquilino', 54991668901, '56789012345');

INSERT INTO Imovel (
    desc_imovel, endereco_imovel, id_cidade, cep, tipo_imovel, situacao_imovel
)
VALUES
('Chalé de madeira com lareira e vista para o vale, 2 quartos e 1 banheiro', 'Rua das Araucárias, 456', 3, 99778001, 'chalé', 'alugado'),
('Sítio com lago, casa principal com 3 quartos e área de lazer com churrasqueira', 'Estrada Linha Boa Esperança, km 12', 4, 99882003, 'sítio', 'não-alugado'),
('Kitnet moderna no centro, ideal para estudantes, 1 quarto e cozinha integrada', 'Rua Julio de Castilhos, 88', 1, 99015123, 'kitnet', 'alugado'),
('Cobertura com 3 suítes, hidromassagem e varanda gourmet', 'Rua Dom Pedro II, 200', 2, 91469033, 'apartamento', 'não-alugado'),
('Sobrado com garagem para 2 carros, 3 quartos e escritório', 'Rua Itália, 321', 5, 99645000, 'sobrado', 'não-alugado'),
('Casa geminada com 2 quartos, sala ampla e quintal nos fundos', 'Rua Campinas, 109', 6, 99348012, 'casa', 'alugado'),
('Prédio comercial com 3 andares e estacionamento próprio', 'Av. XV de Novembro, 500', 7, 99234056, 'comercial', 'não-alugado');


SELECT * FROM Imovel
WHERE id_cidade NOT IN (1, 2, 3);
SELECT * FROM Contrato
WHERE id_imovel NOT IN (1, 2, 3);
SELECT * FROM Pessoa
WHERE tipo_pessoa NOT IN ('jurídica');


SELECT * FROM Cidade
WHERE nome_cidade IN ('Erechim', 'Estação', 'Áurea');
SELECT * FROM Pessoa
WHERE id_pessoa IN (1, 2, 3, 4);
SELECT * FROM Imovel
WHERE situacao_imovel IN ('alugado', 'não-alugado');


SELECT * FROM Contrato
WHERE valor_aluguel BETWEEN 1000 AND 1300;
SELECT * FROM Pessoa
WHERE cep BETWEEN 99000000 AND 99500000;
SELECT * FROM Contrato
WHERE dia_vencimento BETWEEN 5 AND 15;


SELECT * FROM Imovel
WHERE (tipo_imovel = 'casa' OR tipo_imovel = 'sobrado')
AND situacao_imovel = 'não-alugado';
SELECT * FROM Pessoa
WHERE tipo_pessoa = 'física'
AND telefone LIKE '54%';
SELECT * FROM Contrato
WHERE valor_aluguel > 1000
OR dia_vencimento < 10;

SELECT * FROM Pessoa
WHERE nome_pessoa LIKE 'M%';
SELECT * FROM Imovel
WHERE desc_imovel LIKE '%cobertura%';
SELECT * FROM Pessoa
WHERE nomew_pessoa NOT LIKE '%a';


INSERT INTO Pessoa (
    nome_pessoa, endereco_pessoa, id_cidade, cep, tipo_pessoa, telefone, cpf_pessoa
) VALUES
('Carla Fernandes', 'Rua das Palmeiras, 230', 3, 99745321, 'fisica', 54981451234, '01834567290'),
('Rafael Souza', 'Av. Brasil, 1000', 2, 99662340, 'fisica', 54999887766, '17654289013'),
('Bruna Oliveira', 'Rua Sete de Setembro, 755', 4, 99451278, 'fisica', 54991234567, '90381245671'),
('Daniel Moraes', 'Rua das Araucárias, 88', 5, 99345678, 'fisica', 54994561234, '28104798321'),
('Joana Cardoso', 'Av. Santo Ângelo, 321', 1, 99001234, 'fisica', 54998217654, '45392107438'),
('Felipe Almeida', 'Travessa São José, 91', 6, 99234567, 'fisica', 54993456789, '15098721345'),
('Luciana Reis', 'Rua Pedro Álvares, 478', 3, 99456789, 'fisica', 54993123456, '09567213084'),
('Maurício Becker', 'Av. Farrapos, 370', 7, 99567891, 'juridica', 54996784521, '82304987562');

alter table Cidade add column regiao VARCHAR(20);


