-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: app
-- ------------------------------------------------------
-- Server version	8.0.25-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `book_title` varchar(255) NOT NULL,
  `book_price` int NOT NULL,
  `book_year` date NOT NULL,
  `book_description` mediumtext,
  `book_cover` mediumtext,
  `book_posted_by` int DEFAULT NULL,
  `book_quantity` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  KEY `book_posted_by_idx` (`book_posted_by`),
  CONSTRAINT `book_posted_by` FOREIGN KEY (`book_posted_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Book 1 ',300,'2020-05-05','Book','url',1,'0');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int DEFAULT NULL,
  `adress` mediumtext,
  `name` varchar(40) DEFAULT NULL,
  `surrname` varchar(40) DEFAULT NULL,
  `ordered_from` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_ibfk_1` (`book_id`,`ordered_from`),
  KEY `ordered_from_idx` (`ordered_from`),
  CONSTRAINT `book_id` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ordered_from` FOREIGN KEY (`ordered_from`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'Djure gajicea','Petar','Petrovic',1),(6,1,'Djure gajicea','Petar','Petrovic',1),(7,1,'Djure gajicea','Petar','Petrovic',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` mediumtext NOT NULL,
  `email` mediumtext NOT NULL,
  `verified_account` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'MIljan','123','miljan.radulovic@gmail.com',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'app'
--
/*!50003 DROP PROCEDURE IF EXISTS `book_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`miljan`@`localhost` PROCEDURE `book_order`(pBook_id INT,pQuantity INT,pAdress MEDIUMTEXT,pName VARCHAR(40),pSurrname VARCHAR(40),pOrderedFrom INT)
BEGIN
DECLARE pBook_amount INT;
DECLARE pMessage MEDIUMTEXT DEFAULT 'Order succesfull!';
DECLARE commitTransatcion BOOLEAN DEFAULT TRUE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET commitTransatcion = FALSE;

START TRANSACTION;

SELECT book_quantity FROM books WHERE book_id = pBook_id AND book_posted_by = pOrderedFrom INTO pBook_amount;
-- SELECT pBook_amount AS 'book amount';

IF pBook_amount < pQuantity OR pBook_amount = 0 THEN 
	SET pMessage = 'Not enough books to make this order!';
ELSE
	UPDATE books SET book_quantity = book_quantity - pQuantity WHERE book_id = pBook_id AND book_posted_by = pOrderedFrom;
    SELECT book_quantity FROM books WHERE book_id = pBook_id AND book_posted_by = pOrderedFrom INTO pBook_amount;
    INSERT INTO orders(book_id,adress,name,surrname,ordered_from) VALUES (pBook_id,pAdress,pName,pSurrname,pOrderedFrom);
END IF;
-- SELECT * FROM books;
-- SELECT commitTransatcion as trans;
IF commitTransatcion IS TRUE THEN 
	COMMIT;
	SELECT pMessage;
ELSE
	ROLLBACK;
    GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
	SELECT CONCAT("Error occured! ",@p1, ': ', @p2) INTO pMessage;
	SELECT pMessage;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-18 14:11:30
