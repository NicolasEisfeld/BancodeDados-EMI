-- Banco de Dados Pré-IFRS - André, Eloísa, Matheus, Nicolas e Phelipe
-- Script com criação de tabelas, relacionamentos e inserções de dados
-- Atualizado 3º Trimestre 2025

DROP DATABASE IF EXISTS PreIFRS;
CREATE DATABASE PreIFRS;
USE PreIFRS;

CREATE TABLE Avatar (
	id_avatar BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_avatar VARCHAR(30) NOT NULL,
    imagem_avatar VARCHAR(500) NOT NULL
);

CREATE TABLE Escola (
	id_escola BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_escola VARCHAR(45) NOT NULL UNIQUE,
    tipo ENUM ('Federal', 'Estadual', 'Municipal', 'Particular') NOT NULL
);

CREATE TABLE Ranking (
	id_ranking BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    posicao_ranking INT NOT NULL UNIQUE,
	pontos_ranking INT NOT NULL
);

CREATE TABLE Disciplina (
	id_disciplina BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_disciplina VARCHAR(55) NOT NULL UNIQUE
);    

CREATE TABLE Simulado (
	id_simulado BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tempo_questao TIME,
    pontos_questao INT NOT NULL
);

CREATE TABLE Usuario (
	id_usuario BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(40) NOT NULL,
    email_usuario VARCHAR(50) NOT NULL UNIQUE,
    apelido_usuario VARCHAR(20) NOT NULL UNIQUE,
    senha_usuario VARCHAR(50) NOT NULL,
    tipo_usuario ENUM('Admin', 'Estudante'),
    id_avatar BIGINT,
    CONSTRAINT fk_usuario_avatar FOREIGN KEY (id_avatar) REFERENCES Avatar(id_avatar)
);

CREATE TABLE Estudante(
	id_estudante BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    CONSTRAINT fk_usuario_estudante FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    dataNasc_estudante DATE NOT NULL,
    telefone_estudante VARCHAR(45) NOT NULL UNIQUE,
	pontuacao_total INT DEFAULT 0,
    dias_consecutivos INT DEFAULT 0,
    ultima_atividade DATE,
    id_escola BIGINT NOT NULL,
    CONSTRAINT fk_escola_estudante FOREIGN KEY (id_escola) REFERENCES Escola(id_escola),
    id_ranking BIGINT,
    CONSTRAINT fk_ranking_estudante FOREIGN KEY (id_ranking) REFERENCES Ranking(id_ranking)
);

CREATE TABLE Conteudo (
	id_conteudo BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_conteudo VARCHAR(55) NOT NULL,
    texto_conteudo TEXT NOT NULL,
    imagem_conteudo VARCHAR(500),
    link_conteudo VARCHAR(500),
    altImagem_conteudo VARCHAR(500),
	id_disciplina BIGINT NOT NULL,
    CONSTRAINT fk_conteudo_disciplina FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);

CREATE TABLE Assunto (
	id_assunto BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_assunto VARCHAR(55) NOT NULL,
    id_conteudo BIGINT NOT NULL,
    CONSTRAINT fk_assunto_conteudo FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id_conteudo),
    id_usuario BIGINT NOT NULL, /*Usuario que cadastrou o assunto (admin)*/
    CONSTRAINT fk_assunto_adminstrador FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Questao (
    id_questao BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    enunciado_questao VARCHAR(500) NOT NULL,
    alternativa1_questao VARCHAR(500) NOT NULL,
    alternativa2_questao VARCHAR(500) NOT NULL,
    alternativa3_questao VARCHAR(500) NOT NULL,
    alternativa4_questao VARCHAR(500) NOT NULL,
    alternativa5_questao VARCHAR(500) NOT NULL,
    resposta_correta ENUM('A', 'B', 'C', 'D', 'E'),
    resolucao_questao TEXT,
    id_disciplina BIGINT NOT NULL,
    id_conteudo BIGINT NOT NULL,
    CONSTRAINT fk_questao_disciplina FOREIGN KEY (id_disciplina)
        REFERENCES Disciplina (id_disciplina),
    CONSTRAINT fk_questao_conteudo FOREIGN KEY (id_conteudo)
        REFERENCES Conteudo (id_conteudo)
);

CREATE TABLE Questao_Assunto (
    id_questao BIGINT NOT NULL,
    id_assunto BIGINT NOT NULL,
    PRIMARY KEY (id_questao, id_assunto),
    CONSTRAINT fk_questao_assunto FOREIGN KEY(id_questao) REFERENCES Questao(id_questao),
    CONSTRAINT fk_assunto_questao FOREIGN KEY(id_assunto) REFERENCES Assunto(id_assunto)
);

CREATE TABLE Usuario_Questao (
	id_usuario BIGINT NOT NULL,
    CONSTRAINT fk_usuario_questao FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    id_questao BIGINT NOT NULL,
    CONSTRAINT fk_questao_usuario FOREIGN KEY (id_questao) REFERENCES Questao(id_questao),
    PRIMARY KEY(id_usuario, id_questao)
);

CREATE TABLE Simulado_Questao (
    id_questao BIGINT NOT NULL,
    id_simulado BIGINT NOT NULL,
    PRIMARY KEY (id_questao , id_simulado),
    CONSTRAINT fk_simulado_questao FOREIGN KEY (id_questao)
        REFERENCES Questao (id_questao),
    CONSTRAINT fk_questao_simulado FOREIGN KEY (id_simulado)
        REFERENCES Simulado (id_simulado),
    alternativa_escolhida ENUM('A', 'B', 'C', 'D', 'E') NOT NULL
);

CREATE TABLE Feedback (
    id_feedback BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    texto_feedback VARCHAR(255),
    estrelas_feedback DECIMAL(2,1) NOT NULL CHECK (estrelas_feedback BETWEEN 1 AND 5),
    id_usuario BIGINT NOT NULL,
    CONSTRAINT fk_feedback_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Inserções para o Banco de Dados PreIFRS
-- Disciplinas: Biologia, Química e Física

USE PreIFRS;

-- Tabela Avatar
INSERT INTO Avatar (nome_avatar, imagem_avatar) VALUES
('Cientista', 'https://example.com/avatars/cientista.png'),
('Átomo', 'https://example.com/avatars/atomo.png'),
('DNA', 'https://example.com/avatars/dna.png'),
('Microscópio', 'https://example.com/avatars/microscopio.png'),
('Foguete', 'https://example.com/avatars/foguete.png'),
('Célula', 'https://example.com/avatars/celula.png'),
('Estrela', 'https://example.com/avatars/estrela.png'),
('Beaker', 'https://example.com/avatars/beaker.png');

-- Tabela Escola
INSERT INTO Escola (nome_escola, tipo) VALUES
('IFRS - Campus Erechim', 'Federal'),
('IFRS - Campus Bento Gonçalves', 'Federal'),
('Colégio Estadual Érico Veríssimo', 'Estadual'),
('EE Ensino Médio Dom Pedro II', 'Estadual'),
('Colégio Marista São José', 'Particular'),
('Colégio Anglo', 'Particular'),
('EM Ensino Fundamental Paulo Freire', 'Municipal');

-- Tabela Ranking
INSERT INTO Ranking (posicao_ranking, pontos_ranking) VALUES
(1, 15000),
(2, 12500),
(3, 10800),
(4, 9500),
(5, 8200),
(6, 7100),
(7, 6300),
(8, 5500),
(9, 4800),
(10, 4200);

-- Tabela Disciplina
INSERT INTO Disciplina (nome_disciplina) VALUES
('Biologia'),
('Química'),
('Física');

-- Tabela Simulado
INSERT INTO Simulado (tempo_questao, pontos_questao) VALUES
('00:03:00', 10),
('00:02:30', 8),
('00:04:00', 12),
('00:03:30', 10),
('00:02:00', 6);

-- Tabela Usuario (Admins e Estudantes)
INSERT INTO Usuario (nome_usuario, email_usuario, apelido_usuario, senha_usuario, tipo_usuario, id_avatar) VALUES
('André Silva', 'andre.silva@admin.com', 'andreAdmin', 'senha123', 'Admin', 1),
('Eloísa Kieling', 'eloisa.kieling@admin.com', 'eloisaAdmin', 'senha123', 'Admin', 2),
('Matheus de Vargas', 'matheus.vargas@estudante.com', 'matheusV', 'senha456', 'Estudante', 3),
('Nicolas Ferreira', 'nicolas.ferreira@estudante.com', 'nicolasF', 'senha456', 'Estudante', 4),
('Phelipe Schmidt', 'phelipe.souza@estudante.com', 'phelipeS', 'senha456', 'Estudante', 5),
('Julia Ferreira', 'julia.ferreira@estudante.com', 'juliaF', 'senha789', 'Estudante', 6),
('Lucas Almeida', 'lucas.almeida@estudante.com', 'lucasA', 'senha789', 'Estudante', 7),
('Mariana Rocha', 'mariana.rocha@estudante.com', 'marianaR', 'senha789', 'Estudante', 8),
('Pedro Martins', 'pedro.martins@estudante.com', 'pedroM', 'senha101', 'Estudante', 1),
('Ana Paula Lima', 'ana.lima@estudante.com', 'anaL', 'senha101', 'Estudante', 2);

-- Tabela Estudante
INSERT INTO Estudante (id_usuario, dataNasc_estudante, telefone_estudante, pontuacao_total, dias_consecutivos, ultima_atividade, id_escola, id_ranking) VALUES
(3, '2007-05-15', '(54) 99876-5432', 10800, 15, '2025-11-05', 1, 3),
(4, '2007-08-22', '(54) 98765-4321', 12500, 20, '2025-11-05', 1, 2),
(5, '2008-03-10', '(54) 97654-3210', 9500, 12, '2025-11-04', 2, 4),
(6, '2007-11-30', '(54) 96543-2109', 8200, 10, '2025-11-05', 3, 5),
(7, '2008-01-18', '(54) 95432-1098', 7100, 8, '2025-11-03', 4, 6),
(8, '2007-07-25', '(54) 94321-0987', 15000, 25, '2025-11-05', 5, 1),
(9, '2008-04-12', '(54) 93210-9876', 6300, 7, '2025-11-05', 6, 7),
(10, '2007-09-05', '(54) 92109-8765', 5500, 6, '2025-11-02', 1, 8);

-- Tabela Conteudo - BIOLOGIA
INSERT INTO Conteudo (nome_conteudo, texto_conteudo, imagem_conteudo, link_conteudo, altImagem_conteudo, id_disciplina) VALUES
('Célula e Organização dos Seres Vivos', 'Estudo da célula como unidade básica da vida, diferenças entre células animais e vegetais.', 'https://example.com/img/celula.jpg', 'https://example.com/biologia/celula', 'Imagem de célula animal e vegetal', 1),
('Corpo Humano e Saúde', 'Estudo dos sistemas do corpo humano: digestório, respiratório, circulatório, entre outros.', 'https://example.com/img/corpo-humano.jpg', 'https://example.com/biologia/corpo-humano', 'Sistemas do corpo humano', 1),
('Meio Ambiente e Seres Vivos', 'Relações entre seres vivos, cadeias e teias alimentares, ciclos da natureza.', 'https://example.com/img/ecossistema.jpg', 'https://example.com/biologia/ecologia', 'Cadeia alimentar', 1),
('Biodiversidade', 'Classificação e características dos principais grupos de seres vivos.', 'https://example.com/img/biodiversidade.jpg', 'https://example.com/biologia/biodiversidade', 'Diversidade de seres vivos', 1);

-- Tabela Conteudo de QUÍMICA
INSERT INTO Conteudo (nome_conteudo, texto_conteudo, imagem_conteudo, link_conteudo, altImagem_conteudo, id_disciplina) VALUES
('Propriedades da Matéria', 'Estudo dos estados físicos, mudanças de estado e propriedades gerais e específicas.', 'https://example.com/img/estados-materia.jpg', 'https://example.com/quimica/materia', 'Estados físicos da matéria', 2),
('Substâncias e Misturas', 'Diferenças entre substâncias puras e misturas, métodos de separação.', 'https://example.com/img/misturas.jpg', 'https://example.com/quimica/substancias', 'Separação de misturas', 2),
('Átomos e Elementos Químicos', 'Estrutura atômica básica, tabela periódica e elementos químicos.', 'https://example.com/img/atomo.jpg', 'https://example.com/quimica/atomos', 'Modelo atômico', 2),
('Transformações Químicas', 'Reações químicas do cotidiano, combustão, oxidação e evidências de reações.', 'https://example.com/img/reacoes.jpg', 'https://example.com/quimica/reacoes', 'Reações químicas', 2);

-- Tabela Conteudo de FÍSICA
INSERT INTO Conteudo (nome_conteudo, texto_conteudo, imagem_conteudo, link_conteudo, altImagem_conteudo, id_disciplina) VALUES
('Movimento e Força', 'Estudo dos movimentos, velocidade, aceleração e forças no cotidiano.', 'https://example.com/img/movimento.jpg', 'https://example.com/fisica/movimento', 'Movimento de objetos', 3),
('Calor e Temperatura', 'Diferença entre calor e temperatura, propagação de calor e dilatação térmica.', 'https://example.com/img/calor.jpg', 'https://example.com/fisica/calor', 'Termômetro', 3),
('Eletricidade', 'Circuitos elétricos simples, corrente elétrica e consumo de energia.', 'https://example.com/img/eletricidade.jpg', 'https://example.com/fisica/eletricidade', 'Circuito elétrico', 3),
('Ondas e Som', 'Propriedades das ondas, som e luz no cotidiano.', 'https://example.com/img/ondas.jpg', 'https://example.com/fisica/ondas', 'Ondas sonoras', 3);

-- Tabela Assunto de BIOLOGIA
INSERT INTO Assunto (nome_assunto, id_conteudo, id_usuario) VALUES
('Estrutura Celular', 1, 1),
('Diferenças entre Célula Animal e Vegetal', 1, 1),
('Sistema Digestório', 2, 2),
('Sistema Respiratório e Circulatório', 2, 2),
('Cadeias e Teias Alimentares', 3, 1),
('Fotossíntese e Respiração', 3, 1),
('Classificação dos Animais', 4, 2),
('Reino Vegetal', 4, 2);

-- Tabela Assunto - QUÍMICA
INSERT INTO Assunto (nome_assunto, id_conteudo, id_usuario) VALUES
('Estados Físicos da Matéria', 5, 1),
('Mudanças de Estado', 5, 1),
('Substâncias Puras e Misturas', 6, 2),
('Métodos de Separação', 6, 2),
('Estrutura Atômica', 7, 1),
('Tabela Periódica', 7, 1),
('Reações Químicas', 8, 2),
('Combustão', 8, 2);

-- Tabela Assunto - FÍSICA
INSERT INTO Assunto (nome_assunto, id_conteudo, id_usuario) VALUES
('Velocidade e Movimento', 9, 1),
('Tipos de Força', 9, 1),
('Temperatura e Termômetros', 10, 2),
('Propagação de Calor', 10, 2),
('Corrente Elétrica', 11, 1),
('Circuitos Elétricos', 11, 1),
('Propriedades do Som', 12, 2),
('Luz e Cores', 12, 2);

-- Tabela Questao - BIOLOGIA
INSERT INTO Questao (enunciado_questao, alternativa1_questao, alternativa2_questao, alternativa3_questao, alternativa4_questao, alternativa5_questao, resposta_correta, resolucao_questao, id_disciplina, id_conteudo) VALUES
('Qual é a principal diferença entre célula animal e célula vegetal?', 'A célula animal tem núcleo e a vegetal não', 'A célula vegetal possui parede celular e cloroplastos', 'A célula animal é maior que a vegetal', 'A célula vegetal não possui membrana plasmática', 'Ambas são exatamente iguais', 'B', 'A célula vegetal possui parede celular (celulose) e cloroplastos, estruturas ausentes na célula animal.', 1, 1),
('O sistema responsável por levar o oxigênio para todas as células do corpo é o:', 'Sistema digestório', 'Sistema nervoso', 'Sistema circulatório', 'Sistema excretor', 'Sistema locomotor', 'C', 'O sistema circulatório, através do sangue, transporta oxigênio e nutrientes para todas as células do corpo.', 1, 2),
('Em uma cadeia alimentar, os seres vivos que produzem seu próprio alimento através da fotossíntese são chamados de:', 'Consumidores', 'Decompositores', 'Produtores', 'Herbívoros', 'Carnívoros', 'C', 'Os produtores (plantas) realizam fotossíntese e produzem seu próprio alimento, sendo a base da cadeia alimentar.', 1, 3),
('Os mamíferos são animais que possuem como característica principal:', 'Corpo coberto por escamas', 'Presença de glândulas mamárias', 'Respiração por brânquias', 'Temperatura do corpo variável', 'Reprodução por ovos externos', 'B', 'A principal característica dos mamíferos é a presença de glândulas mamárias que produzem leite para alimentar os filhotes.', 1, 4);

-- Tabela Questao - QUÍMICA
INSERT INTO Questao (enunciado_questao, alternativa1_questao, alternativa2_questao, alternativa3_questao, alternativa4_questao, alternativa5_questao, resposta_correta, resolucao_questao, id_disciplina, id_conteudo) VALUES
('Qual o grupo funcional característico dos álcoois?', 'Carbonila', 'Hidroxila', 'Carboxila', 'Amina', 'Éster', 'B', 'Os álcoois apresentam o grupo funcional hidroxila (-OH) ligado a carbono saturado.', 2, 5),
('Qual ácido é encontrado no suco gástrico?', 'Ácido acético', 'Ácido sulfúrico', 'Ácido clorídrico', 'Ácido nítrico', 'Ácido fosfórico', 'C', 'O suco gástrico contém ácido clorídrico (HCl) que auxilia na digestão.', 2, 6),
('Em uma reação exotérmica:', 'A entalpia dos produtos é maior que dos reagentes', 'Há absorção de calor', 'A variação de entalpia é positiva', 'Há liberação de calor', 'Não há troca de energia', 'D', 'Reações exotérmicas liberam calor para o ambiente, com ΔH negativo.', 2, 7),
('Quantos mols de átomos existem em 12g de carbono-12?', '0,5 mol', '1 mol', '2 mols', '6 mols', '12 mols', 'B', 'A massa molar do carbono-12 é 12g/mol, portanto 12g correspondem a 1 mol.', 2, 8);

-- Tabela Questao - FÍSICA
INSERT INTO Questao (enunciado_questao, alternativa1_questao, alternativa2_questao, alternativa3_questao, alternativa4_questao, alternativa5_questao, resposta_correta, resolucao_questao, id_disciplina, id_conteudo) VALUES
('Segundo a Segunda Lei de Newton, a força resultante é igual a:', 'massa dividida pela aceleração', 'massa multiplicada pela velocidade', 'massa multiplicada pela aceleração', 'aceleração dividida pela massa', 'velocidade multiplicada pela aceleração', 'C', 'A Segunda Lei de Newton estabelece que F = m × a, onde F é força, m é massa e a é aceleração.', 3, 9),
('Qual lei da termodinâmica estabelece que a energia não pode ser criada nem destruída?', 'Lei Zero', 'Primeira Lei', 'Segunda Lei', 'Terceira Lei', 'Lei de Boyle', 'B', 'A Primeira Lei da Termodinâmica é a lei da conservação de energia.', 3, 10),
('A força entre duas cargas elétricas é:', 'diretamente proporcional à distância', 'inversamente proporcional ao quadrado da distância', 'independente da distância', 'proporcional ao cubo da distância', 'inversamente proporcional à distância', 'B', 'Pela Lei de Coulomb, a força elétrica é inversamente proporcional ao quadrado da distância entre as cargas.', 3, 11),
('Quando a luz passa do ar para a água, ela:', 'mantém a mesma velocidade', 'aumenta de velocidade', 'diminui de velocidade', 'é totalmente absorvida', 'não sofre alteração', 'C', 'A luz diminui de velocidade ao passar para um meio mais denso, causando refração.', 3, 12);

-- Tabela Questao_Assunto
INSERT INTO Questao_Assunto (id_questao, id_assunto) VALUES
(1, 2), 
(2, 3), 
(3, 5), 
(4, 7),
(5, 10), 
(6, 11), 
(7, 13), 
(8, 15), 
(9, 18), 
(10, 19), 
(11, 21), 
(12, 23); 

-- Tabela Usuario_Questao (questões favoritadas pelos usuários)
INSERT INTO Usuario_Questao (id_usuario, id_questao) VALUES
(3, 1), (3, 5), (3, 9),
(4, 2), (4, 6), (4, 10),
(5, 3), (5, 7), (5, 11),
(6, 4), (6, 8), (6, 12),
(7, 1), (7, 2), (7, 3),
(8, 5), (8, 6), (8, 7);

-- Tabela Simulado_Questao
INSERT INTO Simulado_Questao (id_questao, id_simulado, alternativa_escolhida) VALUES
(1, 1, 'B'), (2, 1, 'C'), (5, 1, 'B'), (9, 1, 'C'),
(3, 2, 'B'), (6, 2, 'C'), (10, 2, 'B'),
(4, 3, 'B'), (7, 3, 'D'), (11, 3, 'B'), (12, 3, 'C'),
(8, 4, 'B'), (1, 4, 'B'), (5, 4, 'A'),
(2, 5, 'C'), (6, 5, 'C'), (9, 5, 'C');

-- Tabela Feedback
INSERT INTO Feedback (texto_feedback, estrelas_feedback, id_usuario) VALUES
('Excelente plataforma! Muito útil para estudar para o IFRS.', 5.0, 3),
('Gostei muito das questões de Biologia, são bem elaboradas.', 4.5, 4),
('O sistema de ranking motiva bastante. Poderia ter mais questões de Física.', 4.0, 5),
('Adorei a organização dos conteúdos por disciplina.', 5.0, 6),
('Bom, mas poderia ter mais simulados disponíveis.', 3.5, 7),
('Plataforma excelente! Os conteúdos de Química são ótimos.', 4.8, 8),
('Muito bom para revisar matérias. Interface intuitiva.', 4.5, 9),
('Ajudou muito nos meus estudos. Recomendo!', 5.0, 10);

-- 5 Selects com GROUP BY (sendo 3 com agregação)


-- 5 Selects com INNER JOIN

/* Listar Usuarios */
SELECT nome_usuario, apelido_usuario, tipo_usuario, nome_avatar FROM Usuario
INNER JOIN Avatar ON avatar.id_avatar = usuario.id_avatar;

/* Listar todas as questões do banco*/
SELECT enunciado_questao,  nome_assunto, nome_conteudo, nome_disciplina FROM Questao
INNER JOIN Questao_Assunto ON Questao_Assunto.id_questao = questao.id_questao
INNER JOIN Assunto ON Questao_Assunto.id_assunto = assunto.id_assunto
INNER JOIN Conteudo ON conteudo.id_conteudo = questao.id_conteudo
INNER JOIN Disciplina ON disciplina.id_disciplina = questao.id_disciplina;

/* Sistema de Ranking*/ 
SELECT nome_usuario, apelido_usuario, pontos_ranking, posicao_ranking FROM Estudante
INNER JOIN Usuario ON usuario.id_usuario = estudante.id_usuario
INNER JOIN Ranking ON ranking.id_ranking = estudante.id_ranking
ORDER BY pontos_ranking DESC;

/* Exibir feedbacks*/
SELECT nome_usuario, texto_feedback, estrelas_feedback FROM Usuario
INNER JOIN Feedback ON feedback.id_usuario = usuario.id_usuario;

/* Exibir Conteúdos */
SELECT nome_conteudo, texto_conteudo, imagem_conteudo, link_conteudo, nome_disciplina FROM Conteudo
INNER JOIN Disciplina ON disciplina.id_disciplina = conteudo.id_disciplina
WHERE nome_disciplina = "Biologia";

-- 3 Selects com LEFT JOIN

-- 3 Selects com RIGHT JOIN


