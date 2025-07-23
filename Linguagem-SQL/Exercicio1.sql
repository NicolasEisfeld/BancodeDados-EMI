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
    telefone BIGINT
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

ALTER TABLE Pessoa add Column CPF Varchar(11) Not Null; /* Adicionando o atributo CPF em uma tabela já existente*/

INSERT INTO Pessoa(nome_pessoa, endereco_pessoa, id_cidade, cep, tipo_pessoa, telefone, CPF) values
('aria Paula Brock', 'Av. 5 de Maio - 923', 1, 96291071, 'Física', 54924812431, 07518492834);

UPDATE Imovel set Cor='Azul' where tipo_imovel='casa';
UPDATE Imovel set Cor='Cinza' where tipo_imovel='apartamento';
UPDATE Imovel set Cor='Marrom' where tipo_imovel='mansão';

UPDATE Pessoa set CPF=03527392450 where nome_pessoa='André da Silva Maciag';
UPDATE Pessoa set CPF=02325121463 where nome_pessoa='Matheus de Vargas Carteri';
UPDATE Pessoa set CPF=01923497412 where nome_pessoa='Phelipe Eduardo Schmidt';
UPDATE Pessoa set CPF=12354813171 where nome_pessoa='Eloísa Kieling Bolís';

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
    id_imovel, id_inquilino, id_fiador, data_contrato,
    valor_aluguel, dia_vencimento, periodo_aluguel
)
VALUES 
(1, 2, 3, '2025-01-10', 1200.00, 5, 12),
(2, 4, 5, '2025-02-15', 950.00, 10, 24),
(3, 6, 7, '2025-03-01', 1100.00, 8, 18),
(4, 8, 9, '2025-03-25', 1350.00, 15, 36),
(5, 10, 11, '2025-04-05', 1000.00, 12, 6),
(6, 12, 13, '2025-04-20', 1150.00, 7, 24),
(7, 14, 15, '2025-05-10', 980.00, 9, 12),
(8, 16, 17, '2025-05-22', 1250.00, 3, 30),
(9, 18, 19, '2025-06-01', 890.00, 6, 18),
(10, 20, 1, '2025-06-15', 1050.00, 11, 24);

SELECT * from Cidade;

SELECT * from Imovel;
SELECT * from Contrato;
SELECT * from Pessoa;

INSERT INTO Pessoa (
    nome_pessoa, endereco_pessoa, id_cidade, cep,
    tipo_pessoa, telefone, cpf
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

UPDATE Pessoa SET cpf = '82493571046' WHERE id_pessoa = 1;
UPDATE Pessoa SET cpf = '19368420571' WHERE id_pessoa = 2;
UPDATE Pessoa SET cpf = '50987164239' WHERE id_pessoa = 3;
UPDATE Pessoa SET cpf = '74812059683' WHERE id_pessoa = 4;
UPDATE Pessoa SET cpf = '60243187950' WHERE id_pessoa = 5;
UPDATE Pessoa SET cpf = '97805432166' WHERE id_pessoa = 6;
UPDATE Pessoa SET cpf = '38109625478' WHERE id_pessoa = 7;
UPDATE Pessoa SET cpf = '25741396802' WHERE id_pessoa = 8;
UPDATE Pessoa SET cpf = '46589273109' WHERE id_pessoa = 9;
UPDATE Pessoa SET cpf = '13978265430' WHERE id_pessoa = 10;
UPDATE Pessoa SET cpf = '89012347562' WHERE id_pessoa = 11;




