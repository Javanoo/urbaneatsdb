-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: urbaneatsdb
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'grilled chicken','grilled chicken with mashed potatoes, served hot',11999.99,'available',2,'2026-02-26 09:08:41','2026-02-26 07:08:41'),(2,1,'chips and chicken','fried chips and grilled chicken',6999.99,'available',2,'2026-02-26 09:10:25','2026-02-26 07:10:25'),(3,1,'coca cola','carbonated drink',1999.99,'available',6,'2026-02-26 09:11:14','2026-02-26 07:11:14'),(4,1,'chocolate lava cake','chocolate flavoured cake, medium',8999.99,'available',3,'2026-02-26 09:13:13','2026-02-26 07:13:13');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `menu_items_category`
--

LOCK TABLES `menu_items_category` WRITE;
/*!40000 ALTER TABLE `menu_items_category` DISABLE KEYS */;
INSERT INTO `menu_items_category` VALUES (1,'starter','2026-02-26 08:58:47','2026-02-26 06:58:47'),(2,'mains','2026-02-26 08:59:00','2026-02-26 06:59:00'),(3,'dessert','2026-02-26 09:01:15','2026-02-26 07:01:15'),(4,'soup','2026-02-26 09:01:25','2026-02-26 07:01:25'),(5,'salads','2026-02-26 09:01:33','2026-02-26 07:01:33'),(6,'beverages','2026-02-26 09:01:50','2026-02-26 07:01:50');
/*!40000 ALTER TABLE `menu_items_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `opening_hours`
--

LOCK TABLES `opening_hours` WRITE;
/*!40000 ALTER TABLE `opening_hours` DISABLE KEYS */;
INSERT INTO `opening_hours` VALUES (1,1,'Mon','09:00:00','20:00:00','2026-02-26 08:08:25','2026-02-26 06:08:25'),(3,1,'Tue','08:00:00','20:00:00','2026-02-26 08:11:01','2026-02-26 06:11:01');
/*!40000 ALTER TABLE `opening_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `restaurants`
--

LOCK TABLES `restaurants` WRITE;
/*!40000 ALTER TABLE `restaurants` DISABLE KEYS */;
INSERT INTO `restaurants` VALUES (1,'melbone apple pie','P.O.Box 1002, Lilongwe, Malawi','Lilongwe',NULL,'open',NULL,2,'2026-02-26 08:03:49','2026-02-26 06:03:49'),(2,'sushi syllup','P.O.Box z10, Blantyre, Malawi','Blantyre',NULL,'open',NULL,2,'2026-02-26 08:04:43','2026-02-26 06:04:43'),(3,'mark chef-array','Area 9, Lilongwe, Malawi','Lilongwe',NULL,'open',NULL,1,'2026-02-26 08:07:11','2026-02-26 06:07:11');
/*!40000 ALTER TABLE `restaurants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_types`
--

LOCK TABLES `user_types` WRITE;
/*!40000 ALTER TABLE `user_types` DISABLE KEYS */;
INSERT INTO `user_types` VALUES (1,'administrator','2026-02-28 23:11:19','2026-02-28 21:11:19'),(2,'customer','2026-02-28 23:11:32','2026-02-28 21:11:32'),(3,'restaurant manager','2026-02-28 23:11:43','2026-02-28 21:11:43'),(4,'delivery rider','2026-02-28 23:12:02','2026-02-28 21:12:02');
/*!40000 ALTER TABLE `user_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'matthews','siebens','siebens@urbaneats.com','0882930201','ms01ss',1,'active','2026-02-26 07:18:20','2026-02-26 05:18:20'),(2,'simons','kafka','kafkas@urbaneats.com','0882000211','sk01as',1,'active','2026-02-26 07:20:03','2026-02-26 05:20:03'),(3,'jameson','nidir','nidirj@urbaneats.com','0928930015','jn05rn',1,'active','2026-02-26 07:23:01','2026-02-26 05:32:23'),(4,'james','noida','noidaj@urbaneats.com','0993893008','jn08as',1,'active','2026-02-26 07:26:04','2026-02-26 05:26:04'),(5,'mark','dinello','dinellom@urbaneats.com','0893191028','md08ok',1,'active','2026-02-26 07:29:29','2026-02-26 05:29:29'),(6,'michael','pally','pallym@urbaneats.com','0993893012','mp02yl',4,'active','2026-02-26 07:48:49','2026-02-26 05:48:49'),(7,'keida','noida','noidak@urbaneats.com','0883893008','kn08aa',4,'active','2026-02-26 07:50:37','2026-02-26 05:50:37'),(8,'gerald','nninjaku','nninjakug@urbaneats.com','0982910293','gn03ud',4,'active','2026-02-26 07:52:15','2026-02-26 05:52:15'),(12,'mark','noida','noidaj@urbaneats.com','0993333008','mn08ak',3,'active','2026-02-26 07:37:48','2026-02-26 05:37:48'),(13,'matthews','javanoo','javanooj@urbaneats.com','0993893117','mj07os',3,'active','2026-02-26 07:39:19','2026-02-26 05:39:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-01  0:01:07
