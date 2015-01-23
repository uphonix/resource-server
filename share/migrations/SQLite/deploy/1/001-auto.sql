-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Fri Jan 23 04:05:17 2015
-- 

;
BEGIN TRANSACTION;
--
-- Table: category
--
CREATE TABLE category (
  category_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(50) NOT NULL
);
CREATE UNIQUE INDEX uniq_category ON category (name);
--
-- Table: tag
--
CREATE TABLE tag (
  tag_id INTEGER PRIMARY KEY NOT NULL,
  name varchar NOT NULL
);
CREATE UNIQUE INDEX uniq_tag_name ON tag (name);
--
-- Table: item
--
CREATE TABLE item (
  item_id INTEGER PRIMARY KEY NOT NULL,
  category_fk integer NOT NULL,
  name varchar(96) NOT NULL,
  FOREIGN KEY (category_fk) REFERENCES category(category_id)
);
CREATE INDEX item_idx_category_fk ON item (category_fk);
CREATE UNIQUE INDEX item_category_uniq ON item (item_id, category_fk);
--
-- Table: item_tag
--
CREATE TABLE item_tag (
  item_tag_id INTEGER PRIMARY KEY NOT NULL,
  item_fk integer NOT NULL,
  tag_fk integer NOT NULL,
  FOREIGN KEY (item_fk) REFERENCES item(item_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (tag_fk) REFERENCES tag(tag_id)
);
CREATE INDEX item_tag_idx_item_fk ON item_tag (item_fk);
CREATE INDEX item_tag_idx_tag_fk ON item_tag (tag_fk);
CREATE UNIQUE INDEX item_tag_uniq ON item_tag (item_fk, tag_fk);
COMMIT;
