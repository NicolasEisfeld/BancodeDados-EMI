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

CREATE TABLE Contrato (
	id_contrato INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_imovel INT NOT NULL,
    FOREIGN KEY (id_imovel) REFERENCES Imovel(id_imovel),
    data_contrato DATE NOT NULL,
    valor_aluguel DOUBLE NOT NULL,
    dia_vencimento DATE NOT NULL,
    periodo_aluguel INT
);

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

SELECT * from Pessoa; /*Seleciona todos os dados da tabela de dados para visualizar*/

INSERT INTO Pessoa (nome_pessoa, endereco_pessoa, id_cidade, cep, tipo_pessoa, telefone) values
('André Maciag', 'Rua João II, 360', 1, 76859049, 'Física', 54924035461), 
('Matheus de Vargas', 'Papa Leão IX', 3, 99930000, 'Júridica', 2024309271), 
('Nicolas Eisfeld', 'Av. Comandante Kraemer', 1, 99701690, 'Física', 54992230442), 
('Phelipe Schmidt', 'Rua Atlanta 2066', 6, 53315845, 'Física', 54934025197), 
('Eloísa Bolís', 'Rua João II, 360', 1, 96326078, 'Jurídica', 54914055429);

SELECT * from Imovel;


INSERT INTO Imovel(desc_imovel, endereco_imovel, id_cidade, cep, tipo_imovel, situacao_imovel) values
('Mansão com 5 quartos e 2 suítes, 3 banheiros e 7 cozinhas com espaço ao ar livre', 'Rua Matheus Pinto de Souza, 23456', 8, 99560734, 'mansão','não-alugado'),
('Casa Rústica na Avenida, com dois quartos e um banheiro ao ar livre', 'Av. Zacaria de Freitas, 993', 1, 99462791, 'casa','alugado'),
('Apartamento Coberdura do Edíficio Guarujá, Duplex com 4 quartos e 3 banheiros', 'Av. São Paulo, 1001', 2, 91468027, 'apartamento','não-alugado');

