-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Wed Jan 21 23:14:28 2015
-- 

;
BEGIN TRANSACTION;
--
-- Table: Category
--
CREATE TABLE Category (
  category_id INTEGER PRIMARY KEY NOT NULL,
  name varchar(50) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES item(category_fk) ON DELETE CASCADE
);
--
-- Table: item
--
CREATE TABLE item (
  item_id INTEGER PRIMARY KEY NOT NULL,
  category_fk integer NOT NULL,
  name varchar(96) NOT NULL,
  FOREIGN KEY (category_fk) REFERENCES Category(category_id)
);
CREATE INDEX item_idx_category_fk ON item (category_fk);
--
-- Table: tag
--
CREATE TABLE tag (
  tag_id INTEGER PRIMARY KEY NOT NULL,
  name varchar NOT NULL,
  FOREIGN KEY (tag_id) REFERENCES item_tag(tag_fk) ON DELETE CASCADE
);
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
COMMIT;
