# Host: 127.0.0.1  (Version 5.7.20-log)
# Date: 2018-04-24 10:17:05
# Generator: MySQL-Front 5.4  (Build 4.153) - http://www.mysqlfront.de/

/*!40101 SET NAMES utf8 */;

#
# Structure for table "orgloaction"
#

DROP TABLE IF EXISTS `orgloaction`;
CREATE TABLE `orgloaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orgcode` int(11) DEFAULT NULL,
  `lng` decimal(18,15) DEFAULT NULL COMMENT '经度',
  `lat` decimal(18,15) DEFAULT NULL COMMENT '维度',
  `type` int(1) unsigned zerofill DEFAULT '1' COMMENT '点还是面',
  `length` int(11) unsigned zerofill DEFAULT '00000000000' COMMENT '距离',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
