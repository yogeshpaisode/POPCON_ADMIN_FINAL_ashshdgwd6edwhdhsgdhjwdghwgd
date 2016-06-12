-- phpMyAdmin SQL Dump
-- version 4.3.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 11, 2016 at 10:53 PM
-- Server version: 5.5.42-37.1-log
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `popconco_popconco`
--

-- --------------------------------------------------------

--
-- Table structure for table `first_subcategory`
--

CREATE TABLE IF NOT EXISTS `first_subcategory` (
  `first_subcategory_ID` int(10) unsigned NOT NULL,
  `main_category_ID` int(10) unsigned NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `first_subcategory`
--

INSERT INTO `first_subcategory` (`first_subcategory_ID`, `main_category_ID`, `name`) VALUES
(36, 19, 'yogesh'),
(37, 18, '32'),
(39, 19, 'Good');

-- --------------------------------------------------------

--
-- Table structure for table `main_category`
--

CREATE TABLE IF NOT EXISTS `main_category` (
  `main_category_ID` int(10) unsigned NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `main_category`
--

INSERT INTO `main_category` (`main_category_ID`, `name`) VALUES
(18, '212'),
(19, '31 31');

-- --------------------------------------------------------

--
-- Table structure for table `second_subcategory`
--

CREATE TABLE IF NOT EXISTS `second_subcategory` (
  `second_subcategory_ID` int(10) unsigned NOT NULL,
  `first_subcategory_ID` int(10) unsigned NOT NULL,
  `name` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `second_subcategory`
--

INSERT INTO `second_subcategory` (`second_subcategory_ID`, `first_subcategory_ID`, `name`) VALUES
(11, 36, 'Yogesh'),
(14, 36, 'test');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `first_subcategory`
--
ALTER TABLE `first_subcategory`
  ADD PRIMARY KEY (`first_subcategory_ID`) USING BTREE, ADD KEY `FK_main_category_ID_First` (`main_category_ID`);

--
-- Indexes for table `main_category`
--
ALTER TABLE `main_category`
  ADD PRIMARY KEY (`main_category_ID`) USING BTREE;

--
-- Indexes for table `second_subcategory`
--
ALTER TABLE `second_subcategory`
  ADD PRIMARY KEY (`second_subcategory_ID`) USING BTREE, ADD KEY `FK_first_subcategory_ID_Second` (`first_subcategory_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `first_subcategory`
--
ALTER TABLE `first_subcategory`
  MODIFY `first_subcategory_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `main_category`
--
ALTER TABLE `main_category`
  MODIFY `main_category_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `second_subcategory`
--
ALTER TABLE `second_subcategory`
  MODIFY `second_subcategory_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `first_subcategory`
--
ALTER TABLE `first_subcategory`
ADD CONSTRAINT `FK_main_category_ID_First` FOREIGN KEY (`main_category_ID`) REFERENCES `main_category` (`main_category_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `second_subcategory`
--
ALTER TABLE `second_subcategory`
ADD CONSTRAINT `FK_first_subcategory_ID_Second` FOREIGN KEY (`first_subcategory_ID`) REFERENCES `first_subcategory` (`first_subcategory_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



DROP TABLE IF EXISTS product_Detail;
CREATE TABLE  product_Detail (
  `product_Detail_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,

  `main_category_ID` int(10) unsigned NOT NULL,
  `first_subcategory_ID` int(10) unsigned NOT NULL,
  `second_subcategory_ID` int(10) unsigned NOT NULL,
  
  search_tag text NOT NULL,
  product_detail text NOT NULL,
  material_detail text NOT NULL,
  care text NOT NULL,
  selling_Price int NOT NULL,
  display_price int NOT NULL,
  
  PRIMARY KEY (`product_Detail_ID`) USING BTREE,
  
  
  KEY `FK_main_category_ID` (`main_category_ID`),
  CONSTRAINT `FK_main_category_ID` FOREIGN KEY (`main_category_ID`) 
  REFERENCES `main_category` (`main_category_ID`),
  
  KEY `FK_first_subcategory_ID` (`first_subcategory_ID`),
  CONSTRAINT `FK_first_subcategory_ID` FOREIGN KEY (`first_subcategory_ID`) 
  REFERENCES `first_subcategory` (`first_subcategory_ID`),
  
  KEY `FK_second_subcategory_ID` (`second_subcategory_ID`),
  CONSTRAINT `FK_second_subcategory_ID` FOREIGN KEY (`second_subcategory_ID`) 
  REFERENCES `second_subcategory` (`second_subcategory_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS product_by_Color;
CREATE TABLE  product_by_Color (
  `product_by_Color_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,

  `product_Detail_ID` int(10) unsigned NOT NULL,
  
  name text NOT NULL,
  title text NOT NULL,
  hex text NOT NULL,
  
  PRIMARY KEY (`product_by_Color_ID`) USING BTREE,
  
  KEY `FK_product_Detail_ID` (`product_Detail_ID`),
  CONSTRAINT `FK_product_Detail_ID` FOREIGN KEY (`product_Detail_ID`) 
  REFERENCES `product_Detail` (`product_Detail_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS product_by_Color_Images;
CREATE TABLE  product_by_Color_Images (
  `product_by_Color_Images_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,

  `product_by_Color_ID` int(10) unsigned NOT NULL,
  
  name text NOT NULL,
  
  PRIMARY KEY (`product_by_Color_Images_ID`) USING BTREE,
  
  KEY `FK_product_by_Color_ID` (`product_by_Color_ID`),
  CONSTRAINT `FK_product_by_Color_ID` FOREIGN KEY (`product_by_Color_ID`) 
  REFERENCES `product_by_Color` (`product_by_Color_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS product_Size;
CREATE TABLE  product_Size (
  `product_Size_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,

  `product_Detail_ID` int(10) unsigned NOT NULL,
  
  size_type text NOT NULL,
  
  PRIMARY KEY (`product_Size_ID`) USING BTREE,
  
  KEY `FK_Size_product_Detail_ID` (`product_Detail_ID`),
  CONSTRAINT `FK_Size_product_Detail_ID` FOREIGN KEY (`product_Detail_ID`) 
  REFERENCES `product_Detail` (`product_Detail_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


DROP TABLE IF EXISTS size_Stock_by_Color;
CREATE TABLE  size_Stock_by_Color (
  `size_Stock_by_Color_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,

  `product_Size_ID` int(10) unsigned NOT NULL,
  `product_by_Color_ID` int(10) unsigned NOT NULL,
  
  stock int NOT NULL,
  
  PRIMARY KEY (`size_Stock_by_Color_ID`) USING BTREE,
  
  KEY `FK_product_Size_ID` (`product_Size_ID`),
  CONSTRAINT `FK_product_Size_ID` FOREIGN KEY (`product_Size_ID`) 
  REFERENCES `product_Size` (`product_Size_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  
  KEY `FK_Stock_product_by_Color_ID` (`product_by_Color_ID`),
  CONSTRAINT `FK_Stock_product_by_Color_ID` FOREIGN KEY (`product_by_Color_ID`) 
  REFERENCES `product_by_Color` (`product_by_Color_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;
