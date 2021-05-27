-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema livraria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema livraria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `livraria` DEFAULT CHARACTER SET utf8 ;
USE `livraria` ;

-- -----------------------------------------------------
-- Table `livraria`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`estado` (
  `cod_estado_ibge` INT NOT NULL,
  `nomel_estado` VARCHAR(45) NOT NULL,
  `sigla_estado` VARCHAR(2) NOT NULL,
  `regiao` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_estado_ibge`))
ENGINE = InnoDB;

CREATE INDEX `sigla_idx` ON `livraria`.`estado` (`sigla_estado` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `livraria`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`cidade` (
  `cod_cidade_ibge` INT NOT NULL,
  `nome_cidade` VARCHAR(80) NOT NULL,
  `cod_estado_ibge` INT NOT NULL,
  PRIMARY KEY (`cod_cidade_ibge`),
  CONSTRAINT `fk_cidade_estado`
    FOREIGN KEY (`cod_estado_ibge`)
    REFERENCES `livraria`.`estado` (`cod_estado_ibge`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_cidade_estado_idx` ON `livraria`.`cidade` (`cod_estado_ibge` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `livraria`.`livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`livro` (
  `id_livro` INT NOT NULL AUTO_INCREMENT,
  `titulo_livro` VARCHAR(120) NOT NULL,
  `numero_edicao` INT NOT NULL,
  `ano_edicao` INT NOT NULL,
  PRIMARY KEY (`id_livro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `livraria`.`editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `livraria`.`editora` (
  `cod_editora` INT NOT NULL AUTO_INCREMENT,
  `nomel_editora` VARCHAR(45) NOT NULL,
  `telefone_editora` VARCHAR(30) NULL,
  `cod_cidade_ibge` INT NOT NULL,
  `id_livro` INT NULL,
  PRIMARY KEY (`cod_editora`),
  CONSTRAINT `fk_editora_cidade1`
    FOREIGN KEY (`cod_cidade_ibge`)
    REFERENCES `livraria`.`cidade` (`cod_cidade_ibge`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_editora_livro1`
    FOREIGN KEY (`id_livro`)
    REFERENCES `livraria`.`livro` (`id_livro`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_editora_cidade1_idx` ON `livraria`.`editora` (`cod_cidade_ibge` ASC) VISIBLE;

CREATE INDEX `fk_editora_livro1_idx` ON `livraria`.`editora` (`id_livro` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `livraria`.`estado`
-- -----------------------------------------------------
START TRANSACTION;
USE `livraria`;
INSERT INTO `livraria`.`estado` (`cod_estado_ibge`, `nomel_estado`, `sigla_estado`, `regiao`) VALUES (12, 'Pernambuco', 'PE', 'Nordeste');
INSERT INTO `livraria`.`estado` (`cod_estado_ibge`, `nomel_estado`, `sigla_estado`, `regiao`) VALUES (13, 'Paraíba', 'PB', 'Nordeste');
INSERT INTO `livraria`.`estado` (`cod_estado_ibge`, `nomel_estado`, `sigla_estado`, `regiao`) VALUES (14, 'São Paulo', 'SP', 'Sudeste');
INSERT INTO `livraria`.`estado` (`cod_estado_ibge`, `nomel_estado`, `sigla_estado`, `regiao`) VALUES (15, 'Paraná', 'PR', 'Sul');
INSERT INTO `livraria`.`estado` (`cod_estado_ibge`, `nomel_estado`, `sigla_estado`, `regiao`) VALUES (16, 'Amazonas', 'AM', 'Norte');
INSERT INTO `livraria`.`estado` (`cod_estado_ibge`, `nomel_estado`, `sigla_estado`, `regiao`) VALUES (17, 'Distrito Federal', 'DF', 'Centro-Oeste');

COMMIT;

