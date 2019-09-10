# content.sql
# ------------------------------------------------------------

DROP TABLE IF EXISTS `stories`;

CREATE TABLE `stories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `launch_date` date DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `likes` int(10) unsigned NOT NULL DEFAULT '0',
  `privacy` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=994 DEFAULT CHARSET=utf8;
