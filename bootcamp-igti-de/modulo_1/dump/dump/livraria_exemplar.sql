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
-- Table structure for table `exemplar`
--

DROP TABLE IF EXISTS `exemplar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exemplar` (
  `id_exemplar` int DEFAULT NULL,
  `id_livro` int DEFAULT NULL,
  `ISBN` int DEFAULT NULL,
  `id-exemplar` int DEFAULT NULL,
  `situação` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exemplar`
--

LOCK TABLES `exemplar` WRITE;
/*!40000 ALTER TABLE `exemplar` DISABLE KEYS */;
INSERT INTO `exemplar` VALUES (1,1,764321,1,'disponível'),(2,1,764321,2,'disponível'),(3,2,4347421,1,'extraviado'),(4,3,64732829,1,'em manutenção'),(5,3,64732829,2,'disponível'),(6,4,236678678,1,'disponível'),(7,5,12354321,1,'disponível'),(8,6,67849098,1,'disponível'),(9,7,274532617,1,'disponível'),(10,8,7644309,1,'disponível'),(11,9,98076534,1,'disponível'),(12,10,3214666,1,'emprestado'),(13,10,3214666,2,'extraviado'),(14,11,3214665,1,'disponível'),(15,11,3214665,2,'disponível'),(16,11,3214665,3,'disponível'),(17,12,12323455,1,'disponível'),(18,12,12323455,2,'disponível'),(19,13,8764320,1,'disponível'),(20,13,8764320,2,'disponível'),(21,13,8764320,3,'disponível'),(22,14,8764319,1,'disponível'),(23,14,8764319,2,'em manutenção'),(24,14,8764319,3,'disponível'),(25,15,8764318,1,'disponível'),(26,16,98764320,1,'disponível'),(27,16,98764320,2,'disponível'),(28,16,98764320,3,'disponível'),(29,17,98764319,1,'em manutenção'),(30,17,98764319,2,'disponível'),(31,18,98764318,1,'disponível'),(32,19,68764320,1,'disponível'),(33,22,123455,1,'disponível'),(34,22,123455,2,'disponível'),(35,23,123454,1,'disponível');
/*!40000 ALTER TABLE `exemplar` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-27  2:35:08
