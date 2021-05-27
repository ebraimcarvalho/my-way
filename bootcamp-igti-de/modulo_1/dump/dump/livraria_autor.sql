CREATE DATABASE  IF NOT EXISTS `livraria` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `livraria`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: livraria
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `id` int DEFAULT NULL,
  `nome` text,
  `biografia` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Roberto Martins Figueiredo','Roberto Martins Figueiredo é um biomédico brasileiro, conhecido como Dr. Bactéria ao participar do quadro Tá limpo do programa Fantástico. Na série, ele falava dos perigos microscópicos que se escondem no cotidiano, esclarecendo dúvidas sobre contaminação de alimentos, higiene, saúde pública e temas relacionados.'),(2,'Daniel Kahneman','Daniel Kahneman é um teórico da economia comportamental, a qual combina a economia com a ciência cognitiva para explicar o comportamento aparentemente irracional da gestão do risco pelos seres humanos.'),(3,'Hilary Duff',''),(4,'Robson Pinheiro','Robson Pinheiro Santos é um médium psicógrafo brasileiro. Suas obras psicografadas destacam-se pela influência da Umbanda.'),(5,'Cecelia Ahern',''),(6,'Arlene Eisenberg','Arlene Leila Scharaga Eisenberg foi uma autora mais conhecida por suas contribuições aos pais na literatura de auto-ajuda. Eisenberg co-escreveu o que foi descrito como a \'bíblia da gravidez americana\', o que esperar quando você está esperando'),(7,'Sandee Hathaway',''),(8,'Heidi Murkoff','Heidi Murkoff é autora da série de guias de gravidez O que esperar quando você está esperando. Ela também é a criadora de WhatToExpect.com e fundadora da Fundação What to Expect. A revista Time nomeou Murkoff como uma das 100 pessoas mais influentes do mundo em 2011.'),(9,'Julio Cesar de Barros','Jornalista e Escritor'),(10,'Maria José Valero','Bióloga e Escritora'),(11,'Jared Diamond',''),(12,'Monteiro Lobato','José Bento Renato Monteiro Lobato foi um escritor, ativista, diretor e produtor brasileiro. Foi um importante editor de livros inéditos e autor de importantes traduções.'),(13,'Machado de Assis','Joaquim Maria Machado de Assis foi um escritor brasileiro, considerado por muitos críticos, estudiosos, escritores e leitores um dos maiores senão o maior nome da literatura do Brasil.'),(14,'Yuval Noah Harari','Professor israelense de História');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-27  2:35:07
