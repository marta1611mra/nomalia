
-- -----------------------------------------------------
-- DATABASE nomalia
-- -----------------------------------------------------

-- DROP DATABASE IF EXISTS nomalia;
CREATE DATABASE IF NOT EXISTS nomalia     
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE nomalia ;

-- -----------------------------------------------------
-- Table tipo_viagem
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipo_viagem (
    id_tipo_viagem INT AUTO_INCREMENT,
    nome_tipo VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_tipo_viagem),
    UNIQUE (nome_tipo)
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table utilizador
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS utilizador (
    id_utilizador INT AUTO_INCREMENT,
    nome_utilizador VARCHAR(45) NOT NULL,
    palavra_passe VARCHAR(64) NOT NULL,
    email VARCHAR(45) NOT NULL,
    biografia VARCHAR(400),
    pontos INT NOT NULL,
    PRIMARY KEY (id_utilizador),
    UNIQUE (nome_utilizador),
    UNIQUE (email)
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table pais
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pais (
    id_pais INT AUTO_INCREMENT,
    nome_pais VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_pais),
    UNIQUE (nome_pais)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table cidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cidade (
    id_cidade INT AUTO_INCREMENT,
    nome_cidade VARCHAR(45) NOT NULL,
    id_pais INT NOT NULL,
    PRIMARY KEY (id_cidade),
    FOREIGN KEY (id_pais)
        REFERENCES pais(id_pais)
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table viagem
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS viagem (
    id_viagem INT AUTO_INCREMENT,
    data_partida DATE NOT NULL,
    data_chegada DATE NOT NULL,
    id_tipo_viagem INT NOT NULL,
    id_utilizador INT NOT NULL,
    PRIMARY KEY (id_viagem),
    FOREIGN KEY (id_tipo_viagem)
        REFERENCES tipo_viagem(id_tipo_viagem),
    FOREIGN KEY (id_utilizador)
        REFERENCES utilizador(id_utilizador)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table viagem_cidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS viagem_cidade (
    id_viagem INT NOT NULL,
    id_cidade INT NOT NULL,
    PRIMARY KEY (id_viagem, id_cidade),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem),
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

-- -----------------------------------------------------
-- Table publicacao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS publicacao (
    id_publicacao INT AUTO_INCREMENT,
    data DATE NOT NULL,
    descricao VARCHAR(500),
    id_viagem INT NOT NULL,
    id_utilizador INT NOT NULL,
    PRIMARY KEY (id_publicacao),
    UNIQUE (id_viagem),
    FOREIGN KEY (id_viagem) REFERENCES viagem(id_viagem),
    FOREIGN KEY (id_utilizador) REFERENCES utilizador(id_utilizador)
);

-- -----------------------------------------------------
-- Table ficheiros_audio_visual
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS ficheiro_audio_visual (
    id_ficheiro INT AUTO_INCREMENT,
    ficheiro_audiovisual VARCHAR(400) NOT NULL,
    id_publicacao INT NOT NULL,
    PRIMARY KEY (id_ficheiro),
    FOREIGN KEY (id_publicacao)
        REFERENCES publicacao(id_publicacao)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table comentario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS comentario (
    id_comentario INT AUTO_INCREMENT,
    comentario VARCHAR(500),
    id_utilizador INT NOT NULL,
    id_publicacao INT NOT NULL,
    PRIMARY KEY (id_comentario),
    FOREIGN KEY (id_utilizador)
        REFERENCES utilizador(id_utilizador),
    FOREIGN KEY (id_publicacao)
        REFERENCES publicacao(id_publicacao)
) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table segue
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS segue (
    id_utilizador INT NOT NULL,
    id_seguidor INT NOT NULL,
    PRIMARY KEY (id_utilizador, id_seguidor),
    FOREIGN KEY (id_utilizador)
        REFERENCES utilizador(id_utilizador),
    FOREIGN KEY (id_seguidor)
        REFERENCES utilizador(id_utilizador)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table tipo_vale
-- -----------------------------------------------------
CREATE TABLE tipo_vale ( 
id_tipo_vale INT AUTO_INCREMENT, 
nome_tipo_vale VARCHAR(45) NOT NULL CHECK (nome_tipo_vale IN ('hotel', 'atividade', 'companhia aerea')), 
descricao_tipo VARCHAR(300) NOT NULL, 
valor_pontos_tipo INT NOT NULL, 
PRIMARY KEY (id_tipo_vale), 
UNIQUE (nome_tipo_vale)
 ) ENGINE=InnoDB;


-- -----------------------------------------------------
-- Table vale_de_desconto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS vale_de_desconto (
    id_vale_de_desconto INT AUTO_INCREMENT,
    usado BOOLEAN NOT NULL,
    id_tipo_vale INT NOT NULL,
    id_utilizador INT NOT NULL,
    PRIMARY KEY (id_vale_de_desconto),
    FOREIGN KEY (id_tipo_vale)
        REFERENCES tipo_vale(id_tipo_vale),
    FOREIGN KEY (id_utilizador)
        REFERENCES utilizador(id_utilizador)
) ENGINE=InnoDB;
