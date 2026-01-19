USE nomalia;

-- Procedimentos

-- DROP PROCEDURE IF EXISTS TrocarValeDesconto;
DELIMITER $$

CREATE PROCEDURE TrocarValeDesconto(
    IN p_id_utilizador INT,
    IN p_id_tipo_vale INT
)
BEGIN
    DECLARE custo INT;
    DECLARE saldo INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro na troca de vale.';
    END;

    SELECT valor_pontos_tipo INTO custo
    FROM tipo_vale
    WHERE id_tipo_vale = p_id_tipo_vale;

    IF custo IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Tipo de vale inexistente.';
    END IF;

    SET saldo = PontosDisponiveis(p_id_utilizador);

    IF saldo < custo THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Pontos insuficientes.';
    END IF;

    START TRANSACTION;

        UPDATE utilizador
        SET pontos = pontos - custo
        WHERE id_utilizador = p_id_utilizador;

        INSERT INTO vale_de_desconto (usado, id_tipo_vale, id_utilizador)
        VALUES (FALSE, p_id_tipo_vale, p_id_utilizador);

    COMMIT;
END $$

DELIMITER ;

-- DROP PROCEDURE IF EXISTS RegistarViagemPublicacao;
DELIMITER $$

CREATE PROCEDURE RegistarViagemPublicacao(
    IN p_id_utilizador INT,
    IN p_id_tipo_viagem INT,
    IN p_data_partida DATE,
    IN p_data_chegada DATE,
    IN p_descricao VARCHAR(500)
)
BEGIN
    DECLARE v_id_viagem INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Erro ao registar viagem e publicação.';
    END;

    START TRANSACTION;

        INSERT INTO viagem (data_partida, data_chegada, id_tipo_viagem, id_utilizador)
        VALUES (p_data_partida, p_data_chegada, p_id_tipo_viagem, p_id_utilizador);

        SET v_id_viagem = LAST_INSERT_ID();

        INSERT INTO publicacao (data, descricao, id_viagem, id_utilizador)
        VALUES (CURDATE(), p_descricao, v_id_viagem, p_id_utilizador);


    COMMIT;
END $$

DELIMITER ;

-- DROP PROCEDURE IF EXISTS AtualizarPerfil;
DELIMITER $$

CREATE PROCEDURE AtualizarPerfil(
    IN p_id_utilizador INT,
    IN p_biografia VARCHAR(400))
BEGIN
    UPDATE utilizador
    SET biografia = p_biografia
    WHERE id_utilizador = p_id_utilizador ;
END $$

DELIMITER ;

-- Procedimento CriarComentario
-- DROP PROCEDURE IF EXISTS CriarComentario
DELIMITER $$

CREATE PROCEDURE CriarComentario(
    IN p_id_utilizador INT,
    IN p_id_publicacao INT,
    IN p_texto VARCHAR(500)
)
BEGIN
    INSERT INTO comentario (id_utilizador, id_publicacao, comentario)
    VALUES (p_id_utilizador, p_id_publicacao, p_texto);
END $$

DELIMITER ;


-- Funções 
-- DROP FUNCTION IF EXISTS PontosDisponiveis;
DELIMITER $$

CREATE FUNCTION PontosDisponiveis(p_id_utilizador INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE saldo INT;

    SELECT pontos INTO saldo
    FROM utilizador
    WHERE id_utilizador = p_id_utilizador;

    RETURN IFNULL(saldo, 0);
END $$

DELIMITER ;

-- Triggers

-- DROP TRIGGER IF EXISTS ValidaPasse;
DELIMITER $$

CREATE TRIGGER ValidaPasse
BEFORE INSERT ON utilizador
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.palavra_passe) < 15 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'A palavra-passe deve ter pelo menos 15 caracteres.';
    END IF;

    SET NEW.palavra_passe = SHA2(NEW.palavra_passe, 256);
END $$

DELIMITER ;

-- DROP TRIGGER IF EXISTS ImpedeAutoFollow;
DELIMITER $$

CREATE TRIGGER ImpedeAutoFollow
BEFORE INSERT ON segue
FOR EACH ROW
BEGIN
    IF NEW.id_utilizador = NEW.id_seguidor THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Um utilizador não pode seguir-se a si próprio.';
    END IF;
END $$

DELIMITER ;

-- DROP TRIGGER IF EXISTS ValidaComentario;
DELIMITER $$

CREATE TRIGGER ValidaComentario
BEFORE INSERT ON comentario
FOR EACH ROW
BEGIN
    IF NEW.comentario IS NULL OR TRIM(NEW.comentario) = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'O comentário não pode ser vazio.';
    END IF;
END $$
DELIMITER ;

-- DROP TRIGGER IF EXISTS AtribuiPontosPublicacao
DELIMITER $$

CREATE TRIGGER AtribuiPontosPublicacao
AFTER INSERT ON publicacao
FOR EACH ROW
BEGIN
    UPDATE utilizador
    SET pontos = pontos + 10
    WHERE id_utilizador = NEW.id_utilizador;
END $$
DELIMITER ;

-- DROP TRIGGER IF EXISTS ValidaAutorComentario;
DELIMITER $$
CREATE TRIGGER ValidaAutorComentario
BEFORE UPDATE ON comentario
FOR EACH ROW
BEGIN
    IF OLD.id_utilizador <> NEW.id_utilizador THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Não é permitido alterar comentários de outros utilizadores.';
    END IF;
END $$
DELIMITER ;

