/*Exercício Imobiliária*/
/*Nicolas Eisfeld 2 INFO*/
Drop DATABASE Imobiliaria;

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
('Maria Paula Brock', 'Av. 5 de Maio - 923', 1, 96291071, 'Física', 54924812431, 07518492834);

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

ALTER TABLE pessoa
ADD CONSTRAINT cidade_idcidade_fk
FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade);


INSERT INTO Contrato (
    id_imovel, id_inquilino, id_fiador, data_contrato,
    valor_aluguel, dia_vencimento, periodo_aluguel
)
VALUES 
(1, 7, 8, '2025-01-10', 1200.00, 5, 12),  
(2, 9, 10, '2025-02-15', 950.00, 10, 24), 
(3, 11, 28, '2025-03-01', 1100.00, 8, 18), 
(4, 27, 30, '2025-03-25', 1350.00, 15, 36),
(5, 29, 32, '2025-04-05', 1000.00, 12, 6), 
(6, 31, 34, '2025-04-20', 1150.00, 7, 24),
(7, 33, 36, '2025-05-10', 980.00, 9, 12), 
(8, 35, 38, '2025-05-22', 1250.00, 3, 30), 
(9, 37, 40, '2025-06-01', 890.00, 6, 18),  
(10, 39, 8, '2025-06-15', 1050.00, 11, 24);


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
('Luciana Alves', 'Rua das Palmeiras, 654', 5, 99050000, 'inquilino', 54991668901, '56789012345'),
('Roberto Farias', 'Rua do Comércio, 12', 1, 99060000, 'inquilino', 54991779012, '67890123456'),
('Fernanda Castro', 'Av. Independência, 345', 2, 99070000, 'fiador', 54991880123, '78901234567'),
('Paulo Mendes', 'Rua das Laranjeiras, 98', 3, 99080000, 'inquilino', 54991991234, '89012345678'),
('Juliana Silva', 'Rua General Osório, 77', 4, 99090000, 'fiador', 54992002345, '90123456789'),
('André Pereira', 'Av. Sete de Setembro, 150', 5, 99100000, 'inquilino', 54992113456, '01234567890'),
('Patrícia Oliveira', 'Rua XV de Novembro, 201', 6, 99110000, 'fiador', 54992224567, '11234567891'),
('Rafael Costa', 'Rua Flores da Cunha, 87', 7, 99120000, 'inquilino', 54992335678, '21234567892'),
('Camila Rocha', 'Rua da Liberdade, 59', 8, 99130000, 'fiador', 54992446789, '31234567893'),
('Thiago Martins', 'Av. Borges de Medeiros, 33', 9, 99140000, 'inquilino', 54992557890, '41234567894'),
('Beatriz Carvalho', 'Rua Ernesto Dorneles, 141', 10, 99150000, 'fiador', 54992668901, '51234567895'),
('Marcelo Duarte', 'Rua Dom Pedro II, 229', 11, 99160000, 'inquilino', 54992779012, '61234567896'),
('Aline Ferreira', 'Rua Santo Antônio, 84', 12, 99170000, 'fiador', 54992880123, '71234567897'),
('Lucas Nogueira', 'Rua João Pessoa, 45', 1, 99180000, 'inquilino', 54992991234, '81234567898'),
('Carolina Moraes', 'Av. Júlio de Castilhos, 300', 2, 99190000, 'fiador', 54993002345, '91234567899'),
('Gustavo Almeida', 'Rua Getúlio Vargas, 120', 3, 99200000, 'inquilino', 54993113456, '98765432100');



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
('Prédio comercial com 3 andares e estacionamento próprio', 'Av. XV de Novembro, 500', 7, 99234056, 'comercial', 'não-alugado'),
('Apartamento de 2 quartos com sacada e área de lazer completa', 'Av. Brasil, 1200', 8, 99123045, 'apartamento', 'alugado'),
('Casa térrea com 4 quartos, suíte master e jardim espaçoso', 'Rua das Oliveiras, 78', 9, 99567000, 'casa', 'não-alugado'),
('Loja comercial térrea com 80m² no centro da cidade', 'Rua Bento Gonçalves, 45', 10, 99245012, 'comercial', 'alugado'),
('Kitnet mobiliada próxima à universidade, ideal para estudantes', 'Rua Universitária, 33', 11, 99112001, 'kitnet', 'não-alugado'),
('Sítio com pomar, açude e casa rústica de 2 quartos', 'Estrada Linha Velha, km 5', 12, 99690021, 'sítio', 'não-alugado'),
('Cobertura duplex com 4 suítes, piscina privativa e vista panorâmica', 'Av. Independência, 301', 2, 91469099, 'apartamento', 'alugado'),
('Chalé aconchegante em área de turismo rural, com lareira e deck', 'Linha Nova Esperança, s/n', 5, 99810022, 'chalé', 'não-alugado'),
('Prédio comercial com 6 salas independentes e estacionamento', 'Rua da Produção, 501', 7, 99456010, 'comercial', 'não-alugado'),
('Sobrado de alto padrão com 5 quartos, área gourmet e piscina', 'Rua das Palmeiras, 400', 4, 99777011, 'sobrado', 'alugado'),
('Casa geminada com 3 quartos, cozinha planejada e garagem coberta', 'Rua das Hortênsias, 212', 1, 99015022, 'casa', 'não-alugado');


SELECT * from Contrato;

SELECT id_imovel, id_inquilino, id_fiador, COUNT(*) 
FROM Contrato
WHERE data_contrato BETWEEN '2025-05-01' AND '2025-08-31'
GROUP BY id_imovel;

SELECT valor_aluguel, SUM(valor_aluguel)
FROM Contrato
WHERE data_contrato BETWEEN '2025-01-01' AND '2025-12-31'
GROUP By valor_aluguel;


SELECT tipo_imovel, COUNT(*) AS tipos_disponiveis
FROM Imovel
WHERE situacao_imovel = "não-alugado"
GROUP BY tipo_imovel;

SELECT id_imovel, valor_aluguel, sum(valor_aluguel) from Contrato
Where periodo_aluguel > 2
GROUP BY id_imovel HAVING valor_aluguel > 500;

SELECT periodo_aluguel, COUNT(*) as qtd_contratos FROM Contrato
WHERE valor_aluguel > 1000 GROUP BY periodo_aluguel;


SELECT Pessoa.nome_pessoa, Imovel.desc_imovel, Contrato.valor_aluguel, Contrato.data_contrato
FROM Contrato
INNER JOIN Pessoa ON Contrato.id_inquilino = Pessoa.id_pessoa
INNER JOIN Imovel ON Contrato.id_imovel = Imovel.id_imovel;

SELECT Imovel.endereco_imovel, Imovel.tipo_imovel, Cidade.nome_cidade, Cidade.uf
FROM Imovel
INNER JOIN Cidade ON Imovel.id_cidade = Cidade.id_cidade;

SELECT Contrato.id_contrato, Pessoa_Inquilino.nome_pessoa AS Inquilino, Pessoa_Fiador.nome_pessoa AS Fiador, Contrato.valor_aluguel
FROM Contrato
INNER JOIN Pessoa AS Pessoa_Inquilino ON Contrato.id_inquilino = Pessoa_Inquilino.id_pessoa
INNER JOIN Pessoa AS Pessoa_Fiador ON Contrato.id_fiador = Pessoa_Fiador.id_pessoa;

