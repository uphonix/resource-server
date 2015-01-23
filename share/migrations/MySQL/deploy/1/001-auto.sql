-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Fri Jan 23 08:48:42 2015
-- 
;
SET foreign_key_checks=0;
--
-- Table: `category`
--
CREATE TABLE `category` (
  `category_id` integer NOT NULL auto_increment,
  `name` varchar(50) collate utf8_bin NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE `uniq_category` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table: `tag`
--
CREATE TABLE `tag` (
  `tag_id` integer NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE `uniq_tag_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table: `item`
--
CREATE TABLE `item` (
  `item_id` integer NOT NULL auto_increment,
  `category_id` integer NOT NULL,
  `name` varchar(96) collate utf8_bin NOT NULL,
  INDEX `item_idx_category_id` (`category_id`),
  PRIMARY KEY (`item_id`),
  UNIQUE `item_category_uniq` (`item_id`, `category_id`),
  CONSTRAINT `item_fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Table: `item_tag`
--
CREATE TABLE `item_tag` (
  `item_tag_id` integer NOT NULL auto_increment,
  `item_id` integer NOT NULL,
  `tag_id` integer NOT NULL,
  INDEX `item_tag_idx_item_id` (`item_id`),
  INDEX `item_tag_idx_tag_id` (`tag_id`),
  PRIMARY KEY (`item_tag_id`),
  UNIQUE `item_tag_uniq` (`item_id`, `tag_id`),
  CONSTRAINT `item_tag_fk_item_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `item_tag_fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET foreign_key_checks=1;
