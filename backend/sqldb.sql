/*
SQLyog Community v13.2.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - product
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`product` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `product`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add category',7,'add_category'),
(26,'Can change category',7,'change_category'),
(27,'Can delete category',7,'delete_category'),
(28,'Can view category',7,'view_category'),
(29,'Can add customer',8,'add_customer'),
(30,'Can change customer',8,'change_customer'),
(31,'Can delete customer',8,'delete_customer'),
(32,'Can view customer',8,'view_customer'),
(33,'Can add login',9,'add_login'),
(34,'Can change login',9,'change_login'),
(35,'Can delete login',9,'delete_login'),
(36,'Can view login',9,'view_login'),
(37,'Can add order_main',10,'add_order_main'),
(38,'Can change order_main',10,'change_order_main'),
(39,'Can delete order_main',10,'delete_order_main'),
(40,'Can view order_main',10,'view_order_main'),
(41,'Can add order_sub',11,'add_order_sub'),
(42,'Can change order_sub',11,'change_order_sub'),
(43,'Can delete order_sub',11,'delete_order_sub'),
(44,'Can view order_sub',11,'view_order_sub'),
(45,'Can add product',12,'add_product'),
(46,'Can change product',12,'change_product'),
(47,'Can delete product',12,'delete_product'),
(48,'Can view product',12,'view_product'),
(49,'Can add stocks',13,'add_stocks'),
(50,'Can change stocks',13,'change_stocks'),
(51,'Can delete stocks',13,'delete_stocks'),
(52,'Can view stocks',13,'view_stocks'),
(53,'Can add shop',14,'add_shop'),
(54,'Can change shop',14,'change_shop'),
(55,'Can delete shop',14,'delete_shop'),
(56,'Can view shop',14,'view_shop'),
(57,'Can add review',15,'add_review'),
(58,'Can change review',15,'change_review'),
(59,'Can delete review',15,'delete_review'),
(60,'Can view review',15,'view_review'),
(61,'Can add payments',16,'add_payments'),
(62,'Can change payments',16,'change_payments'),
(63,'Can delete payments',16,'delete_payments'),
(64,'Can view payments',16,'view_payments'),
(65,'Can add offers',17,'add_offers'),
(66,'Can change offers',17,'change_offers'),
(67,'Can delete offers',17,'delete_offers'),
(68,'Can view offers',17,'view_offers'),
(69,'Can add notification',18,'add_notification'),
(70,'Can change notification',18,'change_notification'),
(71,'Can delete notification',18,'delete_notification'),
(72,'Can view notification',18,'view_notification'),
(73,'Can add feedback',19,'add_feedback'),
(74,'Can change feedback',19,'change_feedback'),
(75,'Can delete feedback',19,'delete_feedback'),
(76,'Can view feedback',19,'view_feedback'),
(77,'Can add delivery_boy',20,'add_delivery_boy'),
(78,'Can change delivery_boy',20,'change_delivery_boy'),
(79,'Can delete delivery_boy',20,'delete_delivery_boy'),
(80,'Can view delivery_boy',20,'view_delivery_boy'),
(81,'Can add damaged_products',21,'add_damaged_products'),
(82,'Can change damaged_products',21,'change_damaged_products'),
(83,'Can delete damaged_products',21,'delete_damaged_products'),
(84,'Can view damaged_products',21,'view_damaged_products'),
(85,'Can add complaint',22,'add_complaint'),
(86,'Can change complaint',22,'change_complaint'),
(87,'Can delete complaint',22,'delete_complaint'),
(88,'Can view complaint',22,'view_complaint'),
(89,'Can add cart',23,'add_cart'),
(90,'Can change cart',23,'change_cart'),
(91,'Can delete cart',23,'delete_cart'),
(92,'Can view cart',23,'view_cart'),
(93,'Can add assign_order',24,'add_assign_order'),
(94,'Can change assign_order',24,'change_assign_order'),
(95,'Can delete assign_order',24,'delete_assign_order'),
(96,'Can view assign_order',24,'view_assign_order'),
(97,'Can add return',25,'add_return'),
(98,'Can change return',25,'change_return'),
(99,'Can delete return',25,'delete_return'),
(100,'Can view return',25,'view_return');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(24,'product_app','assign_order'),
(23,'product_app','cart'),
(7,'product_app','category'),
(22,'product_app','complaint'),
(8,'product_app','customer'),
(21,'product_app','damaged_products'),
(20,'product_app','delivery_boy'),
(19,'product_app','feedback'),
(9,'product_app','login'),
(18,'product_app','notification'),
(17,'product_app','offers'),
(10,'product_app','order_main'),
(11,'product_app','order_sub'),
(16,'product_app','payments'),
(12,'product_app','product'),
(25,'product_app','return'),
(15,'product_app','review'),
(14,'product_app','shop'),
(13,'product_app','stocks'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2025-03-12 13:30:30.166706'),
(2,'auth','0001_initial','2025-03-12 13:30:30.851119'),
(3,'admin','0001_initial','2025-03-12 13:30:31.050612'),
(4,'admin','0002_logentry_remove_auto_add','2025-03-12 13:30:31.056134'),
(5,'admin','0003_logentry_add_action_flag_choices','2025-03-12 13:30:31.056134'),
(6,'contenttypes','0002_remove_content_type_name','2025-03-12 13:30:31.135974'),
(7,'auth','0002_alter_permission_name_max_length','2025-03-12 13:30:31.201213'),
(8,'auth','0003_alter_user_email_max_length','2025-03-12 13:30:31.217279'),
(9,'auth','0004_alter_user_username_opts','2025-03-12 13:30:31.232252'),
(10,'auth','0005_alter_user_last_login_null','2025-03-12 13:30:31.287387'),
(11,'auth','0006_require_contenttypes_0002','2025-03-12 13:30:31.294896'),
(12,'auth','0007_alter_validators_add_error_messages','2025-03-12 13:30:31.300847'),
(13,'auth','0008_alter_user_username_max_length','2025-03-12 13:30:31.321881'),
(14,'auth','0009_alter_user_last_name_max_length','2025-03-12 13:30:31.336835'),
(15,'auth','0010_alter_group_name_max_length','2025-03-12 13:30:31.358703'),
(16,'auth','0011_update_proxy_permissions','2025-03-12 13:30:31.363791'),
(17,'auth','0012_alter_user_first_name_max_length','2025-03-12 13:30:31.381166'),
(18,'product_app','0001_initial','2025-03-12 13:30:33.766406'),
(19,'product_app','0002_return','2025-03-12 13:30:33.879690'),
(20,'product_app','0003_alter_assign_order_id_alter_cart_id_and_more','2025-03-12 13:30:43.784679'),
(21,'sessions','0001_initial','2025-03-12 13:30:43.831555'),
(22,'product_app','0004_rename_liscense_no_shop_location','2025-03-18 12:27:50.451550'),
(23,'product_app','0005_remove_customer_id_proof','2025-03-19 10:00:15.814258'),
(24,'product_app','0006_delete_return','2025-03-19 10:25:45.025019');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('awvni3u8x7dv62xxv9ik2on6jjnfp9an','eyJsaWQiOjF9:1tuxqm:oMs3WxjiUNNf9a1jHT80VzyZKpBt9Rp6bqhBOdQerDE','2025-04-02 18:09:08.860465'),
('flgdelsuwifdhpppj9jchnjz1g7m1q2f','eyJsaWQiOjJ9:1tuy1Q:2WOBqPbaqWCuxWXEgynKekbZoz21k039HHnfWHrAaPk','2025-04-02 18:20:08.959480'),
('nn65cqhmq9hok13m7pwz0l893lqwokdq','eyJsaWQiOjE1fQ:1tvbba:eebAOD2bfpijYLFirCQjk2gHbNl_Gtj8TzJ2brNp0pk','2025-04-04 12:36:06.317957');

/*Table structure for table `product_app_assign_order` */

DROP TABLE IF EXISTS `product_app_assign_order`;

CREATE TABLE `product_app_assign_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `DELIVERY_id` bigint(20) NOT NULL,
  `ORDER_SUB_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_assign_order_DELIVERY_id_7eb74cc6_fk` (`DELIVERY_id`),
  KEY `product_app_assign_order_ORDER_SUB_id_5a0cbe32_fk` (`ORDER_SUB_id`),
  CONSTRAINT `product_app_assign_order_DELIVERY_id_7eb74cc6_fk` FOREIGN KEY (`DELIVERY_id`) REFERENCES `product_app_delivery_boy` (`id`),
  CONSTRAINT `product_app_assign_order_ORDER_SUB_id_5a0cbe32_fk` FOREIGN KEY (`ORDER_SUB_id`) REFERENCES `product_app_order_sub` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_assign_order` */

/*Table structure for table `product_app_cart` */

DROP TABLE IF EXISTS `product_app_cart`;

CREATE TABLE `product_app_cart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `quantity` varchar(100) NOT NULL,
  `CUSTOMER_id` bigint(20) NOT NULL,
  `PRODUCT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_cart_CUSTOMER_id_6ababef9_fk` (`CUSTOMER_id`),
  KEY `product_app_cart_PRODUCT_id_06ce4a63_fk` (`PRODUCT_id`),
  CONSTRAINT `product_app_cart_CUSTOMER_id_6ababef9_fk` FOREIGN KEY (`CUSTOMER_id`) REFERENCES `product_app_customer` (`id`),
  CONSTRAINT `product_app_cart_PRODUCT_id_06ce4a63_fk` FOREIGN KEY (`PRODUCT_id`) REFERENCES `product_app_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_cart` */

insert  into `product_app_cart`(`id`,`date`,`quantity`,`CUSTOMER_id`,`PRODUCT_id`) values 
(60,'2025-03-21','2',6,8),
(61,'2025-03-21','1',6,7);

/*Table structure for table `product_app_category` */

DROP TABLE IF EXISTS `product_app_category`;

CREATE TABLE `product_app_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Category_name` varchar(50) NOT NULL,
  `SHOP_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_category_SHOP_id_e6fd27fb_fk` (`SHOP_id`),
  CONSTRAINT `product_app_category_SHOP_id_e6fd27fb_fk` FOREIGN KEY (`SHOP_id`) REFERENCES `product_app_shop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_category` */

insert  into `product_app_category`(`id`,`Category_name`,`SHOP_id`) values 
(5,'Headphones',5),
(6,'Mobile Accessories',5),
(7,'furniture',4),
(8,'home decor',4);

/*Table structure for table `product_app_complaint` */

DROP TABLE IF EXISTS `product_app_complaint`;

CREATE TABLE `product_app_complaint` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `complaint` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `reply` varchar(50) NOT NULL,
  `CUSTOMER_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_complaint_CUSTOMER_id_e9ee07ef_fk` (`CUSTOMER_id`),
  CONSTRAINT `product_app_complaint_CUSTOMER_id_e9ee07ef_fk` FOREIGN KEY (`CUSTOMER_id`) REFERENCES `product_app_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_complaint` */

insert  into `product_app_complaint`(`id`,`complaint`,`date`,`status`,`reply`,`CUSTOMER_id`) values 
(2,'shop products low quality','2025-03-20','pending','pending',7),
(3,'delivery boy rude','2025-03-20','replied',' will check sir',7),
(4,'slow delivery ','2025-03-20','replied',' U r far away sirrr',7);

/*Table structure for table `product_app_customer` */

DROP TABLE IF EXISTS `product_app_customer`;

CREATE TABLE `product_app_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `c_name` varchar(100) NOT NULL,
  `number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `dob` varchar(50) NOT NULL,
  `pic` varchar(300) NOT NULL,
  `place` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `pin` varchar(10) NOT NULL,
  `LOGIN_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_customer_LOGIN_id_64e02dcf_fk` (`LOGIN_id`),
  CONSTRAINT `product_app_customer_LOGIN_id_64e02dcf_fk` FOREIGN KEY (`LOGIN_id`) REFERENCES `product_app_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_customer` */

insert  into `product_app_customer`(`id`,`c_name`,`number`,`email`,`dob`,`pic`,`place`,`district`,`state`,`pin`,`LOGIN_id`) values 
(6,'hafeez','8593077795','hafeezpallath@gmail.com','2004-03-01','/media/user/20250320-023647.jpg.jpg','pattambi','palakkad','kerala ','679533',18),
(7,'rizwan','8282763828','rizwan@gmail.com','2004-03-20','/media/user/20250320-023827.jpg.jpg','ayinoor','thrissur','kerala','679536',19),
(8,'safzy','9373936847','safzy@gmail.com','2003-03-20','/media/user/20250320-023955.jpg.jpg','kootupatha','palakkad','kerala','736729',20);

/*Table structure for table `product_app_damaged_products` */

DROP TABLE IF EXISTS `product_app_damaged_products`;

CREATE TABLE `product_app_damaged_products` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `about` varchar(300) NOT NULL,
  `status` varchar(30) NOT NULL,
  `CUSTOMER_id` bigint(20) NOT NULL,
  `PRODUCT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_damaged_products_CUSTOMER_id_55549b5e_fk` (`CUSTOMER_id`),
  KEY `product_app_damaged_products_PRODUCT_id_3cfd72cc_fk` (`PRODUCT_id`),
  CONSTRAINT `product_app_damaged_products_CUSTOMER_id_55549b5e_fk` FOREIGN KEY (`CUSTOMER_id`) REFERENCES `product_app_customer` (`id`),
  CONSTRAINT `product_app_damaged_products_PRODUCT_id_3cfd72cc_fk` FOREIGN KEY (`PRODUCT_id`) REFERENCES `product_app_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_damaged_products` */

/*Table structure for table `product_app_delivery_boy` */

DROP TABLE IF EXISTS `product_app_delivery_boy`;

CREATE TABLE `product_app_delivery_boy` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `d_name` varchar(100) NOT NULL,
  `number` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `dob` varchar(50) NOT NULL,
  `pic` varchar(300) NOT NULL,
  `id_proof` varchar(300) NOT NULL,
  `place` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `pin` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `LOGIN_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_delivery_boy_LOGIN_id_f8575c5b_fk` (`LOGIN_id`),
  CONSTRAINT `product_app_delivery_boy_LOGIN_id_f8575c5b_fk` FOREIGN KEY (`LOGIN_id`) REFERENCES `product_app_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_delivery_boy` */

insert  into `product_app_delivery_boy`(`id`,`d_name`,`number`,`email`,`dob`,`pic`,`id_proof`,`place`,`district`,`state`,`pin`,`status`,`LOGIN_id`) values 
(4,'midlaj','8372973672','midlaj@gmail.com','2002-03-20','/media/user/20250320-031139.jpg','/media/user/20250320-0311391.jpg','vatuli','palakkad','kerala ','792782','approved',21),
(5,'athul','8373793672','athul@gmail.com','2006-03-20','/media/user/20250320-031328.jpg','/media/user/20250320-0313281.jpg','kunnamkukam ','thrissur ','kerala','837289','approved',22),
(6,'fahad','9272782679','fahad@gmail.com','2002-03-20','/media/user/20250320-031531.jpg','/media/user/20250320-0315311.jpg','palakkad','palakkad','kerala','827892','approved',23);

/*Table structure for table `product_app_feedback` */

DROP TABLE IF EXISTS `product_app_feedback`;

CREATE TABLE `product_app_feedback` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `feedback` varchar(100) NOT NULL,
  `CUSTOMER_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_feedback_CUSTOMER_id_482d5e35_fk` (`CUSTOMER_id`),
  CONSTRAINT `product_app_feedback_CUSTOMER_id_482d5e35_fk` FOREIGN KEY (`CUSTOMER_id`) REFERENCES `product_app_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_feedback` */

/*Table structure for table `product_app_login` */

DROP TABLE IF EXISTS `product_app_login`;

CREATE TABLE `product_app_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(15) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_login` */

insert  into `product_app_login`(`id`,`username`,`password`,`type`) values 
(13,'admin','admin','admin'),
(14,'fafa@gmail.com','Fafa@123','pending'),
(15,'yaseen@gmail.com','Yaseen@123','shop'),
(16,'safwan@gmail.com','Safwan@123','shop'),
(17,'fake@gmail.com','Fake@123','pending'),
(18,'hafeezpallath@gmail.com','hafees','user'),
(19,'rizwan@gmail.com','rizwan','user'),
(20,'safzy@gmail.com','safzy1','user'),
(21,'midlaj@gmail.com','midlaj','dboy'),
(22,'athul@gmail.com','Athul@123','dboy'),
(23,'fahad@gmail.com','fahadd','dboy');

/*Table structure for table `product_app_notification` */

DROP TABLE IF EXISTS `product_app_notification`;

CREATE TABLE `product_app_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `notification` varchar(100) NOT NULL,
  `SHOP_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_notification_SHOP_id_8531686f_fk` (`SHOP_id`),
  CONSTRAINT `product_app_notification_SHOP_id_8531686f_fk` FOREIGN KEY (`SHOP_id`) REFERENCES `product_app_shop` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_notification` */

/*Table structure for table `product_app_offers` */

DROP TABLE IF EXISTS `product_app_offers`;

CREATE TABLE `product_app_offers` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `offer_des` varchar(100) NOT NULL,
  `s_date` date NOT NULL,
  `e_date` date NOT NULL,
  `PRODUCT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_offers_PRODUCT_id_0d31986d_fk` (`PRODUCT_id`),
  CONSTRAINT `product_app_offers_PRODUCT_id_0d31986d_fk` FOREIGN KEY (`PRODUCT_id`) REFERENCES `product_app_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_offers` */

/*Table structure for table `product_app_order_main` */

DROP TABLE IF EXISTS `product_app_order_main`;

CREATE TABLE `product_app_order_main` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `request_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `amount` varchar(50) NOT NULL,
  `CUSTOMER_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_order_main_CUSTOMER_id_409a213e_fk` (`CUSTOMER_id`),
  CONSTRAINT `product_app_order_main_CUSTOMER_id_409a213e_fk` FOREIGN KEY (`CUSTOMER_id`) REFERENCES `product_app_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_order_main` */

/*Table structure for table `product_app_order_sub` */

DROP TABLE IF EXISTS `product_app_order_sub`;

CREATE TABLE `product_app_order_sub` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `r_quntity` varchar(50) NOT NULL,
  `ORDER_MAIN_id` bigint(20) NOT NULL,
  `PRODUCT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_order_sub_ORDER_MAIN_id_03a5c251_fk` (`ORDER_MAIN_id`),
  KEY `product_app_order_sub_PRODUCT_id_0685fcd0_fk` (`PRODUCT_id`),
  CONSTRAINT `product_app_order_sub_ORDER_MAIN_id_03a5c251_fk` FOREIGN KEY (`ORDER_MAIN_id`) REFERENCES `product_app_order_main` (`id`),
  CONSTRAINT `product_app_order_sub_PRODUCT_id_0685fcd0_fk` FOREIGN KEY (`PRODUCT_id`) REFERENCES `product_app_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_order_sub` */

/*Table structure for table `product_app_payments` */

DROP TABLE IF EXISTS `product_app_payments`;

CREATE TABLE `product_app_payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `p_date` date NOT NULL,
  `amnt` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL,
  `ORDER_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_payments_ORDER_id_2b83dee8_fk` (`ORDER_id`),
  CONSTRAINT `product_app_payments_ORDER_id_2b83dee8_fk` FOREIGN KEY (`ORDER_id`) REFERENCES `product_app_order_sub` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_payments` */

/*Table structure for table `product_app_product` */

DROP TABLE IF EXISTS `product_app_product`;

CREATE TABLE `product_app_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Product_name` varchar(50) NOT NULL,
  `pic` varchar(300) NOT NULL,
  `price` varchar(50) NOT NULL,
  `about` varchar(100) NOT NULL,
  `CATEGORY_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_product_CATEGORY_id_75187308_fk` (`CATEGORY_id`),
  CONSTRAINT `product_app_product_CATEGORY_id_75187308_fk` FOREIGN KEY (`CATEGORY_id`) REFERENCES `product_app_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_product` */

insert  into `product_app_product`(`id`,`Product_name`,`pic`,`price`,`about`,`CATEGORY_id`) values 
(3,'Overhead Earphones','/media/20250320-020825.jpg','299','bluetooth supported, 20hr battery backup',5),
(4,'Noise TWS','/media/20250320-022217.jpg','899',' 24hour Battery backup',5),
(5,'Phone Stand','/media/20250320-022405.jpg','350',' Multipurpose, steel made',6),
(6,'Chair','/media/20250321-141351.jpg','499',' Teak, cusioned chair',7),
(7,'Sofa','/media/20250321-141445.jpg','2999',' Two people can sit, 2 yr warranty\r\n',7),
(8,'Plant wall hanger','/media/20250321-141730.jpg','250',' doesnt come with plant.',8);

/*Table structure for table `product_app_review` */

DROP TABLE IF EXISTS `product_app_review`;

CREATE TABLE `product_app_review` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `rating` varchar(100) NOT NULL,
  `review` varchar(100) NOT NULL,
  `CUSTOMER_id` bigint(20) NOT NULL,
  `SHOP_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_review_CUSTOMER_id_b5062069_fk` (`CUSTOMER_id`),
  KEY `product_app_review_SHOP_id_6e73527d_fk` (`SHOP_id`),
  CONSTRAINT `product_app_review_CUSTOMER_id_b5062069_fk` FOREIGN KEY (`CUSTOMER_id`) REFERENCES `product_app_customer` (`id`),
  CONSTRAINT `product_app_review_SHOP_id_6e73527d_fk` FOREIGN KEY (`SHOP_id`) REFERENCES `product_app_shop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_review` */

/*Table structure for table `product_app_shop` */

DROP TABLE IF EXISTS `product_app_shop`;

CREATE TABLE `product_app_shop` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(50) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `location` varchar(50) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `id_proof` varchar(300) NOT NULL,
  `place` varchar(50) NOT NULL,
  `district` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `pin` varchar(10) NOT NULL,
  `status` varchar(50) NOT NULL,
  `LOGIN_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_shop_LOGIN_id_09384418_fk` (`LOGIN_id`),
  CONSTRAINT `product_app_shop_LOGIN_id_09384418_fk` FOREIGN KEY (`LOGIN_id`) REFERENCES `product_app_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_shop` */

insert  into `product_app_shop`(`id`,`shop_name`,`owner_name`,`location`,`contact_no`,`email`,`id_proof`,`place`,`district`,`state`,`pin`,`status`,`LOGIN_id`) values 
(3,'djedhjbz','fvewvfv','https://maps.app.goo.gl/YSyK29Nn4Xv8anUw5','9898987673','fafa@gmail.com','/media/20250320-014304.jpg','patatbi','palakkad','korale','838383','pending',14),
(4,'yaseen Mart','yaseen V S','https://maps.app.goo.gl/vwtw6KJCzgARPtJS6','9238399331','yaseen@gmail.com','/media/20250320-014546.jpg','kokkur','palakkad','Kerala','679591','approved',15),
(5,'Safu electronics','Safwan P','https://maps.app.goo.gl/RfHjErqsTusw78eb9','9238399322','safwan@gmail.com','/media/20250320-015010.jpg','koottupatha','palakkad','kerala','679533','approved',16),
(6,'fakerman\'s shop','fakeguy','https://maps.app.goo.gl/UyzYnkxtR8Y8fhoc7','9836454563','fake@gmail.com','/media/20250320-020849.jpg','area','jilla','karnataka','366333','pending',17);

/*Table structure for table `product_app_stocks` */

DROP TABLE IF EXISTS `product_app_stocks`;

CREATE TABLE `product_app_stocks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `s_quntity` varchar(50) NOT NULL,
  `PRODUCT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_app_stocks_PRODUCT_id_b25c11f4_fk` (`PRODUCT_id`),
  CONSTRAINT `product_app_stocks_PRODUCT_id_b25c11f4_fk` FOREIGN KEY (`PRODUCT_id`) REFERENCES `product_app_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `product_app_stocks` */

insert  into `product_app_stocks`(`id`,`s_quntity`,`PRODUCT_id`) values 
(3,'18',4),
(4,'10',5),
(5,'11',6),
(6,'40',7),
(7,'46',8);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
