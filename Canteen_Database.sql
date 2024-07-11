-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: CANTEEN_1
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

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
-- Table structure for table `CANTEEN`
--

DROP TABLE IF EXISTS `CANTEEN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CANTEEN` (
  `Opening_Year` date DEFAULT NULL,
  `Location` varchar(64) DEFAULT NULL,
  `CanteenID` varchar(32) NOT NULL,
  `Mon` varchar(32) DEFAULT NULL,
  `Tue` varchar(32) DEFAULT NULL,
  `Wed` varchar(32) DEFAULT NULL,
  `Thu` varchar(32) DEFAULT NULL,
  `Fri` varchar(32) DEFAULT NULL,
  `Sat` varchar(32) DEFAULT NULL,
  `Sun` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`CanteenID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CANTEEN`
--

LOCK TABLES `CANTEEN` WRITE;
/*!40000 ALTER TABLE `CANTEEN` DISABLE KEYS */;
INSERT INTO `CANTEEN` VALUES ('2019-06-10','Amphitheatre Backside','BBC','1000','1000','1000','1000','1000','1600','1600'),('2018-12-05','Opp to FG','David','0900','0900','0900','0900','0900','1400','Closed'),('2022-03-20','Next to Tantra','JuiceCanteen','0700','0700','0700','0700','0700','1200','1200'),('2021-02-15','Next to Athidi Niwas','Tantra','0830','0830','0830','0830','0830','1400','Closed'),('2020-01-01','Opp to Lec Hall','VindhyaCanteen','0200','0200','0200','0200','0200','1400','1400');
/*!40000 ALTER TABLE `CANTEEN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONTAINS`
--

DROP TABLE IF EXISTS `CONTAINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONTAINS` (
  `OrderID` int NOT NULL,
  `Iname` varchar(32) NOT NULL,
  `Item_quantity` varchar(32) NOT NULL,
  PRIMARY KEY (`OrderID`,`Iname`,`Item_quantity`),
  KEY `Iname` (`Iname`,`Item_quantity`),
  CONSTRAINT `CONTAINS_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `ORDER_TABLE` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CONTAINS_ibfk_2` FOREIGN KEY (`Iname`, `Item_quantity`) REFERENCES `MENU_ITEMS` (`Item_name`, `Quantity`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONTAINS`
--

LOCK TABLES `CONTAINS` WRITE;
/*!40000 ALTER TABLE `CONTAINS` DISABLE KEYS */;
INSERT INTO `CONTAINS` VALUES (1,'Burger','Regular'),(8,'Burger','Regular'),(16,'Burger','Regular'),(1,'Fresh Juice','Medium'),(11,'Fresh Juice','Medium'),(4,'Pasta','Small'),(13,'Pasta','Small'),(5,'Pizza','Large'),(10,'Pizza','Large'),(7,'Sandwich','Regular'),(14,'Sandwich','Regular');
/*!40000 ALTER TABLE `CONTAINS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CUSTOMER`
--

DROP TABLE IF EXISTS `CUSTOMER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CUSTOMER` (
  `CustomerID` int NOT NULL,
  `Cname` varchar(64) DEFAULT NULL,
  `CDOB` date DEFAULT NULL,
  `CustomerRole` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CUSTOMER`
--

LOCK TABLES `CUSTOMER` WRITE;
/*!40000 ALTER TABLE `CUSTOMER` DISABLE KEYS */;
INSERT INTO `CUSTOMER` VALUES (1,'John Doe','1990-05-15','Regular'),(2,'Jane Smith','1985-08-22','VIP'),(3,'Bob Johnson','1998-12-10','Regular'),(4,'Alice Brown','1995-04-03','Regular'),(5,'Charlie Davis','1980-11-28','VIP');
/*!40000 ALTER TABLE `CUSTOMER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEEDBACK`
--

DROP TABLE IF EXISTS `FEEDBACK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FEEDBACK` (
  `CanteenID` varchar(32) NOT NULL,
  `Serial_number` int NOT NULL,
  `Rating` decimal(10,0) DEFAULT NULL,
  `Comments` varchar(64) DEFAULT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`CanteenID`,`Serial_number`,`CustomerID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `FEEDBACK_ibfk_1` FOREIGN KEY (`CanteenID`) REFERENCES `CANTEEN` (`CanteenID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FEEDBACK_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FEEDBACK_chk_1` CHECK (((`Rating` >= 0) and (`Rating` <= 10)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEEDBACK`
--

LOCK TABLES `FEEDBACK` WRITE;
/*!40000 ALTER TABLE `FEEDBACK` DISABLE KEYS */;
INSERT INTO `FEEDBACK` VALUES ('BBC',3,7,'Fast service',3),('BBC',8,7,'Fresh ingredients',3),('BBC',13,7,'Clean environment',3),('David',5,10,'Excellent experience',5),('David',10,10,'Highly recommended',5),('David',15,10,'Outstanding',5),('JuiceCanteen',4,6,'Average',4),('JuiceCanteen',9,6,'Improvement needed',4),('JuiceCanteen',14,6,'Satisfactory',4),('Tantra',2,9,'Delicious food',2),('Tantra',7,9,'Friendly staff',2),('Tantra',12,9,'Tasty food',2),('VindhyaCanteen',1,8,'Good service',1),('VindhyaCanteen',6,8,'Good quality',1),('VindhyaCanteen',11,8,'Quick service',1),('VindhyaCanteen',16,8,'Polite staff',1);
/*!40000 ALTER TABLE `FEEDBACK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INGREDIENTS`
--

DROP TABLE IF EXISTS `INGREDIENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `INGREDIENTS` (
  `Ingredients` varchar(64) NOT NULL,
  `Item_quantity` varchar(32) NOT NULL,
  `Iname` varchar(32) NOT NULL,
  PRIMARY KEY (`Ingredients`,`Item_quantity`,`Iname`),
  KEY `Iname` (`Iname`,`Item_quantity`),
  CONSTRAINT `INGREDIENTS_ibfk_1` FOREIGN KEY (`Iname`, `Item_quantity`) REFERENCES `MENU_ITEMS` (`Item_name`, `Quantity`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INGREDIENTS`
--

LOCK TABLES `INGREDIENTS` WRITE;
/*!40000 ALTER TABLE `INGREDIENTS` DISABLE KEYS */;
INSERT INTO `INGREDIENTS` VALUES ('Beef','Regular','Burger'),('Orange','Medium','Fresh Juice'),('Pasta Noodles','Small','Pasta'),('Cheese','Large','Pizza'),('Chicken','Regular','Sandwich');
/*!40000 ALTER TABLE `INGREDIENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MENU_ITEMS`
--

DROP TABLE IF EXISTS `MENU_ITEMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MENU_ITEMS` (
  `Item_name` varchar(32) NOT NULL,
  `Quantity` varchar(32) NOT NULL,
  `Price` int DEFAULT NULL,
  `Units_sold` int DEFAULT NULL,
  `CanteenID` varchar(32) NOT NULL,
  PRIMARY KEY (`Item_name`,`Quantity`,`CanteenID`),
  KEY `idx_menu_items` (`Item_name`,`Quantity`),
  KEY `CanteenID` (`CanteenID`),
  CONSTRAINT `MENU_ITEMS_ibfk_1` FOREIGN KEY (`CanteenID`) REFERENCES `CANTEEN` (`CanteenID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MENU_ITEMS_chk_1` CHECK ((`Price` >= 0)),
  CONSTRAINT `MENU_ITEMS_chk_2` CHECK ((`Units_sold` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MENU_ITEMS`
--

LOCK TABLES `MENU_ITEMS` WRITE;
/*!40000 ALTER TABLE `MENU_ITEMS` DISABLE KEYS */;
INSERT INTO `MENU_ITEMS` VALUES ('Burger','Regular',5,50,'VindhyaCanteen'),('Fresh Juice','Medium',3,60,'JuiceCanteen'),('Pasta','Small',6,25,'David'),('Pizza','Large',10,30,'Tantra'),('Sandwich','Regular',4,40,'BBC');
/*!40000 ALTER TABLE `MENU_ITEMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORDER_TABLE`
--

DROP TABLE IF EXISTS `ORDER_TABLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORDER_TABLE` (
  `OrderID` int NOT NULL,
  `ODate` date DEFAULT NULL,
  `OStatus` int DEFAULT NULL,
  `TotalPrice` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `CanteenPlaced` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `CanteenPlaced` (`CanteenPlaced`),
  CONSTRAINT `ORDER_TABLE_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ORDER_TABLE_ibfk_2` FOREIGN KEY (`CanteenPlaced`) REFERENCES `CANTEEN` (`CanteenID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ORDER_TABLE_chk_1` CHECK ((`TotalPrice` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDER_TABLE`
--

LOCK TABLES `ORDER_TABLE` WRITE;
/*!40000 ALTER TABLE `ORDER_TABLE` DISABLE KEYS */;
INSERT INTO `ORDER_TABLE` VALUES (1,'2023-01-10',1,20,1,'VindhyaCanteen'),(2,'2023-02-15',1,30,2,'Tantra'),(3,'2023-03-20',1,25,3,'BBC'),(4,'2023-04-25',1,15,4,'JuiceCanteen'),(5,'2023-05-01',1,18,5,'David'),(6,'2023-06-10',1,22,1,'VindhyaCanteen'),(7,'2023-07-15',1,40,2,'Tantra'),(8,'2023-08-20',1,35,3,'BBC'),(9,'2023-09-25',1,28,4,'JuiceCanteen'),(10,'2023-10-01',1,19,5,'David'),(11,'2023-11-10',1,21,1,'VindhyaCanteen'),(12,'2023-12-15',1,32,2,'Tantra'),(13,'2024-01-20',1,27,3,'BBC'),(14,'2024-02-25',1,14,4,'JuiceCanteen'),(15,'2024-03-01',1,16,5,'David'),(16,'2024-04-10',1,24,1,'VindhyaCanteen');
/*!40000 ALTER TABLE `ORDER_TABLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PAYMENT`
--

DROP TABLE IF EXISTS `PAYMENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PAYMENT` (
  `PaymentID` int NOT NULL,
  `CustomerID` int DEFAULT NULL,
  `PMethod` varchar(32) DEFAULT NULL,
  `PAmount` int DEFAULT NULL,
  `PDate` date DEFAULT NULL,
  `Canteen_paid` varchar(32) DEFAULT NULL,
  `Order_paid` int DEFAULT NULL,
  `User_paying` int DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `Canteen_paid` (`Canteen_paid`),
  KEY `Order_paid` (`Order_paid`),
  KEY `User_paying` (`User_paying`),
  CONSTRAINT `PAYMENT_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PAYMENT_ibfk_2` FOREIGN KEY (`Canteen_paid`) REFERENCES `CANTEEN` (`CanteenID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `PAYMENT_ibfk_3` FOREIGN KEY (`Order_paid`) REFERENCES `ORDER_TABLE` (`OrderID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `PAYMENT_ibfk_4` FOREIGN KEY (`User_paying`) REFERENCES `CUSTOMER` (`CustomerID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `PAYMENT_chk_1` CHECK ((`PAmount` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PAYMENT`
--

LOCK TABLES `PAYMENT` WRITE;
/*!40000 ALTER TABLE `PAYMENT` DISABLE KEYS */;
INSERT INTO `PAYMENT` VALUES (1,1,'Card',20,'2023-01-10','VindhyaCanteen',1,1),(2,2,'Cash',30,'2023-02-15','Tantra',2,2),(3,3,'Card',25,'2023-03-20','BBC',3,3),(4,4,'Cash',15,'2023-04-25','JuiceCanteen',4,4),(5,5,'Card',18,'2023-05-01','David',5,5),(6,1,'Card',22,'2023-06-10','VindhyaCanteen',6,1),(7,2,'Cash',40,'2023-07-15','Tantra',7,2),(8,3,'Card',35,'2023-08-20','BBC',8,3),(9,4,'Cash',28,'2023-09-25','JuiceCanteen',9,4),(10,5,'Card',19,'2023-10-01','David',10,5),(11,1,'Card',21,'2023-11-10','VindhyaCanteen',11,1),(12,2,'Cash',32,'2023-12-15','Tantra',12,2),(13,3,'Card',27,'2024-01-20','BBC',13,3),(14,4,'Cash',14,'2024-02-25','JuiceCanteen',14,4),(15,5,'Card',16,'2024-03-01','David',15,5),(16,1,'Card',24,'2024-04-10','VindhyaCanteen',16,1);
/*!40000 ALTER TABLE `PAYMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PHONE_NUMBER`
--

DROP TABLE IF EXISTS `PHONE_NUMBER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PHONE_NUMBER` (
  `Phone_no` bigint NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`Phone_no`,`CustomerID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `PHONE_NUMBER_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PHONE_NUMBER`
--

LOCK TABLES `PHONE_NUMBER` WRITE;
/*!40000 ALTER TABLE `PHONE_NUMBER` DISABLE KEYS */;
INSERT INTO `PHONE_NUMBER` VALUES (1234567890,1),(3334445555,1),(7778889999,2),(9876543210,2),(5551112222,3),(5551234567,3),(9995551111,4),(9998887777,4),(1112223333,5),(1119995555,5);
/*!40000 ALTER TABLE `PHONE_NUMBER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROVIDES`
--

DROP TABLE IF EXISTS `PROVIDES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROVIDES` (
  `CustomerID` int NOT NULL,
  `CanteenID` varchar(32) NOT NULL,
  `S_No` int NOT NULL,
  PRIMARY KEY (`CustomerID`,`CanteenID`,`S_No`),
  KEY `CanteenID` (`CanteenID`),
  CONSTRAINT `PROVIDES_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PROVIDES_ibfk_2` FOREIGN KEY (`CanteenID`) REFERENCES `CANTEEN` (`CanteenID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROVIDES`
--

LOCK TABLES `PROVIDES` WRITE;
/*!40000 ALTER TABLE `PROVIDES` DISABLE KEYS */;
INSERT INTO `PROVIDES` VALUES (3,'BBC',3),(3,'BBC',8),(5,'David',5),(5,'David',10),(4,'JuiceCanteen',4),(4,'JuiceCanteen',9),(2,'Tantra',2),(2,'Tantra',7),(1,'VindhyaCanteen',1),(1,'VindhyaCanteen',6);
/*!40000 ALTER TABLE `PROVIDES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SERVES`
--

DROP TABLE IF EXISTS `SERVES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SERVES` (
  `CanteenID` varchar(32) NOT NULL,
  `OrderID` int NOT NULL,
  `CustomerID` int NOT NULL,
  PRIMARY KEY (`CanteenID`,`OrderID`,`CustomerID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `SERVES_ibfk_1` FOREIGN KEY (`CanteenID`) REFERENCES `CANTEEN` (`CanteenID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SERVES_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `ORDER_TABLE` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SERVES`
--

LOCK TABLES `SERVES` WRITE;
/*!40000 ALTER TABLE `SERVES` DISABLE KEYS */;
INSERT INTO `SERVES` VALUES ('VindhyaCanteen',1,1),('Tantra',2,2),('BBC',3,3),('JuiceCanteen',4,4),('David',5,5),('VindhyaCanteen',6,1),('Tantra',7,2),('BBC',8,3),('JuiceCanteen',9,4),('David',10,5),('VindhyaCanteen',11,1),('Tantra',12,2),('BBC',13,3),('JuiceCanteen',14,4),('David',15,5),('VindhyaCanteen',16,1);
/*!40000 ALTER TABLE `SERVES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STAFF`
--

DROP TABLE IF EXISTS `STAFF`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STAFF` (
  `StaffID` int NOT NULL,
  `Salary` int DEFAULT NULL,
  `SuperStaffID` int DEFAULT NULL,
  `CanID` varchar(32) DEFAULT NULL,
  `Aadhar` int DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  KEY `SuperStaffID` (`SuperStaffID`),
  KEY `CanID` (`CanID`),
  KEY `Aadhar` (`Aadhar`),
  CONSTRAINT `STAFF_ibfk_1` FOREIGN KEY (`SuperStaffID`) REFERENCES `STAFF` (`StaffID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `STAFF_ibfk_2` FOREIGN KEY (`CanID`) REFERENCES `CANTEEN` (`CanteenID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `STAFF_ibfk_3` FOREIGN KEY (`Aadhar`) REFERENCES `STAFF_DETAILS` (`Aadhar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `STAFF_chk_1` CHECK ((`Salary` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STAFF`
--

LOCK TABLES `STAFF` WRITE;
/*!40000 ALTER TABLE `STAFF` DISABLE KEYS */;
INSERT INTO `STAFF` VALUES (1,50000,NULL,'VindhyaCanteen',111111111),(2,48000,1,'Tantra',222222222),(3,55000,1,'VindhyaCanteen',333333333),(4,52000,NULL,'JuiceCanteen',444444444),(5,49000,3,'VindhyaCanteen',555555555);
/*!40000 ALTER TABLE `STAFF` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STAFF_DETAILS`
--

DROP TABLE IF EXISTS `STAFF_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STAFF_DETAILS` (
  `Aadhar` int NOT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Gender` varchar(32) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  PRIMARY KEY (`Aadhar`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STAFF_DETAILS`
--

LOCK TABLES `STAFF_DETAILS` WRITE;
/*!40000 ALTER TABLE `STAFF_DETAILS` DISABLE KEYS */;
INSERT INTO `STAFF_DETAILS` VALUES (111111111,'John Doe','Male','1990-01-15'),(222222222,'Jane Smith','Female','1985-05-22'),(333333333,'Bob Johnson','Male','1992-09-10'),(444444444,'Alice Williams','Female','1988-03-28'),(555555555,'Charlie Brown','Male','1995-12-05');
/*!40000 ALTER TABLE `STAFF_DETAILS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-03  4:08:43
