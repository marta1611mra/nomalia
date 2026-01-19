USE nomalia;

-- Roles
DROP ROLE IF EXISTS 'administrador', 'utilizador';
CREATE ROLE 'administrador', 'utilizador';

-- Criação de contas de utilizador 
DROP USER IF EXISTS 'admin1'@'localhost', 'user1'@'localhost';
CREATE USER 'admin1'@'localhost' IDENTIFIED BY 'Admin123#';
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'User123#';

-- Associação de roles
GRANT 'administrador' TO 'admin1'@'localhost';
SET DEFAULT ROLE 'administrador' TO 'admin1'@'localhost';

GRANT 'utilizador' TO 'user1'@'localhost';
SET DEFAULT ROLE 'utilizador' TO 'user1'@'localhost';


-- RM 13 (Seguir utilizadores,deixar de seguir e  visualizar seguidores)
GRANT INSERT, SELECT, DELETE ON segue TO 'utilizador';

-- RM 14 e 15 (Criar, editar e visualizar publicações e viagens)
GRANT SELECT, UPDATE ON viagem TO 'utilizador';
GRANT SELECT, UPDATE ON publicacao TO 'utilizador';
GRANT EXECUTE ON PROCEDURE RegistarViagemPublicacao TO 'utilizador';

-- RM 16 e 17 (Inserção, edição e visualização de comentários)
GRANT SELECT, UPDATE ON comentario TO 'utilizador';
GRANT EXECUTE ON PROCEDURE CriarComentario TO 'utilizador';

-- RM 18 (Inserir, editar e visualizar dados do perfil)
GRANT SELECT (id_utilizador, nome_utilizador, email, biografia, pontos)
ON utilizador
TO 'utilizador';
GRANT EXECUTE ON PROCEDURE AtualizarPerfil TO 'utilizador';

-- RM 19 (Trocar pontos por vales de desconto)
GRANT SELECT ON tipo_vale TO 'utilizador';
GRANT SELECT ON vale_de_desconto TO 'utilizador';
GRANT EXECUTE ON PROCEDURE TrocarValeDesconto TO 'utilizador';
GRANT EXECUTE ON FUNCTION PontosDisponiveis TO 'utilizador';


-- RM 20 e RC 26 (O administrador visualizar e remover viagens,publicações e os comentários)
GRANT SELECT, DELETE ON viagem TO 'administrador';
GRANT SELECT, DELETE ON publicacao TO 'administrador';
GRANT SELECT, DELETE ON comentario TO 'administrador';
GRANT SELECT, DELETE ON viagem_cidade TO 'administrador';
GRANT SELECT, DELETE ON ficheiro_audio_visual TO 'administrador';
GRANT SELECT (id_utilizador, nome_utilizador, email, biografia,pontos) ON nomalia.utilizador
TO administrador;
