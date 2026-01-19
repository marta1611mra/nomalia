-- Povoamento

-- TIPOS DE VIAGEM
INSERT INTO tipo_viagem (id_tipo_viagem, nome_tipo) VALUES
(1, 'Lazer'),
(2, 'Profissional'),
(3, 'Cultural'),
(4, 'Gastronómica');


-- PAÍSES
INSERT INTO pais (id_pais, nome_pais) VALUES
(1, 'Portugal'),
(2, 'Espanha'),
(3, 'Islândia'),
(4, 'Italy'),
(5, 'França'),
(6, 'Estados Unidos da América'),
(7, 'Japão'),
(8, 'Brasil');


-- CIDADES
INSERT INTO cidade (id_cidade, nome_cidade, id_pais) VALUES
    (1, 'Lisboa', 1), (3, 'Porto', 1), (5, 'Braga', 1),
    (6, 'Barcelona', 2), (7, 'Madrid', 2), (8, 'Sevilha', 2),
    (10, 'Reiquiavique', 3), (11, 'Vik', 3),
    (13, 'Roma', 4), (15, 'Florença', 4), (16, 'Veneza', 4),
    (17, 'Paris', 5), (18, 'Lyon', 5),
    (19, 'Nova Iorque', 6), (20, 'Los Angeles', 6), (21, 'São Francisco', 6),
    (22, 'Tóquio', 7), (23, 'Quioto', 7), (24, 'Osaca', 7),
    (25, 'Rio de Janeiro', 8), (26, 'São Paulo', 8), (27, 'Salvador', 8);


-- TIPOS DE VALE
INSERT INTO tipo_vale (id_tipo_vale, nome_tipo_vale, descricao_tipo, valor_pontos_tipo) VALUES
(1, 'hotel', 'Desconto de 10% em parceiros.', 100),
(2, 'atividade', 'Desconto de 15% em parceiros.', 150);


-- UTILIZADORES
-- (as palavras-passe serão cifradas pelo trigger)
INSERT INTO utilizador (id_utilizador, nome_utilizador, palavra_passe, email, biografia, pontos) VALUES
(1, 'soraia_faria', 'PasswordMuitoSegura#123', 'sfaria@gmail.com', 'Apaixonada por viagens.', 120),
(2, 'matheus_azevedo', 'PasswordMuitoSegura#456', 'matheus@gmail.com', 'Explorador urbano.', 80),
(3, 'miguel_santos', 'PasswordMuitoSegura#789', 'miguel@gmail.com', 'Viajar é viver.', 60),
(4, 'joana_mendes', 'PasswordUltraSegura#ABC', 'joana@gmail.com', 'Cultura e gastronomia.', 95),
(5, 'carolina_ribeiro', 'PasswordMuitoSegura#477', 'carolina.ribeiro@gmail.com', 'Amante de viagens culturais e gastronómicas', 70),
(6, 'admin_nomalia', 'AdminPasswordSuperSafe#1', 'admin@nomalia.com', 'Administrador.', 0);

-- VIAGENS
INSERT INTO viagem (id_viagem, data_partida, data_chegada, id_tipo_viagem, id_utilizador) VALUES
(1, '2024-02-10', '2024-02-18', 3, 1),
(2, '2023-09-10', '2023-09-15', 1, 2),
(3, '2024-03-01', '2024-03-10', 3, 4),
(4, '2024-04-05', '2024-04-20', 2, 1),
(5, '2024-05-01', '2024-05-12', 1, 3),
(6, '2024-06-10', '2024-06-15', 4, 5),
(7, '2024-07-01', '2024-07-07', 1, 2),
(8, '2024-08-10', '2024-08-25', 1, 3);

-- ASSOCIAÇÃO VIAGEM CIDADE
INSERT INTO viagem_cidade (id_viagem, id_cidade) VALUES 
    (1, 10), (1, 11),        -- Islândia
    (2, 6), (2, 8),          -- Espanha
    (3, 13), (3, 15), (3, 16), -- Itália (Roma, Florença, Veneza)
    (4, 19), (4, 20), (4, 21), -- EUA
    (5, 22), (5, 23), (5, 24), -- Japão
    (6, 17), (6, 18),        -- França
    (7, 1), (7, 5),          -- Portugal
    (8, 25), (8, 27);        -- Brasil


-- PUBLICAÇÕES
INSERT INTO publicacao (id_publicacao, data, descricao, id_viagem, id_utilizador) VALUES
(1, '2024-02-15', 'As paisagens da Islândia são irreais.', 1, 1),
(2, '2023-09-14', 'Barcelona é cheia de energia.', 2, 2),
(3, '2024-03-06', 'Roma é história viva.', 3, 4),
(4, '2024-04-12', 'Viagem profissional intensa.', 4, 1),
(5, '2024-05-07', 'Japão superou expectativas.', 5, 3),
(6, '2024-06-13', 'Gastronomia francesa incrível.', 6, 5),
(7, '2024-07-04', 'Portugal é sempre especial.', 7, 2),
(8, '2024-08-18', 'Brasil é pura alegria.', 8, 3);


-- FICHEIROS ÁUDIO-VISUAIS
INSERT INTO ficheiro_audio_visual (id_ficheiro, ficheiro_audiovisual, id_publicacao)
VALUES
(1, 'media/foto1.jpg', 1),
(2, 'media/video1.mp4', 1),
(3, 'media/foto2.jpg', 2),
(4, 'media/lisboa1.jpg', 3),
(5, 'media/trabalho1.jpg', 4),
(6, 'media/neve1.jpg', 5),
(7, 'media/neve2.mp4', 5),
(8, 'media/paris.jpg', 6),
(9, 'media/roma.jpg', 7),
(10,'media/japao.mp4', 8);


-- COMENTÁRIOS
INSERT INTO comentario (id_comentario, comentario, id_utilizador, id_publicacao) VALUES
(1, 'Que lugar incrível!', 2, 1),
(2, 'Está na minha lista!', 3, 1),
(3, 'Barcelona nunca falha.', 1, 2),
(4, 'Roma é eterna.', 2, 3),
(5, 'Boa sorte na viagem!', 4, 4),
(6, 'Japão parece mágico.', 1, 5),
(7, 'Comida francesa é única.', 3, 6),
(8, 'Portugal é casa.', 5, 7);



-- SEGUIDORES
INSERT INTO segue (id_utilizador, id_seguidor) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 4),
(4, 1),
(5, 2);


-- VALES DE DESCONTO
INSERT INTO vale_de_desconto (id_vale_de_desconto, usado, id_tipo_vale, id_utilizador) VALUES
(1, FALSE, 1, 1),
(2, TRUE, 1, 2),
(3, FALSE, 2, 4);

