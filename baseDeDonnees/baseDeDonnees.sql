-- mysqldump-php https://github.com/ifsnop/mysqldump-php
--
-- Host: localhost	Database: projets4
-- ------------------------------------------------------
-- Server version 	5.7.23
-- Date: Sun, 03 Mar 2019 07:33:26 +0000

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `category` VALUES (1,'Enfant'),(2,'Junior'),(3,'Adulte');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `category` with 3 row(s)
--

--
-- Table structure for table `club`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `club` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ville_club` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_postal_club` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_club` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_club_owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_club` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_B8EE387227D818F7` (`email_club`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `club`
--

LOCK TABLES `club` WRITE;
/*!40000 ALTER TABLE `club` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `club` VALUES (2,'admin','admin','25310','0381359831','admin','$2y$13$6.GD.C5/hpFh7r6UwWOD2ut/9tJdcr7/9Qikmha3KGQO09KyS19We','admin@gmail.com','\"ROLE_ADMIN\"');
/*!40000 ALTER TABLE `club` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `club` with 1 row(s)
--

--
-- Table structure for table `competition`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `club_organizer_id` int(11) DEFAULT NULL,
  `date_competition` date NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` decimal(5,0) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nb_max_team` decimal(4,0) NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B50A2CB1FDD8E52A` (`club_organizer_id`),
  CONSTRAINT `FK_B50A2CB1FDD8E52A` FOREIGN KEY (`club_organizer_id`) REFERENCES `club` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition`
--

LOCK TABLES `competition` WRITE;
/*!40000 ALTER TABLE `competition` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `competition` VALUES (1,2,'2019-02-02','montbeliard','2 rue blabla',25300,'compet 1',8,'compet club admin only'),(2,2,'2019-03-06','bla','3 rue blabla',25310,'compet 2',50,'yo');
/*!40000 ALTER TABLE `competition` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `competition` with 2 row(s)
--

--
-- Table structure for table `competition_dance`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competition_dance` (
  `competition_id` int(11) NOT NULL,
  `dance_id` int(11) NOT NULL,
  PRIMARY KEY (`competition_id`,`dance_id`),
  KEY `IDX_EBFCCFB97B39D312` (`competition_id`),
  KEY `IDX_EBFCCFB965D64EDD` (`dance_id`),
  CONSTRAINT `FK_EBFCCFB965D64EDD` FOREIGN KEY (`dance_id`) REFERENCES `dance` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_EBFCCFB97B39D312` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition_dance`
--

LOCK TABLES `competition_dance` WRITE;
/*!40000 ALTER TABLE `competition_dance` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `competition_dance` VALUES (1,2),(1,4),(2,2),(2,4);
/*!40000 ALTER TABLE `competition_dance` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `competition_dance` with 4 row(s)
--

--
-- Table structure for table `competition_judge`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competition_judge` (
  `competition_id` int(11) NOT NULL,
  `judge_id` int(11) NOT NULL,
  PRIMARY KEY (`competition_id`,`judge_id`),
  KEY `IDX_E24CF1C27B39D312` (`competition_id`),
  KEY `IDX_E24CF1C2B7D66194` (`judge_id`),
  CONSTRAINT `FK_E24CF1C27B39D312` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_E24CF1C2B7D66194` FOREIGN KEY (`judge_id`) REFERENCES `judge` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition_judge`
--

LOCK TABLES `competition_judge` WRITE;
/*!40000 ALTER TABLE `competition_judge` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `competition_judge` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7);
/*!40000 ALTER TABLE `competition_judge` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `competition_judge` with 12 row(s)
--

--
-- Table structure for table `competition_team`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `competition_team` (
  `competition_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`competition_id`,`team_id`),
  KEY `IDX_CAA3380D7B39D312` (`competition_id`),
  KEY `IDX_CAA3380D296CD8AE` (`team_id`),
  CONSTRAINT `FK_CAA3380D296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_CAA3380D7B39D312` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competition_team`
--

LOCK TABLES `competition_team` WRITE;
/*!40000 ALTER TABLE `competition_team` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `competition_team` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6);
/*!40000 ALTER TABLE `competition_team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `competition_team` with 12 row(s)
--

--
-- Table structure for table `dance`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_dance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dance`
--

LOCK TABLES `dance` WRITE;
/*!40000 ALTER TABLE `dance` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `dance` VALUES (1,'disco'),(2,'hip hop'),(3,'popping'),(4,'break dance'),(5,'dance show'),(6,'salsa'),(7,'show caraibe'),(8,'swing'),(9,'tango argentino'),(10,'claquettes');
/*!40000 ALTER TABLE `dance` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `dance` with 10 row(s)
--

--
-- Table structure for table `dancer`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dancer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `club_id` int(11) NOT NULL,
  `name_dancer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name_dancer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_birth_dancer` date NOT NULL,
  `email_dancer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_authorized` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_B11CC8A961190A32` (`club_id`),
  CONSTRAINT `FK_B11CC8A961190A32` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dancer`
--

LOCK TABLES `dancer` WRITE;
/*!40000 ALTER TABLE `dancer` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `dancer` VALUES (2,2,'dancerA','dA','1999-06-01','test@gmail.com',1),(3,2,'dancerB','dB','1999-02-02','test@gmail.com',1),(4,2,'dancerC','dC','2000-02-02','test@gmail.com',1),(5,2,'dancerD','dD','1999-02-01','test@gmail.com',1),(6,2,'dancerE','dE','1999-02-02','test@gmail.com',1),(7,2,'dancerF','dF','1999-01-01','test@gmail.com',1),(9,2,'dancerH','dH','2000-02-02','test@gmail.com',1),(10,2,'dancerI','dI','1998-02-02','test@gmail.com',1),(11,2,'dancerJ','dJ','1998-02-02','test@gmail.com',1),(12,2,'dancerG','dG','2000-02-02','test@gmail.com',1),(13,2,'dancerK','dK','2000-02-02','test@gmail.com',1),(14,2,'dancerL','dL','1998-02-02','test@gmail.com',1);
/*!40000 ALTER TABLE `dancer` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `dancer` with 12 row(s)
--

--
-- Table structure for table `judge`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `judge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_judge` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name_judge` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `judge`
--

LOCK TABLES `judge` WRITE;
/*!40000 ALTER TABLE `judge` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `judge` VALUES (1,'A','a'),(2,'B','b'),(3,'C','c'),(4,'D','d'),(5,'E','e'),(6,'F','f'),(7,'G','g');
/*!40000 ALTER TABLE `judge` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `judge` with 7 row(s)
--

--
-- Table structure for table `mailbox`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `club` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailbox`
--

LOCK TABLES `mailbox` WRITE;
/*!40000 ALTER TABLE `mailbox` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `mailbox` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `mailbox` with 0 row(s)
--

--
-- Table structure for table `reglement`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reglement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pdf_file` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reglement`
--

LOCK TABLES `reglement` WRITE;
/*!40000 ALTER TABLE `reglement` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `reglement` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `reglement` with 0 row(s)
--

--
-- Table structure for table `resultat`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `note` decimal(10,2) DEFAULT NULL,
  `nb_gardes` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_E7DB5DE2296CD8AE` (`team_id`),
  CONSTRAINT `FK_E7DB5DE2296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultat`
--

LOCK TABLES `resultat` WRITE;
/*!40000 ALTER TABLE `resultat` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `resultat` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `resultat` with 0 row(s)
--

--
-- Table structure for table `row`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `row` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dance_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `num_tour` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `formation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `piste` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_done` tinyint(1) DEFAULT NULL,
  `passage_simul` int(11) DEFAULT NULL,
  `competition_id` int(11) DEFAULT NULL,
  `nb_judge` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8430F6DB65D64EDD` (`dance_id`),
  KEY `IDX_8430F6DB12469DE2` (`category_id`),
  KEY `IDX_8430F6DB7B39D312` (`competition_id`),
  CONSTRAINT `FK_8430F6DB12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_8430F6DB65D64EDD` FOREIGN KEY (`dance_id`) REFERENCES `dance` (`id`),
  CONSTRAINT `FK_8430F6DB7B39D312` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `row`
--

LOCK TABLES `row` WRITE;
/*!40000 ALTER TABLE `row` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `row` VALUES (37,2,3,'1','duo','A',0,2,1,3),(38,4,3,'1','duo','A',0,2,1,3);
/*!40000 ALTER TABLE `row` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `row` with 2 row(s)
--

--
-- Table structure for table `row_team`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `row_team` (
  `row_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  PRIMARY KEY (`row_id`,`team_id`),
  KEY `IDX_BF6969E883A269F2` (`row_id`),
  KEY `IDX_BF6969E8296CD8AE` (`team_id`),
  CONSTRAINT `FK_BF6969E8296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_BF6969E883A269F2` FOREIGN KEY (`row_id`) REFERENCES `row` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `row_team`
--

LOCK TABLES `row_team` WRITE;
/*!40000 ALTER TABLE `row_team` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `row_team` VALUES (37,1),(37,2),(37,3),(37,4),(37,5),(37,6),(38,1),(38,2),(38,3),(38,4),(38,5),(38,6);
/*!40000 ALTER TABLE `row_team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `row_team` with 12 row(s)
--

--
-- Table structure for table `team`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `club_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `is_present` tinyint(1) NOT NULL,
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C4E0A61F61190A32` (`club_id`),
  KEY `IDX_C4E0A61F12469DE2` (`category_id`),
  CONSTRAINT `FK_C4E0A61F12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_C4E0A61F61190A32` FOREIGN KEY (`club_id`) REFERENCES `club` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `team` VALUES (1,2,3,1,'duo'),(2,2,3,1,'duo'),(3,2,3,1,'duo'),(4,2,3,1,'duo'),(5,2,3,1,'duo'),(6,2,3,1,'duo');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `team` with 6 row(s)
--

--
-- Table structure for table `team_dance`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_dance` (
  `team_id` int(11) NOT NULL,
  `dance_id` int(11) NOT NULL,
  PRIMARY KEY (`team_id`,`dance_id`),
  KEY `IDX_DF4DB42F296CD8AE` (`team_id`),
  KEY `IDX_DF4DB42F65D64EDD` (`dance_id`),
  CONSTRAINT `FK_DF4DB42F296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_DF4DB42F65D64EDD` FOREIGN KEY (`dance_id`) REFERENCES `dance` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_dance`
--

LOCK TABLES `team_dance` WRITE;
/*!40000 ALTER TABLE `team_dance` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `team_dance` VALUES (1,2),(1,4),(2,2),(2,4),(3,2),(3,4),(4,2),(4,4),(5,2),(5,4),(6,2),(6,4);
/*!40000 ALTER TABLE `team_dance` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `team_dance` with 12 row(s)
--

--
-- Table structure for table `team_dancer`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_dancer` (
  `team_id` int(11) NOT NULL,
  `dancer_id` int(11) NOT NULL,
  PRIMARY KEY (`team_id`,`dancer_id`),
  KEY `IDX_C7078F70296CD8AE` (`team_id`),
  KEY `IDX_C7078F70A7CAA267` (`dancer_id`),
  CONSTRAINT `FK_C7078F70296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C7078F70A7CAA267` FOREIGN KEY (`dancer_id`) REFERENCES `dancer` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_dancer`
--

LOCK TABLES `team_dancer` WRITE;
/*!40000 ALTER TABLE `team_dancer` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `team_dancer` VALUES (1,2),(1,3),(2,4),(2,5),(3,6),(3,7),(4,9),(4,10),(5,11),(5,12),(6,13),(6,14);
/*!40000 ALTER TABLE `team_dancer` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `team_dancer` with 12 row(s)
--

--
-- Table structure for table `ticket`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `etat` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_97A0ADA3F675F31B` (`author_id`),
  CONSTRAINT `FK_97A0ADA3F675F31B` FOREIGN KEY (`author_id`) REFERENCES `club` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

-- Dumped table `ticket` with 0 row(s)
--

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on: Sun, 03 Mar 2019 07:33:26 +0000
