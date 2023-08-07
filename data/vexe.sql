-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th5 05, 2023 lúc 03:30 AM
-- Phiên bản máy phục vụ: 5.7.36
-- Phiên bản PHP: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `vexe`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `admin_lienhe`
--

DROP TABLE IF EXISTS `admin_lienhe`;
CREATE TABLE IF NOT EXISTS `admin_lienhe` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `lh_id` int(11) NOT NULL,
  `is_checked` int(11) NOT NULL,
  PRIMARY KEY (`Mã`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `bus_model`
--

DROP TABLE IF EXISTS `bus_model`;
CREATE TABLE IF NOT EXISTS `bus_model` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Tên_Loại` varchar(255) NOT NULL,
  `Loại_ghế` int(11) NOT NULL,
  `Số_ghế` int(11) NOT NULL,
  `Số_hàng` int(11) NOT NULL,
  `Số_cột` int(11) NOT NULL,
  `Sơ_đồ` varchar(255) NOT NULL,
  `Mã_nhân_viên_tạo` int(11) NOT NULL,
  `Mã_nhân_viên_chỉnh_sửa` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  UNIQUE KEY `Tên_Loại` (`Tên_Loại`),
  UNIQUE KEY `Sơ_đồ` (`Sơ_đồ`),
  KEY `Mã_nhân_viên_chỉnh_sửa` (`Mã_nhân_viên_chỉnh_sửa`),
  KEY `Mã_nhân_viên_tạo` (`Mã_nhân_viên_tạo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `bus_model`
--

INSERT INTO `bus_model` (`Mã`, `Tên_Loại`, `Loại_ghế`, `Số_ghế`, `Số_hàng`, `Số_cột`, `Sơ_đồ`, `Mã_nhân_viên_tạo`, `Mã_nhân_viên_chỉnh_sửa`, `created_at`, `updated_at`) VALUES
(6, 'Ghe Ngoi', 0, 47, 12, 6, '100000110011110011110011110011110011110011110011110011110011110011111111', 1, 1, '2018-10-24 08:15:10', '2018-10-24 08:15:10'),
(7, 'Giuong Nam', 1, 41, 13, 5, '10000101011010110101101011010111111101011010110101101011010111111', 1, 1, '2018-10-24 08:20:42', '2018-10-24 08:20:42');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chuyen_xe`
--

DROP TABLE IF EXISTS `chuyen_xe`;
CREATE TABLE IF NOT EXISTS `chuyen_xe` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Mã_nhân_viên_tạo` int(11) NOT NULL,
  `Mã_lộ_trình` int(11) NOT NULL,
  `Mã_tài_xế` int(11) NOT NULL,
  `Mã_xe` int(11) NOT NULL,
  `Ngày_xuất_phát` date NOT NULL,
  `Giờ_xuất_phát` time NOT NULL,
  `Trạng_thái` int(11) NOT NULL DEFAULT '0',
  `Tiền_vé` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_del` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`Mã`),
  KEY `Mã_lộ_trình` (`Mã_lộ_trình`),
  KEY `Mã_tài_xế` (`Mã_tài_xế`),
  KEY `Mã_xe` (`Mã_xe`),
  KEY `Mã_nhân_viên_tạo` (`Mã_nhân_viên_tạo`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `chuyen_xe`
--

INSERT INTO `chuyen_xe` (`Mã`, `Mã_nhân_viên_tạo`, `Mã_lộ_trình`, `Mã_tài_xế`, `Mã_xe`, `Ngày_xuất_phát`, `Giờ_xuất_phát`, `Trạng_thái`, `Tiền_vé`, `created_at`, `updated_at`, `is_del`) VALUES
(50, 1, 15, 8, 9, '2023-04-20', '00:00:00', 0, 175000, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0),
(51, 1, 10, 8, 9, '2023-05-25', '12:00:00', 0, 170000, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Tên` varchar(255) DEFAULT NULL,
  `Tên_không_dấu` varchar(255) NOT NULL,
  `Ngày_sinh` date DEFAULT NULL,
  `Giới tính` set('0','1','2') DEFAULT NULL,
  `Địa chỉ` tinytext,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Sđt` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  UNIQUE KEY `Sđt` (`Sđt`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`Mã`, `Tên`, `Tên_không_dấu`, `Ngày_sinh`, `Giới tính`, `Địa chỉ`, `Password`, `Email`, `Sđt`, `created_at`, `updated_at`) VALUES
(37, 'Khách Hàng 2', 'Khach Hang 2', '2000-11-16', '2', 'Long Xuyên', 'e10adc3949ba59abbe56e057f20f883e', 'khachang2@gmail.com', '0338465715', '2023-04-22 07:40:53', '2023-04-22 07:40:53'),
(38, 'Khách Hàng 3', 'Khach Hang 3', '2000-07-20', '1', 'Long Xuyên', 'e10adc3949ba59abbe56e057f20f883e', 'khachhang3@gmail.com', '0335478941', '2023-04-22 07:41:30', '2023-04-22 07:41:30'),
(39, 'Khách Hàng 1', 'Khach Hang 1', '2000-02-17', '1', 'long xuyên', 'e10adc3949ba59abbe56e057f20f883e', 'khachhang1@gmail.com', '0337890541', '2023-05-04 11:06:40', '2023-05-04 11:06:40');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dondatve`
--

DROP TABLE IF EXISTS `dondatve`;
CREATE TABLE IF NOT EXISTS `dondatve` (
  `Mã` varchar(255) NOT NULL,
  `Mã_nhân_viên_đặt` int(11) DEFAULT NULL,
  `Mã_khách_hàng` int(11) NOT NULL,
  `Mã_chuyến_xe` int(11) NOT NULL,
  `Vị_trí_đặt` varchar(255) NOT NULL,
  `Trạng_thái` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `duong_di`
--

DROP TABLE IF EXISTS `duong_di`;
CREATE TABLE IF NOT EXISTS `duong_di` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Mã_Trạm_Start` int(11) NOT NULL,
  `Mã_Trạm_End` int(11) NOT NULL,
  `Tọa_độ_detail` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  KEY `Mã_Trạm_Start` (`Mã_Trạm_Start`),
  KEY `Mã_Trạm_End` (`Mã_Trạm_End`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Họ_Tên` varchar(255) NOT NULL,
  `Ngày_sinh` date NOT NULL,
  `Giới_tính` set('0','1','2') DEFAULT NULL,
  `Địa_chỉ` tinytext NOT NULL,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Loại_NV` set('QTV','QLDV','TX') NOT NULL,
  `Chi_nhánh` varchar(255) DEFAULT NULL,
  `Bằng_lái` varchar(255) DEFAULT NULL,
  `Sđt` varchar(255) NOT NULL,
  `Date_Starting` date NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Sđt` (`Sđt`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `employee`
--

INSERT INTO `employee` (`Mã`, `Họ_Tên`, `Ngày_sinh`, `Giới_tính`, `Địa_chỉ`, `Username`, `Password`, `Email`, `Loại_NV`, `Chi_nhánh`, `Bằng_lái`, `Sđt`, `Date_Starting`, `created_at`, `updated_at`) VALUES
(1, 'Thái Bảo', '2001-04-04', '1', 'Long Xuyên', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@gmail.com', 'QTV', 'Long Xuyên', NULL, '0337890541', '2023-01-01', '2023-04-01 20:02:37', '2023-04-20 09:54:48'),
(8, 'Nguyễn Văn A', '1998-02-20', '1', 'Long Xuyên', 'taixe', 'd41d8cd98f00b204e9800998ecf8427e', 'taixe@gmail.com', 'TX', 'Long Xuyên', '120154789631', '0335478961', '2020-01-20', '2023-04-20 08:41:43', '2023-04-20 08:42:14'),
(9, 'Nhân viên đặt vé', '1999-02-20', '2', 'Long Xuyên', 'datve', 'e10adc3949ba59abbe56e057f20f883e', 'datve@gmail.com', 'QLDV', 'Long Xuyên', NULL, '0338769515', '2020-01-20', '2023-04-20 08:45:28', '2023-04-20 08:45:28');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `gioi_thieu`
--

DROP TABLE IF EXISTS `gioi_thieu`;
CREATE TABLE IF NOT EXISTS `gioi_thieu` (
  `gt_id` int(10) NOT NULL AUTO_INCREMENT,
  `noidung` text CHARACTER SET utf8 NOT NULL,
  `id_admin_created` int(10) NOT NULL,
  `id_admin_changed` int(10) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`gt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `gioi_thieu`
--

INSERT INTO `gioi_thieu` (`gt_id`, `noidung`, `id_admin_created`, `id_admin_changed`, `created_at`, `updated_at`) VALUES
(1, '<p>Ch&agrave;o mừng bạn đến với trang web của ch&uacute;ng t&ocirc;i</p>', 1, 1, '2018-11-15 17:16:18', '2023-04-20 08:15:23');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lienhe`
--

DROP TABLE IF EXISTS `lienhe`;
CREATE TABLE IF NOT EXISTS `lienhe` (
  `lh_id` int(10) NOT NULL AUTO_INCREMENT,
  `ho_ten` varchar(255) CHARACTER SET utf8 NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `dien_thoai` varchar(255) CHARACTER SET utf8 NOT NULL,
  `tieu_de` varchar(255) CHARACTER SET utf8 NOT NULL,
  `noi_dung` text CHARACTER SET utf8 NOT NULL,
  `ngay_dang` datetime NOT NULL,
  `is_checked` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lh_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lo_trinh`
--

DROP TABLE IF EXISTS `lo_trinh`;
CREATE TABLE IF NOT EXISTS `lo_trinh` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Mã_nhân_viên_tạo` int(11) NOT NULL,
  `Mã_nhân_viên_chỉnh_sửa` int(11) NOT NULL,
  `Nơi_đi` varchar(255) NOT NULL,
  `Nơi_đến` varchar(255) NOT NULL,
  `Các_trạm_dừng_chân` varchar(255) NOT NULL,
  `Thời_gian_đi_dự_kiến` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  KEY `Mã_nhân_viên_chỉnh_sửa` (`Mã_nhân_viên_chỉnh_sửa`),
  KEY `Mã_nhân_viên_tạo` (`Mã_nhân_viên_tạo`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `lo_trinh`
--

INSERT INTO `lo_trinh` (`Mã`, `Mã_nhân_viên_tạo`, `Mã_nhân_viên_chỉnh_sửa`, `Nơi_đi`, `Nơi_đến`, `Các_trạm_dừng_chân`, `Thời_gian_đi_dự_kiến`, `created_at`, `updated_at`) VALUES
(10, 1, 1, 'TP. Hồ Chí Minh (TPHCM)', 'An Giang (Long Xuyên)', '4', 18000, '2023-04-20 08:46:46', '2023-04-20 08:46:46'),
(11, 1, 1, 'An Giang (Châu Đốc)', 'TP. Hồ Chí Minh (TPHCM)', '4', 21600, '2023-04-20 08:47:43', '2023-04-20 08:47:43'),
(12, 1, 1, 'Cần Thơ (Cần Thơ)', 'TP. Hồ Chí Minh (TPHCM)', '5', 14400, '2023-04-20 08:48:33', '2023-04-20 08:48:33'),
(13, 1, 1, 'TP. Hồ Chí Minh (TPHCM)', 'Đà Lạt (Đà Lạt)', '6', 28800, '2023-04-20 08:50:53', '2023-04-20 08:50:53'),
(14, 1, 1, 'An Giang (Châu Đốc)', 'An Giang (Long Xuyên)', '4', 7200, '2023-04-20 08:51:13', '2023-04-20 08:51:13'),
(15, 1, 1, 'An Giang (Long Xuyên)', 'TP. Hồ Chí Minh (TPHCM)', '4', 18000, '2023-04-20 08:51:46', '2023-04-20 08:52:01');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `news_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `image` varchar(255) NOT NULL,
  `introduce` text CHARACTER SET utf8 NOT NULL,
  `content` longtext CHARACTER SET utf8 NOT NULL,
  `check_slide` int(11) NOT NULL,
  `id_admin_created` int(10) NOT NULL,
  `id_admin_changed` int(10) NOT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`news_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Đang đổ dữ liệu cho bảng `news`
--

INSERT INTO `news` (`news_id`, `title`, `image`, `introduce`, `content`, `check_slide`, `id_admin_created`, `id_admin_changed`, `is_disabled`, `created_at`, `updated_at`) VALUES
(5, 'Chuyển Tuyến Hải Phòng ↔ Hồ Chí Minh, Vũng Tàu Về Bến Thượng Lý - Hải Phòng Từ 22/11/2017', 'tintuc3.jpg', 'Thông báo chuyển về BẾN XE THƯỢNG LÝ-HẢI PHÒNG từ 22/11/2017\r\nBẾN XE THƯỢNG LÝ: SỐ 52 ĐƯỜNG HÀ NỘI (SỞ DẦU) - HỒNG BÀNG.', '<p>Xe kh&aacute;ch Ho&agrave;ng Long k&iacute;nh b&aacute;o tới qu&yacute; kh&aacute;ch h&agrave;ng chuyển bến xe từ 22/11/2017 :<br />\r\n- Theo sự động vi&ecirc;n, định hướng từ Ủy Ban nh&acirc;n d&acirc;n Th&agrave;nh phố v&agrave; quy hoạch của Sở giao th&ocirc;ng vận tải Hải Ph&ograve;ng.</p>\r\n\r\n<p>- Kể từ 22/11/2017, Xe kh&aacute;ch Ho&agrave;ng Long chuyển to&agrave;n bộ tuyến đi c&aacute;c tỉnh miền trung, miền nam từ bến xe Niệm Nghĩa về BẾN XE THƯỢNG L&Yacute; :</p>\r\n\r\n<p><strong>Hải Ph&ograve;ng &harr;&nbsp;HỒ CH&Iacute; MINH<br />\r\nHải Ph&ograve;ng &harr; VŨNG T&Agrave;U&nbsp;<br />\r\nHải Ph&ograve;ng &harr; Đ&Agrave; NẴNG</strong></p>\r\n\r\n<p>C&aacute;c tuyến đi tới c&aacute;c tỉnh, th&agrave;nh phố tr&ecirc;n to&agrave;n Quốc như:&nbsp;<br />\r\n<em><strong>Ninh B&igrave;nh &rarr; Thanh H&oacute;a &rarr; Vinh, Nghệ An&rarr; H&agrave; Tĩnh &rarr; Đồng Hới, Quảng B&igrave;nh &rarr; Quảng Trị&nbsp;&rarr; Huế &rarr; Quảng Nam &rarr; Quảng Ng&atilde;i &rarr; B&igrave;nh Đ&igrave;nh, Quy Nhơn, Ph&uacute; Y&ecirc;n &rarr; Nha Trang, Cam Ranh,Kh&aacute;nh H&ograve;a &rarr; Phan Rang, Phan Thiết, B&igrave;nh Thuận &rarr; Đồng Nai &hellip; cũng sẽ xuất ph&aacute;t tại Bến xe Thượng L&yacute; v&agrave; ngược lại.&nbsp;</strong></em><br />\r\n- Ho&agrave;ng Long hiện đ&atilde; mở th&ecirc;m văn ph&ograve;ng chuyển ph&aacute;t nhanh h&agrave;ng h&oacute;a, b&aacute;n v&eacute; c&aacute;c tuyến ngắn v&agrave; tuyến miền trung, miền nam tại vị tr&iacute;&nbsp;<strong>cổng ch&iacute;nh Bến xe Thượng L&yacute;</strong>.<br />\r\n- Mọi hoạt động kh&aacute;c của xe kh&aacute;ch Ho&agrave;ng Long tr&ecirc;n địa b&agrave;n Hải Ph&ograve;ng kh&ocirc;ng thay đổi.&nbsp;<br />\r\n- Tuyến Hải Ph&ograve;ng- H&agrave; Nội vẫn hoạt động b&igrave;nh thường tại bến xe Niệm Nghĩa.</p>\r\n\r\n<p>- Mọi chi tiết xin li&ecirc;n hệ tổng đ&agrave;i<strong>&nbsp;02253.920.920&nbsp;</strong>24/7 Ho&agrave;ng Long sẽ tư vấn trực tiếp đến qu&yacute; kh&aacute;ch.</p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/tintuc3.jpg\" style=\"height:638px; width:960px\" /></p>', 1, 1, 1, 0, '2018-11-15 10:17:40', '2023-04-20 08:54:10'),
(17, 'Đà Lạt – Thiên đường du lịch nghỉ dưỡng của Việt Nam', 'canh-dep-da-lat.jpg', 'Đà Lạt là một thành phố trực thuộc tỉnh và tỉnh lị tỉnh Lâm Đồng, nằm trên cao nguyên Lâm Viên, ở độ cao 1.500 m so với mặt nước biển và diện tích tự nhiên: 393,29 km².\r\nVới nhiều cảnh quan đẹp, Đà Lạt là một trong những thành phố du lịch nổi tiếng nhất của Việt Nam. Trong thời Pháp thuộc, tên tiếng Latin Dat Aliis Laetitiam Aliis Temperiem có nghĩa là “cho những người này niềm vui, cho những người khác sự mát mẻ”. Đà Lạt được mệnh danh là : thành phố hoa, thành phố tình yêu, thành phố mùa xuân, thành phố sương mù.', '<p><strong>1. Giới thiệu:</strong><br />\r\nĐ&agrave; Lạt l&agrave; một th&agrave;nh phố trực thuộc tỉnh v&agrave; tỉnh lị tỉnh L&acirc;m Đồng, nằm tr&ecirc;n cao nguy&ecirc;n L&acirc;m Vi&ecirc;n, ở độ cao 1.500 m so với mặt nước biển v&agrave; diện t&iacute;ch tự nhi&ecirc;n: 393,29 km&sup2;.<br />\r\nVới nhiều cảnh quan đẹp, Đ&agrave; Lạt l&agrave; một trong những th&agrave;nh phố du lịch nổi tiếng nhất của Việt Nam. Trong thời Ph&aacute;p thuộc, t&ecirc;n tiếng Latin Dat Aliis Laetitiam Aliis Temperiem c&oacute; nghĩa l&agrave; &ldquo;cho những người n&agrave;y niềm vui, cho những người kh&aacute;c sự m&aacute;t mẻ&rdquo;. Đ&agrave; Lạt được mệnh danh l&agrave; : th&agrave;nh phố hoa, th&agrave;nh phố t&igrave;nh y&ecirc;u, th&agrave;nh phố m&ugrave;a xu&acirc;n, th&agrave;nh phố sương m&ugrave;.</p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/anh%201.jpg\" style=\"height:591px; width:739px\" /></p>\r\n\r\n<p><strong>2. Vị tr&iacute; địa l&yacute;:</strong></p>\r\n\r\n<p>Th&agrave;nh phố Đ&agrave; Lạt nằm trong cao nguy&ecirc;n Lang Biang, ph&iacute;a Bắc tỉnh L&acirc;m Đồng, Về ph&iacute;a Bắc, Đ&agrave; Lạt gi&aacute;p với huyện Lạc Dương, về ph&iacute;a Đ&ocirc;ng v&agrave; Đ&ocirc;ng Nam gi&aacute;p với huyện Đơn Dương, về ph&iacute;a T&acirc;y v&agrave; T&acirc;y Nam gi&aacute;p với hai huyện L&acirc;m H&agrave; v&agrave; Đức Trọng.<br />\r\nH&agrave;ng trăm năm trước đ&acirc;y, Đ&agrave; Lạt l&agrave; địa b&agrave;n cư tr&uacute; của người Lạch, vốn l&agrave; cư d&acirc;n của to&agrave;n bộ cao nguy&ecirc;n Lang Biang. Đ&agrave; Lạt c&oacute; diện t&iacute;ch hơn 400 km&sup2;, bao bọc bởi c&aacute;c đỉnh n&uacute;i cao v&agrave; d&atilde;y n&uacute;i li&ecirc;n tiếp:</p>\r\n\r\n<p>a/ Ph&iacute;a Bắc v&agrave; T&acirc;y Bắc giới hạn bởi d&atilde;y Chorơmui, Yộ Đa Myut (1.816 m), T&acirc;y Bắc dựa v&agrave;o ch&acirc;n d&atilde;y n&uacute;i Chư Yang Kae (1.921 m), thuộc quần sơn Lang Biang m&agrave; đỉnh cao nhất l&agrave; Chư Yang Sinh (1.408 m).<br />\r\nb/ Ph&iacute;a Đ&ocirc;ng l&agrave; ch&acirc;n d&atilde;y n&uacute;i Bi Doup (2.278 m) dốc xuống cao nguy&ecirc;n Dran.<br />\r\nc/ Ph&iacute;a Đ&ocirc;ng Nam chắn bởi d&atilde;y Cho Proline (1.629 m).<br />\r\nd/ Ph&iacute;a Nam v&agrave; T&acirc;y Nam c&oacute; d&atilde;y n&uacute;i Voi (1.754 m) v&agrave; Y&agrave;ng Sơreng bao bọc. Địa h&igrave;nh: Cao trung b&igrave;nh so với mặt biển l&agrave; 1.500 m. Nơi cao nhất trong trung t&acirc;m th&agrave;nh phố l&agrave; Nh&agrave; Bảo T&agrave;ng (1.532 m), nơi thấp nhất l&agrave; thung lũng Nguyễn Tri Phương (1.398,2 m).</p>\r\n\r\n<p>B&ecirc;n trong cao nguy&ecirc;n, địa h&igrave;nh Đ&agrave; Lạt ph&acirc;n th&agrave;nh hai bậc r&otilde; rệt:<br />\r\n+ Bậc địa h&igrave;nh thấp l&agrave; v&ugrave;ng trung t&acirc;m c&oacute; dạng như một l&ograve;ng chảo bao gồm c&aacute;c d&atilde;y đồi đỉnh tr&ograve;n, dốc thoải c&oacute; độ cao tương đối 25-100 m, lượn s&oacute;ng nhấp nh&ocirc;, độ ph&acirc;n cắt yếu, độ cao trung b&igrave;nh khoảng 1.500 m.<br />\r\n+ Bao quanh khu vực l&ograve;ng chảo n&agrave;y l&agrave; c&aacute;c đỉnh n&uacute;i với độ cao khoảng 1.700 m tạo th&agrave;nh v&agrave;nh đai che chắn gi&oacute; cho v&ugrave;ng trung t&acirc;m. Ph&iacute;a Đ&ocirc;ng Bắc c&oacute; hai n&uacute;i thấp: h&ograve;n &Ocirc;ng (L&aacute;p B&ecirc; Bắc 1.738 m) v&agrave; h&ograve;n Bộ (L&aacute;p B&ecirc; Nam 1.709 m). Ở ph&iacute;a Bắc, ngự trị cao nguy&ecirc;n Lang Biang l&agrave; d&atilde;y n&uacute;i B&agrave; (Lang Biang) h&ugrave;ng vĩ, cao 2.169 m, k&eacute;o d&agrave;i theo trục Đ&ocirc;ng Bắc &ndash; T&acirc;y Nam từ suối Đa Sar (đổ v&agrave;o Đa Nhim) đến Đa Me (đổ v&agrave;o Đạ Đờng). Ph&iacute;a Đ&ocirc;ng &aacute;n ngữ bởi d&atilde;y n&uacute;i đỉnh Gi&oacute; H&uacute; (1.644 m). Về ph&iacute;a T&acirc;y Nam, c&aacute;c d&atilde;y n&uacute;i hướng v&agrave;o T&agrave; Nung giữa d&atilde;y Y&agrave;ng Sơreng m&agrave; c&aacute;c đỉnh cao ti&ecirc;u biểu l&agrave; Pin Hatt (1.691 m) v&agrave; You Lou Rouet (1.632 m).</p>\r\n\r\n<p>B&ecirc;n ngo&agrave;i cao nguy&ecirc;n l&agrave; c&aacute;c dốc n&uacute;i từ hơn 1.700 m đột ngột đổ xuống c&aacute;c cao nguy&ecirc;n b&ecirc;n dưới c&oacute; độ cao từ 700 m đến 900 m.</p>\r\n\r\n<p>Kh&iacute; hậu: Do ảnh hưởng của độ cao v&agrave; rừng th&ocirc;ng bao bọc, Đ&agrave; Lạt mang nhiều đặc t&iacute;nh của miền &ocirc;n đới. Nhiệt độ trung b&igrave;nh 18&ndash;21&deg;C, nhiệt độ cao nhất chưa bao giờ qu&aacute; 30&deg;C v&agrave; thấp nhất kh&ocirc;ng dưới 5&deg;C.<br />\r\nCh&iacute;nh th&ocirc;ng Đ&agrave; Lạt gi&uacute;p cho Đ&agrave; Lạt th&ecirc;m phần m&aacute;t mẻ</p>\r\n\r\n<p>Đ&agrave; Lạt c&oacute; hai m&ugrave;a r&otilde; rệt. M&ugrave;a mưa từ th&aacute;ng 5 đến th&aacute;ng 10, m&ugrave;a nắng từ th&aacute;ng 11 đến th&aacute;ng 4. M&ugrave;a h&egrave; thường c&oacute; mưa v&agrave;o buổi chiều, đ&ocirc;i khi c&oacute; mưa đ&aacute;.<br />\r\nLượng mưa trung b&igrave;nh năm l&agrave; 1562 mm v&agrave; độ ẩm 82%.<br />\r\nĐ&agrave; Lạt kh&ocirc;ng bao giờ c&oacute; b&atilde;o, chỉ c&oacute; gi&oacute; lớn do ảnh hưởng b&atilde;o từ biển thổi v&agrave;o v&igrave; sườn đ&ocirc;ng kh&ocirc;ng c&oacute; n&uacute;i che chắn.</p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/anh%202.jpg\" style=\"height:759px; width:1024px\" /></p>\r\n\r\n<p><strong>3. Tiềm năng du lịch:</strong></p>\r\n\r\n<p>Được v&iacute; như một Tiểu Paris, Đ&agrave; Lạt từng mộng mơ v&agrave; n&ecirc;n thơ nhờ c&aacute;i lạnh cao nguy&ecirc;n ban đ&ecirc;m, sương m&ugrave; buổi sớm v&agrave; những dải rừng th&ocirc;ng bao quanh th&agrave;nh phố. Kh&ocirc;ng gian n&agrave;y tuy vậy đ&atilde; phần n&agrave;o bị mất đi c&aacute;i chất Ph&aacute;p trong c&aacute;c kiến tr&uacute;c biệt thự thiếu chăm s&oacute;c hay bị sửa đổi kh&ocirc;ng ph&ugrave; hợp.<br />\r\nDu lịch tuy l&agrave; một thế mạnh song cũng l&agrave; yếu tố l&agrave;m thay đổi Đ&agrave; Lạt theo hướng đ&ocirc; thị h&oacute;a.</p>\r\n\r\n<p>Đồi C&ugrave; nằm giữa trung t&acirc;m th&agrave;nh phố Đ&agrave; Lạt nằm kế b&ecirc;n l&agrave; Hồ Xu&acirc;n Hương do vậy thường được nhắc đến như một địa danh d&iacute;nh liền nhau &ndash; nhiều người cho rằng Đ&agrave; Lạt sẽ k&eacute;m phần mỹ lệ nếu thiếu Đồi C&ugrave; v&agrave; hồ Xu&acirc;n Hương. Năm 1942, khi thiết kế đồ &aacute;n quy hoạch th&agrave;nh phố Đ&agrave; Lạt, kiến tr&uacute;c sư Lagisquet đ&atilde; khoanh v&ugrave;ng Đồi C&ugrave; như một khu vực bất khả x&acirc;m phạm nhằm tạo một tầm nh&igrave;n tho&aacute;ng đ&atilde;ng cho Đ&agrave; Lạt. Về sau, một kiến tr&uacute;c sư người Anh đ&atilde; thiết kế biến Đồi C&ugrave; th&agrave;nh s&acirc;n golf 9 lỗ kh&aacute; nổi tiếng của v&ugrave;ng Đ&ocirc;ng Nam &Aacute; v&agrave; hiện nay Đồi C&ugrave; đ&atilde; được n&acirc;ng cấp th&agrave;nh s&acirc;n golf 18 lỗ. T&ecirc;n Đồi C&ugrave; kh&ocirc;ng r&otilde; c&oacute; từ bao giờ, v&agrave; v&igrave; sao gọi l&agrave; &ldquo;Đồi C&ugrave;&rdquo; lại c&oacute; hai hướng l&yacute; giải, c&oacute; người cho rằng những quả đồi thoai thoải nơi đ&acirc;y khi nh&igrave;n từ xa giống như tấm lưng trần của những con c&ugrave; khổng lồ n&ecirc;n đ&atilde; v&iacute; von gọi l&agrave; &ldquo;Đồi C&ugrave;&rdquo;; cũng c&oacute; người giải th&iacute;ch sở dĩ c&oacute; t&ecirc;n &ldquo;Đồi C&ugrave;&rdquo; v&igrave; nơi đ&acirc;y l&agrave; một địa điểm chơi golf hay c&ograve;n gọi l&agrave; đ&aacute;nh c&ugrave;.</p>\r\n\r\n<p>Hồ Xu&acirc;n Hương nằm ngay trung t&acirc;m th&agrave;nh phố Đ&agrave; Lạt v&agrave; b&ecirc;n cạnh Đồi C&ugrave;. Hồ thực chất l&agrave; hồ nh&acirc;n tạo được x&acirc;y dựng v&agrave;o năm 1919 do s&aacute;ng kiến của Cunhac. Để tạo th&agrave;nh hồ, người ta đắp một c&aacute;i đập chắn d&ograve;ng suối chảy qua thung lũng, hồ c&oacute; diện t&iacute;ch mặt nước rộng 25 ha, chu vi d&agrave;i 5,1 km. Xung quanh hồ nhiều kiến tr&uacute;c độc đ&aacute;o c&oacute; gi&aacute; trị nghệ thuật, thẩm mỹ cao được x&acirc;y dựng như kh&aacute;ch sạn Palace, thao trường L&acirc;m Vi&ecirc;n, nh&agrave; nghỉ C&ocirc;ng Đo&agrave;n, Nh&agrave; h&agrave;ng Thanh Thủy, Thủy Tạ&hellip; Trước kia hồ c&oacute; t&ecirc;n gọi Grand Lac (hồ lớn). V&agrave;o buổi s&aacute;ng sớm sương m&ugrave; hiện l&ecirc;n rất đẹp v&agrave; thơ mộng.</p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/anh%203.jpg\" style=\"height:368px; width:550px\" /></p>\r\n\r\n<p>Hồ Suối V&agrave;ng l&agrave; hồ nước ngọt lớn nhất tại Đ&agrave; Lạt, cung cấp nước sinh hoạt cho th&agrave;nh phố qua đập tr&agrave;n của c&ocirc;ng ty cấp nước Đ&agrave; Lạt. Thung lũng Suối V&agrave;ng c&ograve;n l&agrave; điểm đến du lịch nổi tiếng với vườn hoa v&agrave; rừng th&ocirc;ng.</p>\r\n\r\n<p>C&ocirc;ng vi&ecirc;n hoa Đ&agrave; Lạt nằm quanh tr&ecirc;n bờ ph&iacute;a Bắc của hồ Xu&acirc;n Hương, tr&ecirc;n thung lũng của Đồi C&ugrave;. Trước đ&acirc;y c&ocirc;ng vi&ecirc;n hoa Đ&agrave; Lạt c&oacute; t&ecirc;n l&agrave; B&iacute;ch C&acirc;u, hiện nay diện t&iacute;ch của c&ocirc;ng vi&ecirc;n hoa được mở rộng tới 7000 m&sup2;, với c&aacute;ch bố tr&iacute; tho&aacute;ng đ&atilde;ng, tạo ấn tượng cho người chợt gh&eacute;. C&aacute;c loại hoa v&agrave; c&acirc;y cảnh nổi tiếng của Đ&agrave; Lạt được trồng tỉa chăm s&oacute;c chu đ&aacute;o, cảnh sắc tươi m&aacute;t, phong ph&uacute; bốn m&ugrave;a. H&agrave;ng năm thường tổ chức lễ hội hoa v&agrave; l&agrave; th&ocirc;ng điệp nhằm mời gọi, thu h&uacute;t c&aacute;c nh&agrave; đầu tư trong nước v&agrave; nước ngo&agrave;i ph&aacute;t triển Đ&agrave; Lạt v&agrave; c&aacute;c v&ugrave;ng phụ cận trở th&agrave;nh trung t&acirc;m sản xuất, xuất khẩu hoa của cả nước v&agrave; khu vực Đ&ocirc;ng Nam &Aacute;.</p>\r\n\r\n<p>C&aacute;c điểm tham quan du lịch kh&aacute;c:</p>\r\n\r\n<ul>\r\n	<li>Đỉnh Lang Biang</li>\r\n	<li>Hồ Than Thở</li>\r\n	<li>Th&aacute;c Cam Ly</li>\r\n	<li>Th&aacute;c Datanla</li>\r\n	<li>Th&aacute;c Hang Cọp</li>\r\n	<li>Th&aacute;c Prenn</li>\r\n	<li>Th&aacute;c Pongour</li>\r\n	<li>Thung lũng T&igrave;nh Y&ecirc;u</li>\r\n	<li>Đồi Mộng Mơ.</li>\r\n	<li>Thung Lũng V&agrave;ng (gần Hồ Dan Kia)</li>\r\n	<li>Hồ Tuyền L&acirc;m</li>\r\n	<li>Khu Biệt thự Trần Lệ Xu&acirc;n&nbsp;</li>\r\n</ul>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/dalat/anh%204.jpg\" style=\"height:768px; width:1024px\" /></p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/dalat/anh%205.jpg\" style=\"height:529px; width:800px\" /></p>', 1, 1, 1, 0, '2018-11-30 18:01:04', '2018-11-30 18:01:04'),
(20, 'Quảng Ngãi - Thành Phố Anh Hùng', 'quang ngai.jpg', 'Là tỉnh ven biển nằm trong vùng kinh tế trọng điểm của miền Trung, Quảng Ngãi hội đủ nhiều yếu tố hấp dẫn để các nhà đầu tư an tâm khi đầu tư vào đây, đó là Quảng Ngãi nằm giữa hai đầu Bắc- Nam, vừa có cảng biển, vừa có đường quốc lộ, vừa có đường sắt Bắc-Nam, cùng với những chính sách ưu đãi đầu tư đặc biệt từ Chính phủ và của địa phương. Chính vì vậy Quảng Ngãi là địa điểm lý tưởng cho các công ty muốn mở rộng thị trường đến đến cả hai miền Nam - Bắc và khu vực miền Trung rộng lớn. Ngoài ra, từ Quảng Ngãi, các doanh nghiệp có thể mở rộng tiếp cận thị trường sang Lào, đông bắc Thái Lan và Campuchia', '<p><strong>Ng&agrave;y nay, Quảng Ng&atilde;i đ&atilde; vươn l&ecirc;n trở th&agrave;nh một trong 13 tỉnh c&oacute; đ&oacute;ng g&oacute;p ng&acirc;n s&aacute;ch lớn nhờ c&oacute; Nh&agrave; m&aacute;y Lọc dầu Dung Quất &ndash; nh&agrave; m&aacute;y lọc h&oacute;a dầu đầu ti&ecirc;n của Việt Nam v&agrave; Khu kinh tế (KKT) Dung Quất, một trong những KKT ti&ecirc;n phong v&agrave; th&agrave;nh c&ocirc;ng nhất trong cả nước, g&oacute;p phần lớn cho việc ph&aacute;t triển trong khu vực kinh tế trọng điểm miền Trung.</strong></p>\r\n\r\n<p><strong><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/QuangNgai/qn1.jpg\" style=\"height:382px; width:650px\" /></strong></p>\r\n\r\n<p><strong>ĐIỀU KIỆN TỰ NHI&Ecirc;N V&Agrave; CƠ SỞ HẠ TẦNG</strong><br />\r\n<br />\r\n<strong>Địa l&yacute; h&agrave;nh ch&iacute;nh</strong></p>\r\n\r\n<p>Quảng Ng&atilde;i trải d&agrave;i từ 14&deg;32&rsquo; đến 15&deg;25&rsquo; vĩ độ Bắc, từ 108&deg;06&rsquo; đến 109&deg;04&rsquo; kinh độ Đ&ocirc;ng; ph&iacute;a bắc gi&aacute;p tỉnh Quảng Nam, ph&iacute;a nam gi&aacute;p tỉnh B&igrave;nh Định, ph&iacute;a t&acirc;y gi&aacute;p tỉnh Kon Tum, ph&iacute;a đ&ocirc;ng gi&aacute;p biển Đ&ocirc;ng, c&aacute;ch thủ đ&ocirc; H&agrave; Nội 883 km về ph&iacute;a bắc v&agrave; th&agrave;nh phố Hồ Ch&iacute; Minh 838 km về ph&iacute;a nam. Diện t&iacute;ch tự nhi&ecirc;n khoảng 5.152,67 km&sup2;, bao gồm 1 th&agrave;nh phố trực thuộc tỉnh (th&agrave;nh phố Quảng Ng&atilde;i), 6 huyện đồng bằng ven biển (B&igrave;nh Sơn, Sơn Tịnh, Tư Nghĩa, Nghĩa H&agrave;nh, Mộ Đức, Đức Phổ), 6 huyện miền n&uacute;i (Ba Tơ, Tr&agrave; Bồng, T&acirc;y Tr&agrave;, Sơn T&acirc;y, Sơn H&agrave;, Minh Long) v&agrave; 1 huyện đảo (L&yacute; Sơn).<br />\r\n<br />\r\n<strong>D&acirc;n số, d&acirc;n cư</strong></p>\r\n\r\n<p>D&acirc;n số Quảng Ng&atilde;i năm 2013 l&agrave; 1,236 triệu người, với mật độ d&acirc;n số trung b&igrave;nh 237 người/km&sup2;. Đ&acirc;y l&agrave; địa b&agrave;n sinh sống của nhiều tộc người kh&aacute;c nhau; trong đ&oacute; chiếm đa số l&agrave; người Kinh (88%), Hre (8,58%), Cor (1,8%)&hellip;<br />\r\n<br />\r\n<strong>Giao th&ocirc;ng vận tải</strong></p>\r\n\r\n<p><em><strong>1. Đường bộ:</strong></em></p>\r\n\r\n<p>Quốc lộ 1A: đoạn chạy qua tỉnh: 98km</p>\r\n\r\n<p>Quốc lộ 24A: Nối liền Quốc lội 1A (đoạn qua Thạch Trụ, huyện Mộ Đức, tỉnh Quảng Ng&atilde;i) với KonTum d&agrave;i 69km v&agrave; Quốc lộ 24B d&agrave;i 18km.</p>\r\n\r\n<p>Đường Đ&ocirc;ng Trường Sơn đi qua 02 x&atilde; Sơn M&ugrave;a v&agrave; Sơn Bua, huyện Sơn T&acirc;y với tổng chiều d&agrave;i 13 km</p>\r\n\r\n<p>Tỉnh lộ: Gồm 18 tuyến với tổng chiều d&agrave;i 520,5km</p>\r\n\r\n<p>Đường ven biển Dung Quất- Sa Huỳnh đi qua c&aacute;c huyện B&igrave;nh Sơn, Sơn Tịnh, Tư Nghĩa, Mộ Đức, Đức Phổ v&agrave; th&agrave;nh phố Quảng Ng&atilde;i, với chiều d&agrave;i khoảng 117 Km. C&oacute; điểm đầu tại ranh giữa hai tỉnh Quảng Nam v&agrave; Quảng Ng&atilde;i thuộc Khu kinh tế Dung Quất v&agrave; điểm cuối giao với Quốc lộ 1A tại Km1116 thuộc Sa Huỳnh, huyện Đức Phổ. Đ&acirc;y l&agrave; tuyến đường g&oacute;p phần quan trọng khơi dậy tiềm năng vừa ph&aacute;t triển kinh tế - x&atilde; hội dọc v&ugrave;ng ven biển, n&acirc;ng cao đời sống người d&acirc;n, vừa gắn với củng cố, tăng cường tiềm lực quốc ph&ograve;ng - an ninh ở khu vực n&agrave;y.</p>\r\n\r\n<p>Đường nội KKT Dung Quất: c&oacute; tổng chiều d&agrave;i tr&ecirc;n 60km. Hiện tiếp tục đầu tư x&acirc;y dựng ho&agrave;n th&agrave;nh c&aacute;c tuyến đường như: đường Dung Quất nối với đường Hồ Ch&iacute; Minh theo hướng Tr&agrave; My - Tr&agrave; Bồng - B&igrave;nh Long - Ng&atilde; ba Nh&agrave; m&aacute;y lọc dầu - cảng Dung Quất. Quy hoạch v&agrave; x&acirc;y dựng tuyến đường Trị B&igrave;nh - cảng Dung Quất v&agrave; một số tuyến đường trục ch&iacute;nh của đ&ocirc; thị Vạn Tường.<br />\r\n<em><strong>&nbsp;<br />\r\n2. Đường Sắt:</strong></em></p>\r\n\r\n<p>Tuyến đường sắt Bắc - Nam: chạy suốt chiều d&agrave;i tỉnh.</p>\r\n\r\n<p><em><strong>3. Đường h&agrave;ng kh&ocirc;ng:&nbsp;&nbsp;</strong></em></p>\r\n\r\n<p>S&acirc;n bay Chu Lai (Tỉnh Quảng Nam) c&aacute;ch Th&agrave;nh phố Quảng Ng&atilde;i 35km, c&aacute;ch Khu kinh tế Dung Quất 04km về hướng Bắc.</p>\r\n\r\n<p>&nbsp;<strong>4. Hệ thống cảng biển:&nbsp;</strong></p>\r\n\r\n<p>Cảng biển nước s&acirc;u Dung Quất: với lợi thế k&iacute;n gi&oacute;, c&aacute;ch tuyến h&agrave;ng hải quốc tế 90km, tuyến nội hải 30km v&agrave; độ s&acirc;u từ 10-19m, cảng Dung Quất đ&atilde; được thiết kế với hệ thống cảng đa chức năng gồm:</p>\r\n\r\n<p>-&nbsp;&nbsp;&nbsp; Khu cảng Dầu kh&iacute; với lượng h&agrave;ng h&oacute;a th&ocirc;ng qua l&agrave; 6,1 triệu tấn dầu sản phẩm/năm v&agrave; x&acirc;y dựng 01 bến phao để nhập dầu th&ocirc; cho t&agrave;u dầu c&oacute; trọng tải từ 80.000 tấn - 110.000 tấn tại vịnh Việt Thanh; cảng chuy&ecirc;n d&ugrave;ng gắn với Khu c&ocirc;ng nghiệp li&ecirc;n hợp t&agrave;u thủy, khu x&acirc;y dựng Nh&agrave; m&aacute;y Luyện c&aacute;n th&eacute;p v&agrave; c&aacute;c Nh&agrave; m&aacute;y C&ocirc;ng nghiệp nặng.</p>\r\n\r\n<p>-&nbsp;&nbsp;&nbsp; Cảng tổng hợp được chia th&agrave;nh 2 ph&acirc;n khu cảng: ph&acirc;n khu cảng Tổng hợp 1 ở ngay sau Khu cảng Dầu kh&iacute;, đảm bảo cho c&aacute;c t&agrave;u c&oacute; trọng tải từ 5.000 tấn - 50.000 tấn ra v&agrave;o; ph&acirc;n khu cảng Tổng hợp 2 ở ph&iacute;a Nam vịnh Dung Quất, b&ecirc;n tả s&ocirc;ng Đập.</p>\r\n\r\n<p>-&nbsp;&nbsp;&nbsp; &nbsp;Khu cảng Chuy&ecirc;n d&ugrave;ng gắn với Khu c&ocirc;ng nghiệp li&ecirc;n hợp t&agrave;u thủy, khu x&acirc;y dựng Nh&agrave; m&aacute;y Luyện c&aacute;n th&eacute;p v&agrave; c&aacute;c Nh&agrave; m&aacute;y C&ocirc;ng nghiệp nặng.</p>\r\n\r\n<p>-&nbsp;&nbsp;&nbsp; &nbsp;Khu cảng Thương mại phục vụ cho Khu bảo thuế v&agrave; 01 cảng trung chuyển container quốc tế nằm tại vị tr&iacute; giữa Khu cảng Chuy&ecirc;n d&ugrave;ng v&agrave; Khu cảng Tổng hợp để đ&oacute;n t&agrave;u c&oacute; trọng tải từ 10 - 15 vạn DWT.&nbsp;<br />\r\n&nbsp;<br />\r\nCảng Dung Quất được đầu tư x&acirc;y dựng để bảo đảm khối lượng h&agrave;ng h&oacute;a th&ocirc;ng qua khoảng 20 triệu tấn/năm v&agrave;o năm 2010 v&agrave; khoảng 34 triệu tấn/năm v&agrave;o năm 2020 Hiện nay đang vận h&agrave;nh bến tổng hợp cho t&agrave;u 1,5 vạn DWT.<br />\r\n&nbsp;<br />\r\n* Ngo&agrave;i ra, với bờ biển d&agrave;i 144 km, Quảng Ng&atilde;i c&oacute; nhiều cửa biển, cảng biển nhỏ như: Sa Kỳ, Sa Cần, B&igrave;nh Ch&acirc;u, Mỹ &Aacute;,&hellip; c&oacute; tiềm năng về giao th&ocirc;ng đường thủy, thương mại v&agrave; du lịch</p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/QuangNgai/qn2.jpg\" style=\"height:1200px; width:1599px\" /></p>\r\n\r\n<p><strong>T&Agrave;I NGUY&Ecirc;N THI&Ecirc;N NHI&Ecirc;N V&Agrave; TIỀM NĂNG PH&Aacute;T TRIỂN</strong></p>\r\n\r\n<p><strong>T&agrave;i nguy&ecirc;n đất</strong></p>\r\n\r\n<p>Theo kết quả điều tra x&acirc;y dựng bản đồ đất thuộc hệ thống ph&acirc;n loại của FAO - UNESCO, tr&ecirc;n diện t&iacute;ch 513.688,14 ha, Quảng Ng&atilde;i c&oacute; 9 nh&oacute;m đất ch&iacute;nh với 25 đơn vị đất v&agrave; 68 đơn vị đất phụ. Ch&iacute;n nh&oacute;m đất ch&iacute;nh l&agrave;: cồn c&aacute;t, đất c&aacute;t ven biển, đất mặn, đất ph&ugrave; sa, đất gi&acirc;y, đất x&aacute;m, đất đỏ v&agrave;ng, đất đen, đất nứt nẻ, đất x&oacute;i m&ograve;n trơ trọi đ&aacute;. Trong đ&oacute;, nh&oacute;m đất x&aacute;m c&oacute; vị tr&iacute; quan trọng (chiếm 74,65% diện t&iacute;ch đất tự nhi&ecirc;n) th&iacute;ch hợp với c&acirc;y c&ocirc;ng nghiệp d&agrave;i ng&agrave;y, c&acirc;y đặc sản, dược liệu, chăn nu&ocirc;i gia s&uacute;c v&agrave; nh&oacute;m đất ph&ugrave; sa thuộc hạ lưu c&aacute;c s&ocirc;ng (chiếm 19,3% diện t&iacute;ch đất tự nhi&ecirc;n), th&iacute;ch hợp với trồng l&uacute;a, c&acirc;y c&ocirc;ng nghiệp ngắn ng&agrave;y, rau đậu.</p>\r\n\r\n<p>Diện t&iacute;ch đất của Quảng Ng&atilde;i được sử dụng gồm 322.034,59 ha đất n&ocirc;ng nghiệp (62,5% diện t&iacute;ch đất tự nhi&ecirc;n), 45.636,2 ha đất phi n&ocirc;ng nghiệp (8,86% diện t&iacute;ch đất tự nhi&ecirc;n) v&agrave; 147.595,9ha đất chưa sử dụng (28,64% diện t&iacute;ch đất tự nhi&ecirc;n).</p>\r\n\r\n<p><strong>T&agrave;i nguy&ecirc;n rừng</strong></p>\r\n\r\n<p>Rừng Quảng Ng&atilde;i phong ph&uacute; về l&acirc;m, thổ sản với nhiều loại gỗ như: trắc, huỳnh, đinh hương, sến, kiền kiền, gụ, dỗi&hellip;, tổng trữ lượng gỗ khoảng 9,8 triệu m&sup3;. So với c&aacute;c tỉnh trong v&ugrave;ng duy&ecirc;n hải miền Trung, vốn rừng tự nhi&ecirc;n của Quảng Ng&atilde;i rất &iacute;t, chủ yếu l&agrave; rừng trung b&igrave;nh v&agrave; rừng ngh&egrave;o, nhưng nếu so về trữ lượng (t&iacute;nh tr&ecirc;n 1 ha) th&igrave; trữ lượng c&aacute;c loại rừng của Quảng Ng&atilde;i lại cao hơn mức trung b&igrave;nh của cả nước.</p>\r\n\r\n<p><strong>T&agrave;i nguy&ecirc;n kho&aacute;ng sản</strong></p>\r\n\r\n<p>T&agrave;i nguy&ecirc;n kho&aacute;ng sản kh&ocirc;ng đa dạng về chủng loại, chủ yếu l&agrave; kho&aacute;ng sản phục vụ cho c&ocirc;ng nghiệp vật liệu x&acirc;y dựng, nước kho&aacute;ng v&agrave; một số kho&aacute;ng sản kh&aacute;c.</p>\r\n\r\n<p>Những kho&aacute;ng sản c&oacute; thể khai th&aacute;c trong 10 năm tới l&agrave;: graph&iacute;t trữ lượng khoảng 4 triệu tấn, trong đ&oacute; trữ lượng cho ph&eacute;p đưa v&agrave;o khai th&aacute;c 2,5 triệu tấn, h&agrave;m lượng c&aacute;cbon trung b&igrave;nh 20%, c&oacute; nơi 24% nằm tr&ecirc;n địa b&agrave;n huyện Sơn Tịnh; silimanhit trữ lượng 1 triệu tấn, ph&acirc;n bổ ở Hưng Nhượng (Sơn Tịnh); than b&ugrave;n ở B&igrave;nh Ph&uacute; (B&igrave;nh Sơn) trữ lượng 476 ngh&igrave;n m&sup3;; cao lanh ở Sơn Tịnh trữ lượng khoảng 4 triệu tấn. Đ&aacute; x&acirc;y dựng gồm c&aacute;c loại đ&aacute; l&agrave;m vật liệu x&acirc;y dựng, rải đường giao th&ocirc;ng, &aacute;p tường, l&aacute;t nền, trữ lượng tr&ecirc;n 7 tỷ m&sup3;, ph&acirc;n bố ở Đức Phổ, Tr&agrave; Bồng v&agrave; một số huyện kh&aacute;c; nước kho&aacute;ng ở Thạch B&iacute;ch (Tr&agrave; Bồng), Đức L&acirc;n (Mộ Đức), Nghĩa Thuận (Tư Nghĩa) v&agrave; Sơn Tịnh.</p>\r\n\r\n<p><strong>T&agrave;i nguy&ecirc;n biển v&agrave; ven biển</strong></p>\r\n\r\n<p>Với bờ biển d&agrave;i 144 km, c&ugrave;ng v&ugrave;ng l&atilde;nh hải rộng lớn 11.000 km&sup2;, c&oacute; 6 cửa biển, dồi d&agrave;o nguồn lực hải sản, Quảng Ng&atilde;i c&ograve;n c&oacute; một khả năng lớn để đi l&ecirc;n từ ph&aacute;t triển kinh tế biển đặc biệt l&agrave; khai th&aacute;c c&oacute; hiệu quả c&aacute; nổi trữ lượng khoảng 68.000 tấn c&aacute;c loại. &ETH;&acirc;y cũng l&agrave; ng&agrave;nh kinh tế mũi nhọn của tỉnh. Với 6 huyện ven biển v&agrave; một huyện đảo, c&oacute; thể n&oacute;i biển đảo Quảng Ng&atilde;i c&oacute; nhiều tiềm năng về cảnh quan, địa h&igrave;nh, nhiều di t&iacute;ch lịch sử, lễ hội truyền thống, l&agrave; một trong c&aacute;c tỉnh c&oacute; bờ biển d&agrave;i v&agrave; đẹp, c&oacute; diện t&iacute;ch khai th&aacute;c, nu&ocirc;i trồng thủy hải sản rộng lớn. Đặc biệt, đảo L&yacute; Sơn c&ograve;n l&agrave; nơi lưu giữ h&igrave;nh ảnh của những đội h&ugrave;ng binh xưa dong buồm ra biển Đ&ocirc;ng, đặt những vi&ecirc;n đ&aacute; chủ quyền thi&ecirc;ng li&ecirc;ng đầu ti&ecirc;n tr&ecirc;n quần đảo Ho&agrave;ng Sa v&agrave; Trường Sa.</p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/QuangNgai/qn3.jpg\" style=\"height:429px; width:640px\" /></p>\r\n\r\n<p><strong>T&agrave;i nguy&ecirc;n du lịch</strong></p>\r\n\r\n<p>Quảng Ng&atilde;i c&oacute; di chỉ văn h&oacute;a Sa Huỳnh, ch&ugrave;a Thi&ecirc;n Ấn, th&agrave;nh cổ Ch&acirc;u Sa... l&agrave; những di t&iacute;ch lịch sử - văn h&oacute;a (LSVH) quan trọng của thời tiền - sơ sử v&agrave; cổ trung đại. Quảng Ng&atilde;i cũng l&agrave; nơi lưu dấu nhiều sự kiện v&agrave; chứng t&iacute;ch quan trọng trong lịch sử đấu tranh c&aacute;ch mạng thời hiện đại như: Chứng t&iacute;ch Sơn Mỹ, địa đạo &ETH;&agrave;m To&aacute;i x&atilde; B&igrave;nh Ch&acirc;u, Ba Tơ quật khởi, mộ nh&agrave; ch&iacute; sĩ y&ecirc;u nước Huỳnh Th&uacute;c Kh&aacute;ng... Ngo&agrave;i ra, Quảng Ng&atilde;i c&oacute; 144 km bờ biển với những quang cảnh n&ecirc;n thơ rất th&iacute;ch hợp cho việc ph&aacute;t triển kinh doanh du lịch như: b&atilde;i biển Sa Huỳnh, b&atilde;i biển Mỹ Kh&ecirc;, vũng Dung Quất, mũi Ba L&agrave;ng An, Cổ Lũy c&ocirc; th&ocirc;n... Trong v&ugrave;ng biển ph&iacute;a đ&ocirc;ng của tỉnh c&oacute; đảo L&yacute; Sơn, một v&ugrave;ng biển đảo c&oacute; nhiều cảnh quan thi&ecirc;n nhi&ecirc;n kỳ th&uacute;, l&agrave; v&ugrave;ng đất ph&ecirc;n dậu ph&iacute;a đ&ocirc;ng của tỉnh, qu&ecirc; hương của những &ldquo;h&ugrave;ng binh&rdquo; Ho&agrave;ng Sa thuở trước, l&agrave; &ldquo;vương quốc&rdquo; của nghề trồng tỏi v&agrave; nghề đ&aacute;nh bắt hải sản xa bờ, cũng l&agrave; một &ldquo;trọng địa&rdquo; du lịch đầy tiềm năng với những b&atilde;i biển hoang sơ, c&oacute; nhiều di t&iacute;ch LSVH, c&ugrave;ng những bến thuyền t&agrave;u ghe tấp nập&hellip; hấp dẫn du kh&aacute;ch.</p>\r\n\r\n<p><img alt=\"\" src=\"/lvtn/public/images/tintuc/files/QuangNgai/qn4.jpg\" style=\"height:375px; width:500px\" /></p>\r\n\r\n<p><strong>Di sản văn h&oacute;a</strong></p>\r\n\r\n<p>Quảng Ng&atilde;i l&agrave; mảnh đất c&oacute; bề d&agrave;y lịch sử, l&agrave; qu&ecirc; hương của văn h&oacute;a Sa Huỳnh v&agrave; l&agrave; địa b&agrave;n trọng yếu của văn h&oacute;a Champa, c&oacute; hai danh thắng nổi tiếng l&agrave; &quot;n&uacute;i Ấn, s&ocirc;ng Tr&agrave;&quot;. Đặc biệt, Quảng Ng&atilde;i c&oacute; hệ thống Trường Lũy được x&acirc;y dựng từ thế kỷ XVI, trải dọc v&ugrave;ng trung du ph&iacute;a t&acirc;y của tỉnh, k&eacute;o d&agrave;i đến tỉnh B&igrave;nh Định, l&agrave; hệ thống th&agrave;nh lũy d&agrave;i nhất Việt Nam, được c&ocirc;ng nhận l&agrave; di t&iacute;ch LSVH cấp quốc gia. Quảng Ng&atilde;i c&ograve;n l&agrave; qu&ecirc; hương của c&aacute;c danh nh&acirc;n, danh tướng như: Trương Định, L&ecirc; Trung Đ&igrave;nh, Phạm Văn Đồng; nhiều nh&agrave; tr&iacute; thức, nh&agrave; văn, nh&agrave; thơ, nhạc sĩ, nghệ sĩ t&ecirc;n tuổi: B&iacute;ch Kh&ecirc;, Tế Hanh, NSND Tr&agrave; Giang, Trương Quang Lục, Thế Bảo, Nhất Sinh... Quảng Ng&atilde;i c&ograve;n c&oacute; những lễ hội văn h&oacute;a đặc sắc diễn ra quanh năm như: lễ hội nghinh &Ocirc;ng, lễ khao lề thế l&iacute;nh Ho&agrave;ng Sa (L&yacute; Sơn), lễ hội ăn tr&acirc;u, lễ hội cầu ngư, lễ hội đua thuyền&hellip;</p>\r\n\r\n<p>(Nguồn: www.nhipcauviet.com.vn)</p>', 1, 1, 1, 0, '2018-11-30 18:30:53', '2018-12-05 13:34:27');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thong_ke`
--

DROP TABLE IF EXISTS `thong_ke`;
CREATE TABLE IF NOT EXISTS `thong_ke` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Tháng` int(11) NOT NULL,
  `Năm` int(11) NOT NULL,
  `Số_chuyến_xe` int(11) NOT NULL,
  `Chi_phí` int(11) NOT NULL,
  `Doanh_thu` int(11) NOT NULL,
  `created__at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tinh`
--

DROP TABLE IF EXISTS `tinh`;
CREATE TABLE IF NOT EXISTS `tinh` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Tên` varchar(255) NOT NULL,
  `Tên_không_dấu` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  UNIQUE KEY `Tên` (`Tên`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `tinh`
--

INSERT INTO `tinh` (`Mã`, `Tên`, `Tên_không_dấu`, `created_at`, `updated_at`) VALUES
(31, 'An Giang (Long Xuyên)', 'An Giang (Long Xuyen)', '2023-04-20 08:17:51', '2023-04-20 08:17:51'),
(32, 'An Giang (Châu Đốc)', 'An Giang (Chau Doc)', '2023-04-20 08:18:08', '2023-04-20 08:18:08'),
(33, 'Cần Thơ (Cần Thơ)', 'Can Tho (Can Tho)', '2023-04-20 08:18:37', '2023-04-20 08:18:37'),
(34, 'Cao Lãnh (Cao Lãnh)', 'Cao Lanh (Cao Lanh)', '2023-04-20 08:18:54', '2023-04-20 08:18:54'),
(35, 'TP. Hồ Chí Minh (TPHCM)', 'TP. Ho Chi Minh (TPHCM)', '2023-04-20 08:19:35', '2023-04-20 08:19:35'),
(36, 'An Giang (Tịnh Biên)', 'An Giang (Tinh Bien)', '2023-04-20 08:20:03', '2023-04-20 08:20:03'),
(37, 'Đà Lạt (Đà Lạt)', 'Da Lat (Da Lat)', '2023-04-20 08:20:33', '2023-04-20 08:20:33'),
(38, 'Hà Tiên (Hà Tiên)', 'Ha Tien (Ha Tien)', '2023-04-20 08:20:56', '2023-04-20 08:20:56'),
(39, 'Kiên Giang (Kiên Giang)', 'Kien Giang (Kien Giang)', '2023-04-20 08:21:13', '2023-04-20 08:21:13');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tram_dung`
--

DROP TABLE IF EXISTS `tram_dung`;
CREATE TABLE IF NOT EXISTS `tram_dung` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Tên` varchar(255) NOT NULL,
  `Tọa_độ` varchar(255) NOT NULL,
  `Mã_nhân_viên_tạo` int(11) NOT NULL,
  `Mã_nhân_viên_chỉnh_sửa` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  UNIQUE KEY `Tên` (`Tên`),
  UNIQUE KEY `Tọa_độ` (`Tọa_độ`),
  KEY `Mã_nhân_viên_tạo` (`Mã_nhân_viên_tạo`),
  KEY `Mã_nhân_viên_chỉnh_sửa` (`Mã_nhân_viên_chỉnh_sửa`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `tram_dung`
--

INSERT INTO `tram_dung` (`Mã`, `Tên`, `Tọa_độ`, `Mã_nhân_viên_tạo`, `Mã_nhân_viên_chỉnh_sửa`, `created_at`, `updated_at`) VALUES
(4, 'Bến Xe Long Xuyên', '10.358564615350147, 105.43414585155628', 1, 1, '2023-04-20 08:28:24', '2023-04-20 08:28:24'),
(5, 'Không', '10.371660215460267,105.43233633041382', 1, 1, '2023-04-20 08:31:14', '2023-04-20 08:31:14'),
(6, 'Trạm dừng chân Thành Bưởi (TP-DL)', '11.950350525677159, 108.46395273994644', 1, 1, '2023-04-20 08:33:23', '2023-04-20 08:33:23'),
(7, 'Trạm dừng Chân Thần Tài _Cty Khải Duyên (LX - CĐ)', '10.445690046895898, 105.36707326504767', 1, 1, '2023-04-20 08:34:48', '2023-04-20 08:35:16');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `ve`
--

DROP TABLE IF EXISTS `ve`;
CREATE TABLE IF NOT EXISTS `ve` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Mã_chuyến_xe` int(11) NOT NULL,
  `Mã_nhân_viên_đặt` int(11) DEFAULT NULL,
  `Mã_khách_hàng` int(11) DEFAULT NULL,
  `Mã_đặt_vé` varchar(255) DEFAULT NULL,
  `Vị_trí_ghế` varchar(255) NOT NULL,
  `Trạng_thái` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `is_hide` tinyint(1) NOT NULL DEFAULT '0',
  `Thời_điểm_chọn` datetime DEFAULT NULL,
  PRIMARY KEY (`Mã`),
  KEY `Mã_chuyến_xe` (`Mã_chuyến_xe`),
  KEY `Mã_khách_hàng` (`Mã_khách_hàng`),
  KEY `Mã_nhân_viên_đặt` (`Mã_nhân_viên_đặt`)
) ENGINE=InnoDB AUTO_INCREMENT=5271 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `ve`
--

INSERT INTO `ve` (`Mã`, `Mã_chuyến_xe`, `Mã_nhân_viên_đặt`, `Mã_khách_hàng`, `Mã_đặt_vé`, `Vị_trí_ghế`, `Trạng_thái`, `created_at`, `updated_at`, `is_hide`, `Thời_điểm_chọn`) VALUES
(5192, 50, NULL, NULL, NULL, 'A-2', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5193, 50, NULL, NULL, NULL, 'A-3', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5195, 50, NULL, NULL, NULL, 'A-5', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5196, 50, NULL, NULL, NULL, 'A-6', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5197, 50, NULL, NULL, NULL, 'A-7', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5198, 50, NULL, NULL, NULL, 'A-8', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5199, 50, NULL, NULL, NULL, 'A-9', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5200, 50, NULL, NULL, NULL, 'A-10', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5201, 50, NULL, NULL, NULL, 'A-11', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5202, 50, NULL, NULL, NULL, 'A-12', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5203, 50, NULL, NULL, NULL, 'A-13', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5204, 50, NULL, NULL, NULL, 'A-14', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5205, 50, NULL, NULL, NULL, 'A-15', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5206, 50, NULL, NULL, NULL, 'A-16', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5207, 50, NULL, NULL, NULL, 'A-17', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5208, 50, NULL, NULL, NULL, 'A-18', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5209, 50, NULL, NULL, NULL, 'A-19', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5210, 50, NULL, NULL, NULL, 'A-20', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5211, 50, NULL, NULL, NULL, 'B-1', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5212, 50, NULL, NULL, NULL, 'B-2', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5213, 50, NULL, NULL, NULL, 'B-3', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5214, 50, NULL, NULL, NULL, 'B-4', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5215, 50, NULL, NULL, NULL, 'B-5', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5216, 50, NULL, NULL, NULL, 'B-6', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5217, 50, NULL, NULL, NULL, 'B-7', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5218, 50, NULL, NULL, NULL, 'B-8', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5219, 50, NULL, NULL, NULL, 'B-9', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5220, 50, NULL, NULL, NULL, 'B-10', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5221, 50, NULL, NULL, NULL, 'B-11', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5222, 50, NULL, NULL, NULL, 'B-12', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5223, 50, NULL, NULL, NULL, 'B-13', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5224, 50, NULL, NULL, NULL, 'B-14', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5225, 50, NULL, NULL, NULL, 'B-15', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5226, 50, NULL, NULL, NULL, 'B-16', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5227, 50, NULL, NULL, NULL, 'B-17', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5228, 50, NULL, NULL, NULL, 'B-18', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5229, 50, NULL, NULL, NULL, 'B-19', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5230, 50, NULL, NULL, NULL, 'B-20', 0, '2023-04-20 08:56:09', '2023-04-20 08:56:09', 0, NULL),
(5231, 51, NULL, 39, NULL, 'A-1', 2, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, '2023-05-05 07:34:57'),
(5232, 51, NULL, 37, NULL, 'A-2', 2, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, '2023-05-04 09:46:09'),
(5233, 51, NULL, NULL, NULL, 'A-3', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5234, 51, NULL, NULL, NULL, 'A-4', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5235, 51, NULL, NULL, NULL, 'A-5', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5236, 51, NULL, NULL, NULL, 'A-6', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5237, 51, NULL, NULL, NULL, 'A-7', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5238, 51, NULL, NULL, NULL, 'A-8', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5239, 51, NULL, NULL, NULL, 'A-9', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5240, 51, NULL, NULL, NULL, 'A-10', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5241, 51, NULL, NULL, NULL, 'A-11', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5242, 51, NULL, NULL, NULL, 'A-12', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5243, 51, NULL, NULL, NULL, 'A-13', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5244, 51, NULL, NULL, NULL, 'A-14', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5245, 51, NULL, NULL, NULL, 'A-15', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5246, 51, NULL, NULL, NULL, 'A-16', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5247, 51, NULL, NULL, NULL, 'A-17', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5248, 51, NULL, NULL, NULL, 'A-18', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5249, 51, NULL, NULL, NULL, 'A-19', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5250, 51, NULL, NULL, NULL, 'A-20', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5251, 51, NULL, NULL, NULL, 'B-1', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5252, 51, NULL, NULL, NULL, 'B-2', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5253, 51, NULL, NULL, NULL, 'B-3', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5254, 51, NULL, NULL, NULL, 'B-4', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5255, 51, NULL, NULL, NULL, 'B-5', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5256, 51, NULL, NULL, NULL, 'B-6', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5257, 51, NULL, NULL, NULL, 'B-7', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5258, 51, NULL, NULL, NULL, 'B-8', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5259, 51, NULL, NULL, NULL, 'B-9', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5260, 51, NULL, NULL, NULL, 'B-10', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5261, 51, NULL, NULL, NULL, 'B-11', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5262, 51, NULL, NULL, NULL, 'B-12', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5263, 51, NULL, NULL, NULL, 'B-13', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5264, 51, NULL, NULL, NULL, 'B-14', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5265, 51, NULL, NULL, NULL, 'B-15', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5266, 51, NULL, NULL, NULL, 'B-16', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5267, 51, NULL, NULL, NULL, 'B-17', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5268, 51, NULL, NULL, NULL, 'B-18', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5269, 51, NULL, NULL, NULL, 'B-19', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL),
(5270, 51, NULL, NULL, NULL, 'B-20', 0, '2023-05-04 09:43:11', '2023-05-04 09:43:11', 0, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `xe`
--

DROP TABLE IF EXISTS `xe`;
CREATE TABLE IF NOT EXISTS `xe` (
  `Mã` int(11) NOT NULL AUTO_INCREMENT,
  `Biển_số` varchar(255) NOT NULL,
  `Mã_loại_xe` int(11) NOT NULL,
  `Ngày_bảo_trì_gần_nhất` date NOT NULL,
  `Ngày_bảo_trì_tiếp_theo` date NOT NULL,
  `location` tinytext,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`Mã`),
  UNIQUE KEY `Biển_số` (`Biển_số`),
  KEY `Mã_loại_xe` (`Mã_loại_xe`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `xe`
--

INSERT INTO `xe` (`Mã`, `Biển_số`, `Mã_loại_xe`, `Ngày_bảo_trì_gần_nhất`, `Ngày_bảo_trì_tiếp_theo`, `location`, `created_at`, `updated_at`) VALUES
(9, '67A-256.89', 7, '2023-01-01', '2023-06-20', NULL, '2023-04-20 08:37:10', '2023-04-20 08:39:17'),
(10, '67A-875.21', 6, '2023-01-01', '2023-06-20', NULL, '2023-04-20 08:37:50', '2023-04-20 08:39:25'),
(11, '67A-246.89', 6, '2023-01-01', '2023-06-20', NULL, '2023-04-20 08:38:48', '2023-04-20 08:39:36');

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `bus_model`
--
ALTER TABLE `bus_model`
  ADD CONSTRAINT `bus_model_ibfk_1` FOREIGN KEY (`Mã_nhân_viên_tạo`) REFERENCES `employee` (`Mã`),
  ADD CONSTRAINT `bus_model_ibfk_2` FOREIGN KEY (`Mã_nhân_viên_chỉnh_sửa`) REFERENCES `employee` (`Mã`);

--
-- Các ràng buộc cho bảng `chuyen_xe`
--
ALTER TABLE `chuyen_xe`
  ADD CONSTRAINT `chuyen_xe_ibfk_1` FOREIGN KEY (`Mã_lộ_trình`) REFERENCES `lo_trinh` (`Mã`),
  ADD CONSTRAINT `chuyen_xe_ibfk_2` FOREIGN KEY (`Mã_tài_xế`) REFERENCES `employee` (`Mã`),
  ADD CONSTRAINT `chuyen_xe_ibfk_3` FOREIGN KEY (`Mã_xe`) REFERENCES `xe` (`Mã`),
  ADD CONSTRAINT `chuyen_xe_ibfk_4` FOREIGN KEY (`Mã_nhân_viên_tạo`) REFERENCES `employee` (`Mã`);

--
-- Các ràng buộc cho bảng `duong_di`
--
ALTER TABLE `duong_di`
  ADD CONSTRAINT `duong_di_ibfk_1` FOREIGN KEY (`Mã_Trạm_Start`) REFERENCES `tram_dung` (`Mã`),
  ADD CONSTRAINT `duong_di_ibfk_2` FOREIGN KEY (`Mã_Trạm_End`) REFERENCES `tram_dung` (`Mã`);

--
-- Các ràng buộc cho bảng `lo_trinh`
--
ALTER TABLE `lo_trinh`
  ADD CONSTRAINT `lo_trinh_ibfk_1` FOREIGN KEY (`Mã_nhân_viên_tạo`) REFERENCES `employee` (`Mã`),
  ADD CONSTRAINT `lo_trinh_ibfk_2` FOREIGN KEY (`Mã_nhân_viên_chỉnh_sửa`) REFERENCES `employee` (`Mã`);

--
-- Các ràng buộc cho bảng `tram_dung`
--
ALTER TABLE `tram_dung`
  ADD CONSTRAINT `tram_dung_ibfk_1` FOREIGN KEY (`Mã_nhân_viên_tạo`) REFERENCES `employee` (`Mã`),
  ADD CONSTRAINT `tram_dung_ibfk_2` FOREIGN KEY (`Mã_nhân_viên_chỉnh_sửa`) REFERENCES `employee` (`Mã`);

--
-- Các ràng buộc cho bảng `ve`
--
ALTER TABLE `ve`
  ADD CONSTRAINT `ve_ibfk_1` FOREIGN KEY (`Mã_nhân_viên_đặt`) REFERENCES `employee` (`Mã`),
  ADD CONSTRAINT `ve_ibfk_2` FOREIGN KEY (`Mã_khách_hàng`) REFERENCES `customer` (`Mã`),
  ADD CONSTRAINT `ve_ibfk_3` FOREIGN KEY (`Mã_chuyến_xe`) REFERENCES `chuyen_xe` (`Mã`);

--
-- Các ràng buộc cho bảng `xe`
--
ALTER TABLE `xe`
  ADD CONSTRAINT `xe_ibfk_1` FOREIGN KEY (`Mã_loại_xe`) REFERENCES `bus_model` (`Mã`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
