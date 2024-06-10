-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: merussi
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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `ID_CATEGORIA` int NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'prueba'),(2,'LACTEOS'),(3,'GOLOSINAS'),(4,'FIDEOS'),(5,'FRESCOS'),(6,'LIMPIEZA'),(7,'HIGIENE PERSONAL'),(8,'MEDICAMENTOS');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `ID_FACTURA` int NOT NULL AUTO_INCREMENT,
  `COD_EMPLEADO` int NOT NULL,
  `COD_CLIENTE` int NOT NULL,
  `FEC_EMISION` date NOT NULL DEFAULT (curdate()),
  `OBSERVACIONES` varchar(100) DEFAULT 'SIN OBSERVACIONES',
  PRIMARY KEY (`ID_FACTURA`),
  KEY `FK_EMPLEADO_FACTURA` (`COD_EMPLEADO`),
  KEY `FK_CLIENTE_FACTURA` (`COD_CLIENTE`),
  CONSTRAINT `FK_CLIENTE_FACTURA` FOREIGN KEY (`COD_CLIENTE`) REFERENCES `persona` (`ID_PERSONA`),
  CONSTRAINT `FK_EMPLEADO_FACTURA` FOREIGN KEY (`COD_EMPLEADO`) REFERENCES `persona` (`ID_PERSONA`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (1,3,9,'2024-04-20','VENTA POR MENOR'),(2,3,9,'2024-04-20','VENTA POR MENOR'),(3,4,7,'2024-04-21','CLIENTE DEL ALMACEN DON ARMANDO');
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_detalle`
--

DROP TABLE IF EXISTS `factura_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura_detalle` (
  `ID_DETALLE` int NOT NULL AUTO_INCREMENT,
  `ID_FACTURA` int NOT NULL,
  `ID_PRODUCTO` int NOT NULL,
  `CANTIDAD` decimal(3,0) NOT NULL,
  `TOTAL` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`ID_DETALLE`),
  UNIQUE KEY `ID_FACTURA` (`ID_FACTURA`,`ID_PRODUCTO`,`ID_DETALLE`),
  KEY `FK_PRODUCTO_FACTURA_DETALLE` (`ID_PRODUCTO`),
  CONSTRAINT `FK_FACTURA_FACTURA_DETALLE` FOREIGN KEY (`ID_FACTURA`) REFERENCES `factura` (`ID_FACTURA`),
  CONSTRAINT `FK_PRODUCTO_FACTURA_DETALLE` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `producto` (`ID_PRODUCTO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_detalle`
--

LOCK TABLES `factura_detalle` WRITE;
/*!40000 ALTER TABLE `factura_detalle` DISABLE KEYS */;
INSERT INTO `factura_detalle` VALUES (1,1,1,2,1600.00),(2,1,1,2,1600.00),(3,2,14,2,6500.00),(4,2,12,10,3000.00),(5,2,6,1,1500.00),(6,3,6,10,15000.00);
/*!40000 ALTER TABLE `factura_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura_pago`
--

DROP TABLE IF EXISTS `factura_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura_pago` (
  `ID_PAGO` int NOT NULL AUTO_INCREMENT,
  `ID_FACTURA` int NOT NULL,
  `ID_FPAGO` int NOT NULL,
  `TOTAL` decimal(18,2) NOT NULL,
  PRIMARY KEY (`ID_PAGO`),
  UNIQUE KEY `ID_PAGO` (`ID_PAGO`,`ID_FACTURA`,`ID_FPAGO`),
  KEY `FK_FORMA_DE_PAGO_FACTURA_PAGO` (`ID_FPAGO`),
  KEY `FK_FACTURA_FACTURA_PAGO` (`ID_FACTURA`),
  CONSTRAINT `FK_FACTURA_FACTURA_PAGO` FOREIGN KEY (`ID_FACTURA`) REFERENCES `factura` (`ID_FACTURA`),
  CONSTRAINT `FK_FORMA_DE_PAGO_FACTURA_PAGO` FOREIGN KEY (`ID_FPAGO`) REFERENCES `forma_de_pago` (`ID_FPAGO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura_pago`
--

LOCK TABLES `factura_pago` WRITE;
/*!40000 ALTER TABLE `factura_pago` DISABLE KEYS */;
INSERT INTO `factura_pago` VALUES (1,1,1,1600.00),(2,2,1,11000.00),(3,3,1,5000.00),(4,3,2,6000.00);
/*!40000 ALTER TABLE `factura_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forma_de_pago`
--

DROP TABLE IF EXISTS `forma_de_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forma_de_pago` (
  `ID_FPAGO` int NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_FPAGO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forma_de_pago`
--

LOCK TABLES `forma_de_pago` WRITE;
/*!40000 ALTER TABLE `forma_de_pago` DISABLE KEYS */;
INSERT INTO `forma_de_pago` VALUES (1,'EFECTIVO'),(2,'TARJETA DEBITO'),(3,'TARJETA CREDITO'),(4,'TRANSFERENCIA');
/*!40000 ALTER TABLE `forma_de_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_cambios`
--

DROP TABLE IF EXISTS `log_cambios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_cambios` (
  `ID_LOG` int NOT NULL AUTO_INCREMENT,
  `TABLA_AFECTADA` varchar(50) DEFAULT NULL,
  `ACCION` varchar(50) DEFAULT NULL,
  `FECHA` datetime DEFAULT NULL,
  `ID_REGISTRO` int DEFAULT NULL,
  `OBSERVACIONES` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_LOG`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_cambios`
--

LOCK TABLES `log_cambios` WRITE;
/*!40000 ALTER TABLE `log_cambios` DISABLE KEYS */;
INSERT INTO `log_cambios` VALUES (1,'PRODUCTO_STOCK','UPDATE','2024-04-27 20:22:27',2,'PRODUCTO SIN STOCK');
/*!40000 ALTER TABLE `log_cambios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `ID_PERSONA` int NOT NULL AUTO_INCREMENT,
  `ID_ROL` int NOT NULL,
  `NOMBRE` varchar(30) NOT NULL,
  `APELLIDO` varchar(30) NOT NULL,
  `ID_TIPODOC` int NOT NULL,
  `NRO_DOCUMENTO` varchar(20) NOT NULL,
  `FEC_NACIMIENTO` date DEFAULT (curdate()),
  `DIRECCION_NRO` decimal(4,0) NOT NULL,
  `DIRECCION_CALLE` varchar(30) NOT NULL,
  `ID_POSTAL` int NOT NULL,
  `ID_PROVINCIA` int NOT NULL,
  PRIMARY KEY (`ID_PERSONA`),
  KEY `FK_ROL_PERSONA` (`ID_ROL`),
  KEY `FK_TIPODOC_PERSONA` (`ID_TIPODOC`),
  KEY `FK_POSTAL_PERSONA` (`ID_POSTAL`),
  KEY `FK_PROVINCIA_PERSONA` (`ID_PROVINCIA`),
  CONSTRAINT `FK_POSTAL_PERSONA` FOREIGN KEY (`ID_POSTAL`) REFERENCES `postal` (`ID_POSTAL`),
  CONSTRAINT `FK_PROVINCIA_PERSONA` FOREIGN KEY (`ID_PROVINCIA`) REFERENCES `provincia` (`ID_PROVINCIA`),
  CONSTRAINT `FK_ROL_PERSONA` FOREIGN KEY (`ID_ROL`) REFERENCES `rol` (`ID_ROL`),
  CONSTRAINT `FK_TIPODOC_PERSONA` FOREIGN KEY (`ID_TIPODOC`) REFERENCES `tipo_documento` (`ID_TIPODOC`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,1,'VALENTINA','REIGADA',1,'234530022213','1990-01-01',123,'VENECIA',1,1),(2,1,'LUCILA','REIGADA',1,'234110022213','1990-01-01',122,'VALENCIA',1,1),(3,2,'GUSTAVO','SOSA',1,'234530022213','1990-01-01',123,'LELOL',2,1),(4,2,'LORENA','MENDOZA',1,'234530022213','1990-01-01',103,'MILCO',3,1),(5,2,'LUCAS','GONZALEZ',1,'234530022213','1990-01-01',193,'SOLERL',1,1),(6,2,'LUCIANO','ESPINOZA',1,'234530022213','1990-01-01',113,'MILO',4,1),(7,3,'AGUSTIN','PEREZ',1,'234530022213','1990-01-01',123,'LELOL',2,1),(8,3,'LORENA','REINOSO',1,'234530022213','1990-01-01',103,'MILCO',3,1),(9,3,'JULIAN','MENDEZ',1,'234530022213','1990-01-01',193,'SOLERL',1,1),(10,3,'NICOLAS','VERONA',1,'234530022213','1990-01-01',113,'MILO',4,1),(11,1,'GUSTAVO','REINOSO',1,'122211','1990-01-01',122,'VALENCIA',1,1),(12,1,'VALENTINA','COBACHO',1,'1233211','1999-10-01',122,'VALENCIA',1,1);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_trigger` AFTER INSERT ON `persona` FOR EACH ROW BEGIN
    INSERT INTO LOG_CAMBIOS (tabla_afectada, accion, fecha, id_registro, observaciones)
    VALUES ('PERSONA', 'INSERT', NOW() , NEW.ID_PERSONA, 'NUEVA PERSONA EN EL SISTEMA');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `postal`
--

DROP TABLE IF EXISTS `postal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postal` (
  `ID_POSTAL` int NOT NULL AUTO_INCREMENT,
  `LOCALIDAD` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_POSTAL`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postal`
--

LOCK TABLES `postal` WRITE;
/*!40000 ALTER TABLE `postal` DISABLE KEYS */;
INSERT INTO `postal` VALUES (1,'FLORENCIO VARELA'),(2,'QUILMES'),(3,'BERNAL'),(4,'DON BOSCO');
/*!40000 ALTER TABLE `postal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `ID_PRODUCTO` int NOT NULL AUTO_INCREMENT,
  `ID_CATEGORIA` int NOT NULL,
  `NOMBRE` varchar(30) NOT NULL,
  `FEC_VENCIMIENTO` date NOT NULL,
  `PRECIO` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`ID_PRODUCTO`),
  KEY `FK_PRODUCTO_CATEGORIA` (`ID_CATEGORIA`),
  CONSTRAINT `FK_PRODUCTO_CATEGORIA` FOREIGN KEY (`ID_CATEGORIA`) REFERENCES `categoria` (`ID_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,1,'JUGO CEPITA','2024-12-20',800.00),(2,1,'GASEOSA COCA COLA','2024-12-20',1300.00),(3,1,'GASEOSA MANOS','2024-12-20',900.00),(4,1,'VINO LOS OMBUES','2024-12-20',10000.00),(5,1,'GASEOSA PEPSI','2024-12-20',1100.00),(6,2,'LECHE SERENISIMA','2024-07-20',1500.00),(7,2,'SANCOR SANCOR','2024-06-20',1300.00),(8,2,'QUESO PORT SALUD','2024-05-20',3500.00),(9,3,'CHOCOLATE','2024-12-20',500.00),(10,3,'GOMITAS SANCOR','2024-12-20',100.00),(11,3,'ALFAJOR JORGITO','2024-12-20',700.00),(12,3,'ALFAJOR FULBITO','2024-12-20',300.00),(13,3,'CARAMELOS MASTICABLES','2024-12-20',230.00),(14,4,'FIDEOS MATARAZZO','2024-08-10',1300.00),(15,4,'FIDEOS CAMPONOLA','2024-08-10',2399.99),(16,4,'FIDEOS QUE RICO','2024-08-10',800.99),(17,4,'FIDEOS DON VICENTE','2024-08-10',3000.00),(18,5,'SALCHICHAS','2024-08-12',2000.00),(19,5,'PATYS','2024-09-01',3400.00),(20,5,'MEDALLON DE POLLO','2024-06-01',4500.00),(21,5,'MEDALLON DE JAMON Y QUESO','2024-06-01',4000.00),(22,5,'MEDALLON DE QUESO Y CEBOLLA','2024-06-01',4000.00),(23,6,'DETERGENTE','2026-01-01',2090.99),(24,6,'AROMATIZANTE','2026-01-01',2090.99),(25,6,'JABON EN POLVO','2026-01-01',2090.99),(26,6,'LAVANDINA','2026-01-01',2090.99),(27,6,'TOALLITAS','2028-01-01',8000.00),(28,6,'CEPILLO DE DIENTES','2028-01-01',2090.99),(29,6,'HILO DENTAL','2026-01-01',2090.99),(30,6,'PASTA DE DIENTES','2026-01-01',2090.99),(31,6,'ANTI FEBRIL','2028-01-01',800.00),(32,6,'ANALGESICO','2028-01-01',800.00),(33,8,'IBUPROFENO','2030-01-01',350.00),(34,8,'IBUPROFENO','2030-01-01',350.00),(35,8,'IBUPROFENO','2030-01-01',350.00);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_stock`
--

DROP TABLE IF EXISTS `producto_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto_stock` (
  `ID_STOCK` int NOT NULL AUTO_INCREMENT,
  `ID_PRODUCTO` int NOT NULL,
  `CANTIDAD` decimal(5,0) NOT NULL,
  PRIMARY KEY (`ID_STOCK`),
  KEY `FK_PRODUCTO_PRODUCTO_STOCK` (`ID_PRODUCTO`),
  CONSTRAINT `FK_PRODUCTO_PRODUCTO_STOCK` FOREIGN KEY (`ID_PRODUCTO`) REFERENCES `producto` (`ID_PRODUCTO`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_stock`
--

LOCK TABLES `producto_stock` WRITE;
/*!40000 ALTER TABLE `producto_stock` DISABLE KEYS */;
INSERT INTO `producto_stock` VALUES (1,1,27),(2,2,0),(3,3,0),(4,4,3),(5,5,10),(6,6,9),(7,7,30),(8,8,6),(9,9,10),(10,10,2),(11,11,10),(12,12,0),(13,13,3),(14,14,1),(15,15,10),(16,16,10),(17,17,30),(18,18,10),(19,19,15),(20,20,10),(21,21,0),(22,22,10),(23,23,6),(24,24,30),(25,25,10),(26,26,6),(27,27,10),(28,28,0),(29,29,10),(30,30,15),(31,31,3),(32,32,3),(33,35,10);
/*!40000 ALTER TABLE `producto_stock` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_productoStock_trigger` BEFORE UPDATE ON `producto_stock` FOR EACH ROW BEGIN
    DECLARE stock_disponible NUMERIC(5,0);

    -- Obtener el stock disponible del producto antes de la actualización
    SELECT CANTIDAD INTO stock_disponible
    FROM PRODUCTO_STOCK
    WHERE ID_PRODUCTO = OLD.ID_PRODUCTO;

    -- Verificar si hay suficiente stock disponible para el pedido
    IF stock_disponible < NEW.CANTIDAD  THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente stock disponible para el pedido';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_productoStock_trigger` AFTER UPDATE ON `producto_stock` FOR EACH ROW BEGIN
    IF NEW.CANTIDAD = 0 THEN
        INSERT INTO LOG_CAMBIOS (tabla_afectada, accion, fecha, id_registro, observaciones)
        VALUES ('PRODUCTO_STOCK', 'UPDATE', NOW(), OLD.ID_PRODUCTO, 'PRODUCTO SIN STOCK');
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provincia` (
  `ID_PROVINCIA` int NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_PROVINCIA`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES (1,'BUENOS AIRES'),(2,'CATAMARCA'),(3,'CHACO'),(4,'CHUBUT'),(5,'CORDOBA'),(6,'CORRIENTES'),(7,'ENTRE RIOS'),(8,'FORMOSA'),(9,'JUJUY'),(10,'LA PAMPA'),(11,'LA RIOJA'),(12,'MENDOZA'),(13,'MISIONES'),(14,'NEUQUEN'),(15,'RIO NEGRO'),(16,'SALTA'),(17,'SAN JUAN'),(18,'SANTA CRUZ'),(19,'SANTA FE'),(20,'SANTIAGO DEL ESTERO'),(21,'TIERRA DEL FUEGO'),(22,'TUCUMAN');
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `ID_ROL` int NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'DUENO'),(2,'EMPLEADO'),(3,'CLIENTE');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_documento`
--

DROP TABLE IF EXISTS `tipo_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_documento` (
  `ID_TIPODOC` int NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_TIPODOC`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_documento`
--

LOCK TABLES `tipo_documento` WRITE;
/*!40000 ALTER TABLE `tipo_documento` DISABLE KEYS */;
INSERT INTO `tipo_documento` VALUES (1,'DNI');
/*!40000 ALTER TABLE `tipo_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_factura_en_efectivo`
--

DROP TABLE IF EXISTS `vw_factura_en_efectivo`;
/*!50001 DROP VIEW IF EXISTS `vw_factura_en_efectivo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_factura_en_efectivo` AS SELECT 
 1 AS `NRO_FACTURA`,
 1 AS `NOMBRE_EMPLEADO`,
 1 AS `NOMBRE_CLIENTE`,
 1 AS `FECHA_EMISION`,
 1 AS `TOTAL`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_productos_a_reponer`
--

DROP TABLE IF EXISTS `vw_productos_a_reponer`;
/*!50001 DROP VIEW IF EXISTS `vw_productos_a_reponer`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_productos_a_reponer` AS SELECT 
 1 AS `ID_PRODUCTO`,
 1 AS `NOMBRE`,
 1 AS `CANTIDAD_STOCK`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_ventas_de_abril`
--

DROP TABLE IF EXISTS `vw_ventas_de_abril`;
/*!50001 DROP VIEW IF EXISTS `vw_ventas_de_abril`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_ventas_de_abril` AS SELECT 
 1 AS `NRO_FACTURA`,
 1 AS `NOMBRE_EMPLEADO`,
 1 AS `NOMBRE_CLIENTE`,
 1 AS `FECHA_EMISION`,
 1 AS `TOTAL_COMPRA`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'merussi'
--

--
-- Dumping routines for database 'merussi'
--
/*!50003 DROP FUNCTION IF EXISTS `cant_personas_segun_rol` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `cant_personas_segun_rol`(rol INT) RETURNS int
    DETERMINISTIC
    COMMENT 'Esta funcion retorna la cantidad de personas que tienen asignado el rol dado.'
BEGIN
		DECLARE CANTIDAD INT;
        SELECT COUNT(1) INTO CANTIDAD FROM PERSONA WHERE ID_ROL = rol;
        RETURN CANTIDAD;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `facturasDelEmpleado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `facturasDelEmpleado`(ID INT) RETURNS int
    DETERMINISTIC
    COMMENT 'Esta funcion indica si la cantidad de facturas que realizó el empleado dado'
BEGIN
		DECLARE CANTIDAD INT;
        SELECT COUNT(1) INTO CANTIDAD FROM FACTURA WHERE COD_EMPLEADO = ID;
        RETURN CANTIDAD;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `nombreCompleto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `nombreCompleto`(ID INT) RETURNS varchar(61) CHARSET utf8mb4
    NO SQL
    COMMENT 'Esta función retorna el nombre completo de la persona dada por parámetro.'
BEGIN
    DECLARE NOMBRE_PERSONA VARCHAR(30);
    DECLARE APELLIDO_PERSONA VARCHAR(30);
    DECLARE NOMBRE_COMPLETO VARCHAR(61);
    
    SELECT NOMBRE, APELLIDO
    INTO NOMBRE_PERSONA, APELLIDO_PERSONA
    FROM PERSONA
    WHERE ID_PERSONA = ID;
    
    SET NOMBRE_COMPLETO = CONCAT(NOMBRE_PERSONA, ' ', APELLIDO_PERSONA);
    
    RETURN NOMBRE_COMPLETO;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `productoEstrella` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `productoEstrella`() RETURNS int
    DETERMINISTIC
    COMMENT 'Esta funcion retorna el id del producto mas vendido'
BEGIN
		DECLARE ID_PROD INT;
        SELECT ID_PRODUCTO INTO ID_PROD
		FROM
			(SELECT 
				ID_PRODUCTO,
                COUNT(ID_PRODUCTO) AS CANTiDAD_VENDIDA
				FROM
					FACTURA_DETALLE
				GROUP BY 
					ID_PRODUCTO
				ORDER BY CANTiDAD_VENDIDA DESC
				LIMIT 1
			) AS producto_Mas_Vendido;
			
        RETURN ID_PROD;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `tieneStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `tieneStock`(ID INT) RETURNS tinyint(1)
    DETERMINISTIC
    COMMENT 'Esta funcion indica si el producto dado por parámetro tiene stock'
BEGIN
		DECLARE STOCK NUMERIC(5,0);
        SELECT CANTIDAD INTO STOCK FROM PRODUCTO_STOCK WHERE ID_PRODUCTO = ID;
        RETURN STOCK > 0;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `actualizarStockDesdeFactura` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarStockDesdeFactura`(
	IN p_factura INT
)
BEGIN
	DECLARE CANT_FACTURA INT;
      
    SELECT COUNT(1) INTO CANT_FACTURA
    FROM FACTURA 
    WHERE ID_FACTURA = p_factura;
    
    IF CANT_FACTURA = 0 THEN
		SELECT 'La factura dada no existe.' AS Mensaje;
	ELSE
    
        -- Actualizar el stock de los productos vendidos en la factura
        UPDATE PRODUCTO_STOCK ps
        JOIN FACTURA_DETALLE fd ON ps.ID_PRODUCTO = fd.ID_PRODUCTO
        SET ps.CANTIDAD = ps.CANTIDAD - fd.CANTIDAD
        WHERE fd.ID_FACTURA = p_factura;

        SELECT 'Se actualizó el stock de los productos exitosamente!' AS Mensaje;
  
    
    
	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_persona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_persona`(
	IN p_rol INT,
    IN p_nombre VARCHAR(30),
    IN p_apellido VARCHAR(30),
    IN p_tpo_doc INT,
    IN p_nro_doc VARCHAR(20),
    IN p_fec_nac DATE,
    IN p_dir_nro NUMERIC(4,0),
    IN p_dir_calle VARCHAR(30),
    IN p_id_postal INT,
    IN p_id_prov INT
)
BEGIN
    DECLARE CANT_ROL INT;
    DECLARE CANT_TPO_DOC INT;
    DECLARE CANT_POSTAL INT;
    DECLARE CANT_PROV INT;
    
    -- Verificar si existe rol, tipo documento, postal y provincia
    SELECT COUNT(*) INTO CANT_ROL
    FROM ROL
    WHERE ID_ROL  = p_rol;
    
	SELECT COUNT(*) INTO CANT_TPO_DOC
    FROM TIPO_DOCUMENTO
    WHERE ID_TIPODOC  = p_tpo_doc; 

	SELECT COUNT(*) INTO CANT_POSTAL
    FROM POSTAL
    WHERE ID_POSTAL  = p_id_postal; 
   
   	SELECT COUNT(*) INTO CANT_PROV
    FROM PROVINCIA
    WHERE ID_PROVINCIA  = p_id_prov; 
    
    -- Si existen, insertar la persona
    IF (CANT_ROL > 0 AND  CANT_TPO_DOC > 0 AND CANT_POSTAL > 0 AND CANT_PROV > 0) THEN
		INSERT INTO PERSONA (ID_ROL, NOMBRE, APELLIDO, ID_TIPODOC, NRO_DOCUMENTO, FEC_NACIMIENTO, DIRECCION_NRO, DIRECCION_CALLE, ID_POSTAL, ID_PROVINCIA) VALUES
        (p_rol, p_nombre, p_apellido, p_tpo_doc, p_nro_doc, p_fec_nac, p_dir_nro, p_dir_calle, p_id_postal, p_id_prov) ;
        SELECT 'La Persona fue creada de forma éxitosa.';
    ELSE
        SELECT 'Rol, Tipo Documento, Cod. Postal o Cod.Provincia incorrecto o no existe.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_productoYSuStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `crear_productoYSuStock`(
	IN p_categoria INT,
	IN p_nombre VARCHAR(30), 
	IN p_fecha DATE, 
	IN p_precio DECIMAL(18,2),
    IN p_stock NUMERIC(5,0)
)
BEGIN
	DECLARE CANT_CATE INT;
    DECLARE v_producto_id INT; -- Variable para almacenar el nuevo ID_PRODUCTO
    
    -- Verificar si existe rol, tipo documento, postal y provincia
    SELECT COUNT(*) INTO CANT_CATE
    FROM CATEGORIA
    WHERE ID_CATEGORIA  = p_categoria;
    
    IF CANT_CATE = 0 THEN 
		SELECT 'La categoria dada no existe.';
    ELSE IF (p_stock < 1) THEN
			SELECT 'El stock debe ser mayor a 0';
		ELSE
			-- Insertar en la tabla PRODUCTO
            INSERT INTO PRODUCTO (ID_CATEGORIA, NOMBRE, FEC_VENCIMIENTO, PRECIO) 
            VALUES (p_categoria, p_nombre, p_fecha, p_precio);
            -- Obtiene el último id generado.
            SET v_producto_id = LAST_INSERT_ID();
            -- Insertar en la tabla PRODUCTO_STOCK
            INSERT INTO PRODUCTO_STOCK (ID_PRODUCTO, CANTIDAD) 
            VALUES (v_producto_id, p_stock);
            
			SELECT CONCAT('El Producto se creó éxitosamente. Nro Producto:', v_producto_id) AS MENSAJE;
		END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_factura_en_efectivo`
--

/*!50001 DROP VIEW IF EXISTS `vw_factura_en_efectivo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_factura_en_efectivo` AS select `f`.`ID_FACTURA` AS `NRO_FACTURA`,`emp`.`NOMBRE` AS `NOMBRE_EMPLEADO`,`cli`.`NOMBRE` AS `NOMBRE_CLIENTE`,`f`.`FEC_EMISION` AS `FECHA_EMISION`,`fpag`.`TOTAL` AS `TOTAL` from (((`factura` `f` join `persona` `emp` on((`f`.`COD_EMPLEADO` = `emp`.`ID_PERSONA`))) join `persona` `cli` on((`f`.`COD_CLIENTE` = `cli`.`ID_PERSONA`))) join (select `factura_pago`.`ID_FACTURA` AS `ID_FACTURA`,sum(`factura_pago`.`TOTAL`) AS `TOTAL` from `factura_pago` group by `factura_pago`.`ID_FACTURA` having ((count(`factura_pago`.`ID_FPAGO`) = 1) and (max(`factura_pago`.`ID_FPAGO`) = 1))) `fpag` on((`f`.`ID_FACTURA` = `fpag`.`ID_FACTURA`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_productos_a_reponer`
--

/*!50001 DROP VIEW IF EXISTS `vw_productos_a_reponer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_productos_a_reponer` AS select `p`.`ID_PRODUCTO` AS `ID_PRODUCTO`,`p`.`NOMBRE` AS `NOMBRE`,`s`.`CANTIDAD` AS `CANTIDAD_STOCK` from (`producto` `p` join `producto_stock` `s` on((`p`.`ID_PRODUCTO` = `s`.`ID_PRODUCTO`))) where (`s`.`CANTIDAD` < 10) order by `s`.`CANTIDAD` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_ventas_de_abril`
--

/*!50001 DROP VIEW IF EXISTS `vw_ventas_de_abril`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_ventas_de_abril` AS select `f`.`ID_FACTURA` AS `NRO_FACTURA`,`emp`.`NOMBRE` AS `NOMBRE_EMPLEADO`,`cli`.`NOMBRE` AS `NOMBRE_CLIENTE`,`f`.`FEC_EMISION` AS `FECHA_EMISION`,sum(`fdet`.`TOTAL`) AS `TOTAL_COMPRA` from (((`factura` `f` join `persona` `emp` on((`f`.`COD_EMPLEADO` = `emp`.`ID_PERSONA`))) join `persona` `cli` on((`f`.`COD_CLIENTE` = `cli`.`ID_PERSONA`))) join `factura_detalle` `fdet` on((`fdet`.`ID_FACTURA` = `f`.`ID_FACTURA`))) where (`f`.`FEC_EMISION` between '2024-04-01' and '2024-04-30') group by `f`.`ID_FACTURA` */;
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

-- Dump completed on 2024-05-27 23:02:38
