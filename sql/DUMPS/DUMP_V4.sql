-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: app
-- ------------------------------------------------------
-- Server version	8.0.26-0ubuntu0.20.04.2

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (2,'Book 2',500,'2020-03-04','Book 2 desc','url',1,'0'),(7,'book',212,'2020-03-03','book','url',1,'0'),(8,'knjiga',300,'2010-10-10','Bas dobra knjiga','no picture available',1,'0'),(15,'knjiga',300,'2010-10-10','Bas dobra knjiga','no picture available',1,'2'),(21,'knjiga',300,'2010-10-10','Bas dobra knjiga','no picture available',1,'2'),(23,'knjiga',300,'2010-10-10','Bas dobra knjiga','no picture available',1,'2'),(24,'knjiga',300,'2010-10-10','Bas dobra knjiga','no picture available',1,'2'),(26,'knjiga',300,'2010-10-10','Bas dobra knjiga','no picture available',1,'2'),(27,'knjiga',300,'2010-01-10','Bas dobra knjiga','no picture available',1,'2'),(28,'knjiga',300,'2010-10-10','Bas dobra knjiga','no picture available',1,'2');
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
  `phone_number` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `orders_ibfk_1` (`book_id`,`phone_number`),
  KEY `ordered_from_idx` (`phone_number`),
  CONSTRAINT `book_id` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (2,7,'a','a','a',11),(3,7,'Adresa neka','Petar','Petrovic',6000000),(4,7,'Adresa neka','Petar','Petrovic',6000000),(5,7,'Adresa neka','Petar','Petrovic',6000000),(7,8,'Djure gajica 5','Miljan','Radulovic',64122212);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'miljan','$2b$10$K03kiwkC124I07titJC3m.qNnYAyxbcL0I686K1TC6p.EEh.S0S9G','miljan.radulovic@gmail.com',1),(4,'miljan2c','$2b$10$K03kiwkC124I07titJC3m.qNnYAyxbcL0I686K1TC6p.EEh.S0S9G','dragan@dragan.com',0),(5,'Draganche','$2b$10$0xWzVZdr0JO4jMZI.gJB0uNK6LULuHSPWM81I3I/APf.c4y6HTZpy','dragan@draganovic.com',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'app'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_book_to_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`miljan`@`localhost` PROCEDURE `add_book_to_stock`(pAdded_by INT, pBook_title VARCHAR(255), pBook_price INT , pBook_year DATE , pBook_description MEDIUMTEXT, pUrl MEDIUMTEXT,pBook_quantity INT)
BEGIN
DECLARE commitTransatcion BOOLEAN DEFAULT TRUE;
DECLARE pMissingParametar BOOLEAN DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET commitTransatcion = FALSE;
START TRANSACTION;

IF pAdded_by IS NULL OR pBook_title IS NULL OR pbook_price IS NULL OR pBook_year IS NULL OR pBook_description IS NULL OR pUrl IS NULL OR pBook_quantity IS NULL THEN
	SET commitTransatcion = FALSE;
    SET pMissingParametar = TRUE;
END IF;
	INSERT INTO books(book_title,book_price,book_year,book_description,book_cover,book_posted_by,book_quantity) 
    VALUES(pBook_title, pBook_price, pBook_year, pBook_description, pUrl, pAdded_by,pBook_quantity);
IF commitTransatcion IS TRUE THEN
    SELECT "Book added successfully!" AS message;
	COMMIT;
ELSE
IF pMissingParametar IS TRUE THEN
	SELECT "One of the parametars is missing!" AS message;
ELSE
	GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
	SELECT CONCAT("Error occured! ",@p1, ': ', @p2) AS message;
END IF;
	ROLLBACK;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
CREATE DEFINER=`miljan`@`localhost` PROCEDURE `book_order`(pBook_id INT,pQuantity INT,pAdress MEDIUMTEXT,pName VARCHAR(40),pSurrname VARCHAR(40),pOrderedFrom INT,pPhoneNumber INT)
BEGIN
DECLARE pSucces BOOLEAN DEFAULT TRUE;
DECLARE pBook_amount INT;
DECLARE pMessage MEDIUMTEXT DEFAULT 'Order succesfull!';
DECLARE commitTransatcion BOOLEAN DEFAULT TRUE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET commitTransatcion = FALSE;

START TRANSACTION;

SELECT book_quantity FROM books WHERE book_id = pBook_id AND book_posted_by = pOrderedFrom INTO pBook_amount;
IF pBook_amount < pQuantity OR pBook_amount = 0 THEN 
	SET pMessage = 'Not enough books to make this order!';
    SET pSucces = FALSE;
ELSEIF (SELECT COUNT(*) FROM books WHERE book_id = pBook_id) = 0 THEN
		SET pMessage = 'Not ID matched with books table!';
		SET pSucces = FALSE;
ELSEIF (SELECT COUNT(*) FROM users WHERE user_id = pOrderedFrom) = 0 THEN
		SET pMessage = 'Not USER matched with users table!';
		SET pSucces = FALSE;
ELSE
	UPDATE books SET book_quantity = book_quantity - pQuantity WHERE book_id = pBook_id AND book_posted_by = pOrderedFrom;
    SELECT book_quantity FROM books WHERE book_id = pBook_id AND book_posted_by = pOrderedFrom INTO pBook_amount;
    INSERT INTO orders(book_id,adress,name,surrname,phone_number) VALUES (pBook_id,pAdress,pName,pSurrname,pPhoneNumber);
END IF;

IF commitTransatcion IS TRUE THEN 
	COMMIT;
	SELECT pMessage AS message,pSucces AS succes;
ELSE
	ROLLBACK;
    GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
	SELECT CONCAT("Error occured! ",@p1, ': ', @p2) INTO pMessage;
	SELECT pMessage AS message, pSucces AS succes;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_books` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`miljan`@`localhost` PROCEDURE `get_all_books`()
BEGIN
	SELECT book_title,book_price,book_year,book_description,book_cover,username 
	FROM books 
	JOIN users
	ON users.user_id = books.book_posted_by;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_users_books` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`miljan`@`localhost` PROCEDURE `get_users_books`(pUserId INT)
BEGIN
	SELECT * FROM books WHERE book_posted_by = pUserId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`miljan`@`localhost` PROCEDURE `register_user`(pUsername VARCHAR(40),pPassword MEDIUMTEXT, pEmail VARCHAR(255))
BEGIN
DECLARE pMessage VARCHAR(255) DEFAULT 'User registered successfully!';
DECLARE pSuccess BOOLEAN DEFAULT TRUE;
IF (SELECT COUNT(*) FROM users WHERE username = pUsername) > 0 THEN 
	SET pMessage =  "Username already taken!";
    SET pSuccess = FALSE;
ELSEIF (SELECT COUNT(*) FROM users WHERE email = pEmail) > 0 THEN 
	SET pMessage =  "Email already taken!";
    SET pSuccess = FALSE;
ELSE 
	INSERT INTO users(username,password,email,verified_account) VALUES(pUsername,pPassword,pEmail,0);
END IF;
SELECT pMessage AS message,pSuccess AS success;
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

-- Dump completed on 2021-08-13 14:20:17
