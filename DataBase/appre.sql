-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.27-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para appre
CREATE DATABASE IF NOT EXISTS `appre` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `appre`;

-- Volcando estructura para tabla appre.level_app
CREATE TABLE IF NOT EXISTS `level_app` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name_level` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla appre.state_app
CREATE TABLE IF NOT EXISTS `state_app` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name_state` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla appre.user_app
CREATE TABLE IF NOT EXISTS `user_app` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name_user` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `document_number` varchar(15) NOT NULL,
  `cell_phone_number` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_app` varchar(50) NOT NULL,
  `id_level` int(11) NOT NULL,
  `id_state` int(11) NOT NULL,
  `image` blob DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `document_number` (`document_number`),
  UNIQUE KEY `cell_phone_number` (`cell_phone_number`),
  UNIQUE KEY `email` (`email`),
  KEY `id_level` (`id_level`),
  KEY `id_state` (`id_state`),
  CONSTRAINT `user_app_ibfk_1` FOREIGN KEY (`id_level`) REFERENCES `level_app` (`id`),
  CONSTRAINT `user_app_ibfk_2` FOREIGN KEY (`id_state`) REFERENCES `state_app` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
