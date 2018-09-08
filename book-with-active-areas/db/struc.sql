CREATE TABLE `images_coords` (
`cid` INT NOT NULL ,
`image` VARCHAR( 255 ) NOT NULL ,
`info` TEXT NOT NULL ,

UNIQUE (
`cid`
)
) ENGINE = MYISAM ;

ALTER TABLE  `images_coords` ADD  `product_id` INT NOT NULL

-----

CREATE TABLE IF NOT EXISTS `images_coords` (
  `cid` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `info` text NOT NULL,
  UNIQUE KEY `cid` (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

