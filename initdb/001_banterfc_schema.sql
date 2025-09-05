-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: banterfc
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Current Database: `banterfc`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `banterfc` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `banterfc`;

--
-- Table structure for table `_obsolete_api_tokens`
--

DROP TABLE IF EXISTS `_obsolete_api_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `_obsolete_api_tokens` (
  `token_id` bigint NOT NULL AUTO_INCREMENT,
  `device_id` int NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_used_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `revoked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `uq_api_tokens_token` (`token`),
  KEY `fk_api_tokens_device` (`device_id`),
  CONSTRAINT `fk_api_tokens_device` FOREIGN KEY (`device_id`) REFERENCES `user_devices` (`device_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_obsolete_api_tokens`
--

LOCK TABLES `_obsolete_api_tokens` WRITE;
/*!40000 ALTER TABLE `_obsolete_api_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `_obsolete_api_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `achievement_types`
--

DROP TABLE IF EXISTS `achievement_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievement_types` (
  `achievement_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`achievement_type_id`),
  UNIQUE KEY `uq_achievement_types_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievement_types`
--

LOCK TABLES `achievement_types` WRITE;
/*!40000 ALTER TABLE `achievement_types` DISABLE KEYS */;
INSERT INTO `achievement_types` VALUES (1,'Award'),(2,'Other');
/*!40000 ALTER TABLE `achievement_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `achievements`
--

DROP TABLE IF EXISTS `achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `achievements` (
  `achievement_id` int NOT NULL AUTO_INCREMENT,
  `achievement_type_id` int NOT NULL,
  `achievement_name` varchar(100) NOT NULL,
  `achievement_description` varchar(200) DEFAULT NULL,
  `coins_award` int DEFAULT '0',
  PRIMARY KEY (`achievement_id`),
  KEY `fk_achievements_type` (`achievement_type_id`),
  CONSTRAINT `fk_achievements_type` FOREIGN KEY (`achievement_type_id`) REFERENCES `achievement_types` (`achievement_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `achievements`
--

LOCK TABLES `achievements` WRITE;
/*!40000 ALTER TABLE `achievements` DISABLE KEYS */;
INSERT INTO `achievements` VALUES (1,1,'Daily Login','You logged in today!',5),(2,1,'Weekly Login','You logged in for a full week!',10),(3,1,'Top Poster','You are a top poster of the day!',20);
/*!40000 ALTER TABLE `achievements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ad_networks`
--

DROP TABLE IF EXISTS `ad_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_networks` (
  `ad_network_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`ad_network_id`),
  UNIQUE KEY `uq_ad_networks_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_networks`
--

LOCK TABLES `ad_networks` WRITE;
/*!40000 ALTER TABLE `ad_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ad_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_login_attempts`
--

DROP TABLE IF EXISTS `auth_login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_login_attempts` (
  `attempt_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `email_normalized` varchar(255) GENERATED ALWAYS AS ((case when (`email` is null) then NULL else lower(`email`) end)) STORED,
  `username` varchar(50) DEFAULT NULL,
  `username_normalized` varchar(50) GENERATED ALWAYS AS ((case when (`username` is null) then NULL else lower(`username`) end)) STORED,
  `device_id` varchar(128) DEFAULT NULL,
  `ip_addr` varbinary(16) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `success` tinyint(1) NOT NULL,
  `reason` enum('ok','bad_password','no_such_user','locked','mfa_required','mfa_failed','rate_limited','other') NOT NULL DEFAULT 'other',
  `geo_cc` char(2) DEFAULT NULL,
  `risk_score` tinyint unsigned DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`attempt_id`),
  KEY `ix_user_time` (`user_id`,`created_at`),
  KEY `ix_email_time` (`email_normalized`,`created_at`),
  KEY `ix_username_time` (`username_normalized`,`created_at`),
  KEY `ix_ip_time` (`ip_addr`,`created_at`),
  KEY `ix_success_time` (`success`,`created_at`),
  KEY `ix_reason_time` (`reason`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_login_attempts`
--

LOCK TABLES `auth_login_attempts` WRITE;
/*!40000 ALTER TABLE `auth_login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_login_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_stepup_challenges`
--

DROP TABLE IF EXISTS `auth_stepup_challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_stepup_challenges` (
  `challenge_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `device_id` varchar(191) NOT NULL,
  `purpose` varchar(64) NOT NULL,
  `nonce` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `consumed_at` datetime DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`challenge_id`),
  KEY `idx_user_device_purpose` (`user_id`,`device_id`,`purpose`,`expires_at`),
  KEY `idx_expires` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_stepup_challenges`
--

LOCK TABLES `auth_stepup_challenges` WRITE;
/*!40000 ALTER TABLE `auth_stepup_challenges` DISABLE KEYS */;
INSERT INTO `auth_stepup_challenges` VALUES (1,5,'postman-dev-1','coins:spend','151d26ce9ae2a53804ee6abcad5e6d3fcc514c8479511508294b3c5d59164191','2025-09-03 23:42:15',NULL,'2025-09-03 23:40:45.561557'),(2,5,'postman-dev-1','coins:spend','fc90f594e79592e3ecd48048cbe161b34403b5413cad2139f9c7689e76535b54','2025-09-03 23:50:42',NULL,'2025-09-03 23:49:12.093189'),(3,5,'postman-dev-1','coins:spend','ecd5c6e01cbe7a3937a27b390f56d4c83e794b95d702fba1c009fc0d2a6e4999','2025-09-04 00:09:28',NULL,'2025-09-03 23:59:28.231368'),(4,5,'postman-dev-1','coins:spend','6396e8003643eb74cf3855860ae6ab59f8622c139033708b12288154bda4783d','2025-09-04 15:30:52','2025-09-04 15:20:52','2025-09-04 15:20:52.587156'),(5,5,'postman-dev-1','coins:spend','62fa9a60a3ab4c028fe93345a6b0c3e01ff5bdc213e6989bb2316948c2e4c680','2025-09-04 16:28:30','2025-09-04 16:18:30','2025-09-04 16:18:30.194777');
/*!40000 ALTER TABLE `auth_stepup_challenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changed_posts`
--

DROP TABLE IF EXISTS `changed_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changed_posts` (
  `post_id` bigint NOT NULL,
  `reason` enum('vote','boost','post') NOT NULL,
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `ix_changed_posts_time` (`changed_at`),
  KEY `ix_changed_posts_post` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changed_posts`
--

LOCK TABLES `changed_posts` WRITE;
/*!40000 ALTER TABLE `changed_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `changed_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coin_transactions`
--

DROP TABLE IF EXISTS `coin_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coin_transactions` (
  `transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `wallet_id` int NOT NULL,
  `amount` int NOT NULL,
  `balance_after` int NOT NULL,
  `transaction_type_id` int NOT NULL,
  `related_entity_id` bigint DEFAULT NULL,
  `related_entity_type` varchar(50) DEFAULT NULL,
  `notes` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_coin_transactions_wallet` (`wallet_id`),
  KEY `fk_coin_transactions_type` (`transaction_type_id`),
  CONSTRAINT `fk_coin_transactions_type` FOREIGN KEY (`transaction_type_id`) REFERENCES `transaction_types` (`transaction_type_id`),
  CONSTRAINT `fk_coin_transactions_wallet` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`wallet_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coin_transactions`
--

LOCK TABLES `coin_transactions` WRITE;
/*!40000 ALTER TABLE `coin_transactions` DISABLE KEYS */;
INSERT INTO `coin_transactions` VALUES (1,1,5,55,1,NULL,NULL,'Daily login bonus','2025-08-26 22:47:18'),(2,2,-10,20,2,2,'post','Boosted Post #2','2025-08-26 22:47:18');
/*!40000 ALTER TABLE `coin_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_tokens`
--

DROP TABLE IF EXISTS `device_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_tokens` (
  `token_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `refresh_token_hash` char(64) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime DEFAULT NULL,
  `refresh_expires_at` datetime DEFAULT NULL,
  `revoked_at` datetime DEFAULT NULL,
  `last_used_at` datetime DEFAULT NULL,
  `device_pubkey` varbinary(512) DEFAULT NULL COMMENT 'Device public key (private key in Secure Enclave/Keystore)',
  `sign_alg` varchar(32) DEFAULT NULL COMMENT 'Signature algorithm, e.g., ES256',
  `sign_count` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'Monotonic counter if provided by platform (clone detection)',
  `replaced_by_token_hash` char(64) DEFAULT NULL COMMENT 'Hash of the new refresh token when this one is rotated (reuse detection)',
  `integrity_status` enum('unknown','ok','suspect','failed') NOT NULL DEFAULT 'unknown' COMMENT 'Attestation snapshot: Play Integrity / DeviceCheck',
  `integrity_meta` json DEFAULT NULL COMMENT 'Integrity payload (nonce, verdict, details)',
  `device_id_hash` binary(32) GENERATED ALWAYS AS (unhex(sha2(`device_id`,256))) STORED COMMENT 'Hash of app-scoped device UUID for indexing without exposing raw value',
  `last_ip` varbinary(16) DEFAULT NULL COMMENT 'INET6_ATON(client IP) at last use',
  `last_user_agent` varchar(255) DEFAULT NULL COMMENT 'Last known UA (OS/app version)',
  PRIMARY KEY (`token_id`),
  KEY `ix_dt_user_device_revoked` (`user_id`,`device_id`,`revoked_at`),
  KEY `ix_dt_token_hash` (`token_hash`),
  KEY `ix_dt_refresh_token_hash` (`refresh_token_hash`),
  KEY `ix_dt_replaced_by_hash` (`replaced_by_token_hash`),
  KEY `ix_dt_device_hash` (`device_id_hash`),
  KEY `ix_dt_refresh_expiry` (`refresh_expires_at`),
  KEY `ix_dt_access_expiry` (`expires_at`),
  KEY `ix_dt_last_used` (`last_used_at`),
  KEY `ix_dt_integrity_status` (`integrity_status`),
  CONSTRAINT `device_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `chk_dt_refresh_token_hash_len` CHECK (((`refresh_token_hash` is null) or (char_length(`refresh_token_hash`) = 64))),
  CONSTRAINT `chk_dt_replaced_by_hash_len` CHECK (((`replaced_by_token_hash` is null) or (char_length(`replaced_by_token_hash`) = 64))),
  CONSTRAINT `chk_dt_token_hash_len` CHECK ((char_length(`token_hash`) = 64))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_tokens`
--

LOCK TABLES `device_tokens` WRITE;
/*!40000 ALTER TABLE `device_tokens` DISABLE KEYS */;
INSERT INTO `device_tokens` (`token_id`, `user_id`, `device_id`, `token_hash`, `refresh_token_hash`, `created_at`, `expires_at`, `refresh_expires_at`, `revoked_at`, `last_used_at`, `device_pubkey`, `sign_alg`, `sign_count`, `replaced_by_token_hash`, `integrity_status`, `integrity_meta`, `last_ip`, `last_user_agent`) VALUES (1,1,'device123','ee7fdbd598bf649359115e05b9a4e476a85ec6d9bc3c99af39476e66bb1db25c','0c073281e7660e2e31ef8d355d8852a9213116eae753eb3c75f3295560b98e2f','2025-08-27 17:35:25','2025-09-26 17:35:25','2025-11-25 17:35:25',NULL,'2025-09-02 17:36:28',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(2,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 18:17:55','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 22:52:20',0x6465762D706C616365686F6C646572,'ES256',0,NULL,'unknown',NULL,NULL,NULL),(3,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 19:07:37','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 22:52:53',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(4,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 19:17:11','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 22:54:16',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(5,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 19:36:02','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 22:55:55',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(6,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 21:12:32','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 22:56:15',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(7,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 21:19:01','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 22:59:15',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(8,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 21:50:00','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 23:01:41',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(9,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 21:59:32','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 23:03:22',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(10,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 22:30:30','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 23:05:18',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(11,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 22:40:17','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 23:08:28',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(12,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 22:44:04','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 23:10:50',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(13,5,'postman-dev-1','a717056b630965a7ac7e907595030d85609de35bb271ace0d2a49b90944c264d','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 22:47:52','2025-09-03 23:25:50','2025-10-19 16:18:30',NULL,'2025-09-03 22:47:52',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(14,5,'postman-dev-1','3a173d30401904cf8edb9ac0ed0339f0418081b196ba159aec94abab363664a2','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 23:38:32',NULL,'2025-10-19 16:18:30',NULL,'2025-09-04 00:01:49',0x2D2D2D2D2D424547494E205055424C4943204B45592D2D2D2D2D0A4D436F77425159444B32567741794541674939664F43716D6C516452325146357879547279687931657768644C58704D572F6E4C364B53384457303D0A2D2D2D2D2D454E44205055424C4943204B45592D2D2D2D2D0A,'ed25519',0,NULL,'unknown',NULL,NULL,NULL),(15,5,'postman-dev-1','dd670f797ffb82c843a3136f1b50bb4fe940c58980ce1ca0219545266a5e9266','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 23:48:25',NULL,'2025-10-19 16:18:30',NULL,'2025-09-03 23:49:12',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(16,5,'postman-dev-1','d2e25b8050952dad492b8e3502268eaa8e7759df0690a7c8c1d65527fc3d776c','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-03 23:59:00',NULL,'2025-10-19 16:18:30',NULL,'2025-09-04 00:02:07',NULL,NULL,0,NULL,'unknown',NULL,NULL,NULL),(17,5,'postman-dev-1','ab3b5dc44b8d9e0b543d6d6439d7d21b77c11e2645374574a845b56d625390b2','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-04 15:20:53',NULL,'2025-10-19 16:18:30',NULL,'2025-09-04 15:20:52',0x2D2D2D2D2D424547494E205055424C4943204B45592D2D2D2D2D0A4D436F77425159444B32567741794541674939664F43716D6C516452325146357879547279687931657768644C58704D572F6E4C364B53384457303D0A2D2D2D2D2D454E44205055424C4943204B45592D2D2D2D2D0A,'ed25519',0,NULL,'unknown',NULL,NULL,NULL),(18,5,'postman-dev-1','0992b55f0e09cb76ba65bb8b17fc0940629ba0587b9547674c73c83f570991d6','19a2f88393fa7cae87344841c93e75ecd35708ba3201cb57286dad452e428b74','2025-09-04 16:18:30',NULL,'2025-10-19 16:18:30',NULL,'2025-09-04 16:18:30',0x2D2D2D2D2D424547494E205055424C4943204B45592D2D2D2D2D0A4D436F77425159444B32567741794541674939664F43716D6C516452325146357879547279687931657768644C58704D572F6E4C364B53384457303D0A2D2D2D2D2D454E44205055424C4943204B45592D2D2D2D2D0A,'ed25519',0,NULL,'unknown',NULL,NULL,NULL);
/*!40000 ALTER TABLE `device_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `device_types`
--

DROP TABLE IF EXISTS `device_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_types` (
  `device_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`device_type_id`),
  UNIQUE KEY `uq_device_types_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device_types`
--

LOCK TABLES `device_types` WRITE;
/*!40000 ALTER TABLE `device_types` DISABLE KEYS */;
INSERT INTO `device_types` VALUES (1,'Android'),(2,'iOS');
/*!40000 ALTER TABLE `device_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_verifications`
--

DROP TABLE IF EXISTS `email_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verifications` (
  `email_verification_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `purpose` enum('primary','add') NOT NULL DEFAULT 'primary',
  `token_hash` char(64) NOT NULL,
  `sent_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `expires_at` datetime(6) NOT NULL,
  `consumed_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`email_verification_id`),
  UNIQUE KEY `uq_token_hash` (`token_hash`),
  KEY `ix_user_time` (`user_id`,`sent_at`),
  CONSTRAINT `fk_ev_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_verifications`
--

LOCK TABLES `email_verifications` WRITE;
/*!40000 ALTER TABLE `email_verifications` DISABLE KEYS */;
INSERT INTO `email_verifications` VALUES (1,1,'test@example.com','primary','aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa','2025-09-02 22:13:40.728799','2025-09-02 23:13:40.728799',NULL),(2,1,'redfan@example.com','primary','e913454dd33cdab1833b347d9aabf41a6ce1e5b934a8fca47d3b2144992e702e','2025-09-02 22:31:59.758706','2025-09-02 23:31:59.758710','2025-09-02 22:35:33.458254');
/*!40000 ALTER TABLE `email_verifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `external_images`
--

DROP TABLE IF EXISTS `external_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_images` (
  `external_image_id` bigint NOT NULL AUTO_INCREMENT,
  `url` varchar(2048) NOT NULL,
  `host` varchar(255) NOT NULL,
  `normalized_url` varchar(2048) DEFAULT NULL,
  `content_type` varchar(64) DEFAULT NULL,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `byte_length` int unsigned DEFAULT NULL,
  `cached_thumb_key` varchar(512) DEFAULT NULL,
  `cached_thumb_w` int unsigned DEFAULT NULL,
  `cached_thumb_h` int unsigned DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `url_sha256` binary(32) NOT NULL,
  PRIMARY KEY (`external_image_id`),
  UNIQUE KEY `uniq_url_hash` (`url_sha256`),
  KEY `host_scan` (`host`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `external_images`
--

LOCK TABLES `external_images` WRITE;
/*!40000 ALTER TABLE `external_images` DISABLE KEYS */;
INSERT INTO `external_images` VALUES (1,'https://i.imgur.com/A1b2C3d.jpg?utm=123','i.imgur.com','https://i.imgur.com/A1b2C3d.jpg','image/jpeg',1600,900,245678,'s3://thumbs/external/imgur/A1b2C3d_320x180.webp',320,180,'2025-08-29 18:42:03.224456',0x4A44DC15364204A80FE80E9039455CC1608281820FE2B24F1E5233ADE5F05F80),(2,'http://imgur.com/A7ZxQpQ.png','imgur.com','https://i.imgur.com/A7ZxQpQ.png','image/png',512,512,14892,'s3://thumbs/external/imgur/A7ZxQpQ_256x256.webp',256,256,'2025-08-29 18:42:03.224456',0x9E107D9D372BB6826BD81D3542A419D6E5C6B4B0A1B2C3D4E5F60718293A4B5C),(3,'https://i.imgur.com/Loop123.gif','i.imgur.com','https://i.imgur.com/Loop123.gif','image/gif',320,240,27640,'s3://thumbs/external/imgur/Loop123_160x120.webp',160,120,'2025-08-29 18:42:03.224456',0xE3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855),(4,'https://i.imgur.com/CatPic.webp','i.imgur.com','https://i.imgur.com/CatPic.webp','image/webp',1024,1024,89345,'s3://thumbs/external/imgur/CatPic_256x256.webp',256,256,'2025-08-29 18:42:03.224456',0x0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF);
/*!40000 ALTER TABLE `external_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_blobs`
--

DROP TABLE IF EXISTS `image_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image_blobs` (
  `image_id` bigint NOT NULL AUTO_INCREMENT,
  `sha256_hex` char(64) NOT NULL,
  `byte_length` int unsigned NOT NULL,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `mime_type` varchar(64) NOT NULL,
  `storage_key` varchar(512) NOT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `normalized_sha256_hex` char(64) DEFAULT NULL,
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `uniq_sha256` (`sha256_hex`),
  KEY `created_scan` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_blobs`
--

LOCK TABLES `image_blobs` WRITE;
/*!40000 ALTER TABLE `image_blobs` DISABLE KEYS */;
INSERT INTO `image_blobs` VALUES (1,'9e107d9d372bb6826bd81d3542a419d6e5c6b4b0a1b2c3d4e5f60718293a4b5c',265418,1200,800,'image/jpeg','s3://my-media-bucket/images/2025/08/photo_1200x800.jpg','2025-08-29 18:16:40.623860','9e107d9d372bb6826bd81d3542a419d6e5c6b4b0a1b2c3d4e5f60718293a4b5c'),(2,'4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade5f05f80',14892,512,512,'image/png','s3://my-media-bucket/icons/2025/08/app_icon_512.png','2025-08-29 18:16:40.623860','4a44dc15364204a80fe80e9039455cc1608281820fe2b24f1e5233ade5f05f80'),(3,'b1946ac92492d2347c6235b4d2611184b1946ac92492d2347c6235b4d2611184',82301,1024,768,'image/webp','s3://my-media-bucket/images/2025/08/photo_1024x768.webp','2025-08-29 18:16:40.623860','9e107d9d372bb6826bd81d3542a419d6e5c6b4b0a1b2c3d4e5f60718293a4b5c'),(4,'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',27640,320,240,'image/gif','s3://my-media-bucket/gifs/2025/08/anim_320x240.gif','2025-08-29 18:16:40.623860','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855');
/*!40000 ALTER TABLE `image_blobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league_matches`
--

DROP TABLE IF EXISTS `league_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league_matches` (
  `match_id` int NOT NULL AUTO_INCREMENT,
  `home_team_id` int NOT NULL,
  `away_team_id` int NOT NULL,
  `match_date` datetime NOT NULL,
  `result` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`match_id`),
  KEY `fk_league_matches_home` (`home_team_id`),
  KEY `fk_league_matches_away` (`away_team_id`),
  CONSTRAINT `fk_league_matches_away` FOREIGN KEY (`away_team_id`) REFERENCES `teams` (`team_id`),
  CONSTRAINT `fk_league_matches_home` FOREIGN KEY (`home_team_id`) REFERENCES `teams` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league_matches`
--

LOCK TABLES `league_matches` WRITE;
/*!40000 ALTER TABLE `league_matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `league_matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `league_teams`
--

DROP TABLE IF EXISTS `league_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `league_teams` (
  `league_team_id` int NOT NULL AUTO_INCREMENT,
  `league_id` int NOT NULL,
  `team_id` int NOT NULL,
  PRIMARY KEY (`league_team_id`),
  KEY `fk_league_teams_league` (`league_id`),
  KEY `fk_league_teams_team` (`team_id`),
  CONSTRAINT `fk_league_teams_league` FOREIGN KEY (`league_id`) REFERENCES `leagues` (`league_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_league_teams_team` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `league_teams`
--

LOCK TABLES `league_teams` WRITE;
/*!40000 ALTER TABLE `league_teams` DISABLE KEYS */;
INSERT INTO `league_teams` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20);
/*!40000 ALTER TABLE `league_teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leagues`
--

DROP TABLE IF EXISTS `leagues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leagues` (
  `league_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`league_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leagues`
--

LOCK TABLES `leagues` WRITE;
/*!40000 ALTER TABLE `leagues` DISABLE KEYS */;
INSERT INTO `leagues` VALUES (1,'Premier League','2025-08-26 19:59:41','2025-08-26 19:59:41');
/*!40000 ALTER TABLE `leagues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moderation_action_types`
--

DROP TABLE IF EXISTS `moderation_action_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderation_action_types` (
  `action_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`action_type_id`),
  UNIQUE KEY `uq_moderation_action_types_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderation_action_types`
--

LOCK TABLES `moderation_action_types` WRITE;
/*!40000 ALTER TABLE `moderation_action_types` DISABLE KEYS */;
INSERT INTO `moderation_action_types` VALUES (1,'Ban'),(2,'Remove'),(3,'Warn');
/*!40000 ALTER TABLE `moderation_action_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moderation_actions`
--

DROP TABLE IF EXISTS `moderation_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderation_actions` (
  `moderation_action_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `moderator_id` int NOT NULL,
  `action_type_id` int NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`moderation_action_id`),
  KEY `fk_moderation_actions_post` (`post_id`),
  KEY `fk_moderation_actions_user` (`user_id`),
  KEY `fk_moderation_actions_moderator` (`moderator_id`),
  KEY `fk_moderation_actions_type` (`action_type_id`),
  CONSTRAINT `fk_moderation_actions_moderator` FOREIGN KEY (`moderator_id`) REFERENCES `moderators` (`moderator_id`),
  CONSTRAINT `fk_moderation_actions_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `fk_moderation_actions_type` FOREIGN KEY (`action_type_id`) REFERENCES `moderation_action_types` (`action_type_id`),
  CONSTRAINT `fk_moderation_actions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderation_actions`
--

LOCK TABLES `moderation_actions` WRITE;
/*!40000 ALTER TABLE `moderation_actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `moderation_actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moderators`
--

DROP TABLE IF EXISTS `moderators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderators` (
  `moderator_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `team_id` int DEFAULT NULL,
  `league_id` int DEFAULT NULL,
  `created_by_user_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`moderator_id`),
  KEY `fk_moderators_user` (`user_id`),
  KEY `fk_moderators_league` (`league_id`),
  KEY `fk_moderators_created_by` (`created_by_user_id`),
  KEY `ix_moderators_team_user` (`team_id`,`user_id`),
  CONSTRAINT `fk_moderators_created_by` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_moderators_league` FOREIGN KEY (`league_id`) REFERENCES `leagues` (`league_id`),
  CONSTRAINT `fk_moderators_team` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`),
  CONSTRAINT `fk_moderators_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moderators`
--

LOCK TABLES `moderators` WRITE;
/*!40000 ALTER TABLE `moderators` DISABLE KEYS */;
/*!40000 ALTER TABLE `moderators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `reset_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token_hash` char(64) NOT NULL,
  `requested_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `expires_at` datetime(6) NOT NULL,
  `consumed_at` datetime(6) DEFAULT NULL,
  `status` enum('issued','consumed','revoked','expired') NOT NULL DEFAULT 'issued',
  `requested_ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`reset_id`),
  UNIQUE KEY `uniq_token_hash` (`token_hash`),
  KEY `user_open` (`user_id`,`consumed_at`,`expires_at`),
  CONSTRAINT `fk_pr_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_boosts`
--

DROP TABLE IF EXISTS `post_boosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_boosts` (
  `post_boost_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `weight` float DEFAULT '1',
  `coin_cost` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_boost_id`),
  KEY `fk_post_boosts_user` (`user_id`),
  KEY `ix_post_boosts_post` (`post_id`),
  CONSTRAINT `fk_post_boosts_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_boosts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_boosts`
--

LOCK TABLES `post_boosts` WRITE;
/*!40000 ALTER TABLE `post_boosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_boosts` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_post_boosts_ai` AFTER INSERT ON `post_boosts` FOR EACH ROW BEGIN
  INSERT INTO changed_posts (post_id, reason) VALUES (NEW.post_id, 'boost');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_post_boosts_au` AFTER UPDATE ON `post_boosts` FOR EACH ROW BEGIN
  INSERT INTO changed_posts (post_id, reason) VALUES (NEW.post_id, 'boost');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `post_comment_edits`
--

DROP TABLE IF EXISTS `post_comment_edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comment_edits` (
  `comment_edit_id` int NOT NULL AUTO_INCREMENT,
  `post_comment_id` int NOT NULL,
  `editor_user_id` int NOT NULL,
  `old_content` text,
  `new_content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_edit_id`),
  KEY `fk_post_comment_edits_post` (`post_comment_id`),
  KEY `fk_post_comment_edits_user` (`editor_user_id`),
  CONSTRAINT `fk_post_comment_edits_post` FOREIGN KEY (`post_comment_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `fk_post_comment_edits_user` FOREIGN KEY (`editor_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comment_edits`
--

LOCK TABLES `post_comment_edits` WRITE;
/*!40000 ALTER TABLE `post_comment_edits` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_comment_edits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comment_images`
--

DROP TABLE IF EXISTS `post_comment_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comment_images` (
  `post_comment_image_id` bigint NOT NULL AUTO_INCREMENT,
  `post_comment_id` int NOT NULL,
  `image_id` bigint NOT NULL,
  `added_by` int NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `alt_text` varchar(512) DEFAULT NULL,
  `caption` varchar(512) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`post_comment_image_id`),
  UNIQUE KEY `uniq_post_comment_image` (`post_comment_id`,`image_id`),
  KEY `fk_pci_img` (`image_id`),
  KEY `fk_pci_user` (`added_by`),
  KEY `post_comment_scan` (`post_comment_id`,`sort_order`,`post_comment_image_id`),
  CONSTRAINT `fk_pic_img` FOREIGN KEY (`image_id`) REFERENCES `image_blobs` (`image_id`),
  CONSTRAINT `fk_pic_post_comment` FOREIGN KEY (`post_comment_id`) REFERENCES `post_comments` (`post_comment_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pic_user` FOREIGN KEY (`added_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comment_images`
--

LOCK TABLES `post_comment_images` WRITE;
/*!40000 ALTER TABLE `post_comment_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_comment_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comment_votes`
--

DROP TABLE IF EXISTS `post_comment_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comment_votes` (
  `post_comment_vote_id` int NOT NULL AUTO_INCREMENT,
  `post_comment_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vote_type_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_comment_vote_id`),
  KEY `fk_post_comment_votes_user` (`user_id`),
  KEY `fk_post_comment_votes_type` (`vote_type_id`),
  KEY `ix_post_comment_votes_post` (`post_comment_id`),
  CONSTRAINT `fk_post_comment_votes_post` FOREIGN KEY (`post_comment_id`) REFERENCES `post_comments` (`post_comment_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_comment_votes_type` FOREIGN KEY (`vote_type_id`) REFERENCES `vote_types` (`vote_type_id`),
  CONSTRAINT `fk_post_comment_votes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comment_votes`
--

LOCK TABLES `post_comment_votes` WRITE;
/*!40000 ALTER TABLE `post_comment_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_comment_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_comments`
--

DROP TABLE IF EXISTS `post_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_comments` (
  `post_comment_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `parent_comment_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `content_text` text,
  `content_markup` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `edited_at` datetime DEFAULT NULL,
  `edit_count` int DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`post_comment_id`),
  KEY `fk_post_comments_post` (`post_id`),
  KEY `fk_post_comments_comment` (`parent_comment_id`),
  KEY `fk_post_comments_user` (`user_id`),
  CONSTRAINT `fk_post_comments_comment` FOREIGN KEY (`parent_comment_id`) REFERENCES `post_comments` (`post_comment_id`),
  CONSTRAINT `fk_post_comments_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `fk_post_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_comments`
--

LOCK TABLES `post_comments` WRITE;
/*!40000 ALTER TABLE `post_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_edits`
--

DROP TABLE IF EXISTS `post_edits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_edits` (
  `edit_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `editor_user_id` int NOT NULL,
  `old_content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`edit_id`),
  KEY `fk_post_edits_post` (`post_id`),
  KEY `fk_post_edits_user` (`editor_user_id`),
  CONSTRAINT `fk_post_edits_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `fk_post_edits_user` FOREIGN KEY (`editor_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_edits`
--

LOCK TABLES `post_edits` WRITE;
/*!40000 ALTER TABLE `post_edits` DISABLE KEYS */;
INSERT INTO `post_edits` VALUES (1,3,3,'Liverpol fans are celebrating too early.','2025-08-29 18:51:05');
/*!40000 ALTER TABLE `post_edits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_external_images`
--

DROP TABLE IF EXISTS `post_external_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_external_images` (
  `post_external_image_id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `external_image_id` bigint NOT NULL,
  `alt_text` varchar(512) DEFAULT NULL,
  `caption` varchar(512) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`post_external_image_id`),
  UNIQUE KEY `uniq_post_ext` (`post_id`,`external_image_id`),
  KEY `fk_pei_ext` (`external_image_id`),
  KEY `post_scan` (`post_id`,`post_external_image_id`),
  CONSTRAINT `fk_pei_ext` FOREIGN KEY (`external_image_id`) REFERENCES `external_images` (`external_image_id`),
  CONSTRAINT `fk_pei_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_external_images`
--

LOCK TABLES `post_external_images` WRITE;
/*!40000 ALTER TABLE `post_external_images` DISABLE KEYS */;
INSERT INTO `post_external_images` VALUES (1,3,2,'outside meme 1','meme 1 caption','2025-08-29 18:44:03.000000'),(2,3,3,'outside meme 1','meme 1 caption','2025-08-29 18:44:03.000000');
/*!40000 ALTER TABLE `post_external_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_images`
--

DROP TABLE IF EXISTS `post_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_images` (
  `post_image_id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `image_id` bigint NOT NULL,
  `alt_text` varchar(512) DEFAULT NULL,
  `caption` varchar(512) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`post_image_id`),
  UNIQUE KEY `uniq_post_image` (`post_id`,`image_id`),
  KEY `fk_pi_img` (`image_id`),
  KEY `post_scan` (`post_id`,`post_image_id`),
  CONSTRAINT `fk_pi_img` FOREIGN KEY (`image_id`) REFERENCES `image_blobs` (`image_id`),
  CONSTRAINT `fk_pi_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_images`
--

LOCK TABLES `post_images` WRITE;
/*!40000 ALTER TABLE `post_images` DISABLE KEYS */;
INSERT INTO `post_images` VALUES (1,3,1,'my meme','MEME!','2025-08-29 18:24:07.000000'),(2,3,2,'my meme 2','MEME 2!','2025-08-29 18:24:07.000000');
/*!40000 ALTER TABLE `post_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_rankings`
--

DROP TABLE IF EXISTS `post_rankings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_rankings` (
  `post_id` bigint NOT NULL,
  `team_id` bigint NOT NULL,
  `score` double NOT NULL,
  `as_of` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `votes_component` double NOT NULL,
  `boosts_component` double NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `ix_team_score` (`team_id`,`score` DESC,`post_id` DESC),
  KEY `ix_rankings_paging` (`team_id`,`as_of`,`score` DESC,`post_id` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_rankings`
--

LOCK TABLES `post_rankings` WRITE;
/*!40000 ALTER TABLE `post_rankings` DISABLE KEYS */;
INSERT INTO `post_rankings` VALUES (1,2,0,'2025-08-28 19:02:07','2025-08-26 22:46:16',0,0),(2,12,0,'2025-08-28 19:02:07','2025-08-26 22:46:16',0,0),(3,12,0.5924190639592499,'2025-08-28 19:02:07','2025-08-26 22:46:16',1.4816045409242156,0),(4,12,0,'2025-08-28 19:02:07','2025-08-27 22:47:56',0,0),(5,12,0,'2025-08-28 19:02:07','2025-08-27 22:48:07',0,0),(6,12,0,'2025-08-28 19:02:07','2025-08-27 22:48:16',0,0);
/*!40000 ALTER TABLE `post_rankings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_rankings_current`
--

DROP TABLE IF EXISTS `post_rankings_current`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_rankings_current` (
  `post_id` bigint NOT NULL,
  `team_id` int NOT NULL,
  `score` double NOT NULL,
  `as_of` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `votes_component` double NOT NULL,
  `boosts_component` double NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `idx_team_score_desc` (`team_id`,`score` DESC,`post_id` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_rankings_current`
--

LOCK TABLES `post_rankings_current` WRITE;
/*!40000 ALTER TABLE `post_rankings_current` DISABLE KEYS */;
INSERT INTO `post_rankings_current` VALUES (1,2,0,'2025-08-29 21:58:07.000000','2025-08-26 22:46:16.000000',0,0),(2,12,0,'2025-08-29 21:58:07.000000','2025-08-26 22:46:16.000000',0,0),(3,12,0.33755020768715077,'2025-08-29 21:58:07.000000','2025-08-26 22:46:16.000000',1.4816045409242156,0),(4,12,0,'2025-08-30 22:47:07.000000','2025-08-27 22:47:56.000000',0,0),(5,12,0,'2025-08-30 22:48:07.000000','2025-08-27 22:48:07.000000',0,0),(6,12,0,'2025-08-30 22:48:07.000000','2025-08-27 22:48:16.000000',0,0);
/*!40000 ALTER TABLE `post_rankings_current` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_rankings_history`
--

DROP TABLE IF EXISTS `post_rankings_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_rankings_history` (
  `post_id` bigint NOT NULL,
  `team_id` int NOT NULL,
  `score` double NOT NULL,
  `as_of` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `votes_component` double NOT NULL,
  `boosts_component` double NOT NULL,
  PRIMARY KEY (`post_id`,`as_of`),
  KEY `idx_team_asof_score_desc` (`team_id`,`as_of`,`score` DESC,`post_id` DESC),
  KEY `idx_team_asof_post` (`team_id`,`as_of`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_rankings_history`
--

LOCK TABLES `post_rankings_history` WRITE;
/*!40000 ALTER TABLE `post_rankings_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_rankings_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tags`
--

DROP TABLE IF EXISTS `post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_tags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `fk_post_tags_tag` (`tag_id`),
  CONSTRAINT `fk_post_tags_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_tags_tag` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tags`
--

LOCK TABLES `post_tags` WRITE;
/*!40000 ALTER TABLE `post_tags` DISABLE KEYS */;
INSERT INTO `post_tags` VALUES (3,1),(1,4),(2,4);
/*!40000 ALTER TABLE `post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_votes`
--

DROP TABLE IF EXISTS `post_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_votes` (
  `post_vote_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vote_type_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_vote_id`),
  KEY `fk_post_votes_user` (`user_id`),
  KEY `fk_post_votes_type` (`vote_type_id`),
  KEY `ix_post_votes_post` (`post_id`),
  CONSTRAINT `fk_post_votes_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_post_votes_type` FOREIGN KEY (`vote_type_id`) REFERENCES `vote_types` (`vote_type_id`),
  CONSTRAINT `fk_post_votes_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_votes`
--

LOCK TABLES `post_votes` WRITE;
/*!40000 ALTER TABLE `post_votes` DISABLE KEYS */;
INSERT INTO `post_votes` VALUES (1,3,1,1,'2025-08-27 19:30:08'),(2,3,2,1,'2025-08-27 19:30:08'),(3,3,3,1,'2025-08-27 19:30:08');
/*!40000 ALTER TABLE `post_votes` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_post_votes_ai` AFTER INSERT ON `post_votes` FOR EACH ROW BEGIN
  INSERT INTO changed_posts (post_id, reason) VALUES (NEW.post_id, 'vote');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trg_post_votes_au` AFTER UPDATE ON `post_votes` FOR EACH ROW BEGIN
  INSERT INTO changed_posts (post_id, reason) VALUES (NEW.post_id, 'vote');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `team_id` int NOT NULL,
  `content_text` text,
  `content_markup` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `edited_at` datetime DEFAULT NULL,
  `edit_count` int DEFAULT '0',
  `is_anonymous` tinyint(1) DEFAULT '0',
  `is_pinned` tinyint(1) DEFAULT '0',
  `deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`post_id`),
  KEY `fk_posts_user` (`user_id`),
  KEY `ix_posts_team_created` (`team_id`,`created_at` DESC),
  KEY `ix_posts_team_deleted` (`team_id`,`deleted`,`post_id`),
  CONSTRAINT `fk_posts_team` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`),
  CONSTRAINT `fk_posts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,2,'Man Utd were amazing today!','**Man Utd were amazing today!**','2025-08-26 22:46:16','2025-08-26 22:46:16',NULL,0,0,0,0),(2,2,12,'Arsenal should have won that match.','*Arsenal should have won that match.*','2025-08-26 22:46:16','2025-08-27 19:24:04',NULL,0,0,0,0),(3,3,12,'Liverpool fans are celebrating too early.','*Liverpool fans are celebrating too early.*','2025-08-26 22:46:16','2025-08-27 19:24:04',NULL,0,1,0,0),(4,1,12,'hello','hello','2025-08-27 22:47:56','2025-08-27 22:47:56',NULL,0,0,0,0),(5,1,12,'world','world','2025-08-27 22:48:07','2025-08-27 22:48:07',NULL,0,0,0,0),(6,2,12,'oi oi','oi oi','2025-08-27 22:48:16','2025-08-27 22:48:16',NULL,0,0,0,0);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `predictions`
--

DROP TABLE IF EXISTS `predictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predictions` (
  `prediction_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `match_id` int NOT NULL,
  `predicted_score` varchar(10) DEFAULT NULL,
  `coins_spent` int DEFAULT '0',
  `is_completed` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`prediction_id`),
  KEY `fk_predictions_user` (`user_id`),
  KEY `fk_predictions_match` (`match_id`),
  CONSTRAINT `fk_predictions_match` FOREIGN KEY (`match_id`) REFERENCES `league_matches` (`match_id`),
  CONSTRAINT `fk_predictions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `predictions`
--

LOCK TABLES `predictions` WRITE;
/*!40000 ALTER TABLE `predictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `predictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchases` (
  `purchase_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `store_id` int NOT NULL,
  `product_id` varchar(100) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  `purchase_status` varchar(20) NOT NULL,
  PRIMARY KEY (`purchase_id`),
  KEY `fk_purchases_user` (`user_id`),
  KEY `fk_purchases_store` (`store_id`),
  CONSTRAINT `fk_purchases_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`),
  CONSTRAINT `fk_purchases_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_reasons`
--

DROP TABLE IF EXISTS `report_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_reasons` (
  `report_reason_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`report_reason_id`),
  UNIQUE KEY `uq_report_reasons_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_reasons`
--

LOCK TABLES `report_reasons` WRITE;
/*!40000 ALTER TABLE `report_reasons` DISABLE KEYS */;
INSERT INTO `report_reasons` VALUES (2,'Discrimination'),(1,'Illegal content'),(3,'Other');
/*!40000 ALTER TABLE `report_reasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reported_posts`
--

DROP TABLE IF EXISTS `reported_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reported_posts` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `post_comment_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `report_reason_id` int NOT NULL,
  `reviewed_by_user_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`),
  KEY `fk_reported_posts_post` (`post_id`),
  KEY `fk_reported_post_comments_post` (`post_comment_id`),
  KEY `fk_reported_posts_user` (`user_id`),
  KEY `fk_reported_posts_reason` (`report_reason_id`),
  KEY `fk_reported_posts_reviewed` (`reviewed_by_user_id`),
  CONSTRAINT `fk_reported_posts_post` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`),
  CONSTRAINT `fk_reported_posts_post_comment` FOREIGN KEY (`post_comment_id`) REFERENCES `post_comments` (`post_comment_id`),
  CONSTRAINT `fk_reported_posts_reason` FOREIGN KEY (`report_reason_id`) REFERENCES `report_reasons` (`report_reason_id`),
  CONSTRAINT `fk_reported_posts_reviewed` FOREIGN KEY (`reviewed_by_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_reported_posts_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reported_posts`
--

LOCK TABLES `reported_posts` WRITE;
/*!40000 ALTER TABLE `reported_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `reported_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `uq_stores_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (2,'Apple App Store'),(1,'Google Play Store');
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `uq_tags_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (2,'Funny'),(4,'Joke'),(1,'Meme'),(3,'Serious');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `team_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `abbreviation` varchar(5) DEFAULT NULL,
  `primary_color` varchar(7) DEFAULT NULL,
  `secondary_color` varchar(7) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,'Arsenal','ARS','#FF0000','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(2,'Aston Villa','AVL','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(3,'Bournemouth','BOU','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(4,'Brentford','BRE','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:53:38'),(5,'Brighton & Hove Albion','BHA','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:53:26'),(6,'Burnley','BUR','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(7,'Chelsea','CHE','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(8,'Crystal Palace','CRY','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(9,'Everton','EVE','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(10,'Fulham','FUL','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(11,'Leeds United','LEE','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(12,'Liverpool','LFC','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-27 00:00:54'),(13,'Manchester City','MCI','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(14,'Manchester United','MUN','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(15,'Newcastle United','NEW','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(16,'Nottingham Forest','NOT','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(17,'Sunderland','SUN','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(18,'Tottenham Hotspur','TOT','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14'),(19,'West Ham United','WHU','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:52:51'),(20,'Wolverhampton Wanderers','WOL','#FFFFFF','#FFFFFF','2025-08-26 19:59:41','2025-08-26 23:51:14');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiers`
--

DROP TABLE IF EXISTS `tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiers` (
  `tier_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`tier_id`),
  UNIQUE KEY `uq_tiers_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiers`
--

LOCK TABLES `tiers` WRITE;
/*!40000 ALTER TABLE `tiers` DISABLE KEYS */;
INSERT INTO `tiers` VALUES (1,'Free'),(2,'Paid');
/*!40000 ALTER TABLE `tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_types`
--

DROP TABLE IF EXISTS `transaction_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_types` (
  `transaction_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`transaction_type_id`),
  UNIQUE KEY `uq_transaction_types_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_types`
--

LOCK TABLES `transaction_types` WRITE;
/*!40000 ALTER TABLE `transaction_types` DISABLE KEYS */;
INSERT INTO `transaction_types` VALUES (2,'Anonymous Post'),(4,'Avatar'),(3,'Merchandise'),(1,'Post Boost');
/*!40000 ALTER TABLE `transaction_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tunables`
--

DROP TABLE IF EXISTS `tunables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tunables` (
  `id` tinyint NOT NULL,
  `w_vote_paid` decimal(6,3) NOT NULL,
  `w_vote_free` decimal(6,3) NOT NULL,
  `role_factor_creator` decimal(6,3) NOT NULL,
  `role_factor_noncreator` decimal(6,3) NOT NULL,
  `payer_factor_paid` decimal(6,3) NOT NULL,
  `payer_factor_free` decimal(6,3) NOT NULL,
  `mod_factor` decimal(6,3) NOT NULL,
  `tau_hours` decimal(10,3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tunables`
--

LOCK TABLES `tunables` WRITE;
/*!40000 ALTER TABLE `tunables` DISABLE KEYS */;
INSERT INTO `tunables` VALUES (1,1.200,1.000,1.000,0.600,1.200,1.000,1.500,48.000);
/*!40000 ALTER TABLE `tunables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_achievements`
--

DROP TABLE IF EXISTS `user_achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_achievements` (
  `user_achievement_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `achievement_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_achievement_id`),
  KEY `fk_user_achievements_user` (`user_id`),
  KEY `fk_user_achievements_achievement` (`achievement_id`),
  CONSTRAINT `fk_user_achievements_achievement` FOREIGN KEY (`achievement_id`) REFERENCES `achievements` (`achievement_id`),
  CONSTRAINT `fk_user_achievements_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_achievements`
--

LOCK TABLES `user_achievements` WRITE;
/*!40000 ALTER TABLE `user_achievements` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_achievements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_agreements`
--

DROP TABLE IF EXISTS `user_agreements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_agreements` (
  `user_agreement_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `policy_type` enum('privacy','tos','community') NOT NULL,
  `policy_version` varchar(32) NOT NULL,
  `accepted_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `device_id` varchar(128) DEFAULT NULL,
  `ip_addr` varbinary(16) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `locale` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_agreement_id`),
  KEY `ix_ua_user_type_time` (`user_id`,`policy_type`,`accepted_at`),
  KEY `ix_ua_type_version` (`policy_type`,`policy_version`,`accepted_at`),
  CONSTRAINT `fk_ua_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_agreements`
--

LOCK TABLES `user_agreements` WRITE;
/*!40000 ALTER TABLE `user_agreements` DISABLE KEYS */;
INSERT INTO `user_agreements` VALUES (1,4,'privacy','2025-08-15','2025-09-02 19:09:47.387990','ios-3f5a9c27f6d4423e8be7f75a0b3e5a7c',0xAC130001,'PostmanRuntime/7.39.1',NULL),(2,4,'tos','2025-08-15','2025-09-02 19:09:47.387990','ios-3f5a9c27f6d4423e8be7f75a0b3e5a7c',0xAC130001,'PostmanRuntime/7.39.1',NULL),(3,4,'community','2025-08-15','2025-09-02 19:09:47.387990','ios-3f5a9c27f6d4423e8be7f75a0b3e5a7c',0xAC130001,'PostmanRuntime/7.39.1',NULL);
/*!40000 ALTER TABLE `user_agreements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_devices`
--

DROP TABLE IF EXISTS `user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_devices` (
  `device_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `device_type_id` int NOT NULL,
  `device_name` varchar(100) DEFAULT NULL,
  `device_os_version` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_seen` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`device_id`),
  KEY `fk_user_devices_user` (`user_id`),
  KEY `fk_user_devices_type` (`device_type_id`),
  CONSTRAINT `fk_user_devices_type` FOREIGN KEY (`device_type_id`) REFERENCES `device_types` (`device_type_id`),
  CONSTRAINT `fk_user_devices_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_devices`
--

LOCK TABLES `user_devices` WRITE;
/*!40000 ALTER TABLE `user_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_images`
--

DROP TABLE IF EXISTS `user_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_images` (
  `user_image_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `image_id` bigint NOT NULL,
  `visibility` enum('private','team','public') NOT NULL DEFAULT 'private',
  `title` varchar(256) DEFAULT NULL,
  `added_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_image_id`),
  UNIQUE KEY `uniq_user_image` (`user_id`,`image_id`),
  KEY `fk_ui_img` (`image_id`),
  CONSTRAINT `fk_ui_img` FOREIGN KEY (`image_id`) REFERENCES `image_blobs` (`image_id`),
  CONSTRAINT `fk_ui_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_images`
--

LOCK TABLES `user_images` WRITE;
/*!40000 ALTER TABLE `user_images` DISABLE KEYS */;
INSERT INTO `user_images` VALUES (1,1,1,'public','Meme','2025-08-29 18:23:48.000000',0),(2,3,2,'public','Meme 2','2025-08-29 18:23:48.000000',0),(3,2,1,'public','Meme','2025-08-29 18:23:48.000000',0),(4,3,1,'public','Meme','2025-08-29 18:23:48.000000',0);
/*!40000 ALTER TABLE `user_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tag_preferences`
--

DROP TABLE IF EXISTS `user_tag_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_tag_preferences` (
  `user_id` int NOT NULL,
  `tag_id` int NOT NULL,
  `preference` enum('show','hide') DEFAULT NULL,
  PRIMARY KEY (`user_id`,`tag_id`),
  KEY `fk_user_tag_preferences_tag` (`tag_id`),
  CONSTRAINT `fk_user_tag_preferences_tag` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`),
  CONSTRAINT `fk_user_tag_preferences_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tag_preferences`
--

LOCK TABLES `user_tag_preferences` WRITE;
/*!40000 ALTER TABLE `user_tag_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tag_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `username_normalized` varchar(50) GENERATED ALWAYS AS (lower(`username`)) STORED,
  `email` varchar(255) NOT NULL,
  `email_normalized` varchar(255) GENERATED ALWAYS AS (lower(`email`)) STORED,
  `password_hash` varchar(255) DEFAULT NULL,
  `password_changed_at` datetime(6) DEFAULT NULL,
  `password_last_set_at` datetime(6) DEFAULT NULL,
  `team_id` int DEFAULT NULL,
  `tier_id` int DEFAULT NULL,
  `bio` varchar(500) DEFAULT NULL,
  `avatar_image_id` bigint DEFAULT NULL,
  `avatar_updated_at` datetime(6) DEFAULT NULL,
  `signup_platform` enum('ios','android','web','unknown') NOT NULL DEFAULT 'unknown',
  `signup_ip` varbinary(16) DEFAULT NULL,
  `signup_device_id` varchar(128) DEFAULT NULL,
  `is_over_18` tinyint(1) NOT NULL DEFAULT '0',
  `email_verified_at` datetime(6) DEFAULT NULL,
  `status` enum('active','suspended','deleted') NOT NULL DEFAULT 'active',
  `deleted_at` datetime(6) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login_at` datetime(6) DEFAULT NULL,
  `last_login_ip` varbinary(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_users_username` (`username`),
  UNIQUE KEY `uq_users_email` (`email`),
  KEY `fk_users_team` (`team_id`),
  KEY `fk_users_tier` (`tier_id`),
  KEY `ix_users_tier` (`user_id`,`tier_id`),
  KEY `ix_users_status` (`status`),
  KEY `ix_users_created_at` (`created_at`),
  KEY `ix_users_email_verified` (`email_verified_at`),
  KEY `idx_users_avatar_image_id` (`avatar_image_id`),
  CONSTRAINT `fk_users_avatar_image` FOREIGN KEY (`avatar_image_id`) REFERENCES `image_blobs` (`image_id`),
  CONSTRAINT `fk_users_team` FOREIGN KEY (`team_id`) REFERENCES `teams` (`team_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_users_tier` FOREIGN KEY (`tier_id`) REFERENCES `tiers` (`tier_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `password_changed_at`, `password_last_set_at`, `team_id`, `tier_id`, `bio`, `avatar_image_id`, `avatar_updated_at`, `signup_platform`, `signup_ip`, `signup_device_id`, `is_over_18`, `email_verified_at`, `status`, `deleted_at`, `created_at`, `updated_at`, `last_login_at`, `last_login_ip`) VALUES (1,'redfan123','redfan@example.com','$2b$10$CS3rlXdJBCnuQuBuHPKpd.Dk5IKkriV63Db8Ibq2fU0lFzfzaJMau',NULL,NULL,12,2,NULL,NULL,NULL,'unknown',NULL,NULL,1,'2025-09-02 22:35:33.458254','active',NULL,'2025-08-26 22:46:12','2025-09-02 22:35:33',NULL,NULL),(2,'gunnersfan','gunners@example.com','hash2',NULL,NULL,1,1,NULL,NULL,NULL,'unknown',NULL,NULL,1,NULL,'active',NULL,'2025-08-26 22:46:12','2025-08-26 22:46:12',NULL,NULL),(3,'kopite','kopite@example.com','hash3',NULL,NULL,12,2,NULL,NULL,NULL,'unknown',NULL,NULL,1,NULL,'active',NULL,'2025-08-26 22:46:12','2025-08-26 23:19:22',NULL,NULL),(4,'reddevil123','reddevil123@example.com','$2b$12$NdnrM314QsqWaRzqhGEtKeKiWSEHrKxj1ztT1f9ZKgt6JjbQzTpru',NULL,'2025-09-02 19:09:47.387990',1,NULL,NULL,NULL,NULL,'ios',0xAC130001,'ios-3f5a9c27f6d4423e8be7f75a0b3e5a7c',1,NULL,'active',NULL,'2025-09-02 19:09:47','2025-09-02 19:09:47',NULL,NULL),(5,'torpkev','kev@banterfc.app','$2b$12$7/8r/v7v7XjN.iLjmZJwhuEex/EUiXn1MY8PSoE3M66VZEIRMg/4y',NULL,'2025-09-03 16:35:48.786789',12,1,'Season ticket holder. Loves winding up rival fans.',NULL,NULL,'unknown',0xAC120001,NULL,1,NULL,'active',NULL,'2025-09-03 16:35:48','2025-09-03 21:21:06',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_recent_fails_15m`
--

DROP TABLE IF EXISTS `v_recent_fails_15m`;
/*!50001 DROP VIEW IF EXISTS `v_recent_fails_15m`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_recent_fails_15m` AS SELECT 
 1 AS `user_id`,
 1 AS `email_normalized`,
 1 AS `username_normalized`,
 1 AS `ip_addr`,
 1 AS `fail_count`,
 1 AS `last_fail_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user_current_agreements`
--

DROP TABLE IF EXISTS `v_user_current_agreements`;
/*!50001 DROP VIEW IF EXISTS `v_user_current_agreements`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user_current_agreements` AS SELECT 
 1 AS `user_agreement_id`,
 1 AS `user_id`,
 1 AS `policy_type`,
 1 AS `policy_version`,
 1 AS `accepted_at`,
 1 AS `device_id`,
 1 AS `ip_addr`,
 1 AS `user_agent`,
 1 AS `locale`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_users_with_agreements`
--

DROP TABLE IF EXISTS `v_users_with_agreements`;
/*!50001 DROP VIEW IF EXISTS `v_users_with_agreements`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_users_with_agreements` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `privacy_version`,
 1 AS `privacy_accepted_at`,
 1 AS `tos_version`,
 1 AS `tos_accepted_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vote_types`
--

DROP TABLE IF EXISTS `vote_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote_types` (
  `vote_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`vote_type_id`),
  UNIQUE KEY `uq_vote_types_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_types`
--

LOCK TABLES `vote_types` WRITE;
/*!40000 ALTER TABLE `vote_types` DISABLE KEYS */;
INSERT INTO `vote_types` VALUES (2,'Downvote'),(1,'Upvote');
/*!40000 ALTER TABLE `vote_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallet_types`
--

DROP TABLE IF EXISTS `wallet_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallet_types` (
  `wallet_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`wallet_type_id`),
  UNIQUE KEY `uq_wallet_types_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallet_types`
--

LOCK TABLES `wallet_types` WRITE;
/*!40000 ALTER TABLE `wallet_types` DISABLE KEYS */;
INSERT INTO `wallet_types` VALUES (1,'Banter Coins');
/*!40000 ALTER TABLE `wallet_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wallets`
--

DROP TABLE IF EXISTS `wallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wallets` (
  `wallet_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `wallet_type_id` int NOT NULL,
  `balance` int DEFAULT '0',
  PRIMARY KEY (`wallet_id`),
  KEY `fk_wallets_user_id` (`user_id`),
  KEY `fk_wallets_wallet_type_id` (`wallet_type_id`),
  CONSTRAINT `fk_wallets_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wallets_wallet_type_id` FOREIGN KEY (`wallet_type_id`) REFERENCES `wallet_types` (`wallet_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wallets`
--

LOCK TABLES `wallets` WRITE;
/*!40000 ALTER TABLE `wallets` DISABLE KEYS */;
INSERT INTO `wallets` VALUES (1,1,1,50),(2,2,1,30),(3,3,1,100);
/*!40000 ALTER TABLE `wallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'banterfc'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `ev_recompute_post_rankings` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`root`@`%`*/ /*!50106 EVENT `ev_recompute_post_rankings` ON SCHEDULE EVERY 60 SECOND STARTS '2025-08-27 21:58:07' ON COMPLETION NOT PRESERVE ENABLE DO CALL PostRankings_Recompute(NOW()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'banterfc'
--
/*!50003 DROP PROCEDURE IF EXISTS `Device_GetSigningKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Device_GetSigningKey`(
  IN p_user_id BIGINT UNSIGNED,
  IN p_device_id VARCHAR(191)
)
BEGIN
  SELECT
    sign_alg,
    device_pubkey
  FROM device_tokens
  WHERE user_id = p_user_id
    AND device_id = p_device_id
    AND revoked_at IS NULL
  ORDER BY token_id DESC
  LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Device_LoginUpsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Device_LoginUpsert`(
  IN p_user_id INT,
  IN p_device_id VARCHAR(128),
  IN p_token_hash CHAR(64),
  IN p_sign_alg VARCHAR(32),
  IN p_device_pubkey TEXT
)
BEGIN
  DECLARE v_now DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6);

  IF p_device_id IS NULL OR CHAR_LENGTH(TRIM(p_device_id)) = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'device_id_required', MYSQL_ERRNO = 1644;
  END IF;

  IF p_token_hash IS NULL OR CHAR_LENGTH(p_token_hash) <> 64 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'token_hash_required', MYSQL_ERRNO = 1644;
  END IF;

  INSERT INTO device_tokens (
    device_id, user_id, sign_alg, device_pubkey, token_hash,
    created_at, last_used_at, revoked_at
  )
  VALUES (
    p_device_id, p_user_id, p_sign_alg, p_device_pubkey, p_token_hash,
    v_now, v_now, NULL
  )
  ON DUPLICATE KEY UPDATE
    user_id       = VALUES(user_id),
    sign_alg      = VALUES(sign_alg),
    device_pubkey = VALUES(device_pubkey),
    token_hash    = VALUES(token_hash),  -- rotate/refresh writes a new hash
    last_used_at  = v_now,
    revoked_at    = NULL;

  SELECT device_id, user_id, sign_alg, device_pubkey, token_hash, created_at, last_used_at, revoked_at
  FROM device_tokens
  WHERE device_id = p_device_id
  LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Device_Refresh_Consume` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Device_Refresh_Consume`(
  IN p_device_id VARCHAR(191),
  IN p_presented_refresh_hash CHAR(64),

  IN p_new_refresh_hash CHAR(64),
  IN p_new_refresh_expires DATETIME,

  IN p_new_access_hash CHAR(64),
  IN p_new_access_expires DATETIME
)
BEGIN
  DECLARE v_token_id BIGINT;
  DECLARE v_user_id BIGINT;
  DECLARE v_refresh_expires DATETIME;
  DECLARE v_revoked_at DATETIME;

  SELECT dt.token_id, dt.user_id, dt.refresh_expires_at, dt.revoked_at
    INTO v_token_id, v_user_id, v_refresh_expires, v_revoked_at
  FROM device_tokens dt
  WHERE dt.device_id = p_device_id
    AND dt.refresh_token_hash = LOWER(p_presented_refresh_hash)
  LIMIT 1;

  IF v_token_id IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid_refresh';
  END IF;

  IF v_revoked_at IS NOT NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'device_revoked';
  END IF;

  IF v_refresh_expires IS NOT NULL AND v_refresh_expires < NOW() THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'refresh_expired';
  END IF;

  UPDATE device_tokens
     SET replaced_by_token_hash = LOWER(p_new_refresh_hash),
         refresh_token_hash     = LOWER(p_new_refresh_hash),
         refresh_expires_at     = p_new_refresh_expires,
         token_hash             = LOWER(p_new_access_hash),
         expires_at             = p_new_access_expires,
         last_used_at           = NOW()
   WHERE token_id = v_token_id;

  SELECT v_token_id AS token_id, v_user_id AS user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Device_Register` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Device_Register`(
  IN p_user_id INT,
  IN p_device_id VARCHAR(128),
  IN p_sign_alg VARCHAR(32),
  IN p_device_pubkey TEXT
)
BEGIN
  DECLARE v_now DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6);

  IF p_device_id IS NULL OR CHAR_LENGTH(TRIM(p_device_id)) = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'device_id_required', MYSQL_ERRNO = 1644;
  END IF;

-- In your Device_Register procedure, replace the INSERT…ON DUPLICATE with this:
INSERT INTO device_tokens (
  device_id, user_id, sign_alg, device_pubkey,
  token_hash,            -- satisfy NOT NULL schemas
  created_at, last_used_at, revoked_at
)
VALUES (
  p_device_id, p_user_id, p_sign_alg, p_device_pubkey,
  REPEAT('0', 64),        -- placeholder until first refresh rotation writes the real hash
  v_now, v_now, NULL
)
ON DUPLICATE KEY UPDATE
  user_id       = VALUES(user_id),
  sign_alg      = VALUES(sign_alg),
  device_pubkey = VALUES(device_pubkey),
  last_used_at  = v_now,
  revoked_at    = NULL;

  -- Return the registered row
  SELECT device_id, user_id, sign_alg, device_pubkey, created_at, last_used_at, revoked_at
  FROM device_tokens
  WHERE device_id = p_device_id
  LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Device_SetRefreshToken` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Device_SetRefreshToken`(
  IN p_user_id BIGINT UNSIGNED,
  IN p_device_id VARCHAR(191),
  IN p_refresh_token_hash CHAR(64),
  IN p_refresh_expires_at DATETIME
)
BEGIN
  UPDATE device_tokens
     SET refresh_token_hash = LOWER(p_refresh_token_hash),
         refresh_expires_at = p_refresh_expires_at,
         replaced_by_token_hash = NULL,
         revoked_at = NULL
   WHERE user_id = p_user_id
     AND device_id = p_device_id;

  IF ROW_COUNT() = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'device_not_registered';
  END IF;

  SELECT 'ok' AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Device_UpdateAccess` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Device_UpdateAccess`(
  IN p_device_id VARCHAR(191),
  IN p_access_hash CHAR(64),
  IN p_access_expires DATETIME
)
BEGIN
  UPDATE device_tokens
     SET token_hash = LOWER(p_access_hash),
         expires_at = p_access_expires
   WHERE device_id = p_device_id
     AND revoked_at IS NULL;

  IF ROW_COUNT() = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'device_not_found_or_revoked';
  END IF;

  SELECT 'ok' AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Email_Verify` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Email_Verify`(IN p_token VARCHAR(255))
BEGIN
  DECLARE v_token_hash CHAR(64);
  DECLARE v_user_id INT;
  DECLARE v_email VARCHAR(255);
  DECLARE v_purpose ENUM('primary','add');
  DECLARE v_now DATETIME(6) DEFAULT NOW(6);

  IF p_token IS NULL OR p_token = '' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='TOKEN_INVALID';
  END IF;

  SET v_token_hash = LOWER(SHA2(p_token, 256));

  SELECT ev.user_id, ev.email, ev.purpose
    INTO v_user_id, v_email, v_purpose
  FROM email_verifications ev
  WHERE ev.token_hash = v_token_hash
    AND ev.consumed_at IS NULL
    AND ev.expires_at > v_now
  LIMIT 1;

  IF v_user_id IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='TOKEN_INVALID_OR_EXPIRED';
  END IF;

  UPDATE email_verifications
  SET consumed_at = v_now
  WHERE token_hash = v_token_hash;

  IF v_purpose = 'primary' THEN
    UPDATE users
    SET email_verified_at = v_now
    WHERE user_id = v_user_id
      AND email = v_email;
  ELSEIF v_purpose = 'add' THEN
    UPDATE users
    SET email = v_email,
        email_verified_at = v_now
    WHERE user_id = v_user_id;
  END IF;

  SELECT
    u.user_id,
    u.email,
    (u.email_verified_at IS NOT NULL) AS email_verified,
    u.email_verified_at
  FROM users u
  WHERE u.user_id = v_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Email_Verify_IssueDev` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Email_Verify_IssueDev`(IN p_user_id INT)
BEGIN
  DECLARE v_email VARCHAR(255);
  DECLARE v_token_raw BLOB;
  DECLARE v_token_b64 VARCHAR(256);
  DECLARE v_token_b64url VARCHAR(256);
  DECLARE v_token_hash CHAR(64);
  DECLARE v_now DATETIME(6) DEFAULT NOW(6);
  DECLARE v_expires DATETIME(6) DEFAULT (NOW(6) + INTERVAL 60 MINUTE);

  SELECT u.email INTO v_email
  FROM users u
  WHERE u.user_id = p_user_id;

  IF v_email IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='USER_NOT_FOUND';
  END IF;

  -- 32 random bytes → base64 → base64url (strip + / =)
  SET v_token_raw     = RANDOM_BYTES(32);
  SET v_token_b64     = TO_BASE64(v_token_raw);
  SET v_token_b64url  = REPLACE(REPLACE(REPLACE(v_token_b64, '+','-'), '/','_'), '=','');

  -- store only 64-char SHA-256 hex of the opaque token
  SET v_token_hash    = LOWER(SHA2(v_token_b64url, 256));

  INSERT INTO email_verifications
    (user_id, email, purpose, token_hash, sent_at, expires_at)
  VALUES
    (p_user_id, v_email, 'primary', v_token_hash, v_now, v_expires);

  -- return plaintext token for testing the verify endpoint
  SELECT
    LAST_INSERT_ID() AS email_verification_id,
    p_user_id        AS user_id,
    v_email          AS email,
    v_token_b64url   AS token,
    v_expires        AS expires_at;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Leagues_GetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Leagues_GetAll`()
    SQL SECURITY INVOKER
BEGIN
	SELECT 
		 l.league_id
		,l.name AS league_name
		,COUNT(*) AS team_count
	FROM 
		league_teams lt
		INNER JOIN 
			teams t 
			ON	lt.team_id = t.team_id
		INNER JOIN 
			leagues l 
			ON	lt.league_id = l.league_id
	GROUP BY
		 l.league_id
		,l.name
	ORDER BY
		l.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `League_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `League_GetById`(IN in_league_id INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT 
		 l.league_id
		,l.name AS league_name
		,COUNT(*) AS team_count
	FROM 
		league_teams lt
		INNER JOIN 
			teams t 
			ON	lt.team_id = t.team_id
		INNER JOIN 
			leagues l 
			ON	lt.league_id = l.league_id
	WHERE 
		l.league_id = in_league_id
	GROUP BY
		 l.league_id
        ,l.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PasswordReset_Consume` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `PasswordReset_Consume`(
  IN p_token_hash CHAR(64),
  IN p_new_password_hash VARCHAR(255),
  IN p_now DATETIME(6)
)
BEGIN
  DECLARE v_user_id INT;

  SELECT pr.user_id
    INTO v_user_id
  FROM password_resets pr
  WHERE pr.token_hash = p_token_hash
    AND pr.status = 'issued'
    AND pr.consumed_at IS NULL
    AND pr.expires_at > p_now
  FOR UPDATE;

  IF v_user_id IS NULL THEN
    SELECT 0 AS ok, 'invalid_or_expired' AS code, 0 AS devices_revoked;
  ELSE
    UPDATE users
       SET password_hash = p_new_password_hash,
           password_changed_at = p_now
     WHERE user_id = v_user_id;

    UPDATE password_resets
       SET consumed_at = p_now,
           status = 'consumed'
     WHERE token_hash = p_token_hash;

    UPDATE device_tokens
       SET revoked_at = p_now
     WHERE user_id = v_user_id
       AND revoked_at IS NULL;

    SELECT 1 AS ok, 'consumed' AS code,
           ROW_COUNT() AS devices_revoked;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PasswordReset_Issue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `PasswordReset_Issue`(
  IN p_email VARCHAR(320),
  IN p_token_hash CHAR(64),
  IN p_expires_at DATETIME(6),
  IN p_request_ip VARCHAR(45),
  IN p_user_agent VARCHAR(255)
)
BEGIN
  DECLARE v_user_id INT;

  SELECT u.user_id
    INTO v_user_id
  FROM users u
  WHERE LOWER(u.email) = LOWER(p_email)
  LIMIT 1;

  -- If user not found, return neutral response (no LEAVE)
  IF v_user_id IS NULL THEN
    SELECT CAST(NULL AS SIGNED) AS reset_id, 0 AS created;
  ELSE
    INSERT INTO password_resets (user_id, token_hash, expires_at, requested_ip, user_agent)
    VALUES (v_user_id, p_token_hash, p_expires_at, p_request_ip, p_user_agent);

    SELECT LAST_INSERT_ID() AS reset_id, 1 AS created;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PostRankings_Recompute` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `PostRankings_Recompute`(
  IN p_now DATETIME(6)
)
    SQL SECURITY INVOKER
BEGIN
  -- Tunables (same as your original)
  SET @w_vote_paid             := 1.2;
  SET @w_vote_free             := 1.0;
  SET @role_factor_creator     := 1.0;
  SET @role_factor_noncreator  := 0.6;
  SET @payer_factor_paid       := 1.2;
  SET @payer_factor_free       := 1.0;
  SET @mod_factor              := 1.5;
  SET @tau_hours               := 48.0;

  /* --------------------------
     CANDIDATE SET (your logic)
     -------------------------- */
  DROP TEMPORARY TABLE IF EXISTS tmp_candidates;
  CREATE TEMPORARY TABLE tmp_candidates (post_id BIGINT PRIMARY KEY) ENGINE=Memory
  AS
  SELECT p.post_id
    FROM posts p
   WHERE p.created_at >= p_now - INTERVAL 72 HOUR
  UNION
  SELECT DISTINCT cp.post_id
    FROM changed_posts cp
   WHERE cp.changed_at >= p_now - INTERVAL 24 HOUR;

  /* --------------------------
     VOTES AGG (your logic)
     -------------------------- */
  DROP TEMPORARY TABLE IF EXISTS tmp_votes;
  CREATE TEMPORARY TABLE tmp_votes (
    post_id BIGINT PRIMARY KEY,
    up_paid  DOUBLE,
    up_free  DOUBLE,
    dn_paid  DOUBLE,
    dn_free  DOUBLE
  ) ENGINE=Memory
  AS
  SELECT
    pv.post_id,
    SUM(CASE WHEN vt.name='upvote'   AND u.tier_id=2 THEN 1 ELSE 0 END) AS up_paid,
    SUM(CASE WHEN vt.name='upvote'   AND u.tier_id<>2 THEN 1 ELSE 0 END) AS up_free,
    SUM(CASE WHEN vt.name='downvote' AND u.tier_id=2 THEN 1 ELSE 0 END) AS dn_paid,
    SUM(CASE WHEN vt.name='downvote' AND u.tier_id<>2 THEN 1 ELSE 0 END) AS dn_free
  FROM post_votes pv
  JOIN vote_types vt ON vt.vote_type_id = pv.vote_type_id
  JOIN tmp_candidates c ON c.post_id = pv.post_id
  JOIN users u ON u.user_id = pv.user_id
  GROUP BY pv.post_id;

  /* --------------------------
     BOOSTS AGG (your logic)
     -------------------------- */
  DROP TEMPORARY TABLE IF EXISTS tmp_boosts;
  CREATE TEMPORARY TABLE tmp_boosts (
    post_id BIGINT PRIMARY KEY,
    boost_w DOUBLE
  ) ENGINE=Memory
  AS
  SELECT
    pb.post_id,
    SUM(
      pb.weight
      * CASE WHEN pb.user_id = p.user_id THEN @role_factor_creator ELSE @role_factor_noncreator END
      * CASE WHEN bu.tier_id = 2 THEN @payer_factor_paid ELSE @payer_factor_free END
      * CASE WHEN m.user_id IS NOT NULL AND m.team_id = p.team_id THEN @mod_factor ELSE 1.0 END
    ) AS boost_w
  FROM post_boosts pb
  JOIN posts p           ON p.post_id = pb.post_id
  JOIN tmp_candidates c  ON c.post_id = pb.post_id
  JOIN users bu          ON bu.user_id = pb.user_id
  LEFT JOIN moderators m ON m.user_id = pb.user_id AND m.team_id = p.team_id
  GROUP BY pb.post_id;

  /* ------------------------------------------------------
     WRITE: append this batch to history (append-only)
     ------------------------------------------------------ */
  INSERT INTO post_rankings_history
    (post_id, team_id, score, as_of, created_at, votes_component, boosts_component)
  SELECT
    p.post_id,
    p.team_id,
    (
      (
        LN(1 + COALESCE(v.up_paid,0) * @w_vote_paid + COALESCE(v.up_free,0) * @w_vote_free)
      - LN(1 + COALESCE(v.dn_paid,0) * @w_vote_paid + COALESCE(v.dn_free,0) * @w_vote_free)
      )
      + COALESCE(b.boost_w,0)
    )
    * EXP( - TIMESTAMPDIFF(HOUR, p.created_at, p_now) / @tau_hours ) AS final_score,
    p_now AS as_of,
    p.created_at,
    (
      LN(1 + COALESCE(v.up_paid,0) * @w_vote_paid + COALESCE(v.up_free,0) * @w_vote_free)
    - LN(1 + COALESCE(v.dn_paid,0) * @w_vote_paid + COALESCE(v.dn_free,0) * @w_vote_free)
    ) AS votes_component,
    COALESCE(b.boost_w,0) AS boosts_component
  FROM tmp_candidates c
  JOIN posts p      ON p.post_id = c.post_id
  LEFT JOIN tmp_votes  v ON v.post_id = p.post_id
  LEFT JOIN tmp_boosts b ON b.post_id = p.post_id
  -- dedupe if same (post_id, as_of) happens (rare)
  ON DUPLICATE KEY UPDATE post_id = VALUES(post_id);

  /* ------------------------------------------------------
     WRITE: update "current" materialized table for fast reads
     ------------------------------------------------------ */
  INSERT INTO post_rankings_current
    (post_id, team_id, score, as_of, created_at, votes_component, boosts_component)
  SELECT post_id, team_id, score, as_of, created_at, votes_component, boosts_component
  FROM post_rankings_history
  WHERE as_of = p_now
  ON DUPLICATE KEY UPDATE
    team_id = VALUES(team_id),
    score   = VALUES(score),
    as_of   = VALUES(as_of),
    created_at = VALUES(created_at),
    votes_component  = VALUES(votes_component),
    boosts_component = VALUES(boosts_component);

  /* ------------------------------------------------------
     Housekeeping
     ------------------------------------------------------ */
  -- keep history only as long as needed for stable pagination
  DELETE FROM post_rankings_history WHERE as_of < p_now - INTERVAL 24 HOUR;

  -- your existing cleanup
  DELETE FROM changed_posts WHERE changed_at < p_now - INTERVAL 48 HOUR;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Posts_GetByTeamId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Posts_GetByTeamId`(
	 IN in_team_id INT
    ,IN in_page_size INT
    ,IN in_snapshot_as_of DATETIME
    ,IN in_last_score INT
    ,IN in_last_post_id INT
)
    SQL SECURITY INVOKER
proc: BEGIN
  DECLARE snap DATETIME(6);
	/* Freeze the candidate set: newer rows won't sneak in */
	SET @last_score := in_last_score;
	SET @last_post_id := in_last_post_id;

  /* Resolve stable snapshot time */
  IF in_snapshot_as_of IS NULL THEN
    SELECT MAX(as_of) INTO snap
    FROM post_rankings_history
    WHERE team_id = in_team_id;
  ELSE
    SELECT MAX(as_of) INTO snap
    FROM post_rankings_history
    WHERE team_id = in_team_id
      AND as_of <= in_snapshot_as_of;
  END IF;

  IF snap IS NULL THEN
    SELECT * FROM (SELECT 1) t WHERE 1=0;
    SELECT * FROM (SELECT 1) t WHERE 1=0;
    LEAVE proc;
  END IF;

  /* latest ≤ snap once */
  DROP TEMPORARY TABLE IF EXISTS tmp_latest;
  CREATE TEMPORARY TABLE tmp_latest (
    post_id BIGINT PRIMARY KEY,
    score   DOUBLE NOT NULL,
    as_of   DATETIME(6) NOT NULL
  ) ENGINE=Memory;

  INSERT INTO tmp_latest (post_id, score, as_of)
  SELECT prh.post_id, prh.score, prh.as_of
  FROM post_rankings_history prh
  JOIN (
    SELECT post_id, MAX(as_of) AS as_of
    FROM post_rankings_history
    WHERE team_id = in_team_id AND as_of <= snap
    GROUP BY post_id
  ) pick USING (post_id, as_of);

  /* Build the page keys only (no TEXT here) */
  DROP TEMPORARY TABLE IF EXISTS tmp_page;
  CREATE TEMPORARY TABLE tmp_page (
    post_id BIGINT PRIMARY KEY,
    score   DOUBLE NOT NULL,
    as_of   DATETIME(6) NOT NULL
  ) ENGINE=Memory;

  INSERT INTO tmp_page (post_id, score, as_of)
  SELECT
    p.post_id, l.score, l.as_of
  FROM tmp_latest l
  JOIN posts p ON p.post_id = l.post_id
  WHERE p.team_id = in_team_id
    AND p.deleted = 0
    AND (
      in_last_score IS NULL
      OR l.score < in_last_score
      OR (l.score = in_last_score AND p.post_id < in_last_post_id)
    )
  ORDER BY l.score DESC, p.post_id DESC
  LIMIT in_page_size;

  /* Result set #1: join to fetch TEXT columns now */
  SELECT
    p.post_id, p.content_text, p.content_markup, tp.score, tp.as_of
  FROM tmp_page tp
  JOIN posts p USING (post_id)
  ORDER BY tp.score DESC, tp.post_id DESC;

  /* Result set #2: next-page token */
  SELECT
    score   AS next_last_score,
    post_id AS next_last_post_id,
    snap    AS snapshot_as_of_token
  FROM tmp_page
  ORDER BY score ASC, post_id ASC
  LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Post_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Post_GetById`(IN in_post_id INT)
    SQL SECURITY INVOKER
BEGIN
    SET @post_id := in_post_id;

    -- Post
    SELECT
        p.post_id
        ,p.content_text
        ,p.content_markup
        ,p.created_at
        ,p.updated_at
        ,p.is_anonymous
    FROM 
        posts p
    WHERE
        p.post_id = @post_id;

    -- User
    SELECT
        u.user_id
        ,u.username
        ,t.name
    FROM
        users u
        INNER JOIN
            posts p
            ON  p.user_id = u.user_id
        INNER JOIN
            tiers t
            ON  t.tier_id = u.tier_id
    WHERE
        p.post_id = @post_id;

    -- Votes
    SELECT
    COALESCE(SUM(vt.name = 'Upvote'),   0) AS upvotes,
    COALESCE(SUM(vt.name = 'Downvote'), 0) AS downvotes
    FROM 
        post_votes pv
        INNER JOIN
            vote_types vt
            ON  vt.vote_type_id = pv.vote_type_id
    WHERE 
        pv.post_id = @post_id;

    -- Images
    SELECT
        pi.post_image_id
        ,pi.alt_text
        ,pi.caption
        ,i.storage_key
        ,i.width
        ,i.height
        ,i.mime_type
    FROM
        image_blobs i
        INNER JOIN
            user_images ui
            ON  ui.image_id = i.image_id
        INNER JOIN
            post_images pi
            ON  pi.image_id = i.image_id
        INNER JOIN
            posts p
            ON  p.post_id = pi.post_id
            AND p.user_id = ui.user_id
    WHERE
        pi.post_id = @post_id;

    -- External Images
    SELECT
        ei.url
        ,ei.width
        ,ei.height
        ,pei.alt_text
        ,pei.caption
    FROM
        external_images ei
        INNER JOIN
            post_external_images pei
            ON  pei.external_image_id = ei.external_image_id
    WHERE
        pei.post_id = @post_id;

    -- Edits
    SELECT
        e.old_content
        ,u.username
        ,e.created_at
    FROM
        post_edits e
        INNER JOIN
            users u
            ON  u.user_id = e.editor_user_id
    WHERE
        e.post_id = @post_id
    ORDER BY
        e.created_at;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `StepUp_CreateChallenge` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `StepUp_CreateChallenge`(
  IN p_user_id BIGINT UNSIGNED,
  IN p_device_id VARCHAR(191),
  IN p_purpose VARCHAR(64),
  IN p_ttl_seconds INT
)
BEGIN
  DECLARE v_nonce CHAR(64);
  DECLARE v_expires DATETIME;

  SET v_nonce = LOWER(HEX(RANDOM_BYTES(32)));
  SET v_expires = DATE_ADD(UTC_TIMESTAMP(), INTERVAL p_ttl_seconds SECOND);

  INSERT INTO auth_stepup_challenges (user_id, device_id, purpose, nonce, expires_at)
  VALUES (p_user_id, p_device_id, p_purpose, v_nonce, v_expires);

  SELECT LAST_INSERT_ID() AS challenge_id, v_nonce AS nonce, v_expires AS expires_at;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `StepUp_GetChallenge` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `StepUp_GetChallenge`(
  IN p_user_id BIGINT UNSIGNED,
  IN p_device_id VARCHAR(191),
  IN p_challenge_id BIGINT UNSIGNED
)
BEGIN
  SELECT
    challenge_id,
    user_id,
    device_id,
    purpose,
    nonce,
    expires_at,
    consumed_at
  FROM auth_stepup_challenges
  WHERE challenge_id = p_challenge_id
    AND user_id = p_user_id
    AND device_id = p_device_id
  LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `StepUp_MarkConsumed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `StepUp_MarkConsumed`(
  IN p_user_id BIGINT UNSIGNED,
  IN p_device_id VARCHAR(191),
  IN p_challenge_id BIGINT UNSIGNED
)
BEGIN
  UPDATE auth_stepup_challenges
     SET consumed_at = UTC_TIMESTAMP()
   WHERE challenge_id = p_challenge_id
     AND user_id = p_user_id
     AND device_id = p_device_id
     AND consumed_at IS NULL
     AND expires_at >= UTC_TIMESTAMP();

  IF ROW_COUNT() = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'challenge_invalid_or_used';
  END IF;

  SELECT 'ok' AS status;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Teams_GetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Teams_GetAll`()
    SQL SECURITY INVOKER
BEGIN
	SELECT 
		 l.name AS league_name
		,t.team_id
		,t.name AS team_name
        ,t.abbreviation
		,t.primary_color
		,t.secondary_color
	FROM 
		league_teams lt
		INNER JOIN 
			teams t 
			ON	lt.team_id = t.team_id
		INNER JOIN 
			leagues l 
			ON	lt.league_id = l.league_id
	ORDER BY
		t.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Teams_GetByLeagueId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Teams_GetByLeagueId`(IN in_league_id INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT 
		 l.name AS league_name
		,t.team_id
		,t.name AS team_name
        ,t.abbreviation
		,t.primary_color
		,t.secondary_color
	FROM 
		league_teams lt
		INNER JOIN 
			teams t 
			ON	lt.team_id = t.team_id
		INNER JOIN 
			leagues l 
			ON	lt.league_id = l.league_id
	WHERE 
		lt.league_id = in_league_id
	ORDER BY
		t.name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Team_GetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Team_GetById`(IN in_team_id INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT 
		 l.name AS league_name
		,t.team_id
		,t.name AS team_name
        ,t.abbreviation
		,t.primary_color
		,t.secondary_color
	FROM 
		league_teams lt
		INNER JOIN 
			teams t 
			ON	lt.team_id = t.team_id
		INNER JOIN 
			leagues l 
			ON	lt.league_id = l.league_id
	WHERE 
		t.team_id = in_team_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Token_CheckExists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Token_CheckExists`(
    IN in_token_hash CHAR(64),
    IN in_device_id VARCHAR(255)
)
    SQL SECURITY INVOKER
BEGIN
    SELECT
        dt.token_id,
        dt.user_id,
        dt.device_id,
        u.tier_id,
        u.team_id
    FROM 
		device_tokens dt
		INNER JOIN 
			users u 
            ON	u.user_id = dt.user_id
    WHERE dt.token_hash = in_token_hash
	AND dt.device_id = in_device_id
    AND dt.revoked_at IS NULL
    AND (dt.expires_at IS NULL OR dt.expires_at > NOW())
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Users_GetByEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Users_GetByEmail`(
  IN p_email VARCHAR(255)
)
BEGIN
  SELECT
    user_id,
    username,
    email,
    password_hash,
    team_id,
    tier_id,
    is_over_18,
    email_verified_at,
    created_at,
    updated_at
  FROM users
  WHERE email = p_email
  LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Users_GetByTeamAbbreviation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Users_GetByTeamAbbreviation`(IN in_team_abbr VARCHAR(5))
    SQL SECURITY INVOKER
BEGIN
	SELECT
		 u.user_id
		,u.username
		,u.email
		,t.name AS tier_name
		,u.is_over_18    
	FROM 
		users u
        INNER JOIN
			teams tm
            ON	tm.team_id = u.team_id
        INNER JOIN
			tiers t
            ON	t.tier_id = u.tier_id
	WHERE
		tm.abbreviation = in_team_abbr
	ORDER BY
		u.username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Users_GetByTeamId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`banterfc_user`@`%` PROCEDURE `Users_GetByTeamId`(IN in_team_id INT)
    SQL SECURITY INVOKER
BEGIN
	SELECT
		 u.user_id
		,u.username
		,u.email
		,t.name AS tier_name
		,u.is_over_18    
	FROM 
		users u
        INNER JOIN
			tiers t
            ON	t.tier_id = u.tier_id
	WHERE
		team_id = in_team_id
	ORDER BY
		u.username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Users_GetMe` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Users_GetMe`(IN p_user_id BIGINT UNSIGNED)
BEGIN
  /*
    Returns the authenticated user's own profile (includes email).
    p_user_id: the user's id from the validated access token.
  */
    SELECT
         u.user_id
        ,u.username
        ,u.email
        ,u.team_id
        ,u.tier_id
        ,u.bio
        ,i.storage_key AS avatar_url -- TODO: Get full url
        ,u.is_over_18
        ,u.created_at
        ,u.updated_at
    FROM 
        users u
        LEFT JOIN 
            image_blobs i
            ON  i.image_id = u.avatar_image_id
    WHERE 
        u.user_id = p_user_id
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Users_GetPublicByUsername` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Users_GetPublicByUsername`(IN p_username VARCHAR(64))
BEGIN
  /*
    Returns public-facing profile by username (no email, no sensitive flags).
    Case-insensitive match on username; adjust if you store normalized_username.
  */
    SELECT
         u.user_id
        ,u.username
        ,u.team_id
        ,u.tier_id
        ,u.bio
        ,i.storage_key AS avatar_url -- TODO: Get full URL
        ,u.created_at
    FROM 
        users u
        LEFT JOIN 
            image_blobs i
            ON  i.image_id = u.avatar_image_id
  WHERE 
    u.username = p_username 
    COLLATE utf8mb4_general_ci
  LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Users_UpdateProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `Users_UpdateProfile`(
  IN p_user_id INT,
  IN p_bio VARCHAR(500),
  IN p_avatar_image_id BIGINT
)
BEGIN
  DECLARE v_now DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6);
  DECLARE v_exists INT DEFAULT 0;
  DECLARE v_owned INT DEFAULT 0;

  /* Normalize bio (trim at SQL layer; app should also trim) */
  IF p_bio IS NOT NULL THEN
    SET p_bio = TRIM(p_bio);
  END IF;

  /* Length check (defense-in-depth; VARCHAR enforces but keep clear error) */
  IF p_bio IS NOT NULL AND CHAR_LENGTH(p_bio) > 500 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'bio_too_long', MYSQL_ERRNO = 1644;
  END IF;

  /* Validate avatar (when provided) */
  IF p_avatar_image_id IS NOT NULL THEN
    /* Image exists? */
    SELECT 1 INTO v_exists
    FROM image_blobs
    WHERE image_id = p_avatar_image_id
    LIMIT 1;

    IF v_exists IS NULL OR v_exists = 0 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'avatar_image_not_found', MYSQL_ERRNO = 1644;
    END IF;

    /* Gallery ownership? (user must have this in their gallery) */
    SELECT 1 INTO v_owned
    FROM user_images
    WHERE user_id = p_user_id
      AND image_id = p_avatar_image_id
      AND deleted = 0
    LIMIT 1;

    IF v_owned IS NULL OR v_owned = 0 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'avatar_image_not_in_user_gallery', MYSQL_ERRNO = 1644;
    END IF;

    /* Apply update with avatar */
    UPDATE users
       SET bio = p_bio,
           avatar_image_id = p_avatar_image_id,
           avatar_updated_at = v_now,
           updated_at = v_now
     WHERE user_id = p_user_id;

  ELSE
    /* Clear avatar if NULL explicitly sent */
    UPDATE users
       SET bio = p_bio,
           avatar_image_id = NULL,
           avatar_updated_at = NULL,
           updated_at = v_now
     WHERE user_id = p_user_id;
  END IF;

  /* Return the updated public-safe profile (expand later as needed) */
  SELECT
    u.user_id,
    u.username,
    u.team_id,
    u.tier_id,
    u.bio,
    u.avatar_image_id,
    u.avatar_updated_at,
    u.updated_at
  FROM users u
  WHERE u.user_id = p_user_id
  LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `User_ChangePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `User_ChangePassword`(
  IN p_user_id INT,
  IN p_new_password_hash VARCHAR(255),
  IN p_now DATETIME(6)
)
BEGIN
  UPDATE users
     SET password_hash = p_new_password_hash,
         password_changed_at = p_now
   WHERE user_id = p_user_id;

  UPDATE device_tokens
     SET revoked_at = p_now
   WHERE user_id = p_user_id
     AND revoked_at IS NULL;

  SELECT 1 AS ok, 'changed' AS code,
         ROW_COUNT() AS devices_revoked;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `User_Create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `User_Create`(
  IN p_username            VARCHAR(50),
  IN p_email               VARCHAR(255),
  IN p_password_hash       VARCHAR(255),
  IN p_team_id             INT,
  IN p_tier_id             INT,
  IN p_is_over_18          TINYINT,         -- must be 1 per Age-Gating policy
  IN p_privacy_version     VARCHAR(32),     -- optional; if provided → user_agreements row
  IN p_tos_version         VARCHAR(32),     -- optional; if provided → user_agreements row
  IN p_community_version   VARCHAR(32),     -- optional; if provided → user_agreements row
  IN p_signup_platform     VARCHAR(16),     -- 'ios'|'android'|'web'|'unknown'
  IN p_signup_ip_str       VARCHAR(45),     -- IPv4/IPv6 textual; will convert to VARBINARY(16)
  IN p_signup_device_id    VARCHAR(128),    -- optional device id at signup
  IN p_user_agent          VARCHAR(255),    -- optional UA
  IN p_locale              VARCHAR(16)      -- optional locale (e.g., en-GB)
)
BEGIN
  DECLARE v_user_id INT;
  DECLARE v_now DATETIME(6) DEFAULT NOW(6);
  DECLARE v_signup_ip VARBINARY(16);
  DECLARE v_platform ENUM('ios','android','web','unknown');

  -- Validate age requirement (must be 1)
  IF p_is_over_18 IS NULL OR p_is_over_18 = 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'AGE_GATE_BLOCKED: is_over_18 must be true';
  END IF;

  -- Normalize/validate platform
  SET v_platform = CASE LOWER(COALESCE(p_signup_platform, 'unknown'))
                     WHEN 'ios' THEN 'ios'
                     WHEN 'android' THEN 'android'
                     WHEN 'web' THEN 'web'
                     ELSE 'unknown'
                   END;

  -- Convert IP string to binary (NULL allowed)
  SET v_signup_ip = CASE
                      WHEN p_signup_ip_str IS NULL OR p_signup_ip_str = '' THEN NULL
                      ELSE INET6_ATON(p_signup_ip_str)
                    END;

  START TRANSACTION;

  -- Insert user (unique constraints on email/username will enforce conflicts)
  INSERT INTO users
  (
    username,
    email,
    password_hash,
    password_last_set_at,
    team_id,
    tier_id,
    signup_platform,
    signup_ip,
    signup_device_id,
    is_over_18,
    email_verified_at,
    status,
    created_at,
    updated_at
  )
  VALUES
  (
    p_username,
    p_email,
    p_password_hash,
    v_now,                       -- password_last_set_at (we just set it)
    p_team_id,
    p_tier_id,
    v_platform,
    v_signup_ip,
    p_signup_device_id,
    CASE WHEN p_is_over_18 IS NULL THEN 0 ELSE p_is_over_18 END,
    NULL,                        -- email_verified_at (will be set by verify flow)
    'active',
    NOW(),                       -- created_at (second precision ok here)
    NOW()                        -- updated_at
  );

  SET v_user_id = LAST_INSERT_ID();

  -- Agreements: insert rows for any provided versions
  IF p_privacy_version IS NOT NULL AND p_privacy_version <> '' THEN
    INSERT INTO user_agreements
      (user_id, policy_type, policy_version, accepted_at, device_id, ip_addr, user_agent, locale)
    VALUES
      (v_user_id, 'privacy', p_privacy_version, v_now, p_signup_device_id, v_signup_ip, p_user_agent, p_locale);
  END IF;

  IF p_tos_version IS NOT NULL AND p_tos_version <> '' THEN
    INSERT INTO user_agreements
      (user_id, policy_type, policy_version, accepted_at, device_id, ip_addr, user_agent, locale)
    VALUES
      (v_user_id, 'tos', p_tos_version, v_now, p_signup_device_id, v_signup_ip, p_user_agent, p_locale);
  END IF;

  IF p_community_version IS NOT NULL AND p_community_version <> '' THEN
    INSERT INTO user_agreements
      (user_id, policy_type, policy_version, accepted_at, device_id, ip_addr, user_agent, locale)
    VALUES
      (v_user_id, 'community', p_community_version, v_now, p_signup_device_id, v_signup_ip, p_user_agent, p_locale);
  END IF;

  -- Return a clean summary row (single result set)
  SELECT
    u.user_id,
    u.username,
    u.email,
    (u.email_verified_at IS NOT NULL) AS email_verified,
    u.team_id,
    u.tier_id,
    u.signup_platform,
    u.created_at,
    u.updated_at
  FROM users u
  WHERE u.user_id = v_user_id;

  COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `banterfc`
--

USE `banterfc`;

--
-- Final view structure for view `v_recent_fails_15m`
--

/*!50001 DROP VIEW IF EXISTS `v_recent_fails_15m`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_recent_fails_15m` AS select coalesce(`a`.`user_id`,0) AS `user_id`,`a`.`email_normalized` AS `email_normalized`,`a`.`username_normalized` AS `username_normalized`,`a`.`ip_addr` AS `ip_addr`,count(0) AS `fail_count`,max(`a`.`created_at`) AS `last_fail_at` from `auth_login_attempts` `a` where ((`a`.`success` = 0) and (`a`.`created_at` >= (utc_timestamp(6) - interval 15 minute))) group by coalesce(`a`.`user_id`,0),`a`.`email_normalized`,`a`.`username_normalized`,`a`.`ip_addr` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_current_agreements`
--

/*!50001 DROP VIEW IF EXISTS `v_user_current_agreements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_current_agreements` AS select `ua1`.`user_agreement_id` AS `user_agreement_id`,`ua1`.`user_id` AS `user_id`,`ua1`.`policy_type` AS `policy_type`,`ua1`.`policy_version` AS `policy_version`,`ua1`.`accepted_at` AS `accepted_at`,`ua1`.`device_id` AS `device_id`,`ua1`.`ip_addr` AS `ip_addr`,`ua1`.`user_agent` AS `user_agent`,`ua1`.`locale` AS `locale` from (`user_agreements` `ua1` join (select `user_agreements`.`user_id` AS `user_id`,`user_agreements`.`policy_type` AS `policy_type`,max(`user_agreements`.`accepted_at`) AS `max_accepted` from `user_agreements` group by `user_agreements`.`user_id`,`user_agreements`.`policy_type`) `latest` on(((`latest`.`user_id` = `ua1`.`user_id`) and (`latest`.`policy_type` = `ua1`.`policy_type`) and (`latest`.`max_accepted` = `ua1`.`accepted_at`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_users_with_agreements`
--

/*!50001 DROP VIEW IF EXISTS `v_users_with_agreements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_users_with_agreements` AS select `u`.`user_id` AS `user_id`,`u`.`username` AS `username`,`u`.`email` AS `email`,`cur_priv`.`policy_version` AS `privacy_version`,`cur_priv`.`accepted_at` AS `privacy_accepted_at`,`cur_tos`.`policy_version` AS `tos_version`,`cur_tos`.`accepted_at` AS `tos_accepted_at` from ((`users` `u` left join `v_user_current_agreements` `cur_priv` on(((`cur_priv`.`user_id` = `u`.`user_id`) and (`cur_priv`.`policy_type` = 'privacy')))) left join `v_user_current_agreements` `cur_tos` on(((`cur_tos`.`user_id` = `u`.`user_id`) and (`cur_tos`.`policy_type` = 'tos')))) */;
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

-- Dump completed on 2025-09-04 19:44:19
