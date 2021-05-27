-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`editora` (
  `id_editora` INT NOT NULL,
  `nome_editora` VARCHAR(100) NULL,
  `pais` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(150) NULL,
  PRIMARY KEY (`id_editora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`area_conhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`area_conhecimento` (
  `id_area_conhecimento` INT NOT NULL,
  `descricao` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id_area_conhecimento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`obra` (
  `id_obra` INT NOT NULL,
  `titulo_obra` VARCHAR(150) NULL,
  `numero_edicao` INT NULL,
  `ano_publicacao` INT NULL,
  `id_editora` INT NOT NULL,
  `id_area_conhecimento` INT NOT NULL,
  `isbn` INT NOT NULL,
  PRIMARY KEY (`id_obra`),
  CONSTRAINT `fk_obra_editora`
    FOREIGN KEY (`id_editora`)
    REFERENCES `biblioteca`.`editora` (`id_editora`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_obra_area_conhecimento1`
    FOREIGN KEY (`id_area_conhecimento`)
    REFERENCES `biblioteca`.`area_conhecimento` (`id_area_conhecimento`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_obra_editora_idx` ON `biblioteca`.`obra` (`id_editora` ASC) VISIBLE;

CREATE INDEX `fk_obra_area_conhecimento1_idx` ON `biblioteca`.`obra` (`id_area_conhecimento` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `biblioteca`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autor` (
  `id_autor` INT NOT NULL,
  `nome_autor` VARCHAR(150) NULL,
  `pais_nacionalidade` VARCHAR(80) NULL,
  PRIMARY KEY (`id_autor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`autor_has_obra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autor_has_obra` (
  `id_autor` INT NOT NULL,
  `id_obra` INT NOT NULL,
  PRIMARY KEY (`id_autor`, `id_obra`),
  CONSTRAINT `fk_autor_has_obra_autor1`
    FOREIGN KEY (`id_autor`)
    REFERENCES `biblioteca`.`autor` (`id_autor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_autor_has_obra_obra1`
    FOREIGN KEY (`id_obra`)
    REFERENCES `biblioteca`.`obra` (`id_obra`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_autor_has_obra_obra1_idx` ON `biblioteca`.`autor_has_obra` (`id_obra` ASC) VISIBLE;

CREATE INDEX `fk_autor_has_obra_autor1_idx` ON `biblioteca`.`autor_has_obra` (`id_autor` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `biblioteca`.`exemplar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`exemplar` (
  `id_exemplar` INT NOT NULL,
  `id_obra` INT NOT NULL,
  `isbn_obra` INT NOT NULL,
  `data_aquisicao` DATE NOT NULL,
  `situacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_exemplar`),
  CONSTRAINT `fk_id_obra`
    FOREIGN KEY (`id_obra`)
    REFERENCES `biblioteca`.`obra` (`id_obra`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_id_obra_idx` ON `biblioteca`.`exemplar` (`id_obra` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `biblioteca`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`usuario` (
  `id_usuario` INT NOT NULL,
  `nome_usuario` VARCHAR(150) NOT NULL,
  `cpf` INT NOT NULL,
  `rg` INT NULL,
  `data_nascimento` DATE NULL,
  `genero` VARCHAR(20) NULL,
  `email` VARCHAR(150) NOT NULL,
  `cep` INT NULL,
  `logradouro` VARCHAR(30) NULL,
  `numero_complemento` INT NULL,
  `bairro` VARCHAR(80) NULL,
  `cidade` VARCHAR(80) NULL,
  `pais` VARCHAR(80) NULL,
  `escolaridade` VARCHAR(60) NULL,
  `estado_civil` VARCHAR(45) NULL,
  `tel_fixo` VARCHAR(45) NULL,
  `tel_celular` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`emprestimo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`emprestimo` (
  `id_emprestimo` INT NOT NULL,
  `id_exemplar` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `data_emprestimo` DATE NULL,
  `data_max_devolucao` DATE NULL,
  `data_efetiva_devolucao` DATE NULL,
  `horario_emprestimo` DATETIME NULL,
  PRIMARY KEY (`id_emprestimo`, `id_exemplar`, `id_usuario`),
  CONSTRAINT `fk_exemplar_has_usuario_exemplar1`
    FOREIGN KEY (`id_exemplar`)
    REFERENCES `biblioteca`.`exemplar` (`id_exemplar`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_exemplar_has_usuario_usuario1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `biblioteca`.`usuario` (`id_usuario`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_exemplar_has_usuario_usuario1_idx` ON `biblioteca`.`emprestimo` (`id_usuario` ASC) VISIBLE;

CREATE INDEX `fk_exemplar_has_usuario_exemplar1_idx` ON `biblioteca`.`emprestimo` (`id_exemplar` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
