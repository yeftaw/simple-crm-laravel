-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 18, 2014 at 05:12 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `kmm`
--

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `groups_name_unique` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(1, 'administrator', '{"admin":1}', '2014-10-04 01:28:28', '2014-10-04 01:28:28'),
(2, 'salesman', '{"sales":1}', '2014-10-04 01:28:28', '2014-10-04 01:28:28'),
(3, 'direktur', '{"direktur":1}', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE IF NOT EXISTS `leads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salutation` varchar(15) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `instance` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lead_status_id` (`status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `salutation`, `first_name`, `last_name`, `phone`, `email`, `instance`, `address`, `address2`, `description`, `status_id`, `created_at`, `updated_at`) VALUES
(1, 'Mr.', 'Yefta', 'Aditya', '085725200070', 'yevtha.aw@gmail.com', 'UNS Surakarta', 'Kauman 05/02, Keden, Pedan, Klaten', NULL, NULL, 6, '2014-10-31 23:45:27', '2014-10-31 23:45:27'),
(4, 'Mr.', 'Bambang', 'Susetya', '08908907098', NULL, NULL, 'Sobayan, Pedan, Klaten', NULL, NULL, 2, '2014-11-09 17:08:01', '2014-11-12 20:32:02'),
(5, '', 'Ali', 'Sudaretna', '089998978786', 'ali.sud@gmail.com', 'Universitas Sebelas Maret', 'Jl. Hayam Wuruk No.23 Surakarta', NULL, NULL, 3, '2014-11-13 13:16:04', '2014-11-13 13:16:04'),
(6, 'Mr.', 'Indarto', 'Suliantoro', '086756456456', 'indarto@gmail.com', NULL, 'Jl. Kenanga No.24 Klaten Selatan, Klaten', 'Jl. Jogja-Solo Km.27, Jogonalan, Klaten', NULL, 2, '2014-11-13 17:19:53', '2014-11-13 17:19:53'),
(7, 'Mr.', 'Agung', 'Sudartadi', '089879079089', 'agung.digauli@gmail.com', 'Universitas Sebelas Maret', 'Jl. Ir. Sutami Surakarta', 'Jl. Tangkuban Prahu No.77 Surakarta', 'Masih rumit orangnya, wah susah pokoknya.', 3, '2014-11-13 17:22:04', '2014-11-13 17:25:48'),
(9, 'Mrs.', 'Anita', NULL, '890890890', NULL, NULL, 'Jl Kenanga No.29', NULL, NULL, 2, '2014-11-14 06:46:58', '2014-11-14 06:46:58'),
(10, '', 'Agus', 'Harimurti Yudhoyono', '0897889798979', 'agus.h@gmail.com', NULL, 'Jl. Redoks No.23 Jakarta Pusat', NULL, NULL, 2, '2014-11-15 13:29:18', '2014-11-15 13:29:18'),
(11, 'Mr.', 'Leni', 'Suratmanwati', '086787898786', 'lee.nny@yahoo.com', 'Bank Mega Cabang Pasar Kliwon', 'Baki, Sukoharjo', NULL, NULL, 2, '2014-11-15 13:31:16', '2014-11-15 13:31:16'),
(12, 'Mr.', 'Handi', 'Utomo', '085725200090', 'agung@gmail.com', NULL, 'Sobayan, Pedan, Klaten', NULL, NULL, 2, '2014-11-15 14:09:52', '2014-11-15 14:09:52'),
(13, 'Mr.', 'Angger', 'Hutomo', '08978878861', NULL, NULL, 'Jogonalan, Klaten Selatan, KLaten', NULL, NULL, 3, '2014-11-15 14:16:57', '2014-11-15 14:16:57'),
(14, 'Mr.', 'Budi', 'Sudarsono', '089898789789', 'budi@gmail.com', 'Universitas Sebelas Maret', 'Pasar Kliwon, Surakarta', 'Ternate Timur, Ternate', 'Orang ini agak susah mas diajak ngobrol. Cuman dia keliatannya prospek, nih langsung tak kasih status penawaran.', 3, '2014-11-15 14:20:21', '2014-11-15 14:20:21'),
(15, '', 'Bambang', '', '0898989898989', NULL, NULL, 'Jebres, Surakarta', NULL, 'Lagi perjalanan nih,  bisa dikontrol ya.', 4, '2014-11-15 14:21:17', '2014-11-15 14:21:17'),
(16, '', 'Yunita', 'Sulastri', '0272728977', NULL, NULL, 'Jl. Mawar No.23, Sukoharjo', NULL, NULL, 4, '2014-11-15 14:22:28', '2014-11-15 14:22:28'),
(17, '', 'Anita', 'Hara', '081328999222', NULL, NULL, 'Sobayan, Pedan, Klaten', NULL, NULL, 3, '2014-11-15 14:26:45', '2014-11-15 14:44:17'),
(18, 'Mr.', 'Linda', 'Dewi', '089123123123', NULL, NULL, 'Jl. Sinatra No.23 Madiun', NULL, NULL, 2, '2014-11-15 14:28:33', '2014-11-15 14:28:33'),
(19, 'Mrs.', 'Iswaya', 'Lindanita', '089089089089', NULL, NULL, 'Sobayan, Pedan, Klaten', NULL, NULL, 3, '2014-11-15 14:30:06', '2014-11-15 14:44:01'),
(20, '', 'Indiarti', NULL, '089087086089', NULL, NULL, 'Sobayan, Pedan, Klaten', NULL, 'Baru kontak udah bilang gak sudi -_-"', 6, '2014-11-15 14:43:29', '2014-11-15 14:43:50'),
(21, '', 'Alisa', 'Subandini', '081234234254', NULL, NULL, 'Sobayan, Pedan, Klaten', NULL, NULL, 4, '2014-11-15 15:00:00', '2014-11-15 15:00:00'),
(22, 'Ms.', 'Inaya', 'Kiswandari', '085643000000', 'inaya@student.uns.ac.id', 'Universitas Sebelas Maret', 'Baki, Sukoharjo', 'Pedan, Klaten', 'Jos banget ini gan', 5, '2014-11-15 15:02:38', '2014-11-15 15:02:38'),
(23, '', 'Andika', 'Pratama', '0272897543', NULL, NULL, 'Kauman, Pedan, Klaten', NULL, NULL, 5, '2014-11-15 15:04:01', '2014-11-15 15:04:01');

-- --------------------------------------------------------

--
-- Table structure for table `lead_statuses`
--

CREATE TABLE IF NOT EXISTS `lead_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(30) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `lead_statuses`
--

INSERT INTO `lead_statuses` (`id`, `status`, `description`) VALUES
(2, 'pengenalan', 'Tahap perkenalan'),
(3, 'penawaran', 'Dalam penawaran atau pengajuan proposal'),
(4, 'pending', 'Menunggu hasil'),
(5, 'sukses', 'Telah terjadi kesepakatan'),
(6, 'gagal', 'Tidak ada kesepakatan');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_04_082113_migration_cartalyst_sentry_install_users', 1),
('2014_10_04_082114_migration_cartalyst_sentry_install_groups', 1),
('2014_10_04_082115_migration_cartalyst_sentry_install_users_groups_pivot', 1),
('2014_10_04_082116_migration_cartalyst_sentry_install_throttle', 1);

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

CREATE TABLE IF NOT EXISTS `throttle` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attempts` int(11) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `last_attempt_at` timestamp NULL DEFAULT NULL,
  `suspended_at` timestamp NULL DEFAULT NULL,
  `banned_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `throttle_user_id_index` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `throttle`
--

INSERT INTO `throttle` (`id`, `user_id`, `ip_address`, `attempts`, `suspended`, `banned`, `last_attempt_at`, `suspended_at`, `banned_at`) VALUES
(1, 1, '127.0.0.1', 0, 0, 0, NULL, NULL, NULL),
(2, 2, NULL, 0, 0, 0, NULL, NULL, NULL),
(3, 12, NULL, 0, 0, 0, NULL, NULL, NULL),
(4, 1, '10.20.30.2', 0, 0, 0, NULL, NULL, NULL),
(5, 1, '10.60.10.6', 0, 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8_unicode_ci,
  `activated` tinyint(1) NOT NULL DEFAULT '0',
  `activation_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activated_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `persist_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_activation_code_index` (`activation_code`),
  KEY `users_reset_password_code_index` (`reset_password_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `permissions`, `activated`, `activation_code`, `activated_at`, `last_login`, `persist_code`, `reset_password_code`, `first_name`, `last_name`, `picture`, `created_at`, `updated_at`) VALUES
(1, 'admin@example.com', '$2y$10$0HaNN47mBhKcczodUQ8J8ueJQK8lCHZDTBDmsT01iZWEOYoRAvu52', NULL, 1, NULL, '2014-10-04 01:28:29', '2014-11-18 13:16:54', '$2y$10$MQP1dDWaHKsOi9jc1uMJwO54uw.K5CkfRdnz/6o5gStcWi4LtkDzO', NULL, 'Super', 'Administrator', NULL, '2014-10-04 01:28:29', '2014-11-18 13:16:54'),
(2, 'salesman@tokodata.com', '$2y$10$/PdqoMqcNZaBe.zJL7hmneS9ayA4OnyQ7C.NQwcgMYoDYHyPmGD3C', NULL, 1, NULL, '2014-10-04 01:28:30', '2014-11-16 09:16:13', '$2y$10$/4UjsKzQqj1eRaALOrAIHe1ArwhcGml54HCX19wnOkuPJ1LVEQL62', NULL, 'Yefta', 'Aditya Wibowo', NULL, '2014-10-04 01:28:30', '2014-11-16 09:16:13'),
(3, 'indah@tokodata.com', '$2y$10$tBI1.ALhP2ZrAvFFijUxC.q.3MYT6r07vRd9CIoooIe230K1wQOUO', NULL, 0, NULL, '2014-11-12 23:30:51', NULL, NULL, NULL, 'Indah', 'Dewi Pertiwi', NULL, '2014-11-12 23:30:50', '2014-11-15 14:55:04'),
(4, 'andrian@tokodata.com', '$2y$10$4HHhFqRNxZ6swqJJNhN4Q.P5WZQxTOeVPhMq.NnyKm85Cgr0.bl8u', NULL, 1, NULL, '2014-11-13 00:19:12', NULL, NULL, NULL, 'Andrian', 'Sebastian', NULL, '2014-11-13 00:19:11', '2014-11-15 14:54:37'),
(5, 'ardiyan@tokodata.com', '$2y$10$5EUdtsjXwwGjCFc0vaf/w.fD5kT9jQbRpJSk1ecZrxWF10v9NA/q.', NULL, 0, NULL, '2014-11-13 08:49:48', NULL, NULL, NULL, 'Ardiyan', 'Sulastri', NULL, '2014-11-13 08:49:47', '2014-11-15 14:54:27'),
(7, 'zidni@tokodata.com', '$2y$10$gi6iG9nXEf3JUW781d3njOp2S2D0JrOpFir8BS4Yf9pkV3aL.6TGq', NULL, 1, NULL, '2014-11-13 10:53:21', NULL, NULL, NULL, 'Zidni', 'Nur Kholiq', NULL, '2014-11-13 10:53:21', '2014-11-15 14:53:26'),
(8, 'layla.moetz@tokodata.com', '$2y$10$FnalWE9TgUsGoIpBstpgve4zrKwzWc7ivnMWSWCXA35uyhWYCsLDO', NULL, 0, NULL, '2014-11-13 11:59:01', NULL, NULL, NULL, 'Layla', 'Anggraini', NULL, '2014-11-13 11:59:00', '2014-11-15 14:53:14'),
(9, 'ariesta.bim@tokodata.com', '$2y$10$0f1M/0lGkx13GGnRC88WkupocQbKY9.V5uGETn/ZLsdAHEdHFcBqW', NULL, 1, NULL, '2014-11-13 15:23:33', NULL, NULL, NULL, 'Arista', 'Bima Handari', NULL, '2014-11-13 15:23:33', '2014-11-15 14:53:01'),
(10, 'susana@tokodata.com', '$2y$10$0ZMBuw911M0J2arKx65MUe4mfXqPyfyn8sbRI.tsVZdaDetZDQAb.', NULL, 1, NULL, '2014-11-13 17:37:29', NULL, NULL, NULL, 'Susana', NULL, NULL, '2014-11-13 17:37:28', '2014-11-15 14:52:15'),
(12, 'direktur@tokodata.com', '$2y$10$CWHgPh9kD7EK0knaDxrJ2u6gC23nv0DEoWH5p80etKSiQzXaqXJ46', NULL, 1, NULL, '2014-11-14 06:42:59', '2014-11-16 09:15:44', '$2y$10$aQacI7r.NI4HXLBmOG8P9eZWheEQjAT7gOY9.y/sVkiyxpHx0K/7i', NULL, 'Direktur', NULL, NULL, '2014-11-14 06:42:59', '2014-11-16 09:15:44'),
(13, 'admin2@tokodata.com', '$2y$10$vV301wRudnEpefMA5qrvOu/kk7wSsINRmEIGT651qJegSnZIok3ii', NULL, 1, NULL, '2014-11-15 14:45:56', NULL, NULL, NULL, 'Administrator Dua', NULL, NULL, '2014-11-15 14:45:55', '2014-11-15 14:50:54'),
(14, 'abu.dawud@tokodata.com', '$2y$10$A2duxtx7F7/Ad75LPNRiJueKs9FNtuqtelytwkPlZGmc.UTPQNwvu', NULL, 0, NULL, '2014-11-15 14:46:43', NULL, NULL, NULL, 'Abu', 'Dawud', NULL, '2014-11-15 14:46:42', '2014-11-15 14:50:30'),
(15, 'rianti@tokodata.com', '$2y$10$isLOw4pLKxzoHPkZGQ.XLO0QBJyi5CM7Jmown00mDL4cnX2xYztCC', NULL, 0, NULL, '2014-11-15 14:47:35', NULL, NULL, NULL, 'Rianti', 'Cartwright', NULL, '2014-11-15 14:47:35', '2014-11-15 14:50:04'),
(16, 'lianda@tokodata.com', '$2y$10$a/BjAckla2ehV0MB.w8I1.8CdmhKFK.CJMmUTMJodZ1hNDxgGaTOO', NULL, 1, NULL, '2014-11-15 14:49:41', NULL, NULL, NULL, 'Lianda', 'Dewi', NULL, '2014-11-15 14:49:40', '2014-11-15 14:49:41');

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE IF NOT EXISTS `users_groups` (
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`user_id`, `group_id`) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 1),
(5, 3),
(7, 2),
(8, 3),
(9, 3),
(10, 1),
(12, 3),
(13, 1),
(14, 1),
(15, 2),
(16, 2);

-- --------------------------------------------------------

--
-- Table structure for table `users_leads`
--

CREATE TABLE IF NOT EXISTS `users_leads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `lead_id` int(10) unsigned NOT NULL,
  `notes` text,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`lead_id`),
  KEY `lead_id` (`lead_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `users_leads`
--

INSERT INTO `users_leads` (`id`, `user_id`, `lead_id`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Catatan qwertyuiop', '2014-11-02 14:57:26', '2014-11-02 14:57:26'),
(3, 1, 4, 'Belum ada notes, buat TA nanti', '2014-11-09 17:08:01', '2014-11-09 17:08:01'),
(4, 2, 5, 'Belum ada notes, buat TA nanti', '2014-11-13 13:16:04', '2014-11-13 13:16:04'),
(5, 1, 6, 'Belum ada notes, buat TA nanti', '2014-11-13 17:19:53', '2014-11-13 17:19:53'),
(6, 1, 7, 'Belum ada notes, buat TA nanti', '2014-11-13 17:22:05', '2014-11-13 17:22:05'),
(8, 2, 9, 'Belum ada notes, buat TA nanti', '2014-11-14 06:46:58', '2014-11-14 06:46:58'),
(9, 1, 10, 'Belum ada notes, buat TA nanti', '2014-11-15 13:29:18', '2014-11-15 13:29:18'),
(10, 1, 11, 'Belum ada notes, buat TA nanti', '2014-11-15 13:31:16', '2014-11-15 13:31:16'),
(11, 1, 12, 'Belum ada notes, buat TA nanti', '2014-11-15 14:09:52', '2014-11-15 14:09:52'),
(12, 1, 13, 'Belum ada notes, buat TA nanti', '2014-11-15 14:16:57', '2014-11-15 14:16:57'),
(13, 1, 14, 'Belum ada notes, buat TA nanti', '2014-11-15 14:20:21', '2014-11-15 14:20:21'),
(14, 1, 15, 'Belum ada notes, buat TA nanti', '2014-11-15 14:21:17', '2014-11-15 14:21:17'),
(15, 1, 16, 'Belum ada notes, buat TA nanti', '2014-11-15 14:22:28', '2014-11-15 14:22:28'),
(16, 1, 17, 'Belum ada notes, buat TA nanti', '2014-11-15 14:26:45', '2014-11-15 14:26:45'),
(17, 1, 18, 'Belum ada notes, buat TA nanti', '2014-11-15 14:28:34', '2014-11-15 14:28:34'),
(18, 1, 19, 'Belum ada notes, buat TA nanti', '2014-11-15 14:30:06', '2014-11-15 14:30:06'),
(19, 1, 20, 'Belum ada notes, buat TA nanti', '2014-11-15 14:43:30', '2014-11-15 14:43:30'),
(20, 1, 21, 'Belum ada notes, buat TA nanti', '2014-11-15 15:00:01', '2014-11-15 15:00:01'),
(21, 1, 22, 'Belum ada notes, buat TA nanti', '2014-11-15 15:02:38', '2014-11-15 15:02:38'),
(22, 1, 23, 'Belum ada notes, buat TA nanti', '2014-11-15 15:04:01', '2014-11-15 15:04:01');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `lead_statuses` (`id`);

--
-- Constraints for table `users_leads`
--
ALTER TABLE `users_leads`
  ADD CONSTRAINT `users_leads_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `users_leads_ibfk_2` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
