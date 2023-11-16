-- Schema desm2
-- -----------------------------------------------------

-- CREATE DATABASE desm2;
USE desm2;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- Table `desm2`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desm2`.`pais` (
  `cod_pais` INT NOT NULL AUTO_INCREMENT,
  `nome_pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_pais`))
ENGINE = InnoDB;

-- Table `desm2`.`jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desm2`.`jogo` (
  `cod_jogo` INT NOT NULL AUTO_INCREMENT,
  `nome_jogo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_jogo`))
ENGINE = InnoDB;

-- Table `desm2`.`jogador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desm2`.`jogador` (
  `cod_jogador` INT NOT NULL AUTO_INCREMENT,
  `nome_jogador` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `num_vitorias` INT NOT NULL,
  `num_derrotas` INT NOT NULL,
  `total_partidas` INT NOT NULL,
  `cod_pais` INT NOT NULL,
  `cod_jogo` INT NOT NULL,
  PRIMARY KEY (`cod_jogador`),
  INDEX `fk_jogador_pais_idx` (`cod_pais` ASC) VISIBLE,
  INDEX `fk_jogador_jogo1_idx` (`cod_jogo` ASC) VISIBLE,
  CONSTRAINT `fk_jogador_pais`
    FOREIGN KEY (`cod_pais`)
    REFERENCES `desm2`.`pais` (`cod_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_jogo1`
    FOREIGN KEY (`cod_jogo`)
    REFERENCES `desm2`.`jogo` (`cod_jogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SELECT * FROM pais LIMIT 10;

INSERT INTO jogador (nome_jogador, genero, data_nascimento, num_vitorias, num_derrotas, total_partidas, cod_pais, cod_jogo)
(SELECT stg.jogador,
	stg.genero,
	stg.data_nascimento,
	stg.num_vitorias,
	stg.num_derrotas,
	stg.total_partidas,
	pais.cod_pais,
    jogo.cod_jogo
FROM stg_jogador AS stg
JOIN jogo ON stg.jogo = jogo.jogo
JOIN pais ON stg.pais = pais.pais
);

-- Questão 1
SELECT pais.pais, AVG(jog.num_vitorias) AS num_vitorias
	FROM jogador AS jog
    JOIN pais ON jog.cod_pais = pais.cod_pais
    GROUP BY pais.pais
    ORDER BY num_vitorias ASC;

-- Questão 2
SELECT SUM(jog.num_derrotas) AS num_derrotas
	FROM jogador AS jog
    JOIN jogo ON jog.cod_jogo = jogo.cod_jogo
    JOIN pais ON jog.cod_pais = pais.cod_pais
    WHERE jogo.jogo = 'Dama' AND pais.pais = 'Argentina';
    
-- Questão 3
SELECT jogo.jogo, COUNT(jog.cod_jogo) AS qtd_jogadores
	FROM jogador AS jog
    JOIN jogo ON jog.cod_jogo = jogo.cod_jogo
    WHERE jog.genero = 'Feminino'
    GROUP BY jogo.jogo
    ORDER BY qtd_jogadores ASC;
    
-- Questão 5
SELECT jogo.jogo, SUM(jog.total_partidas) AS qtd_totais_partidas
	FROM jogador AS jog
    JOIN jogo ON jog.cod_jogo = jogo.cod_jogo
    GROUP BY jogo.jogo
    ORDER BY qtd_totais_partidas ASC;
