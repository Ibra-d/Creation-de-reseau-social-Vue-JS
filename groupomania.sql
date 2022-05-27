-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 27 mai 2022 à 08:36
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `groupomania`
--

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `idComment` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(500) NOT NULL,
  `authorId` int(11) NOT NULL,
  `postId` int(11) NOT NULL,
  PRIMARY KEY (`idComment`),
  KEY `authorId_idx` (`authorId`),
  KEY `postId_idx` (`postId`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `comment`
--

INSERT INTO `comment` (`idComment`, `comment`, `authorId`, `postId`) VALUES
(12, 'Roi thiala..!', 104, 13),
(11, 'Coooooooool', 103, 10),
(13, '@roiThiala Ouais', 104, 10);

-- --------------------------------------------------------

--
-- Structure de la table `like`
--

DROP TABLE IF EXISTS `like`;
CREATE TABLE IF NOT EXISTS `like` (
  `likeId` int(11) NOT NULL AUTO_INCREMENT,
  `postId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`likeId`),
  KEY `postId_idx` (`postId`),
  KEY `userIdlike_idx` (`userId`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `like`
--

INSERT INTO `like` (`likeId`, `postId`, `userId`) VALUES
(18, 13, 103),
(17, 10, 103),
(15, 10, 102),
(19, 14, 104),
(20, 13, 104),
(21, 10, 104);

-- --------------------------------------------------------

--
-- Structure de la table `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
  `postId` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(300) DEFAULT NULL,
  `imageUrl` varchar(300) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `like` int(11) DEFAULT '0',
  `authorId` int(11) NOT NULL,
  `comment` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`postId`),
  KEY `authorId_idx` (`authorId`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `post`
--

INSERT INTO `post` (`postId`, `text`, `imageUrl`, `date`, `like`, `authorId`, `comment`) VALUES
(13, 'salut c\'est Roi thiala', 'http://localhost:3000/images/post/image1653638905654.jpg', '2022-05-27 10:08:25', 2, 103, 1),
(10, 'Salut C\'est Idi', 'http://localhost:3000/images/post/image1653638746824.jpg', '2022-05-27 10:05:46', 3, 102, 2),
(14, 'Salut c\'est le Roi zulu', 'http://localhost:3000/images/post/image1653639004336.jpg', '2022-05-27 10:10:04', 1, 104, 0);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(250) NOT NULL,
  `pp` varchar(500) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  `admin` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=105 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `nom`, `prenom`, `email`, `password`, `pp`, `desc`, `admin`) VALUES
(1, 'Admin', 'Denzel', 'admin@admin.com', '$2b$10$Ty5oq3O43UiA9.apxeraPOLRUR4P1dZGC78ctEzJcwY/gKHfasfsq', 'http://localhost:3000/images/profile/image1653638441148.jpg', NULL, 1),
(104, 'Zulu', 'Chaka', 'chaka@zulu.com', '$2b$10$Z26d.Fui6kbilH15nYNwxuHOC0VOeUn7E8NOuhzhLxeieKSRjr35u', 'http://localhost:3000/images/profile/image1653638977083.jpg', NULL, 0),
(103, 'Thiala', 'Roi', 'roi@thiala.com', '$2b$10$tmyebFfCwk03NRbXuGe5qeBOFAQe.dQpAr3h6Xi1.58IbIwSSWg0u', 'http://localhost:3000/images/profile/image1653638853225.jpg', NULL, 0),
(102, 'Idi', 'Denzel', 'idi@idi.com', '$2b$10$RAnopsBDAzyRz6g1ymjNBeTu3aUwpENGhxKNzPwOqGzBq9xQ.QNSe', 'http://localhost:3000/images/profile/image1653638718341.jpg', NULL, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
