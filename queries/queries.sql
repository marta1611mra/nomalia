USE nomalia;

-- I1 Gestão de Seguidores/Seguidos
SELECT seguido.nome_utilizador AS NomeSeguido
FROM segue s
INNER JOIN utilizador seguido ON s.id_utilizador = seguido.id_utilizador
WHERE s.id_seguidor = 1;

SELECT u_seguidor.nome_utilizador AS NomeSeguidor
FROM segue s
INNER JOIN utilizador u_seguidor ON s.id_seguidor = u_seguidor.id_utilizador
WHERE s.id_utilizador = 1;

-- I2 e I3 Gestão de Publicações e Viagens
CALL RegistarViagemPublicacao(3, 1, '2025-11-16', '2025-11-23', 'A cidade é realmente um paraíso!');

-- I4 Consulta de Comentários
SELECT u.nome_utilizador, p.descricao AS DescricaoPublicacao, c.comentario AS TextoComentario           
FROM utilizador u      
JOIN comentario c ON u.id_utilizador = c.id_utilizador
JOIN publicacao p ON c.id_publicacao = p.id_publicacao;

-- I5 Gestão de Comentários
CALL CriarComentario(1, 1, 'Que lindo! Adorei a foto.');

-- I6 Gestão do Perfil do Utilizador
SELECT nome_utilizador, email, biografia, pontos 
FROM utilizador 
WHERE id_utilizador = 2;

CALL AtualizarPerfil(2, 'Explorador nato e apaixonado por fotografia!');

UPDATE utilizador 
SET biografia = NULL 
WHERE id_utilizador = 2;

-- I7 Consulta de Vales
SELECT u.nome_utilizador, t.valor_pontos_tipo
FROM utilizador u
JOIN vale_de_desconto v ON u.id_utilizador = v.id_utilizador
JOIN tipo_vale t ON v.id_tipo_vale = t.id_tipo_vale;

-- I8 Administração de publicações/comentários

DELETE FROM comentario
WHERE id_publicacao IN (
    SELECT id_publicacao
    FROM publicacao
    WHERE id_viagem = 1
);

DELETE FROM ficheiro_audio_visual
WHERE id_publicacao IN (
    SELECT id_publicacao
    FROM publicacao
    WHERE id_viagem = 1
);


DELETE FROM publicacao
WHERE id_viagem = 1;

DELETE FROM viagem_cidade
WHERE id_viagem = 1;


DELETE FROM viagem
WHERE id_viagem = 1;
