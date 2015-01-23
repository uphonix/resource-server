-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Fri Jan 23 04:05:17 2015
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
) ENGINE=InnoDB;
--
-- Table: `tag`
--
CREATE TABLE `tag` (
  `tag_id` integer NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE `uniq_tag_name` (`name`)
) ENGINE=InnoDB;
--
-- Table: `item`
--
CREATE TABLE `item` (
  `item_id` integer NOT NULL auto_increment,
  `category_fk` integer NOT NULL,
  `name` varchar(96) collate utf8_bin NOT NULL,
  INDEX `item_idx_category_fk` (`category_fk`),
  PRIMARY KEY (`item_id`),
  UNIQUE `item_category_uniq` (`item_id`, `category_fk`),
  CONSTRAINT `item_fk_category_fk` FOREIGN KEY (`category_fk`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB;
--
-- Table: `item_tag`
--
CREATE TABLE `item_tag` (
  `item_tag_id` integer NOT NULL auto_increment,
  `item_fk` integer NOT NULL,
  `tag_fk` integer NOT NULL,
  INDEX `item_tag_idx_item_fk` (`item_fk`),
  INDEX `item_tag_idx_tag_fk` (`tag_fk`),
  PRIMARY KEY (`item_tag_id`),
  UNIQUE `item_tag_uniq` (`item_fk`, `tag_fk`),
  CONSTRAINT `item_tag_fk_item_fk` FOREIGN KEY (`item_fk`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `item_tag_fk_tag_fk` FOREIGN KEY (`tag_fk`) REFERENCES `tag` (`tag_id`)
) ENGINE=InnoDB;
SET foreign_key_checks=1;
