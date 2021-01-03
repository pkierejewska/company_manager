-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 03, 2021 at 01:27 PM
-- Server version: 10.3.25-MariaDB-0ubuntu0.20.04.1
-- PHP Version: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `company_manager`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `duzeImieNazwisko` ()  BEGIN
	 UPDATE uzytkownicy SET 
     imie=CONCAT(UPPER(LEFT(imie, 1)), RIGHT(imie, LENGTH(imie)-1));
     UPDATE uzytkownicy SET
     nazwisko=CONCAT(UPPER(LEFT(nazwisko, 1)), RIGHT(nazwisko, LENGTH(nazwisko)-1));
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dokumenty`
--

CREATE TABLE `dokumenty` (
  `id` int(11) NOT NULL,
  `data` date NOT NULL,
  `l_stron` int(11) NOT NULL,
  `notatki` text NOT NULL,
  `zdjecie_dokumentu` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `dokumenty`
--

INSERT INTO `dokumenty` (`id`, `data`, `l_stron`, `notatki`, `zdjecie_dokumentu`) VALUES
(1, '2021-01-06', 2, 'abcdef', '1r.png');

-- --------------------------------------------------------

--
-- Table structure for table `faktury`
--

CREATE TABLE `faktury` (
  `id` int(11) NOT NULL,
  `nr_faktury` text NOT NULL,
  `netto` decimal(11,0) NOT NULL,
  `vat` int(11) NOT NULL,
  `brutto` decimal(11,0) NOT NULL,
  `waluta` int(11) NOT NULL,
  `kontrahent_id` int(11) NOT NULL,
  `id_dokumentu` int(11) DEFAULT NULL,
  `rodzaj` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faktury`
--

INSERT INTO `faktury` (`id`, `nr_faktury`, `netto`, `vat`, `brutto`, `waluta`, `kontrahent_id`, `id_dokumentu`, `rodzaj`) VALUES
(4, '999', '99', 9, '99', 2, 2, 1, 1),
(5, '997', '99', 7, '99', 3, 5, 1, 1),
(6, '666', '66', 6, '66', 1, 4, 1, 1),
(7, '777', '77', 7, '77', 3, 6, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `kategorie_faktur`
--

CREATE TABLE `kategorie_faktur` (
  `id` int(11) NOT NULL,
  `nazwa` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kategorie_faktur`
--

INSERT INTO `kategorie_faktur` (`id`, `nazwa`) VALUES
(1, 'sprzedaz'),
(2, 'zakup');

-- --------------------------------------------------------

--
-- Table structure for table `kontrahenci`
--

CREATE TABLE `kontrahenci` (
  `id` int(11) NOT NULL,
  `nazwa` text NOT NULL,
  `vat_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kontrahenci`
--

INSERT INTO `kontrahenci` (`id`, `nazwa`, `vat_id`) VALUES
(1, 'nazwa', 123),
(2, 'nowy', 333),
(3, 'nowszy', 999),
(4, 'kokosik', 666),
(5, 'najnowszy', 555),
(6, 'kontrahent7', 777);

-- --------------------------------------------------------

--
-- Table structure for table `licencje`
--

CREATE TABLE `licencje` (
  `id` int(11) NOT NULL,
  `nr_inwentarzowy` int(11) NOT NULL,
  `nazwa` text NOT NULL,
  `opis` text DEFAULT NULL,
  `klucz_seryjny` text NOT NULL,
  `data_zakupu` date NOT NULL,
  `id_faktury` int(11) DEFAULT NULL,
  `wsparcie_do` date NOT NULL,
  `licencja_do` date NOT NULL,
  `notatki` text DEFAULT NULL,
  `id_wlasciciela` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `nazwa` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `nazwa`) VALUES
(1, 'wlasciciel'),
(2, 'pracownik'),
(3, 'auditor');

-- --------------------------------------------------------

--
-- Table structure for table `sprzety`
--

CREATE TABLE `sprzety` (
  `id` int(11) NOT NULL,
  `nr_inwentarzowy` int(11) NOT NULL,
  `nazwa` text NOT NULL,
  `opis` text DEFAULT NULL,
  `nr_seryjny` text NOT NULL,
  `data_zakupu` date NOT NULL,
  `nr_faktury` int(11) DEFAULT NULL,
  `gwarancja_do` date NOT NULL,
  `netto_pl` decimal(10,0) NOT NULL,
  `notatki` text DEFAULT NULL,
  `id_wlasciciela` int(11) NOT NULL,
  `netto` decimal(10,0) NOT NULL,
  `waluta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `uzytkownicy`
--

CREATE TABLE `uzytkownicy` (
  `id` int(11) NOT NULL,
  `imie` text NOT NULL,
  `nazwisko` text NOT NULL,
  `login` text NOT NULL,
  `haslo` text NOT NULL,
  `id_roli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `uzytkownicy`
--

INSERT INTO `uzytkownicy` (`id`, `imie`, `nazwisko`, `login`, `haslo`, `id_roli`) VALUES
(1, 'Kokos', 'Asowy', 'kokosik123', '$2y$10$TPQH6Dm9lfLjUwhT4s6y4uHrS7ogsJQJOHdVeHhedJSZHzeIziXei', 2),
(6, 'Patrycja', 'Nowak', 'patrycja123', '$2y$10$RXBpVYFXvpZ5iTNo71AnluDppV95ncx7s1O..h9W5NxYrywhOPHEa', 1),
(7, 'Katarzyna', 'Kowalska', 'kasia123', '$2y$10$Q/CpMLr7GydzcNgLxMo7gurimnit.2kRhLapl5zD9dCnqDsD7uRgC', 3),
(8, 'Marta', 'Karta', 'marta123', '$2y$10$AcSxYkJEgW57ja7s6yw1uOTXQFoYswFuOrQHaEsfoRFi3Sgv7zP/2', 2),
(14, 'Dominika', 'Kostecka', 'dominika123', '$2y$10$.6wh41apSfZCBSOEc8om7OZhhd2yMyz5aNnbCcHDaWPZB70A2amR6', 2),
(15, 'Adam', 'Nowicki', 'adam1234', '$2y$10$QJWqLErINE5x1kMzMzQy9etknMvdFAfKnFlKvsirWbbiiDFueQWHm', 2),
(16, 'Marcel', 'Iwanicki', 'marcel123', '$2y$10$m2.jfgySZwKCfEklw5DA6ekJg/bORl4m/wJZf8vj0T1wjI0mBFVJq', 2),
(20, 'izabela', 'łęcka', 'izabela123', '$2y$10$1B30tHIOZGP1.uWBoMjJ/ehgRS4hmQrd3Zj/DEi9FgrDpGmAyAaqm', 3),
(21, 'Paweł', 'Stępnik', 'pawel123', '$2y$10$gew.Ol1J1TSOEw7Z0Dtedu6WIba2hDOLC5XCXZimxah5g1pYxXesO', 3),
(22, 'óla', 'óla', 'ola123456', '$2y$10$OXWrKgqoOTX.9e5Ih2zUEOoZ7fyv62fUwmX6M8UJCuo7g695LIgpK', 2),
(23, 'łukasz', 'Kokosanek', 'lukasz123', '$2y$10$0JuQ6RO0GhgOc4m7m9hsouoponYtsh9hXiKhjD2o8m3pYDxT16qxK', 2),
(24, 'Luka', 'Lolo', 'luka1234', '$2y$10$Pi5xtpkKdF.JF2Cjvu42deUocqfGOSoQNnoCPsa7qfdNJZ5s8r6Yq', 1),
(25, 'Łukasz', 'Ąę', 'lukasz1234', '$2y$10$8rV7b19ASok2iZXw2PLVwukyRTvlb2qzK2hEXISgcfLqk192lMrS2', 2),
(26, 'Paweł', 'Kowalski', 'pawel12345', '$2y$10$30rF.Ap1tPvcM1/KpnwFbeEKyBVDqn4JPPvFAMDEWBJ4KBRJ3WOl.', 3);

-- --------------------------------------------------------

--
-- Table structure for table `waluty`
--

CREATE TABLE `waluty` (
  `id` int(11) NOT NULL,
  `nazwa` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `waluty`
--

INSERT INTO `waluty` (`id`, `nazwa`) VALUES
(1, 'PLN'),
(2, 'USD'),
(3, 'EUR'),
(4, 'GBP'),
(5, 'JPY'),
(6, ''),
(7, '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dokumenty`
--
ALTER TABLE `dokumenty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faktury`
--
ALTER TABLE `faktury`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kontrahent_id` (`kontrahent_id`),
  ADD KEY `waluta` (`waluta`),
  ADD KEY `rodzaj` (`rodzaj`),
  ADD KEY `id_dokumentu` (`id_dokumentu`);

--
-- Indexes for table `kategorie_faktur`
--
ALTER TABLE `kategorie_faktur`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kontrahenci`
--
ALTER TABLE `kontrahenci`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `licencje`
--
ALTER TABLE `licencje`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_faktury` (`id_faktury`),
  ADD KEY `id_wlasciciela` (`id_wlasciciela`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sprzety`
--
ALTER TABLE `sprzety`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nr_faktury` (`nr_faktury`),
  ADD KEY `id_wlasciciela` (`id_wlasciciela`),
  ADD KEY `waluta` (`waluta`);

--
-- Indexes for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_roli` (`id_roli`);

--
-- Indexes for table `waluty`
--
ALTER TABLE `waluty`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dokumenty`
--
ALTER TABLE `dokumenty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faktury`
--
ALTER TABLE `faktury`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kategorie_faktur`
--
ALTER TABLE `kategorie_faktur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kontrahenci`
--
ALTER TABLE `kontrahenci`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `licencje`
--
ALTER TABLE `licencje`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sprzety`
--
ALTER TABLE `sprzety`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `waluty`
--
ALTER TABLE `waluty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `faktury`
--
ALTER TABLE `faktury`
  ADD CONSTRAINT `faktury_ibfk_1` FOREIGN KEY (`kontrahent_id`) REFERENCES `kontrahenci` (`id`),
  ADD CONSTRAINT `faktury_ibfk_2` FOREIGN KEY (`waluta`) REFERENCES `waluty` (`id`),
  ADD CONSTRAINT `faktury_ibfk_3` FOREIGN KEY (`rodzaj`) REFERENCES `kategorie_faktur` (`id`),
  ADD CONSTRAINT `faktury_ibfk_4` FOREIGN KEY (`id_dokumentu`) REFERENCES `dokumenty` (`id`);

--
-- Constraints for table `licencje`
--
ALTER TABLE `licencje`
  ADD CONSTRAINT `licencje_ibfk_1` FOREIGN KEY (`id_faktury`) REFERENCES `faktury` (`id`),
  ADD CONSTRAINT `licencje_ibfk_2` FOREIGN KEY (`id_wlasciciela`) REFERENCES `uzytkownicy` (`id`);

--
-- Constraints for table `sprzety`
--
ALTER TABLE `sprzety`
  ADD CONSTRAINT `sprzety_ibfk_1` FOREIGN KEY (`nr_faktury`) REFERENCES `faktury` (`id`),
  ADD CONSTRAINT `sprzety_ibfk_2` FOREIGN KEY (`id_wlasciciela`) REFERENCES `uzytkownicy` (`id`),
  ADD CONSTRAINT `sprzety_ibfk_3` FOREIGN KEY (`waluta`) REFERENCES `waluty` (`id`);

--
-- Constraints for table `uzytkownicy`
--
ALTER TABLE `uzytkownicy`
  ADD CONSTRAINT `uzytkownicy_ibfk_1` FOREIGN KEY (`id_roli`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
