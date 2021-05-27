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
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int DEFAULT NULL,
  `nome` text,
  `cpf` bigint DEFAULT NULL,
  `rg` int DEFAULT NULL,
  `data_nascimento` text,
  `sexo` text,
  `email` text,
  `cep` int DEFAULT NULL,
  `logradouro` text,
  `num` int DEFAULT NULL,
  `Bairro` text,
  `cidade` text,
  `UF` text,
  `telefone fixo` bigint DEFAULT NULL,
  `celular` bigint DEFAULT NULL,
  `status` text,
  `estado civil` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Mariana Fátima Viana',17587654968,185600827,'24/06/1963','Feminino','marianafatimaviana@sheilabenavente.com.br',69314533,'Rua Cândido Pereira',987,'Doutor Sílvio Botelho','Boa Vista','RR',9537490617,95986602819,'Ativo',''),(2,'Jéssica Daniela da Mata',22803230445,428875907,'19/02/1954','Feminino','jessicadanieladamata-92@thibe.com.br',74713240,'Rua Guaiaquil',605,'Jardim Novo Mundo','Goiânia','GO',6228169418,62998439117,'Ativo',''),(3,'Juan Paulo Pereira',9779961828,484305256,'27/11/1943','Masculino','juanpaulopereira_@magicday.com.br',69901758,'Rua Arco-íris',605,'Vitória','Rio Branco','AC',6826298043,68999318454,'Ativo',''),(4,'Elias Raul Teixeira',36878713129,380335566,'03/11/1960','Masculino','eeliasraulteixeira@bat.com',77403230,'Rua 3',478,'Jardim Eldorado','Gurupi','TO',6335431427,63987244742,'Ativo',''),(5,'Marcos Vinicius Bento Fogaça',37362747004,165559299,'05/09/2001','Masculino','marcosviniciusbentofogaca@yaooh.com',71261330,'Quadra Quadra 3 Conjunto 25',208,'Setor Leste (Vila Estrutural - Guará)','Brasília','DF',6139883293,61996206560,'Ativo',''),(6,'Rafaela Isabel Raimunda Aparício',1017588635,467470571,'04/07/1984','Feminino','rafaelaisabelraimundaaparicio-92@arablock.com.br',57083064,'Vila Padre Cícero',850,'Antares','Maceió','AL',8228640060,82985070436,'Suspenso',''),(7,'Ana Louise Agatha Galvão',74652481241,329087575,'19/05/1960','Feminino','aanalouiseagathagalvao@abdalathomaz.adv.br',54410323,'1ª Travessa Maria Rita Barradas',909,'Piedade','Jaboatão dos Guararapes','PE',8127840834,81997453396,'Ativo',''),(8,'Analu Evelyn Milena Aparício',48892704508,488384667,'20/05/1950','Feminino','analuevelynmilenaaparicio_@yahool.com.br',78731432,'Rua Gv-22',401,'Setor Residencial Granville II','Rondonópolis','MT',6637208818,66999067930,'Ativo',''),(9,'Francisca Julia Gonçalves',67463166295,322052579,'27/02/1944','Feminino','franciscajuliagoncalves@fernandesfilpi.com.br',60356610,'Travessa Boata',100,'Antônio Bezerra','Fortaleza','CE',8537720094,85988887344,'Ativo',''),(10,'Brenda Sebastiana Regina da Conceição',9387021572,499837794,'27/12/1949','Feminino','brendasebastianareginadaconceicao@solutionimoveis.com.br',96506395,'Rua Bruno Reinaldo Kipper',456,'Nossa Senhora de Fátima','Cachoeira do Sul','RS',5137389592,51988887387,'Ativo',''),(11,'Sophia Tatiane Lopes',2023823110,222874235,'26/12/1997','Feminino','STL@yahool.com.br',79104460,'Rua 66',205,'Vila Nova Campo Grande','Campo Grande','MS',6725963752,67999550907,'Ativo',''),(12,'Marcelo de Lima',21002949467,495922705,'20/12/1996','Masculino','marceloolima@gabiaatelier.com.br',68927393,'Travessa L14 do Provedor',691,'Provedor','Santana','AP',9635009775,96996507201,'Ativo',''),(13,'Maitê Allana Galvão',33898989640,500757008,'19/11/2000','Feminino','mmaiteallanagalvao@pq.cnpq.br',24716400,'Rua Sampaio Rodrigues',487,'Jardim Catarina','São Gonçalo','RJ',2125071076,21998339757,'Ativo',''),(14,'Patricia Nina Antônia Teixeira',60294169873,247838664,'11/05/1977','Feminino','patricianinaantoniateixeira@jonasmartinez.com',68902017,'Rua Três',619,'Beirol','Macapá','AP',9636264952,96998152747,'Ativo',''),(16,'Milene Barcellos',12345678907,97123467,'13/07/1975','Feminino','mbarcallos@gmail.com',77403230,'Rua 4',123,'Jardim Eldorado','Gurupi','TO',6425431427,63987241213,'Ativo',''),(17,'Clarice Damasceno',16273849573,234876987,'21/12/2005','Feminino','clarice@hotmail.com',74713240,'Rua Guaiaquil',604,'Jardim Novo Mundo','Goiânia','GO',8534520094,63982141213,'Ativo','');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
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
