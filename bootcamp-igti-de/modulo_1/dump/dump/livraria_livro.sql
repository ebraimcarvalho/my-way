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
-- Table structure for table `livro`
--

DROP TABLE IF EXISTS `livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro` (
  `id` int DEFAULT NULL,
  `titulo_livro` text,
  `numero_edicao` int DEFAULT NULL,
  `ano_edicao` int DEFAULT NULL,
  `codigo_editora` int DEFAULT NULL,
  `idioma` text,
  `area_conhecimento` text,
  `preco` double DEFAULT NULL,
  `ISBN` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro`
--

LOCK TABLES `livro` WRITE;
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
INSERT INTO `livro` VALUES (1,'Pelas Ruas de Calcutá',1,1990,5,'Português','1',36.1,'764321'),(2,'Devoted - Devoção',1,2000,4,'Português','1',27.2,'4347421'),(3,'Rápido e Devagar - Duas Formas de Pensar',3,2015,8,'Inglês','3',43.9,'64732829'),(4,'Xô, Bactéria! Tire Suas Dúvidas Com Dr. Bactéria',10,2019,4,'Português','',32.7,'236678678'),(5,'P.s. - Eu Te Amo ',4,2010,4,'Português','4',23.5,'12354321'),(6,'O Que Esperar Quando Você Está Esperando',3,2000,4,'Português','',37.8,'67849098'),(7,'As Melhores Frases Em Veja',1,2017,4,'Português','7',23.9,'274532617'),(8,'Bichos Monstruosos',1,2015,12,'Português','6',24.9,'7644309'),(9,'Casas Mal Assombradas',1,1995,10,'Português','6',27.9,'98076534'),(10,'Colapso',12,2005,13,'Português','6',92.9,'3214667-1'),(11,'Colapso',12,2005,13,'Inglês','6',92.9,'3214667-2'),(12,'Armas, germes e aço',23,2017,13,'Português','6',100.99,'12323456-1'),(13,'Memórias Póstumas de Brás Cubas',1,1881,1,'Português','5',22.5,'8764321-1'),(14,'Memórias Póstumas de Brás Cubas',1,1881,1,'Espanhol','9',22.5,'8764321-2'),(15,'Memórias Póstumas de Brás Cubas',1,1881,12,'Inglês','5',22.5,'8764321-3'),(16,'Dom Casmurro',1,1899,1,'Português','5',25.9,'98764321-1'),(17,'Dom Casmurro',1,1899,12,'Inglês','5',35.9,'98764321-2'),(18,'Dom Casmurro',1,1899,1,'Espanhol','5',25.9,'98764321-3'),(19,'Quincas Borba',1,1891,5,'Português','5',35.9,'68764321-1'),(22,'Sapiens: Uma breve história da humanidade',1,2018,5,'Português','6',50,'123456-1'),(23,'Sapiens: Uma breve história da humanidade',1,2018,5,'Alemão','6',50,'123456-2');
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
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
