-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 10, 2013 at 07:54 PM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `timetable`
--

-- --------------------------------------------------------

--
-- Table structure for table `Classes`
--

CREATE TABLE IF NOT EXISTS `Classes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school` varchar(4) DEFAULT NULL,
  `name` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=67 ;

--
-- Dumping data for table `Classes`
--

INSERT INTO `Classes` (`id`, `school`, `name`) VALUES
(29, 'krm', '1a'),
(30, 'krm', '1b'),
(31, 'krm', '1c'),
(32, 'krm', '1d'),
(33, 'krm', '1e'),
(34, 'krm', '1f'),
(35, 'krm', '1g'),
(36, 'krm', '1p'),
(37, 'krm', '1q'),
(38, 'krm', '2a'),
(39, 'krm', '2b'),
(40, 'krm', '2c'),
(41, 'krm', '2d'),
(42, 'krm', '2e'),
(43, 'krm', '2f'),
(44, 'krm', '2g'),
(45, 'krm', '2p'),
(46, 'krm', '2q'),
(47, 'krm', '3a'),
(48, 'krm', '3b'),
(49, 'krm', '3c'),
(50, 'krm', '3d'),
(51, 'krm', '3e'),
(52, 'krm', '3f'),
(53, 'krm', '3g'),
(54, 'krm', '3p'),
(55, 'krm', '3q'),
(56, 'krm', '4a'),
(57, 'krm', '4b'),
(58, 'krm', '4c'),
(59, 'krm', '4d'),
(60, 'krm', '4e'),
(61, 'krm', '4f'),
(62, 'krm', '4g'),
(63, 'krm', '4p'),
(64, 'krm', '4q'),
(65, 'krm', '5p'),
(66, 'krm', '5q');

-- --------------------------------------------------------

--
-- Table structure for table `Lessons`
--

CREATE TABLE IF NOT EXISTS `Lessons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school` varchar(4) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `class` varchar(4) DEFAULT NULL,
  `teacherAbbr` varchar(5) DEFAULT NULL,
  `teacher` varchar(30) DEFAULT NULL,
  `room` varchar(6) DEFAULT NULL,
  `subjectAbbr` varchar(8) DEFAULT NULL,
  `subject` varchar(30) DEFAULT NULL,
  `halfClass` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Subjects`
--

CREATE TABLE IF NOT EXISTS `Subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school` varchar(4) DEFAULT NULL,
  `abbr` varchar(8) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `optional` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Dumping data for table `Subjects`
--

INSERT INTO `Subjects` (`id`, `school`, `abbr`, `name`, `optional`) VALUES
(1, 'krm', 'D', 'Deutsch', 0),
(2, 'krm', 'dh', 'Deutsch Halbklassen', 0),
(3, 'krm', 'da', 'Aufsatzbesprechung', 0),
(4, 'krm', 'F', 'Französisch', 0),
(5, 'krm', 'fh', 'Französisch Halbklassen', 0),
(6, 'krm', 'I', 'Italienisch', 0),
(7, 'krm', 'ih', 'Italienisch Halbklassen', 0),
(8, 'krm', 'E', 'Englisch', 0),
(9, 'krm', 'eh', 'Englisch Halbklassen', 0),
(10, 'krm', 'G', 'Geschichte', 0),
(11, 'krm', 'Gg', 'Geographie', 0),
(12, 'krm', 'EWR', 'Einführung in Wirtschaft und Recht', 0),
(13, 'krm', 'M', 'Mathematik', 0),
(14, 'krm', 'AM', 'Anwendungen der Mathematik', 0),
(15, 'krm', 'inf', 'Informatik', 0),
(16, 'krm', 'Ph', 'Physik', 0),
(17, 'krm', 'php', 'Physik Praktikum', 0),
(18, 'krm', 'C', 'Chemie', 0),
(19, 'krm', 'cp', 'chemie Praktikum', 0),
(20, 'krm', 'B', 'Biologie', 0),
(21, 'krm', 'bp', 'Biologie Praktikum', 0),
(22, 'krm', 'TK', 'Turnen und Sport Knaben', 0),
(23, 'krm', 'TM', 'Turnen und Sport Mädchen', 0),
(24, 'krm', 'TWPF', 'Turnen und Sport Wahlpflichtfach', 0),
(25, 'krm', 'BG', 'Bildnerisches Gestalten', 0),
(26, 'krm', 'Mu', 'Musik', 0),
(27, 'krm', 'muh', 'Musik Halbklassen', 0),
(28, 'krm', '+', 'Klassenstunde', 0),
(29, 'krm', 'Mpa', 'Mathematik', 0),
(30, 'krm', 'Cpa', 'Chemie', 0),
(31, 'krm', 'Ppa', 'Physik', 0),
(32, 'krm', 'Bpa', 'Biologie', 0),
(33, 'krm', 'Mbc', 'Mathematik', 0),
(34, 'krm', 'Cbc', 'Chemie', 0),
(35, 'krm', 'Pbc', 'Physik', 0),
(36, 'krm', 'Bbc', 'Biologie', 0),
(37, 'krm', 'Delf1', 'Französisch DELF', 1),
(38, 'krm', 'La2', 'Latein', 1),
(39, 'krm', 'BGf', 'Freifach Bildnerisches Gestalten', 1),
(40, 'krm', 'Sf1', 'Spanisch Freifach', 1),
(41, 'krm', 'EAS', 'Englisch A-Stream', 1),
(42, 'krm', 'M+', 'Mathematik Algebra', 1),
(43, 'krm', 'M°', 'Mathematik Geometrie', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Teachers`
--

CREATE TABLE IF NOT EXISTS `Teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `school` varchar(4) DEFAULT NULL,
  `abbr` varchar(5) DEFAULT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `subject` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbr` (`abbr`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=134 ;

--
-- Dumping data for table `Teachers`
--

INSERT INTO `Teachers` (`id`, `school`, `abbr`, `firstName`, `lastName`, `subject`) VALUES
(1, 'krm', NULL, 'Moritz', 'Adelmeyer', 'Mathematik'),
(2, 'krm', NULL, 'Ruth', 'Affolter', 'Latein'),
(3, 'krm', NULL, 'Christian', 'Ammann', 'Chemie'),
(4, 'krm', NULL, 'Isabelle', 'Anderfuhren', 'Sologesang'),
(5, 'krm', NULL, 'Dana', 'Antoniadis', 'Chemie'),
(6, 'krm', NULL, 'Stefan', 'Bachmann', 'Biologie'),
(7, 'krm', NULL, 'Mons', 'Bär', 'Deutsch'),
(8, 'krm', NULL, 'Hansueli', 'Bamert', 'Musik'),
(9, 'krm', NULL, 'Marco', 'Baschera', 'Französisch'),
(10, 'krm', NULL, 'Marino', 'Bernasconi', 'Musik'),
(11, 'krm', NULL, 'Marco', 'Bettinaglio', 'Mathematik'),
(12, 'krm', NULL, 'Mauro', 'Bignotti', 'Französisch'),
(13, 'krm', NULL, 'Harald', 'Billeter', 'Französisch'),
(14, 'krm', NULL, 'Matthias', 'Blösser', 'Deutsch'),
(15, 'krm', NULL, 'Sigrid', 'Böhler', 'Deutsch'),
(16, 'krm', NULL, 'Thomas', 'Bolliger', 'Biologie'),
(17, 'krm', NULL, 'Gabriela', 'Bollinger', 'Englisch'),
(18, 'krm', NULL, 'Sebastian', 'Bott', 'Geschichte'),
(19, 'krm', NULL, 'Felix', 'Brunner', 'Bildnerisches Gestalten'),
(20, 'krm', NULL, 'Werner', 'Buechi', 'Mathematik'),
(21, 'krm', NULL, 'Romina', 'Buica', 'Französisch'),
(22, 'krm', NULL, 'Samuel', 'Byland', 'Physik'),
(23, 'krm', NULL, 'Tatjana', 'Cetkovic', 'Englisch'),
(24, 'krm', NULL, 'Ottavio', 'Clavuot', 'Geschichte'),
(25, 'krm', NULL, 'Margaretha', 'Debrunner', 'Latein'),
(26, 'krm', NULL, 'Marco', 'Didone', 'Physik'),
(27, 'krm', NULL, 'Thomas', 'Dorizzi', 'Mathematik'),
(28, 'krm', NULL, 'Melissa', 'Dornheim', 'Mathematik'),
(29, 'krm', NULL, 'Samantha', 'Dunne', 'Englisch'),
(30, 'krm', NULL, 'Felix', 'Eberle', 'Schlagzeug'),
(31, 'krm', NULL, 'Wolfgang', 'Ebner', 'Sport'),
(32, 'krm', NULL, 'Marcel', 'Ege', 'Gitarre'),
(33, 'krm', NULL, 'Willi', 'Eggel', 'Biologie'),
(34, 'krm', NULL, 'Martin', 'Eigenmann', 'Klavier'),
(35, 'krm', NULL, 'Lukas', 'Fässler', 'Informatik'),
(36, 'krm', NULL, 'Robert', 'Fischinger', 'Französisch'),
(37, 'krm', NULL, 'Eric', 'Fitze', 'Mathematik'),
(38, 'krm', NULL, 'Susanne', 'Flury', 'Sport'),
(39, 'krm', NULL, 'Hanspeter', 'Frehner', 'Querflöte'),
(40, 'krm', NULL, 'Christoph', 'Frei', 'Deutsch'),
(41, 'krm', NULL, 'Martin', 'Frey', 'Klavier'),
(42, 'krm', NULL, 'Martin', 'Friedli', 'Mathematik'),
(43, 'krm', NULL, 'Matthias', 'Fuchs', 'Geschichte'),
(44, 'krm', NULL, 'Ursula', 'Füchslin', 'Geschichte'),
(45, 'krm', NULL, 'Roberta', 'Gaietta', 'Italienisch'),
(46, 'krm', NULL, 'Silvia', 'Gamper', 'Physik'),
(47, 'krm', NULL, 'Filizia', 'Gasnakis', 'Französisch'),
(48, 'krm', NULL, 'Franziska', 'Gassmann', 'Biologie'),
(49, 'krm', NULL, 'Thomas', 'Geiger', 'Saxophon'),
(50, 'krm', NULL, 'Pietro', 'Gilardi', 'Mathematik'),
(51, 'krm', NULL, 'Heloise', 'Girard', 'Französich'),
(52, 'krm', NULL, 'Ekaterina', 'Gots', 'Mathematik'),
(53, 'krm', NULL, 'Mario', 'Häfeli', 'Mathematik'),
(54, 'krm', NULL, 'Philip', 'Herdeg', 'Biologie'),
(55, 'krm', NULL, 'Karin', 'Hesselmann', 'Französisch'),
(56, 'krm', NULL, 'Michael', 'Horn', 'Chemie'),
(57, 'krm', NULL, 'Claudia', 'Imhof', 'Sport'),
(58, 'krm', NULL, 'Stefan', 'Imper', 'Informatik'),
(59, 'krm', NULL, 'Ursula', 'Ingold', 'Sologesang'),
(60, 'krm', NULL, 'Susanne', 'Kalt', 'Deutsch'),
(61, 'krm', NULL, 'Daniel', 'Keller', 'Physik'),
(62, 'krm', NULL, 'Hansulrich', 'Keller', 'Mathematik'),
(63, 'krm', NULL, 'Karin', 'Kind', 'Französisch'),
(64, 'krm', NULL, 'Räto', 'Kindschi', 'Geographie'),
(65, 'krm', NULL, 'Alexander', 'Kionke', 'Musik'),
(66, 'krm', NULL, 'Barbara', 'Klein', 'Mathematik'),
(67, 'krm', NULL, 'Stephan', 'Knorr', 'Mathematik'),
(68, 'krm', NULL, 'Raphael', 'Kost', 'Deutsch'),
(69, 'krm', NULL, 'Axelle', 'Krayenbühl', 'Physik'),
(70, 'krm', NULL, 'Claude', 'Kupfer', 'Geschichte'),
(71, 'krm', NULL, 'Andreas', 'Kyburz', 'Biologie'),
(72, 'krm', NULL, 'Oliver', 'Langenbach', 'Geschichte'),
(73, 'krm', NULL, 'Martin', 'Lieberherr', 'Physik'),
(74, 'krm', NULL, 'Christoph', 'Linder', 'Elektrische Gitarre'),
(75, 'krm', NULL, 'Thomas', 'Luethi', 'Sport'),
(76, 'krm', NULL, 'Gloria', 'Lurati', 'Französisch, Italienisch'),
(77, 'krm', NULL, 'Robert', 'Mark', 'Schlagzeug'),
(78, 'krm', NULL, 'Marko', 'Markovic', 'Chemie'),
(79, 'krm', NULL, 'Lorenz', 'Marti', 'Chemie'),
(80, 'krm', NULL, 'Letizia', 'Martini', ''),
(81, 'krm', NULL, 'Andreas', 'Meier', 'Deutsch'),
(82, 'krm', NULL, 'Regula', 'Meili-Weigold', 'Französisch'),
(83, 'krm', NULL, 'Siegfried', 'Meissner', 'Gitarre'),
(84, 'krm', NULL, 'Bernhard', 'Meister', 'Deutsch'),
(85, 'krm', NULL, 'Philipp', 'Michelus', 'Deutsch'),
(86, 'krm', NULL, 'Srdjan', 'Micic', 'Mathematik'),
(87, 'krm', NULL, 'Adriana', 'Mikolaskova', 'Bildnerisches Gestalten, Infor'),
(88, 'krm', NULL, 'Willi', 'Morant', 'Trompete'),
(89, 'krm', NULL, 'Joe', 'Nickerson', 'Gitarre'),
(90, 'krm', NULL, 'Ulrich', 'Nyffeler', 'Musik'),
(91, 'krm', NULL, 'Felix', 'Perret', 'Schlagzeug'),
(92, 'krm', NULL, 'Odile', 'Pesse', 'Französisch'),
(93, 'krm', NULL, 'Kathrin', 'Pirani', 'Englisch'),
(94, 'krm', NULL, 'Sabrina', 'Puto', 'Französisch'),
(95, 'krm', NULL, 'Daniel', 'Reichmuth', 'Mathematik'),
(96, 'krm', NULL, 'Fabio', 'Rigutini', 'Französisch'),
(97, 'krm', NULL, 'Mathias', 'Roth', 'Sport'),
(98, 'krm', NULL, 'Christine', 'Ruf', 'Französisch'),
(99, 'krm', NULL, 'Marco', 'Sabbatini', 'Sport'),
(100, 'krm', NULL, 'Gregor', 'Schäppi', 'Mathematik'),
(101, 'krm', NULL, 'Heinz', 'Schenkel', 'Mathematik'),
(102, 'krm', NULL, 'Yolanda', 'Schibli', 'Musik'),
(103, 'krm', NULL, 'Martin', 'Schmid', 'Musik'),
(104, 'krm', NULL, 'Adrian', 'Schmid', 'Klarinette'),
(105, 'krm', NULL, 'Ariane', 'Schmidt', 'Deutsch'),
(106, 'krm', NULL, 'Christian', 'Schmidtpeter', 'Geschichte, Geographie'),
(107, 'krm', NULL, 'Marlene', 'Schmucki', 'Biologie'),
(108, 'krm', NULL, 'Valentin', 'Schönherr', 'Geschichte'),
(109, 'krm', NULL, 'Albert', 'Siegenthaler', 'Geographie'),
(110, 'krm', NULL, 'Rolf', 'Siegenthaler', 'Englisch'),
(111, 'krm', NULL, 'Beatrice', 'Sommer', 'Englisch'),
(112, 'krm', NULL, 'Björn', 'Steffen', 'Mathematik'),
(113, 'krm', NULL, 'Sonja', 'Stocker', 'Sologesang'),
(114, 'krm', NULL, 'Franziska', 'Struzek', 'Deutsch'),
(115, 'krm', NULL, 'Eliane', 'Suter', 'Englisch'),
(116, 'krm', NULL, 'Gerhard', 'Toggenburger', 'Chemie'),
(117, 'krm', NULL, 'Claudia', 'Troxler', 'Violine'),
(118, 'krm', NULL, 'Thomas', 'Uhlir', 'Englisch'),
(119, 'krm', NULL, 'Peri', 'Uyumaz', 'Mathematik'),
(120, 'krm', NULL, 'Christian', 'Villiger', 'Deutsch'),
(121, 'krm', NULL, 'Thomas', 'Vontobel', 'Bildnerisches Gestalten'),
(122, 'krm', NULL, 'Ivan', 'Vyskocil', 'Geschichte'),
(123, 'krm', NULL, 'Markus', 'Weber', 'Latein'),
(124, 'krm', NULL, 'Barbara', 'Weber', 'Biologie'),
(125, 'krm', NULL, 'Maria', 'Weber', 'Spanisch'),
(126, 'krm', NULL, 'Daniela', 'Wettstein', 'Bildnerisches Gestalten'),
(127, 'krm', NULL, 'Christoph', 'Wey', 'Bildnerisches Gestalten'),
(128, 'krm', NULL, 'Michael', 'Winkler', 'Gitarre'),
(129, 'krm', NULL, 'Franz', 'Winteler', 'Kontrabass'),
(130, 'krm', NULL, 'Cornelia', 'Worst', 'Englisch'),
(131, 'krm', NULL, 'Anja', 'Woschick', 'Klavier'),
(132, 'krm', NULL, 'Silvia', 'Zuberbühler', 'Turnen'),
(133, 'krm', NULL, 'Marcel', 'Zurflueh', 'Geographie');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
