-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 15, 2024 at 11:01 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `usrs`
--

-- --------------------------------------------------------

--
-- Table structure for table `usrs`
--

CREATE TABLE `usrs` (
  `usr_ID` varchar(30) NOT NULL,
  `usr_PW` varchar(64) NOT NULL,
  `firstName` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `permission` varchar(10) NOT NULL DEFAULT 'viewer'
) ;

--
-- Dumping data for table `usrs`
--

INSERT INTO `usrs` (`usr_ID`, `usr_PW`, `firstName`, `lastName`, `permission`) VALUES
('jasper', '0dfa400dc39e0723ba4c5b6336f8144fd7fd60373e0263bd563e4b699300aa85', 'Zhenwei', 'Zhan', 'viewer'),
('kelly', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'kelly', 'wu', 'viewer'),
('michael', '89e01536ac207279409d4de1e5253e01f4a1769e696db0d6062ca9b8f56767c8', 'Xuhang', 'He', 'viewer');

--
-- Triggers `usrs`
--
DELIMITER $$
CREATE TRIGGER `EncodePW` BEFORE INSERT ON `usrs` FOR EACH ROW begin
    SET NEW.usr_PW = SHA2(NEW.usr_PW, 256);
    
end
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `usrs`
--
ALTER TABLE `usrs`
  ADD PRIMARY KEY (`usr_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
