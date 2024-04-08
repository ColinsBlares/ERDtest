-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: housing
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `apartments`
--

DROP TABLE IF EXISTS `apartments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buildings_id` int NOT NULL,
  `rooms` int NOT NULL,
  `area` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_apartments_buildings_idx` (`buildings_id`),
  CONSTRAINT `fk_apartments_buildings` FOREIGN KEY (`buildings_id`) REFERENCES `buildings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartments`
--

LOCK TABLES `apartments` WRITE;
/*!40000 ALTER TABLE `apartments` DISABLE KEYS */;
INSERT INTO `apartments` VALUES (1,1,1,30.5),(2,1,2,45),(3,2,3,60.2),(4,3,2,55.1),(5,4,4,75.3),(6,2,1,28.4),(7,3,3,65.8),(8,4,2,48.6),(9,4,0,0);
/*!40000 ALTER TABLE `apartments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apartments_has_residents`
--

DROP TABLE IF EXISTS `apartments_has_residents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apartments_has_residents` (
  `apartments_id` int NOT NULL,
  `residents_id` int NOT NULL,
  PRIMARY KEY (`apartments_id`,`residents_id`),
  KEY `fk_apartments_has_residents_residents1_idx` (`residents_id`),
  KEY `fk_apartments_has_residents_apartments1_idx` (`apartments_id`),
  CONSTRAINT `fk_apartments_has_residents_apartments1` FOREIGN KEY (`apartments_id`) REFERENCES `apartments` (`id`),
  CONSTRAINT `fk_apartments_has_residents_residents1` FOREIGN KEY (`residents_id`) REFERENCES `residents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apartments_has_residents`
--

LOCK TABLES `apartments_has_residents` WRITE;
/*!40000 ALTER TABLE `apartments_has_residents` DISABLE KEYS */;
INSERT INTO `apartments_has_residents` VALUES (5,1),(5,2),(1,3),(2,4),(2,5),(2,6),(1,7);
/*!40000 ALTER TABLE `apartments_has_residents` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_resident_to_apartment_insert` AFTER INSERT ON `apartments_has_residents` FOR EACH ROW BEGIN
    -- Формирование описания действия
    SET @Description = CONCAT('Житель с номером ', NEW.residents_id, ' был добавлен в квартиру ', NEW.apartments_id);
    
    -- Добавление записи в лог
    INSERT INTO `logs` (`type`, `description`)
    VALUES ('Addition', @Description);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `buildings`
--

DROP TABLE IF EXISTS `buildings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buildings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `addres` varchar(255) NOT NULL,
  `number` int NOT NULL,
  `floors` int NOT NULL,
  `aparts` int NOT NULL,
  `building_year` date NOT NULL,
  `building_enters` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buildings`
--

LOCK TABLES `buildings` WRITE;
/*!40000 ALTER TABLE `buildings` DISABLE KEYS */;
INSERT INTO `buildings` VALUES (1,'Солнечная улица, 12',1,5,20,'2001-06-15','2'),(2,'Лунная улица, 34',2,10,40,'1999-12-01','4'),(3,'Звездная улица, 56',3,9,36,'2015-08-20','3'),(4,'Галактическая улица, 78',4,12,48,'2020-03-05','4');
/*!40000 ALTER TABLE `buildings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `car` (
  `id` int NOT NULL AUTO_INCREMENT,
  `car_plate` varchar(9) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carPlate_UNIQUE` (`car_plate`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (1,'А001АА77'),(2,'В123ВВ78'),(4,'М789ММ80'),(3,'С456СС79');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carspots`
--

DROP TABLE IF EXISTS `carspots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carspots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `car_id` int NOT NULL,
  `residents_id` int NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_carspots_car1_idx` (`car_id`),
  KEY `fk_carspots_residents1_idx` (`residents_id`),
  CONSTRAINT `fk_carspots_car1` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`),
  CONSTRAINT `fk_carspots_residents1` FOREIGN KEY (`residents_id`) REFERENCES `residents` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carspots`
--

LOCK TABLES `carspots` WRITE;
/*!40000 ALTER TABLE `carspots` DISABLE KEYS */;
INSERT INTO `carspots` VALUES (1,1,1,'Подземная парковка'),(2,2,2,'Парковка у дома'),(3,3,3,'Парковка во дворе'),(4,4,4,'Парковка за забором');
/*!40000 ALTER TABLE `carspots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,'Addition','2024-04-08 16:24:31','Resident ID 6 was added to Apartment ID 2'),(2,'Addition','2024-04-08 16:26:27','Житель с номером 7 был добавлен в квартиру 1');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `apartments_id` int NOT NULL,
  `date` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payments_apartments1_idx` (`apartments_id`),
  CONSTRAINT `fk_payments_apartments1` FOREIGN KEY (`apartments_id`) REFERENCES `apartments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,'2024-03-01',2500.00,'Электроэнергия'),(2,2,'2024-03-01',1500.00,'Газ'),(3,3,'2024-03-01',3200.00,'Вода'),(4,4,'2024-03-01',4200.00,'Отопление');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residents`
--

DROP TABLE IF EXISTS `residents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `residents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `dirth_date` date NOT NULL,
  `registration_date` date NOT NULL,
  `phone_number` varchar(416) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residents`
--

LOCK TABLES `residents` WRITE;
/*!40000 ALTER TABLE `residents` DISABLE KEYS */;
INSERT INTO `residents` VALUES (1,'Алексей Алексеев','1983-05-21','2020-06-15','+79031234567'),(2,'Мария Иванова','1990-11-12','2019-07-22','+79037654321'),(3,'Ольга Петрова','1985-02-18','2021-09-10','+79036665432'),(4,'Дмитрий Смирнов','1978-04-08','2018-03-25','+79039876543'),(5,'Алексей Алексеевич','1992-02-15','2024-04-08','+79995553322'),(6,'testov','2024-08-08','2024-08-08','+79520616992'),(7,'Строев Максим Александрович','2004-03-08','2024-04-08','+79999999999');
/*!40000 ALTER TABLE `residents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `residents_apartments_view`
--

DROP TABLE IF EXISTS `residents_apartments_view`;
/*!50001 DROP VIEW IF EXISTS `residents_apartments_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `residents_apartments_view` AS SELECT 
 1 AS `resident_id`,
 1 AS `full_name`,
 1 AS `dirth_date`,
 1 AS `registration_date`,
 1 AS `phone_number`,
 1 AS `apartment_id`,
 1 AS `rooms`,
 1 AS `area`,
 1 AS `building_id`,
 1 AS `addres`,
 1 AS `building_number`,
 1 AS `floors`,
 1 AS `aparts`,
 1 AS `building_year`,
 1 AS `building_enters`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `residents_has_car`
--

DROP TABLE IF EXISTS `residents_has_car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `residents_has_car` (
  `residents_id` int NOT NULL,
  `car_id` int NOT NULL,
  PRIMARY KEY (`residents_id`,`car_id`),
  KEY `fk_residents_has_car_car1_idx` (`car_id`),
  KEY `fk_residents_has_car_residents1_idx` (`residents_id`),
  CONSTRAINT `fk_residents_has_car_car1` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`),
  CONSTRAINT `fk_residents_has_car_residents1` FOREIGN KEY (`residents_id`) REFERENCES `residents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residents_has_car`
--

LOCK TABLES `residents_has_car` WRITE;
/*!40000 ALTER TABLE `residents_has_car` DISABLE KEYS */;
INSERT INTO `residents_has_car` VALUES (1,1),(2,2),(3,3),(4,4);
/*!40000 ALTER TABLE `residents_has_car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storerooms`
--

DROP TABLE IF EXISTS `storerooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storerooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `apartments_id` int NOT NULL,
  `area` float NOT NULL,
  `number` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_storerooms_apartments1_idx` (`apartments_id`),
  CONSTRAINT `fk_storerooms_apartments1` FOREIGN KEY (`apartments_id`) REFERENCES `apartments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storerooms`
--

LOCK TABLES `storerooms` WRITE;
/*!40000 ALTER TABLE `storerooms` DISABLE KEYS */;
INSERT INTO `storerooms` VALUES (1,1,5,101),(2,2,6.5,102),(3,3,7,103),(4,4,4.5,104);
/*!40000 ALTER TABLE `storerooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'housing'
--

--
-- Dumping routines for database 'housing'
--
/*!50003 DROP FUNCTION IF EXISTS `avg_area_per_resident` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `avg_area_per_resident`(residentID INT) RETURNS float
    DETERMINISTIC
BEGIN
    DECLARE vAvgArea FLOAT;

    -- Вычисляем среднюю площадь квартир для заданного жителя
    SELECT AVG(a.area) INTO vAvgArea
    FROM apartments a
    JOIN apartments_has_residents ahr ON a.id = ahr.apartments_id
    WHERE ahr.residents_id = residentID;
    
    -- Возвращаем среднюю площадь
    IF vAvgArea IS NULL THEN
        RETURN 0;
    ELSE
        RETURN vAvgArea;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_resident_to_apartment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_resident_to_apartment`(
    IN p_full_name VARCHAR(255), 
    IN p_dirth_date DATE, 
    IN p_registration_date DATE, 
    IN p_phone_number VARCHAR(45),
    IN p_apartment_id INT
)
BEGIN
    DECLARE v_resident_id INT;
    DECLARE v_exists INT DEFAULT 0;

    -- Проверка на существование апартамента
    SELECT COUNT(*) INTO v_exists FROM apartments WHERE id = p_apartment_id;
    IF v_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Такой квартиры не существует';
    END IF;

    -- Начало транзакции
    START TRANSACTION;

    -- Добавление жителя
    INSERT INTO residents (full_name, dirth_date, registration_date, phone_number)
    VALUES (p_full_name, p_dirth_date, p_registration_date, p_phone_number);

    -- Получение ID только что добавленного жителя
    SET v_resident_id = LAST_INSERT_ID();
    
    -- Связывание жителя с уже существующей квартирой
    INSERT INTO apartments_has_residents (apartments_id, residents_id)
    VALUES (p_apartment_id, v_resident_id);

    -- Проверка успешности операций и завершение транзакции
    IF ROW_COUNT() > 0 THEN
        COMMIT;
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка при добавлении жителя';
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_resident_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_resident_details`(IN residentID INT)
BEGIN
    DECLARE vFullName VARCHAR(255);
    DECLARE vTotalApartments INT;
    DECLARE vTotalArea FLOAT;
    
    -- Получаем полное имя жителя
    SELECT full_name INTO vFullName
    FROM residents
    WHERE id = residentID;
    
    -- Получаем количество квартир, связанных с жителем
    SELECT COUNT(*) INTO vTotalApartments
    FROM apartments_has_residents
    WHERE residents_id = residentID;
    
    -- Получаем общую площадь всех квартир жителя
    SELECT SUM(a.area) INTO vTotalArea
    FROM apartments a
    JOIN apartments_has_residents ahr ON a.id = ahr.apartments_id
    WHERE ahr.residents_id = residentID;
    
    -- Возвращаем результаты
    SELECT vFullName AS 'Full Name', vTotalApartments AS 'Total Apartments', vTotalArea AS 'Total Area';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `residents_apartments_view`
--

/*!50001 DROP VIEW IF EXISTS `residents_apartments_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `residents_apartments_view` AS select `r`.`id` AS `resident_id`,`r`.`full_name` AS `full_name`,`r`.`dirth_date` AS `dirth_date`,`r`.`registration_date` AS `registration_date`,`r`.`phone_number` AS `phone_number`,`a`.`id` AS `apartment_id`,`a`.`rooms` AS `rooms`,`a`.`area` AS `area`,`b`.`id` AS `building_id`,`b`.`addres` AS `addres`,`b`.`number` AS `building_number`,`b`.`floors` AS `floors`,`b`.`aparts` AS `aparts`,`b`.`building_year` AS `building_year`,`b`.`building_enters` AS `building_enters` from (((`residents` `r` join `apartments_has_residents` `ahr` on((`r`.`id` = `ahr`.`residents_id`))) join `apartments` `a` on((`ahr`.`apartments_id` = `a`.`id`))) join `buildings` `b` on((`a`.`buildings_id` = `b`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-08 19:44:49
