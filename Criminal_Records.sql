-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 13, 2024 at 06:53 AM
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
-- Database: `Criminal_Records`
--

-- --------------------------------------------------------

--
-- Table structure for table `Alias`
--

CREATE TABLE `Alias` (
  `Alias_ID` int(6) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Alias` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Alias`
--

INSERT INTO `Alias` (`Alias_ID`, `Criminal_ID`, `Alias`) VALUES
(1, 1, 'Big John'),
(2, 2, 'Smitty'),
(3, 3, 'Bobby J'),
(4, 4, 'Will'),
(5, 5, 'Davey B'),
(6, 6, 'Alex'),
(7, 7, 'Jessica'),
(8, 8, 'Daniel'),
(9, 9, 'Lisa'),
(10, 10, 'Matthew');

-- --------------------------------------------------------

--
-- Table structure for table `Appeals`
--

CREATE TABLE `Appeals` (
  `Appeal_ID` int(5) NOT NULL,
  `Crime_ID` int(9) DEFAULT NULL,
  `Filing_date` date DEFAULT NULL,
  `Hearing_date` date DEFAULT NULL,
  `Status` char(1) DEFAULT 'P' CHECK (`Status` in ('P','A','D'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Appeals`
--

INSERT INTO `Appeals` (`Appeal_ID`, `Crime_ID`, `Filing_date`, `Hearing_date`, `Status`) VALUES
(1, 123456789, '2024-03-01', '2024-04-01', 'P'),
(2, 987654321, '2024-03-05', '2024-04-05', 'P'),
(3, NULL, '2024-03-10', '2024-04-10', 'P'),
(4, 456789123, '2024-03-15', NULL, 'D'),
(5, 789123456, '2024-03-20', '2024-04-20', 'P'),
(6, 321654987, '2024-03-25', '2024-04-25', 'A'),
(7, 654987321, '2024-03-30', NULL, 'A'),
(8, 234567890, '2024-04-05', '2024-05-05', 'P'),
(9, NULL, NULL, '2024-05-10', 'A'),
(10, 876543210, '2024-04-15', '2024-05-15', 'D');

-- --------------------------------------------------------

--
-- Table structure for table `Crimes`
--

CREATE TABLE `Crimes` (
  `Crime_ID` int(9) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Classification` char(1) DEFAULT 'U',
  `Date_charged` date DEFAULT NULL,
  `Status` char(2) NOT NULL,
  `Hearing_Date` date DEFAULT NULL,
  `Appeal_cut_date` date DEFAULT NULL CHECK (`Classification` in ('F','M','O','U') and `Status` in ('J','H','P'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Crimes`
--

INSERT INTO `Crimes` (`Crime_ID`, `Criminal_ID`, `Classification`, `Date_charged`, `Status`, `Hearing_Date`, `Appeal_cut_date`) VALUES
(1, 101, 'F', '2024-01-15', 'J', '2024-02-20', '2024-03-15'),
(2, 102, 'M', '2024-02-10', 'H', '2024-03-20', '2024-04-10'),
(3, 103, 'O', '2024-03-05', 'P', '2024-04-15', '2024-05-01'),
(4, 104, 'U', '2024-04-20', 'J', '2024-05-10', '2024-06-01'),
(5, 105, 'F', '2024-05-15', 'H', '2024-06-20', '2024-07-15'),
(6, 106, 'M', '2024-06-10', 'P', '2024-07-20', '2024-08-10'),
(7, 107, 'O', '2024-07-05', 'J', '2024-08-15', '2024-09-01'),
(8, 108, 'U', '2024-08-20', 'H', '2024-09-10', '2024-10-01'),
(9, 109, 'F', '2024-09-15', 'P', '2024-10-20', '2024-11-15'),
(10, 110, 'M', '2024-10-10', 'J', '2024-11-20', '2024-12-10');

-- --------------------------------------------------------

--
-- Table structure for table `Crime_charges`
--

CREATE TABLE `Crime_charges` (
  `Charge_ID` int(10) NOT NULL,
  `Crime_ID` int(9) DEFAULT NULL,
  `Crime_code` int(3) DEFAULT NULL,
  `Charge_status` char(2) DEFAULT NULL,
  `Fine_amount` decimal(7,2) DEFAULT NULL,
  `Court_fee` decimal(7,2) DEFAULT NULL,
  `Amount_paid` decimal(7,2) DEFAULT NULL,
  `Pay_due_date` date DEFAULT NULL CHECK (`Charge_status` in ('PD','GL','NG'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Crime_charges`
--

INSERT INTO `Crime_charges` (`Charge_ID`, `Crime_ID`, `Crime_code`, `Charge_status`, `Fine_amount`, `Court_fee`, `Amount_paid`, `Pay_due_date`) VALUES
(1, 1, 101, 'PD', 50.00, 10.00, 60.00, '2024-04-01'),
(2, 2, 102, 'GL', 100.00, 20.00, 80.00, '2024-04-02'),
(3, 3, 103, 'NG', 150.00, 30.00, 90.00, '2024-04-03'),
(4, 4, 104, 'PD', 200.00, 40.00, 100.00, '2024-04-04'),
(5, 5, 105, 'GL', 250.00, 50.00, 110.00, '2024-04-05'),
(6, 6, 106, 'NG', 300.00, 60.00, 120.00, '2024-04-06'),
(7, 7, 107, 'PD', 350.00, 70.00, 130.00, '2024-04-07'),
(8, 8, 108, 'GL', 400.00, 80.00, 140.00, '2024-04-08'),
(9, 9, 109, 'NG', 450.00, 90.00, 150.00, '2024-04-09'),
(10, 10, 110, 'PD', 500.00, 100.00, 160.00, '2024-04-10');

-- --------------------------------------------------------

--
-- Table structure for table `Crime_codes`
--

CREATE TABLE `Crime_codes` (
  `Crime_code` int(3) NOT NULL,
  `Code_description` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Crime_codes`
--

INSERT INTO `Crime_codes` (`Crime_code`, `Code_description`) VALUES
(102, 'Assault'),
(103, 'Burglary'),
(109, 'Domestic violence'),
(107, 'Drug possession'),
(108, 'DUI'),
(110, 'Forgery'),
(106, 'Fraud'),
(104, 'Robbery'),
(101, 'Theft'),
(105, 'Vandalism');

-- --------------------------------------------------------

--
-- Table structure for table `Crime_officers`
--

CREATE TABLE `Crime_officers` (
  `Crime_ID` int(9) NOT NULL,
  `Officer_ID` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Crime_officers`
--

INSERT INTO `Crime_officers` (`Crime_ID`, `Officer_ID`) VALUES
(1001, 2001),
(1002, 2002),
(1003, 2003),
(1004, 2004),
(1005, 2005),
(1006, 2006),
(1007, 2007),
(1008, 2008),
(1009, 2009),
(1010, 2010);

-- --------------------------------------------------------

--
-- Table structure for table `Criminals`
--

CREATE TABLE `Criminals` (
  `Criminal_ID` int(6) NOT NULL,
  `LastName` varchar(15) DEFAULT NULL,
  `FirstName` varchar(10) DEFAULT NULL,
  `Street` varchar(30) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Zip` char(5) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `V_status` char(1) DEFAULT 'N',
  `P_status` char(1) DEFAULT 'N'
) ;

--
-- Dumping data for table `Criminals`
--

INSERT INTO `Criminals` (`Criminal_ID`, `LastName`, `FirstName`, `Street`, `City`, `State`, `Zip`, `Phone`, `V_status`, `P_status`) VALUES
(1, 'Doe', 'John', '123 Main St', 'Anytown', 'CA', '12345', '5551234567', 'N', 'N'),
(2, 'Smith', 'Jane', '456 Elm St', 'Otherville', 'NY', '54321', '5552345678', 'Y', 'N'),
(3, 'Johnson', 'Bob', '789 Oak St', 'Smalltown', 'TX', '67890', '5553456789', 'N', 'Y'),
(4, 'Williams', 'Alice', '246 Pine St', 'Bigcity', 'FL', '13579', '5554567890', 'Y', 'Y'),
(5, 'Brown', 'David', '135 Cedar St', 'Villageville', 'WA', '97531', '5555678901', 'N', 'N'),
(6, 'Jones', 'Emily', '369 Maple St', 'Suburbia', 'OH', '36985', '5556789012', 'Y', 'N'),
(7, 'Garcia', 'Jose', '753 Walnut St', 'Metropolis', 'IL', '75314', '5557890123', 'N', 'Y'),
(8, 'Martinez', 'Maria', '852 Birch St', 'Townsville', 'NC', '85246', '5558901234', 'Y', 'Y'),
(9, 'Lee', 'Michael', '963 Pineapple St', 'Beachtown', 'CA', '96325', '5559012345', 'N', 'N'),
(10, 'Taylor', 'Sarah', '147 Orange St', 'Cityville', 'NV', '74102', '5550123456', 'Y', 'N');

-- --------------------------------------------------------

--
-- Table structure for table `Officers`
--

CREATE TABLE `Officers` (
  `Officer_ID` int(8) NOT NULL,
  `LastName` varchar(15) DEFAULT NULL,
  `FirstName` varchar(10) DEFAULT NULL,
  `Precinct` char(4) NOT NULL,
  `Badge` varchar(14) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `Status` char(1) DEFAULT 'A' CHECK (`Status` in ('A','I'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Officers`
--

INSERT INTO `Officers` (`Officer_ID`, `LastName`, `FirstName`, `Precinct`, `Badge`, `Phone`, `Status`) VALUES
(2001, 'Smith', 'John', 'A123', 'B12345', '1234567890', 'A'),
(2002, 'Johnson', 'David', 'B456', 'B54321', '2345678901', 'I'),
(2003, 'Williams', 'Robert', 'C789', 'B67890', '3456789012', 'A'),
(2004, 'Jones', 'Michael', 'D012', 'B76543', '4567890123', 'I'),
(2005, 'Brown', 'William', 'E345', 'B89012', '5678901234', 'A'),
(2006, 'Davis', 'Charles', 'F678', 'B90123', '6789012345', 'A'),
(2007, 'Miller', 'Joseph', 'G901', 'B01234', '7890123456', 'A'),
(2008, 'Wilson', 'Richard', 'H234', 'B12340', '8901234567', 'A'),
(2009, 'Moore', 'Daniel', 'I567', 'B23456', '9012345678', 'A'),
(2010, 'Taylor', 'Matthew', 'J890', 'B34567', '0123456789', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `Prob_officers`
--

CREATE TABLE `Prob_officers` (
  `Prob_ID` int(5) NOT NULL,
  `LastName` varchar(15) DEFAULT NULL,
  `FirstName` varchar(10) DEFAULT NULL,
  `Street` varchar(30) DEFAULT NULL,
  `City` varchar(20) DEFAULT NULL,
  `State` char(2) DEFAULT NULL,
  `Zip` char(5) DEFAULT NULL,
  `Phone` char(10) DEFAULT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `Status` char(1) NOT NULL CHECK (`Status` in ('A','I'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Prob_officers`
--

INSERT INTO `Prob_officers` (`Prob_ID`, `LastName`, `FirstName`, `Street`, `City`, `State`, `Zip`, `Phone`, `Email`, `Status`) VALUES
(101, 'Smith', 'John', '123 Main St', 'Anytown', 'NY', '12345', '1234567890', 'jsmith@example.com', 'A'),
(102, 'Johnson', 'Emily', '456 Elm St', 'Sometown', 'CA', '67890', '2345678901', 'ejohnson@example.com', 'A'),
(103, 'Williams', 'Michael', '789 Oak St', 'Othertown', 'TX', '13579', '3456789012', 'mwilliams@example.com', 'A'),
(104, 'Jones', 'Jessica', '321 Maple St', 'Anothertown', 'FL', '24680', '4567890123', 'jjones@example.com', 'A'),
(105, 'Brown', 'David', '654 Pine St', 'Cityville', 'IL', '98765', '5678901234', 'dbrown@example.com', 'A'),
(106, 'Davis', 'Sarah', '987 Cedar St', 'Villagetown', 'WA', '56789', '6789012345', 'sdavis@example.com', 'A'),
(107, 'Miller', 'Chris', '1010 Birch St', 'Townville', 'AZ', '10101', '7890123456', 'cmiller@example.com', 'A'),
(108, 'Wilson', 'Jessica', '1212 Walnut St', 'Smalltown', 'OH', '11223', '8901234567', 'jwilson@example.com', 'A'),
(109, 'Taylor', 'Michael', '1414 Spruce St', 'Hometown', 'GA', '20202', '9012345678', 'mtaylor@example.com', 'A'),
(110, 'Anderson', 'Emily', '1616 Ash St', 'Suburbia', 'PA', '30303', '0123456789', 'eanderson@example.com', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `Sentences`
--

CREATE TABLE `Sentences` (
  `Sentence_ID` int(6) NOT NULL,
  `Criminal_ID` int(6) DEFAULT NULL,
  `Type` char(1) DEFAULT NULL,
  `Prob_ID` int(5) DEFAULT NULL,
  `Start_date` date DEFAULT NULL,
  `End_date` date DEFAULT NULL,
  `Violations` int(3) NOT NULL CHECK (`Type` in ('J','H','P'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Sentences`
--

INSERT INTO `Sentences` (`Sentence_ID`, `Criminal_ID`, `Type`, `Prob_ID`, `Start_date`, `End_date`, `Violations`) VALUES
(1, 1, 'J', 101, '2022-01-01', '2022-12-31', 20),
(2, 2, 'J', 102, '2022-02-15', '2022-06-30', 10),
(3, 3, 'J', 103, '2022-03-10', '2022-09-30', 5),
(4, 4, 'P', 104, '2022-04-20', '2022-08-15', 15),
(5, 5, 'H', 105, '2022-05-05', '2022-11-30', 25),
(6, 6, 'J', 106, '2022-06-15', '2022-12-31', 30),
(7, 7, 'J', 107, '2022-07-10', '2022-09-15', 8),
(8, 8, 'P', 108, '2022-08-20', '2022-12-31', 12),
(9, 9, 'J', 109, '2022-09-01', '2022-10-31', 18),
(10, 10, 'H', 110, '2022-10-15', '2022-12-31', 22);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Alias`
--
ALTER TABLE `Alias`
  ADD PRIMARY KEY (`Alias_ID`);

--
-- Indexes for table `Appeals`
--
ALTER TABLE `Appeals`
  ADD PRIMARY KEY (`Appeal_ID`);

--
-- Indexes for table `Crimes`
--
ALTER TABLE `Crimes`
  ADD PRIMARY KEY (`Crime_ID`);

--
-- Indexes for table `Crime_charges`
--
ALTER TABLE `Crime_charges`
  ADD PRIMARY KEY (`Charge_ID`);

--
-- Indexes for table `Crime_codes`
--
ALTER TABLE `Crime_codes`
  ADD PRIMARY KEY (`Crime_code`),
  ADD UNIQUE KEY `Code_description` (`Code_description`);

--
-- Indexes for table `Crime_officers`
--
ALTER TABLE `Crime_officers`
  ADD PRIMARY KEY (`Crime_ID`,`Officer_ID`);

--
-- Indexes for table `Criminals`
--
ALTER TABLE `Criminals`
  ADD PRIMARY KEY (`Criminal_ID`);

--
-- Indexes for table `Officers`
--
ALTER TABLE `Officers`
  ADD PRIMARY KEY (`Officer_ID`),
  ADD UNIQUE KEY `Badge` (`Badge`);

--
-- Indexes for table `Prob_officers`
--
ALTER TABLE `Prob_officers`
  ADD PRIMARY KEY (`Prob_ID`);

--
-- Indexes for table `Sentences`
--
ALTER TABLE `Sentences`
  ADD PRIMARY KEY (`Sentence_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
