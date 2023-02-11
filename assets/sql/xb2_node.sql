-- -------------------------------------------------------------
-- TablePlus 4.8.7(448)
--
-- https://tableplus.com/
--
-- Database: xb2_node
-- Generation Time: 2022-09-14 16:32:04.5510
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `avatar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mimetype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int NOT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `avatar_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `postId` int NOT NULL,
  `userId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `postId` (`postId`),
  KEY `userId` (`userId`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `comment_ibfk_4` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_5` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_6` FOREIGN KEY (`parentId`) REFERENCES `comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `originalname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mimetype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int NOT NULL,
  `postId` int DEFAULT NULL,
  `userId` int NOT NULL,
  `width` smallint NOT NULL,
  `height` smallint NOT NULL,
  `metadata` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `postId` (`postId`),
  KEY `userId` (`userId`),
  CONSTRAINT `file_ibfk_3` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `file_ibfk_4` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `post_tag` (
  `postId` int NOT NULL,
  `tagId` int NOT NULL,
  PRIMARY KEY (`postId`,`tagId`),
  KEY `tagId` (`tagId`),
  CONSTRAINT `post_tag_ibfk_1` FOREIGN KEY (`tagId`) REFERENCES `tag` (`id`),
  CONSTRAINT `post_tag_ibfk_2` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `user_like_post` (
  `userId` int NOT NULL,
  `postId` int NOT NULL,
  PRIMARY KEY (`userId`,`postId`),
  KEY `postId` (`postId`),
  CONSTRAINT `user_like_post_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_like_post_ibfk_4` FOREIGN KEY (`postId`) REFERENCES `post` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `avatar` (`id`, `mimetype`, `filename`, `size`, `userId`) VALUES
(1, 'image/jpeg', 'cbb9a3ab21304ac97c978b2c3e0cbf37', 73205, 3),
(2, 'image/jpeg', '569700332ec0f204cfffbe9ac08d5c15', 77811, 4),
(3, 'image/jpeg', '3c203530f8f11f4673f9060a85a51b37', 75345, 5),
(4, 'image/jpeg', 'db833e4835d12ab8093b5508c2db0fa8', 67678, 1),
(5, 'image/jpeg', 'f0084ad0d3e1d1e24a80c0433ca3e607', 92291, 6);

INSERT INTO `comment` (`id`, `content`, `postId`, `userId`, `parentId`) VALUES
(1, '好一副美丽的春夜雨景~~', 2, 3, NULL),
(2, '同是天涯沦落人，相逢何必曾相识', 3, 3, NULL),
(3, '旅途愉快 😋', 5, 3, NULL),
(4, '没事出来溜达溜达 ：）', 5, 4, 3),
(5, '多日不见，甚是想念', 1, 4, NULL),
(6, '找机会一块儿出来坐坐', 1, 3, 5),
(7, '仿佛听到了雨声', 2, 5, NULL),
(8, '随风潜入夜，润物细无声', 2, 4, NULL),
(9, '想家了', 4, 4, NULL),
(10, '嗯', 4, 3, 9),
(11, '潮汐涨落，能量世大 ~~~', 6, 3, NULL),
(12, '笔落惊风雨，诗成泣鬼神', 7, 4, NULL),
(13, '世间万物，变幻无常', 9, 3, NULL),
(14, '阳光灿烂，鸟语花香', 11, 3, NULL),
(15, '美丽的夕阳，总能勾起按下快门的冲动~~', 12, 3, NULL),
(16, '冬天来了', 8, 5, NULL),
(17, '壮观', 10, 5, NULL),
(18, '人逢喜事精神爽', 13, 4, NULL),
(19, '不辞辛苦行，迫此短景急', 14, 4, NULL),
(20, '万里桥西一草堂，百花潭水即沧浪', 15, 4, NULL),
(21, '浮云连海岳，平野入青徐', 16, 4, NULL),
(22, '柯条未尝损，根蕟不曾移', 17, 5, NULL),
(23, '枝枝总到地，叶叶自开春', 18, 4, NULL),
(24, '石间见海眼，天畔萦水府', 19, 4, NULL),
(25, '来如春梦不多时，去似朝云无觅处', 20, 5, NULL),
(26, '天上秋期近，人间月影清', 21, 4, NULL),
(27, '百草竞春华，丽春应最胜', 22, 4, NULL),
(28, '海天东望夕茫茫，山势川形阔复长', 23, 5, NULL),
(29, '沈竿续蔓深莫测，菱叶荷花静如拭', 24, 4, NULL),
(30, '写的好 ~', 25, 5, NULL),
(31, '字字珠玑 ~', 25, 4, NULL),
(32, '谢谢 😄', 25, 3, 31),
(33, '感谢捧场 ~', 25, 3, 30);

INSERT INTO `file` (`id`, `originalname`, `mimetype`, `filename`, `size`, `postId`, `userId`, `width`, `height`, `metadata`) VALUES
(1, 'IMG_0652.jpeg', 'image/jpeg', 'ed91ea796dcb2cf668f7daa9acf7841e', 4009797, 1, 3, 5511, 3674, '{\"ISO\": 800, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"                                                                                                                                                                                                                                                               \", \"FNumber\": 2, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Photos 4.0\", \"Copyright\": \"                                                                                                                                                                                                                                                               \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"ColorSpace\": 1, \"CreateDate\": 1555268226, \"ModifyDate\": 1555268226, \"FocalLength\": 23, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.009523809523809525, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 2, \"SensingMethod\": 2, \"ExifImageWidth\": 5511, \"ResolutionUnit\": 2, \"BrightnessValue\": 2.05, \"ExifImageHeight\": 3674, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1555268226, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 6.76, \"ExposureCompensation\": 0.67, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(2, 'DSCF4103.jpg', 'image/jpeg', 'a8012527262d05c5e69de97619ee1dbb', 2932120, 2, 4, 2728, 4092, '{\"ISO\": 200, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 4.8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1588693084, \"ModifyDate\": 1588693084, \"FocalLength\": 200, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.00909090909090909, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 4.5, \"SensingMethod\": 2, \"ExifImageWidth\": 2728, \"ResolutionUnit\": 2, \"BrightnessValue\": 5.31, \"ExifImageHeight\": 4092, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1588693084, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 1, \"ShutterSpeedValue\": 6.87, \"ExposureCompensation\": -0.33, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(3, 'OKSR4620.jpeg', 'image/jpeg', '01245b953f80b39f401506d10a6e3598', 1111872, 3, 5, 1184, 1776, '{\"ISO\": 400, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"                                                                                                                                                                                                                                                               \", \"FNumber\": 8, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.272140074\", \"Copyright\": \"                                                                                                                                                                                                                                                               \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"CreateDate\": 1574423365, \"ModifyDate\": 1574444412, \"FocalLength\": 23, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.00625, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"ExifImageWidth\": 1776, \"ResolutionUnit\": 2, \"BrightnessValue\": 5.32, \"ExifImageHeight\": 1184, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1574423365, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 1, \"ShutterSpeedValue\": 7.36, \"ExposureCompensation\": -1, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(4, 'GOTI0295.jpeg', 'image/jpeg', '94817e46d7f20df1f768d27863e0e566', 552380, 4, 3, 1073, 1612, '{\"ISO\": 1600, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"                                                                                                                                                                                                                                                               \", \"FNumber\": 5.6, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.251832120\", \"Copyright\": \"                                                                                                                                                                                                                                                               \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"CreateDate\": 1569364084, \"ModifyDate\": 1569364455, \"FocalLength\": 23, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 1, \"ExposureTime\": 80, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 5, \"SensingMethod\": 2, \"ExifImageWidth\": 1073, \"ResolutionUnit\": 2, \"BrightnessValue\": -11.64, \"ExifImageHeight\": 1612, \"ExposureProgram\": 1, \"SensitivityType\": 1, \"DateTimeOriginal\": 1569364084, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": -6.32, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(5, 'DSCF5100.jpg', 'image/jpeg', '291e42275a93ff3cdcc6253841c3cf51', 14585631, 5, 4, 6000, 4000, '{\"ISO\": 400, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"                                                                                                                                                                                                                                                               \", \"FNumber\": 8, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Digital Camera X-E3 Ver1.22\", \"Copyright\": \"                                                                                                                                                                                                                                                               \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"ColorSpace\": 1, \"CreateDate\": 1569416262, \"ModifyDate\": 1569416262, \"FocalLength\": 23, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.0006666666666666666, \"InteropIndex\": \"R98\", \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"CustomRendered\": 0, \"ExifImageWidth\": 6000, \"ResolutionUnit\": 2, \"BrightnessValue\": 10.26, \"ExifImageHeight\": 4000, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1569416262, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 1, \"YCbCrPositioning\": 2, \"ShutterSpeedValue\": 10.53, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"CompressedBitsPerPixel\": 4.8, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(6, 'IMG_1338.jpeg', 'image/jpeg', '5ee4f4c9f4c7b0b439d52240a11653ed', 6623890, 6, 5, 5760, 3840, '{\"ISO\": 200, \"Make\": \"Canon\", \"Flash\": 16, \"Model\": \"Canon EOS 5D Mark III\", \"Artist\": \"wanghao\", \"FNumber\": 11, \"Software\": \"Snapseed 2.18.200158453\", \"Copyright\": \"ninghao.net\", \"CreateDate\": 1461051897, \"ModifyDate\": 1525017274, \"SubSecTime\": \"61\", \"FocalLength\": 16, \"XResolution\": 300, \"YResolution\": 300, \"ExposureMode\": 0, \"ExposureTime\": 0.03333333333333333, \"MeteringMode\": 5, \"WhiteBalance\": 0, \"ApertureValue\": 6.918863002608617, \"ExifImageWidth\": 5760, \"ResolutionUnit\": 2, \"ExifImageHeight\": 3840, \"ExposureProgram\": 3, \"DateTimeOriginal\": 1461051897, \"MaxApertureValue\": 3, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 4.906891004156053, \"SubSecTimeOriginal\": \"61\", \"SubSecTimeDigitized\": \"61\", \"ExposureCompensation\": 0.3333333333333333, \"FocalPlaneXResolution\": 1600, \"FocalPlaneYResolution\": 1600, \"FocalPlaneResolutionUnit\": 3}'),
(7, 'SJBX9098.jpeg', 'image/jpeg', '94974cd575612ffbda8a7ebc70b528a2', 770690, 7, 3, 1776, 1184, '{\"ISO\": 100, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"                                                                                                                                                                                                                                                               \", \"FNumber\": 11, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.251832120\", \"Copyright\": \"                                                                                                                                                                                                                                                               \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"CreateDate\": 1569355471, \"ModifyDate\": 1569358473, \"FocalLength\": 23, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 1, \"ExposureTime\": 0.125, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6.9, \"SensingMethod\": 2, \"ExifImageWidth\": 1776, \"ResolutionUnit\": 2, \"BrightnessValue\": 6.51, \"ExifImageHeight\": 1184, \"ExposureProgram\": 1, \"SensitivityType\": 1, \"DateTimeOriginal\": 1569355471, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 3, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(8, 'DSCF2336.jpeg', 'image/jpeg', '39614b595809c8b215bf2999fb5fac66', 2018610, 8, 4, 2667, 4000, '{\"ISO\": 2500, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Digital Camera X-E3 Ver1.22\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1578403410, \"ModifyDate\": 1578403410, \"FocalLength\": 200, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 1, \"ExposureTime\": 0.004, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"CustomRendered\": 0, \"ExifImageWidth\": 2667, \"ResolutionUnit\": 2, \"BrightnessValue\": 3.28, \"ExifImageHeight\": 4000, \"ExposureProgram\": 1, \"SensitivityType\": 1, \"DateTimeOriginal\": 1578403410, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 8, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"CompressedBitsPerPixel\": 4.8, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(9, 'DSCF5250.jpg', 'image/jpeg', '0be2388ef05812c692b4f119c399a0fa', 1950950, 9, 5, 4612, 3074, '{\"ISO\": 200, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 5.6, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1590324247, \"ModifyDate\": 1590324247, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.005555555555555556, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 5, \"SensingMethod\": 2, \"ExifImageWidth\": 4612, \"ResolutionUnit\": 2, \"BrightnessValue\": 6.47, \"ExifImageHeight\": 3074, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1590324247, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 7.57, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(10, 'DSCF1622.jpeg', 'image/jpeg', 'd5455493462d09b240d5eefa89f22d35', 6664081, 10, 3, 6000, 4000, '{\"ISO\": 1600, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 4.5, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1578396456, \"ModifyDate\": 1578396456, \"FocalLength\": 63.8, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 1, \"ExposureTime\": 0.002, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 4.3, \"SensingMethod\": 2, \"ExifImageWidth\": 6000, \"ResolutionUnit\": 2, \"BrightnessValue\": 3.68, \"ExifImageHeight\": 4000, \"ExposureProgram\": 1, \"SensitivityType\": 1, \"DateTimeOriginal\": 1578396456, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 9, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 96, \"FocalPlaneResolutionUnit\": 3}'),
(11, 'IMG_0296.jpeg', 'image/jpeg', 'a5908e306417a7ea1be43f7e4c816216', 3756906, 11, 4, 3456, 5184, '{\"ISO\": 100, \"Make\": \"Canon\", \"Flash\": 16, \"Model\": \"Canon EOS 600D\", \"FNumber\": 2.8, \"LensInfo\": [100, 100, 0, 0], \"Software\": \"Snapseed 2.18.200158453\", \"LensModel\": \"EF100mm f/2.8L Macro IS USM\", \"CreateDate\": 1553186270, \"ModifyDate\": 1553186270, \"SubSecTime\": \"51\", \"FocalLength\": 100, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.00625, \"MeteringMode\": 5, \"SerialNumber\": \"154037000162\", \"WhiteBalance\": 0, \"ApertureValue\": 3, \"ExifImageWidth\": 3456, \"ResolutionUnit\": 2, \"ExifImageHeight\": 5184, \"ExposureProgram\": 3, \"SensitivityType\": 2, \"DateTimeOriginal\": 1553186270, \"LensSerialNumber\": \"00000688e7\", \"MaxApertureValue\": 2.8284271210652516, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 7.375, \"SubSecTimeOriginal\": \"51\", \"SubSecTimeDigitized\": \"51\", \"ExposureCompensation\": 0, \"FocalPlaneXResolution\": 5728.176795580111, \"FocalPlaneYResolution\": 5808.403361344538, \"FocalPlaneResolutionUnit\": 2, \"RecommendedExposureIndex\": 100}'),
(12, 'QADD2426.jpeg', 'image/jpeg', '72f2bc12f487d9b57fbd99ecce8f6905', 503683, 12, 5, 1776, 1184, '{\"ISO\": 400, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"                                                                                                                                                                                                                                                               \", \"FNumber\": 8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Digital Camera X-E3 Ver1.22\", \"Copyright\": \"                                                                                                                                                                                                                                                               \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"ColorSpace\": 1, \"CreateDate\": 1569399910, \"ModifyDate\": 1569457115, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 6, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.001, \"InteropIndex\": \"R98\", \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"CustomRendered\": 0, \"ExifImageWidth\": 1776, \"ResolutionUnit\": 2, \"BrightnessValue\": 9.75, \"ExifImageHeight\": 1184, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1569399910, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 1, \"YCbCrPositioning\": 2, \"ShutterSpeedValue\": 10.02, \"ExposureCompensation\": 0.33, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"CompressedBitsPerPixel\": 3.2, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(13, 'IMG_1337.jpeg', 'image/jpeg', '79001dcd0dbd8f1dad6fe9f263cbc470', 11467011, 13, 3, 3840, 5760, '{\"ISO\": 200, \"Make\": \"Canon\", \"Flash\": 16, \"Model\": \"Canon EOS 5D Mark III\", \"Artist\": \"wanghao\", \"FNumber\": 11, \"Software\": \"Adobe Photoshop CS6 Macintosh\", \"Copyright\": \"ninghao.net\", \"ColorSpace\": 1, \"CreateDate\": 1461051643, \"ModifyDate\": 1525017121, \"SubSecTime\": \"00\", \"FocalLength\": 16, \"XResolution\": 300, \"YResolution\": 300, \"ExposureMode\": 0, \"ExposureTime\": 0.07692307692307693, \"MeteringMode\": 5, \"WhiteBalance\": 0, \"ApertureValue\": 6.918863002608617, \"ExifImageWidth\": 3840, \"ResolutionUnit\": 2, \"ExifImageHeight\": 5760, \"ExposureProgram\": 3, \"DateTimeOriginal\": 1461051643, \"MaxApertureValue\": 3, \"SceneCaptureType\": 0, \"YCbCrPositioning\": 1, \"ShutterSpeedValue\": 3.7004399975890543, \"SubSecTimeOriginal\": \"00\", \"SubSecTimeDigitized\": \"00\", \"ExposureCompensation\": 0.3333333333333333, \"FocalPlaneXResolution\": 1600, \"FocalPlaneYResolution\": 1600, \"FocalPlaneResolutionUnit\": 3}'),
(14, 'DSCF2401.jpg', 'image/jpeg', '456ea5f38b633594e6a4cf6cc378b32c', 1952221, 14, 4, 4466, 2977, '{\"ISO\": 100, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 14, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Digital Camera X-E3 Ver1.22\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"CreateDate\": 1588006314, \"ModifyDate\": 1588006314, \"FocalLength\": 23, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 1, \"ExposureTime\": 0.5, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 1, \"ApertureValue\": 7.6, \"SensingMethod\": 2, \"CustomRendered\": 0, \"ExifImageWidth\": 4466, \"ResolutionUnit\": 2, \"BrightnessValue\": 3.18, \"ExifImageHeight\": 2977, \"ExposureProgram\": 1, \"SensitivityType\": 1, \"DateTimeOriginal\": 1588006314, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 1, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"CompressedBitsPerPixel\": 4.8, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(15, 'DSCF7275.jpg', 'image/jpeg', 'b258a992c4ddf12acfb80309c08325ed', 5118520, 15, 5, 4000, 6000, '{\"ISO\": 800, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 4.8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1592073876, \"ModifyDate\": 1592073876, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.023809523809523808, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 4.5, \"SensingMethod\": 2, \"ExifImageWidth\": 4000, \"ResolutionUnit\": 2, \"BrightnessValue\": 1.91, \"ExifImageHeight\": 6000, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1592073876, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 5.47, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(16, 'DSCF1291.jpg', 'image/jpeg', 'd1438141f8f9cac64b32f25dbd270db5', 2654826, 16, 3, 5534, 3689, '{\"ISO\": 200, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1587146315, \"ModifyDate\": 1587146315, \"FocalLength\": 200, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.0013333333333333333, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"ExifImageWidth\": 5534, \"ResolutionUnit\": 2, \"BrightnessValue\": 9.34, \"ExifImageHeight\": 3689, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1587146315, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 1, \"ShutterSpeedValue\": 9.53, \"ExposureCompensation\": -0.33, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(17, 'IMG_8204.jpg', 'image/jpeg', '6293f4ade5f9bcdb844d342089ccee3e', 3928031, 17, 4, 6000, 4000, '{\"ISO\": 1250, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 4.8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1588691690, \"ModifyDate\": 1588691690, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.006666666666666667, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 4.5, \"SensingMethod\": 2, \"ExifImageWidth\": 6000, \"ResolutionUnit\": 2, \"BrightnessValue\": 3.39, \"ExifImageHeight\": 4000, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1588691690, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 7.25, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(18, 'DSCF5703.jpeg', 'image/jpeg', '979e042d9c0e51a62c541e05bd57b64f', 4066132, 18, 5, 6000, 4000, '{\"ISO\": 200, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 5.6, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1590491385, \"ModifyDate\": 1590491385, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.004166666666666667, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 5, \"SensingMethod\": 2, \"ExifImageWidth\": 6000, \"ResolutionUnit\": 2, \"BrightnessValue\": 6.12, \"ExifImageHeight\": 4000, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1590491385, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 7.93, \"ExposureCompensation\": -0.67, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(19, 'DSCF5145.jpeg', 'image/jpeg', 'd9fd2609e1d42f6e09d393d0bdb65dd0', 8931953, 19, 5, 6000, 3703, '{\"ISO\": 400, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"                                                                                                                                                                                                                                                               \", \"FNumber\": 8, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"                                                                                                                                                                                                                                                               \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"CreateDate\": 1569417235, \"ModifyDate\": 1569417235, \"FocalLength\": 23, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.004166666666666667, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"ExifImageWidth\": 6000, \"ResolutionUnit\": 2, \"BrightnessValue\": 7.26, \"ExifImageHeight\": 3703, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1569417235, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 1, \"ShutterSpeedValue\": 7.93, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(20, 'DSCF3934.jpg', 'image/jpeg', '55970f8f315c307e6c520b0e38237fad', 3467904, 20, 1, 4000, 6000, '{\"ISO\": 200, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 5.6, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Digital Camera X-E3 Ver1.22\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1588691101, \"ModifyDate\": 1588691101, \"FocalLength\": 200, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.0058823529411764705, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 5, \"SensingMethod\": 2, \"CustomRendered\": 0, \"ExifImageWidth\": 4000, \"ResolutionUnit\": 2, \"BrightnessValue\": 6.19, \"ExifImageHeight\": 6000, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1588691101, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 7.41, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"CompressedBitsPerPixel\": 4.8, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(21, 'DSCF4627.jpeg', 'image/jpeg', '304b6c0436c82b569547a35d423dc797', 6006674, 21, 3, 6000, 4000, '{\"ISO\": 100, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 5, \"LensInfo\": [23, 23, 2, 2], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF23mmF2 R WR\", \"Sharpness\": 0, \"CreateDate\": 1589832862, \"ModifyDate\": 1589832862, \"FocalLength\": 23, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 1, \"ExposureTime\": 1, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 4.6, \"SensingMethod\": 2, \"ExifImageWidth\": 6000, \"ResolutionUnit\": 2, \"BrightnessValue\": 0.29, \"ExifImageHeight\": 4000, \"ExposureProgram\": 1, \"SensitivityType\": 1, \"DateTimeOriginal\": 1589832862, \"LensSerialNumber\": \"7CA46314\", \"MaxApertureValue\": 2, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 0, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 35, \"FocalPlaneResolutionUnit\": 3}'),
(22, 'DSCF3897.jpg', 'image/jpeg', '6c6fee65f8fb9cbe1b3e7fdc4348117b', 3659404, 22, 1, 4000, 6000, '{\"ISO\": 200, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 5.6, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Digital Camera X-E3 Ver1.22\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1588689949, \"ModifyDate\": 1588689949, \"FocalLength\": 200, \"LightSource\": 0, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.0033333333333333335, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 5, \"SensingMethod\": 2, \"CustomRendered\": 0, \"ExifImageWidth\": 4000, \"ResolutionUnit\": 2, \"BrightnessValue\": 6.41, \"ExifImageHeight\": 6000, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1588689949, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 8.25, \"ExposureCompensation\": -1, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"CompressedBitsPerPixel\": 4.8, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(23, 'DSCF7381.jpg', 'image/jpeg', 'caf09c350843a90eb07282a0f4c8b440', 8800848, 23, 4, 6000, 4000, '{\"ISO\": 400, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 7.1, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Digital Camera X-E3 Ver1.22\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"ColorSpace\": 1, \"CreateDate\": 1592248683, \"ModifyDate\": 1592248683, \"FocalLength\": 60.7, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.008, \"InteropIndex\": \"R98\", \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 5.7, \"SensingMethod\": 2, \"CustomRendered\": 0, \"ExifImageWidth\": 6000, \"ResolutionUnit\": 2, \"BrightnessValue\": 7.61, \"ExifImageHeight\": 4000, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1592248683, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 1, \"YCbCrPositioning\": 2, \"ShutterSpeedValue\": 7.09, \"ExposureCompensation\": 0, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"CompressedBitsPerPixel\": 4.8, \"FocalLengthIn35mmFormat\": 91, \"FocalPlaneResolutionUnit\": 3}'),
(24, 'DSCF7990.jpg', 'image/jpeg', '4dfafc210e60474f3066d39e54375bc8', 5282045, 24, 1, 4000, 6000, '{\"ISO\": 500, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 4.8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1593196929, \"ModifyDate\": 1593196929, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.013333333333333334, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 4.5, \"SensingMethod\": 2, \"ExifImageWidth\": 4000, \"ResolutionUnit\": 2, \"BrightnessValue\": 3.33, \"ExifImageHeight\": 6000, \"ExposureProgram\": 2, \"SensitivityType\": 1, \"DateTimeOriginal\": 1593196929, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 0, \"ShutterSpeedValue\": 6.25, \"ExposureCompensation\": -0.33, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(25, 'DSCF2797.jpg', 'image/jpeg', '40ed56ef3bd3c75d54d24bff34e12e6d', 1411926, 25, 3, 3920, 2614, '{\"ISO\": 400, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1588185896, \"ModifyDate\": 1588185896, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.004545454545454545, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"ExifImageWidth\": 3920, \"ResolutionUnit\": 2, \"BrightnessValue\": 8.4, \"ExifImageHeight\": 2614, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1588185896, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 1, \"ShutterSpeedValue\": 7.84, \"ExposureCompensation\": 0.33, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}'),
(26, 'DSCF2797.jpg', 'image/jpeg', '40ed56ef3bd3c75d54d24bff34e12e6e', 1411926, 25, 3, 3920, 2614, '{\"ISO\": 400, \"Make\": \"FUJIFILM\", \"Flash\": 0, \"Model\": \"X-E3\", \"Artist\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"FNumber\": 8, \"LensInfo\": [55, 200, 3.5, 4.8], \"LensMake\": \"FUJIFILM\", \"Software\": \"Snapseed 2.19.280302127\", \"Copyright\": \"WANG HAO                                                                                                                                                                                                                                                       \", \"LensModel\": \"XF55-200mmF3.5-4.8 R LM OIS\", \"Sharpness\": 0, \"CreateDate\": 1588185896, \"ModifyDate\": 1588185896, \"FocalLength\": 200, \"LightSource\": 0, \"Orientation\": 1, \"XResolution\": 72, \"YResolution\": 72, \"ExposureMode\": 0, \"ExposureTime\": 0.004545454545454545, \"MeteringMode\": 5, \"SerialNumber\": \"7DW10875\", \"WhiteBalance\": 0, \"ApertureValue\": 6, \"SensingMethod\": 2, \"ExifImageWidth\": 3920, \"ResolutionUnit\": 2, \"BrightnessValue\": 8.4, \"ExifImageHeight\": 2614, \"ExposureProgram\": 8, \"SensitivityType\": 1, \"DateTimeOriginal\": 1588185896, \"LensSerialNumber\": \"8HA00297\", \"MaxApertureValue\": 3.6, \"SceneCaptureType\": 1, \"ShutterSpeedValue\": 7.84, \"ExposureCompensation\": 0.33, \"SubjectDistanceRange\": 0, \"FocalPlaneXResolution\": 2564, \"FocalPlaneYResolution\": 2564, \"FocalLengthIn35mmFormat\": 300, \"FocalPlaneResolutionUnit\": 3}');

INSERT INTO `post` (`id`, `title`, `content`, `userId`) VALUES
(1, '黄鹤楼送孟浩然之广陵', '故人西辞黄鹤楼，烟花三月下扬州', 3),
(2, '春夜喜雨', '好雨知时节，当春乃发生', 4),
(3, '琵琶行', '浔阳江头夜送客，枫叶荻花秋瑟瑟', 5),
(4, '静夜思', '床前明月光，疑是地上霜', 3),
(5, '望岳', '会当凌绝顶，一览众山小', 4),
(6, '浪淘沙', '白浪茫茫与海连，平沙浩浩四无边', 5),
(7, '将进酒', '君不见黄河之水天上来，奔流到海不复回', 3),
(8, '天末怀李白', '凉风起天末，君子意如何', 4),
(9, '花非花', '花非花，雾非雾，夜半来，天明去', 5),
(10, '望庐山瀑布', '日照香炉生紫烟，遥看瀑布挂前川', 3),
(11, '绝句二首', '迟日江山丽，春风花草香', 4),
(12, '秋思', '夕照红于烧，晴空碧胜蓝', 5),
(13, '早发白帝城', '朝辞白帝彩云间，千里江陵一日还', 3),
(14, '龙门镇', '细泉兼轻冰，沮洳栈道湿', 4),
(15, '采莲曲', '菱叶萦波荷飐风，荷花深处小船通', 5),
(16, '独坐敬亭山', '众鸟高飞尽，孤云独去闲', 3),
(17, '三绝句', '楸树馨香倚钓矶，斩新花蕊未应飞', 4),
(18, '江南春', '青门柳枝软无力，东风吹作黄金色', 5),
(19, '白云泉', '天平山上白云泉，云自无心水自闲', 5),
(20, '叶子的肖像', '叶子的肖像，每张都不一样', 1),
(21, '月下独酌', '花间一壶酒，独酌无相亲', 3),
(22, '叶子的肖像', '叶子的肖像，每张都不一样', 1),
(23, '登楼', '花近高楼伤客心，万方多难此登临', 4),
(24, '大明湖的荷花', '大明湖里没青蛙，大明湖里有荷花', 1),
(25, '关山月', '明月出天山，苍茫云海间', 3);

INSERT INTO `post_tag` (`postId`, `tagId`) VALUES
(1, 11),
(1, 12),
(1, 13),
(2, 8),
(2, 9),
(3, 3),
(3, 4),
(3, 12),
(4, 5),
(5, 2),
(5, 13),
(6, 4),
(6, 13),
(7, 4),
(7, 7),
(8, 1),
(9, 1),
(10, 16),
(11, 1),
(11, 9),
(12, 3),
(12, 7),
(13, 4),
(14, 6),
(14, 17),
(15, 1),
(16, 7),
(17, 1),
(18, 8),
(19, 6),
(19, 13),
(20, 8),
(20, 9),
(21, 11),
(21, 12),
(22, 8),
(22, 9),
(23, 11),
(24, 1),
(24, 8),
(25, 7),
(25, 13);

INSERT INTO `tag` (`id`, `name`) VALUES
(1, '花'),
(2, '山'),
(3, '秋'),
(4, '水'),
(5, '月'),
(6, '泉'),
(7, '日'),
(8, '叶'),
(9, '春'),
(10, '树'),
(11, '楼'),
(12, '影'),
(13, '云'),
(14, '冰'),
(15, '湖'),
(16, '雪'),
(17, '鱼');

INSERT INTO `user` (`id`, `name`, `password`) VALUES
(1, '王皓', '$2b$10$CsO/ykedPpuxqUETBZTYm.F2U4TXDdo01rLmoRPwjKBv3pIL5pnWq'),
(2, '小雪', '$2b$10$CsO/ykedPpuxqUETBZTYm.F2U4TXDdo01rLmoRPwjKBv3pIL5pnWq'),
(3, '李白', '$2b$10$CsO/ykedPpuxqUETBZTYm.F2U4TXDdo01rLmoRPwjKBv3pIL5pnWq'),
(4, '杜甫', '$2b$10$CsO/ykedPpuxqUETBZTYm.F2U4TXDdo01rLmoRPwjKBv3pIL5pnWq'),
(5, '白居易', '$2b$10$CsO/ykedPpuxqUETBZTYm.F2U4TXDdo01rLmoRPwjKBv3pIL5pnWq'),
(6, '张三', '$2b$10$CsO/ykedPpuxqUETBZTYm.F2U4TXDdo01rLmoRPwjKBv3pIL5pnWq');

INSERT INTO `user_like_post` (`userId`, `postId`) VALUES
(3, 2),
(3, 3),
(3, 5),
(3, 6),
(3, 8),
(3, 9),
(3, 11),
(3, 12),
(3, 14),
(3, 15),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(3, 22),
(3, 23),
(3, 24),
(4, 1),
(4, 3),
(4, 4),
(4, 6),
(4, 7),
(4, 9),
(4, 10),
(4, 12),
(4, 13),
(4, 15),
(4, 16),
(4, 18),
(4, 19),
(4, 20),
(4, 21),
(4, 22),
(4, 24),
(4, 25),
(5, 1),
(5, 2),
(5, 4),
(5, 5),
(5, 7),
(5, 8),
(5, 10),
(5, 11),
(5, 13),
(5, 14),
(5, 16),
(5, 17),
(5, 20),
(5, 21),
(5, 22),
(5, 23),
(5, 24),
(5, 25);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;