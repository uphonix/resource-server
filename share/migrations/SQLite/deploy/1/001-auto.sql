-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Fri Jan 23 08:48:42 2015
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
  category_id integer NOT NULL,
  name varchar(96) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX item_idx_category_id ON item (category_id);
CREATE UNIQUE INDEX item_category_uniq ON item (item_id, category_id);
--
-- Table: item_tag
--
CREATE TABLE item_tag (
  item_tag_id INTEGER PRIMARY KEY NOT NULL,
  item_id integer NOT NULL,
  tag_id integer NOT NULL,
  FOREIGN KEY (item_id) REFERENCES item(item_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tag(tag_id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX item_tag_idx_item_id ON item_tag (item_id);
CREATE INDEX item_tag_idx_tag_id ON item_tag (tag_id);
CREATE UNIQUE INDEX item_tag_uniq ON item_tag (item_id, tag_id);
COMMIT;
