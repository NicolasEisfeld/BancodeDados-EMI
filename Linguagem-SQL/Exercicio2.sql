
DROP DATABASE IF EXISTS Imobiliaria;
CREATE DATABASE Imobiliaria;
USE Imobiliaria;

-- Tabela: Cidade
CREATE TABLE Cidade (
    id_cidade BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome_cidade VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL
);

-- Tabela: Imovel
CREATE TABLE Imovel (
    id_imovel INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    desc_imovel VARCHAR(250) NOT NULL,
    endereco_imovel VARCHAR(150) NOT NULL,
    id_cidade BIGINT NOT NULL,
    cep INT NOT NULL,
    tipo_imovel VARCHAR(50) NOT NULL,
    cor VARCHAR(10),
    situacao_imovel VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade)
);

-- Tabela: Pessoa
CREATE TABLE Pessoa (
    id_pessoa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome_pessoa VARCHAR(45) NOT NULL,
    endereco_pessoa VARCHAR(250) NOT NULL,
    id_cidade BIGINT NOT NULL,
    cep INT,
    tipo_pessoa VARCHAR(8),
    telefone BIGINT,
    cpf VARCHAR(11) NOT NULL,
    CONSTRAINT cidade_idcidade_fk FOREIGN KEY (id_cidade) REFERENCES Cidade(id_cidade)
);

-- Tabela: Proprietario
CREATE TABLE Proprietario (
    id_proprietario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_imovel INT,
    percent_propriedade INT,
    FOREIGN KEY(id_imovel) REFERENCES Imovel(id_imovel)
);

-- Tabela: Contrato
CREATE TABLE Contrato (
    id_contrato INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    id_imovel INT NOT NULL,
    id_inquilino INT NOT NULL,
    id_fiador INT NOT NULL,
    data_contrato DATE NOT NULL,
    valor_aluguel DOUBLE NOT NULL,
    dia_vencimento INT(2) NOT NULL,
    periodo_aluguel INT(2),
    CONSTRAINT imovel_idimovel_fk FOREIGN KEY (id_imovel) REFERENCES Imovel(id_imovel),
    CONSTRAINT pessoas_idinquilino_fk FOREIGN KEY (id_inquilino) REFERENCES Pessoa(id_pessoa),
    CONSTRAINT pessoas_idfiador_fk FOREIGN KEY (id_fiador) REFERENCES Pessoa(id_pessoa)
) ENGINE=InnoDB;

-- Tabela: Recebimento_Aluguel
CREATE TABLE Recebimento_Aluguel (
    data_recebimento DATE PRIMARY KEY NOT NULL,
    id_contrato INT NOT NULL,
    valor_recebimento DOUBLE NOT NULL,
    juros_recebimento DOUBLE NOT NULL,
    multas_recebimento DOUBLE,
    FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato)
);

-- Tabela: Pagamento_Proprietario
CREATE TABLE Pagamento_Proprietario (
    id_contrato INT NOT NULL,
    id_proprietario INT NOT NULL,
    data_pagamento DATE NOT NULL,
    valor_pagamento DOUBLE NOT NULL,
    FOREIGN KEY (id_contrato) REFERENCES Contrato(id_contrato),
    FOREIGN KEY (id_proprietario) REFERENCES Proprietario(id_proprietario),
    FOREIGN KEY (data_pagamento) REFERENCES Recebimento_Aluguel(data_recebimento)
);


-- Cidades da Região
INSERT INTO Cidade (nome_cidade, uf) VALUES
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

-- Pessoas (Inquilinos e Fiadores)
INSERT INTO Pessoa (nome_pessoa, endereco_pessoa, id_cidade, cep, tipo_pessoa, telefone, cpf) VALUES
('ANDré Maciag', 'Rua João II, 360', 1, 76859049, 'Física', 54924035461, '03527392450'),
('Matheus de Vargas', 'Papa Leão IX', 3, 99930000, 'Júridica', 2024309271, '02325121463'),
('Nicolas Eisfeld', 'Av. ComANDante Kraemer', 1, 99701690, 'Física', 54992230442, '01923497412'),
('Phelipe Schmidt', 'Rua Atlanta 2066', 6, 53315845, 'Física', 54934025197, '01923497412'),
('Eloísa Bolís', 'Rua João II, 360', 1, 96326078, 'Jurídica', 54914055429, '12354813171'),
('Maria Paula Brock', 'Av. 5 de Maio - 923', 1, 96291071, 'Física', 54924812431, '07518492834'),
('Ana Souza', 'Rua das Acácias, 123', 1, 99010000, 'inquilino', 54991234567, '12345678901'),
('Carlos Lima', 'Av. Brasil, 456', 2, 99020000, 'fiador', 54991335678, '23456789012'),
('Mariana Dias', 'Rua Bela Vista, 789', 3, 99030000, 'inquilino', 54991446789, '34567890123'),
('Eduardo Gomes', 'Travessa Central, 321', 4, 99040000, 'fiador', 54991557890, '45678901234'),
('Luciana Alves', 'Rua das Palmeiras, 654', 5, 99050000, 'inquilino', 54991668901, '56789012345'),
('Roberto Farias', 'Rua do Comércio, 12', 1, 99060000, 'inquilino', 54991779012, '67890123456'),
('FernANDa Castro', 'Av. Independência, 345', 2, 99070000, 'fiador', 54991880123, '78901234567'),
('Paulo Mendes', 'Rua das Laranjeiras, 98', 3, 99080000, 'inquilino', 54991991234, '89012345678'),
('Juliana Silva', 'Rua General Osório, 77', 4, 99090000, 'fiador', 54992002345, '90123456789'),
('ANDré Pereira', 'Av. Sete de Setembro, 150', 5, 99100000, 'inquilino', 54992113456, '01234567890'),
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

-- Imóveis
INSERT INTO Imovel (desc_imovel, endereco_imovel, id_cidade, cep, tipo_imovel, situacao_imovel, cor) VALUES
('Mansão com 5 quartos e 2 suítes, 3 banheiros e 7 cozinhas com espaço ao ar livre', 'Rua Matheus Pinto de Souza, 23456', 8, 99560734, 'mansão', 'não-alugado', 'Marrom'),
('Casa Rústica na Avenida, com dois quartos e um banheiro ao ar livre', 'Av. Zacaria de Freitas, 993', 1, 99462791, 'casa', 'alugado', 'Azul'),
('Apartamento Coberdura do Edíficio Guarujá, Duplex com 4 quartos e 3 banheiros', 'Av. São Paulo, 1001', 2, 91468027, 'apartamento', 'não-alugado', 'Cinza'),
('Chalé de madeira com lareira e vista para o vale, 2 quartos e 1 banheiro', 'Rua das Araucárias, 456', 3, 99778001, 'chalé', 'alugado', NULL),
('Sítio com lago, casa principal com 3 quartos e área de lazer com churrasqueira', 'Estrada Linha Boa Esperança, km 12', 4, 99882003, 'sítio', 'não-alugado', NULL),
('Kitnet moderna no centro, ideal para estudantes, 1 quarto e cozinha integrada', 'Rua Julio de Castilhos, 88', 1, 99015123, 'kitnet', 'alugado', NULL),
('Cobertura com 3 suítes, hidromassagem e varANDa gourmet', 'Rua Dom Pedro II, 200', 2, 91469033, 'apartamento', 'não-alugado', 'Cinza'),
('Sobrado com garagem para 2 carros, 3 quartos e escritório', 'Rua Itália, 321', 5, 99645000, 'sobrado', 'não-alugado', NULL),
('Casa geminada com 2 quartos, sala ampla e quintal nos fundos', 'Rua Campinas, 109', 6, 99348012, 'casa', 'alugado', 'Azul'),
('Prédio comercial com 3 ANDares e estacionamento próprio', 'Av. XV de Novembro, 500', 7, 99234056, 'comercial', 'não-alugado', NULL),
('Apartamento de 2 quartos com sacada e área de lazer completa', 'Av. Brasil, 1200', 8, 99123045, 'apartamento', 'alugado', 'Cinza'),
('Casa térrea com 4 quartos, suíte master e jardim espaçoso', 'Rua das Oliveiras, 78', 9, 99567000, 'casa', 'não-alugado', 'Azul'),
('Loja comercial térrea com 80m² no centro da cidade', 'Rua Bento Gonçalves, 45', 10, 99245012, 'comercial', 'alugado', NULL),
('Kitnet mobiliada próxima à universidade, ideal para estudantes', 'Rua Universitária, 33', 11, 99112001, 'kitnet', 'não-alugado', NULL),
('Sítio com pomar, açude e casa rústica de 2 quartos', 'Estrada Linha Velha, km 5', 12, 99690021, 'sítio', 'não-alugado', NULL),
('Cobertura duplex com 4 suítes, piscina privativa e vista panorâmica', 'Av. Independência, 301', 2, 91469099, 'apartamento', 'alugado', 'Cinza'),
('Chalé aconchegante em área de turismo rural, com lareira e deck', 'Linha Nova Esperança, s/n', 5, 99810022, 'chalé', 'não-alugado', NULL),
('Prédio comercial com 6 salas independentes e estacionamento', 'Rua da Produção, 501', 7, 99456010, 'comercial', 'não-alugado', NULL),
('Sobrado de alto padrão com 5 quartos, área gourmet e piscina', 'Rua das Palmeiras, 400', 4, 99777011, 'sobrado', 'alugado', NULL),
('Casa geminada com 3 quartos, cozinha planejada e garagem coberta', 'Rua das Hortênsias, 212', 1, 99015022, 'casa', 'não-alugado', 'Azul');

-- Contratos
INSERT INTO Contrato (id_imovel, id_inquilino, id_fiador, data_contrato, valor_aluguel, dia_vencimento, periodo_aluguel) VALUES
(1, 7, 8, '2025-01-10', 1200.00, 5, 12),
(2, 9, 10, '2025-02-15', 950.00, 10, 24),
(3, 11, 13, '2025-03-01', 1100.00, 8, 18),
(4, 14, 15, '2025-03-25', 1350.00, 15, 36),
(5, 16, 17, '2025-04-05', 1000.00, 12, 6),
(6, 18, 19, '2025-04-20', 1150.00, 7, 24),
(7, 20, 21, '2025-05-10', 980.00, 9, 12),
(8, 22, 23, '2025-05-22', 1250.00, 3, 30),
(9, 24, 25, '2025-06-01', 890.00, 6, 18),
(10, 26, 8, '2025-06-15', 1050.00, 11, 24);

SELECT * FROM Cidade;


SELECT * FROM Imovel;


SELECT * FROM Pessoa;


SELECT * FROM Contrato;


SELECT id_imovel, id_inquilino, id_fiador, COUNT(*) AS total_contratos
FROM Contrato
WHERE data_contrato BETWEEN '2025-05-01' AND '2025-08-31'
GROUP BY id_imovel, id_inquilino, id_fiador;

SELECT valor_aluguel, SUM(valor_aluguel) AS total_valor
FROM Contrato
WHERE data_contrato BETWEEN '2025-01-01' AND '2025-12-31'
GROUP BY valor_aluguel;

SELECT tipo_imovel, COUNT(*) AS tipos_disponiveis
FROM Imovel
WHERE situacao_imovel = 'não-alugado'
GROUP BY tipo_imovel;

SELECT id_imovel, valor_aluguel, SUM(valor_aluguel) AS total_valor
FROM Contrato
WHERE periodo_aluguel > 2
GROUP BY id_imovel
HAVING valor_aluguel > 500;

SELECT periodo_aluguel, COUNT(*) AS qtd_contratos
FROM Contrato
WHERE valor_aluguel > 1000
GROUP BY periodo_aluguel;


SELECT 
    Pessoa.nome_pessoa AS Inquilino,
    Imovel.desc_imovel AS Imovel,
    Contrato.valor_aluguel AS Valor,
    Contrato.data_contrato AS Data_Contrato
FROM Contrato
INNER JOIN Pessoa ON Contrato.id_inquilino = Pessoa.id_pessoa
INNER JOIN Imovel ON Contrato.id_imovel = Imovel.id_imovel;


SELECT 
    Imovel.endereco_imovel AS Endereco,
    Imovel.tipo_imovel AS Tipo,
    Cidade.nome_cidade AS Cidade,
    Cidade.uf AS UF
FROM Imovel
INNER JOIN Cidade ON Imovel.id_cidade = Cidade.id_cidade;


SELECT 
    Contrato.id_contrato AS Contrato,
    Pessoa_Inquilino.nome_pessoa AS Inquilino,
    Pessoa_Fiador.nome_pessoa AS Fiador,
    Contrato.valor_aluguel AS Valor
FROM Contrato
INNER JOIN Pessoa AS Pessoa_Inquilino ON Contrato.id_inquilino = Pessoa_Inquilino.id_pessoa
INNER JOIN Pessoa AS Pessoa_Fiador ON Contrato.id_fiador = Pessoa_Fiador.id_pessoa;



-- Inner/Left Joins do Relátorio

-- 1
SELECT tipo_imovel, descricao_imovel, nome_cidade FROM imovel
INNER JOIN cidade
ON imovel.id_cidade = cidade.id_cidade
WHERE nome_cidade = 'Erechim';

SELECT tipo_imovel, descricao_imovel, nome_cidade FROM imovel
LEFT JOIN cidade
ON imovel.id_cidade = cidade.id_cidade
AND nome_cidade = 'Erechim';

-- 2
SELECT contrato.data_contrato, imovel.tipo_imovel, pessoa.nome_pessoa FROM contrato
INNER JOIN imovel ON  contrato.id_imovel = imovel.id_imovel
INNER JOIN pessoa ON  pessoa.id_pessoa = contrato.id_inquilino
WHERE contrato.data_contrato BETWEEN '2025-01-01' AND '2025-12-31';

SELECT contrato.data_contrato, imovel.tipo_imovel, pessoa.nome_pessoa FROM contrato
INNER JOIN imovel ON  contrato.id_imovel = imovel.id_imovel
INNER JOIN pessoa ON  pessoa.id_pessoa = contrato.id_inquilino
AND contrato.data_contrato BETWEEN '2025-01-01' AND '2025-12-31';

-- 3
SELECT imovel.tipo_imovel, pessoa.nome_pessoa, contrato.valor_aluguel FROM contrato
INNER JOIN imovel ON  contrato.id_imovel = imovel.id_imovel
INNER JOIN pessoa ON  contrato.id_inquilino = pessoa.id_pessoa
WHERE pessoa.nome_pessoa LIKE 'A%';

SELECT imovel.tipo_imovel, pessoa.nome_pessoa, contrato.valor_aluguel FROM contrato
LEFT JOIN imovel ON  contrato.id_imovel = imovel.id_imovel
LEFT JOIN pessoa ON  contrato.id_inquilino = pessoa.id_pessoa
AND pessoa.nome_pessoa LIKE 'A%';

-- 4
SELECT contrato.id_contrato, imovel.id_imovel, contrato.data_contrato, imovel.tipo_imovel, pessoa.CPF, pessoa.nome_pessoa
FROM contrato
INNER JOIN imovel ON  imovel.id_imovel = id_contrato
INNER JOIN pessoa ON  id_pessoa = id_contrato
GROUP BY imovel.tipo_imovel;

SELECT contrato.id_contrato, imovel.id_imovel, contrato.data_contrato, imovel.tipo_imovel, pessoa.CPF, pessoa.nome_pessoa
FROM contrato
LEFT JOIN imovel ON  imovel.id_imovel = id_contrato
LEFT JOIN pessoa ON  id_pessoa = id_contrato;

-- 5
SELECT contrato.id_contrato, contrato.valor_aluguel, pessoa.nome_pessoa FROM contrato
INNER JOIN pessoa ON  pessoa.id_pessoa = contrato.id_inquilino
WHERE contrato.valor_aluguel > 1200;

SELECT contrato.id_contrato, contrato.valor_aluguel, pessoa.nome_pessoa FROM contrato
LEFT JOIN pessoa ON  pessoa.id_pessoa = contrato.id_inquilino
AND contrato.valor_aluguel > 1200;

SELECT imovel.tipo_imovel AS tipo, avg(contrato.valor_aluguel), cidade.uf AS uf FROM imovel
INNER JOIN contrato ON  contrato.id_imovel = imovel.id_imovel
INNER JOIN cidade ON  cidade.id_cidade = imovel.id_cidade
GROUP BY tipo;

SELECT imovel.tipo_imovel AS tipo, avg(contrato.valor_aluguel), cidade.uf AS uf FROM imovel
INNER JOIN contrato ON  contrato.id_imovel = imovel.id_imovel
INNER JOIN cidade ON  cidade.id_cidade = imovel.id_cidade;


SELECT contrato.valor_aluguel, imovel.id_imovel, pessoa.nome_pessoa
FROM contrato
INNER JOIN imovel ON  imovel.id_imovel = contrato.id_imovel
INNER JOIN pessoa ON  pessoa.id_pessoa = contrato.id_inquilino
WHERE pessoa.nome_pessoa LIKE 'C%';

SELECT contrato.id_contrato, pessoa.nome_pessoa AS nome_fiador, cidade.nome_cidade, cidade.UF
FROM contrato
INNER JOIN pessoa ON  pessoa.id_pessoa = contrato.id_fiador
INNER JOIN imovel ON  imovel.id_imovel = contrato.id_imovel
INNER JOIN cidade ON  cidade.id_cidade = imovel.id_cidade
WHERE cidade.UF = 'RS';

SELECT imovel.descricao_imovel, cidade.nome_cidade, imovel.situacao_imovel
FROM imovel
INNER JOIN cidade ON  cidade.id_cidade = imovel.id_cidade;


SELECT contrato.valor_aluguel, contrato.id_contrato, cidade.nome_cidade, contrato.data_contrato
FROM contrato
INNER JOIN cidade ON  cidade.id_cidade = contrato.id_cidade
WHERE contrato.data_contrato BETWEEN '2024-03-01' AND '2025-03-01';

SELECT cidade.nome_cidade, count(imovel.id_imovel) AS quantidade_imoveis
FROM cidade
INNER JOIN imovel ON  imovel.id_cidade = cidade.id_cidade
GROUP BY cidade.nome_cidade
order by count(imovel.id_imovel) desc;


SELECT nome_cidade, UF, nome_pessoa, tipo_imovel, situacao_imovel FROM cidade
INNER JOIN pessoa ON  pessoa.id_cidade = cidade.id_cidade
INNER JOIN imovel ON  imovel.id_cidade = cidade.id_cidade
GROUP BY situacao_imovel;



SELECT nome_cidade, avg(valor_aluguel) FROM cidade
INNER JOIN contrato ON  contrato.id_imovel = imovel.id_imovel
WHERE avg(valor_aluguel) > 0;



SELECT nome_pessoa, nome_cidade, data_contrato, id_contrato, contrato.id_imovel FROM contrato
INNER JOIN imovel ON  imovel.id_imovel = contrato.id_imovel
INNER JOIN cidade ON  cidade.id_cidade = imovel.id_cidade
INNER JOIN pessoa ON  contrato.id_inquilino = pessoa.id_Pessoa
WHERE uf = 'sul';


SELECT endereco_pessoa, valor_aluguel FROM contrato
INNER JOIN pessoa ON  contrato.id_inquilino = pessoa.id_pessoa
order by valor_aluguel ASC;

