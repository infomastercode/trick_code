-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema nabebox
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nabebox
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nabebox` DEFAULT CHARACTER SET utf8 ;
USE `nabebox` ;

-- -----------------------------------------------------
-- Table `nabebox`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`product` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`product` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `id_store` INT NULL,
  `id_category_default` INT NOT NULL,
  `on_sales` TINYINT NOT NULL,
  `product_name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `product_width` INT NULL,
  `product_height` INT NULL,
  `product_depth` INT NULL,
  `product_weight` INT NULL,
  `condition` VARCHAR(45) NOT NULL,
  `active` TINYINT NOT NULL,
  `date_add` DATETIME NOT NULL,
  `date_upd` DATETIME NOT NULL,
  PRIMARY KEY (`id_product`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`product_combination`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`product_combination` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`product_combination` (
  `id_product_combination` INT NOT NULL AUTO_INCREMENT,
  `id_product` INT NOT NULL,
  `reference` VARCHAR(45) NOT NULL,
  `ean` VARCHAR(45) NULL,
  `price` DECIMAL NOT NULL,
  `quantity` INT NOT NULL,
  `is_default` INT NOT NULL,
  PRIMARY KEY (`id_product_combination`),
  INDEX `fk_product_combination_product1_idx` (`id_product` ASC),
  CONSTRAINT `fk_product_combination_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `nabebox`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`orders` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`orders` (
  `id_orders` INT NOT NULL AUTO_INCREMENT,
  `reference` VARCHAR(45) NULL,
  `id_carrier` INT NULL,
  `id_cart` INT NULL,
  `id_address_delivery` INT NULL,
  `id_address_invoice` INT NULL,
  `status` VARCHAR(20) NULL,
  `payment` VARCHAR(45) NULL,
  `giff` VARCHAR(45) NULL,
  `shipping_number` VARCHAR(45) NULL,
  `total_discount` DECIMAL NULL,
  `total_pay` DECIMAL NULL,
  `total_shipping` DECIMAL NULL,
  `invoice_number` VARCHAR(45) NULL,
  `delivery_date` DATETIME NULL,
  `note` VARCHAR(255) NULL,
  `date_add` DATETIME NULL,
  `date_upd` DATETIME NULL,
  PRIMARY KEY (`id_orders`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`orders_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`orders_detail` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`orders_detail` (
  `id_orders_detail` INT NOT NULL AUTO_INCREMENT,
  `id_orders` INT NULL,
  `id_product` INT NULL,
  `id_attribute` INT NULL,
  `quantity` INT NULL,
  `price` DECIMAL NULL,
  PRIMARY KEY (`id_orders_detail`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`address` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  `id_customer` INT NULL,
  `alias` VARCHAR(45) NULL,
  `company` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `address` VARCHAR(255) NULL,
  `sub_distinct` VARCHAR(45) NULL,
  `distinct` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  `post_code` VARCHAR(20) NULL,
  `country` VARCHAR(45) NULL,
  `phone_1` VARCHAR(15) NULL,
  `phone_2` VARCHAR(15) NULL,
  `email` VARCHAR(45) NULL,
  `active` TINYINT NULL,
  `date_add` DATETIME NULL,
  `date_upd` DATETIME NULL,
  PRIMARY KEY (`id_address`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`attribute` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`attribute` (
  `id_attribute` INT NOT NULL AUTO_INCREMENT,
  `is_color` TINYINT NOT NULL,
  `attribute_type` TINYINT NULL,
  `attribute_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_attribute`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`attribute_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`attribute_detail` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`attribute_detail` (
  `id_attribute_detail` INT NOT NULL AUTO_INCREMENT,
  `id_attribute` INT NOT NULL,
  `attribute_detail_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_attribute_detail`),
  INDEX `fk_attribute_attribute_group1_idx` (`id_attribute` ASC),
  CONSTRAINT `fk_attribute_attribute_group1`
    FOREIGN KEY (`id_attribute`)
    REFERENCES `nabebox`.`attribute` (`id_attribute`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`customer` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`customer` (
  `id_customer` INT NOT NULL AUTO_INCREMENT,
  `id_group` TINYINT NULL,
  `company` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `secure_key` VARCHAR(45) NULL,
  `birthday` DATE NULL,
  `active` TINYINT NULL,
  `date_add` DATETIME NULL,
  `date_upd` DATETIME NULL,
  PRIMARY KEY (`id_customer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`category` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`category` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `id_parent` INT NOT NULL,
  `category_name` VARCHAR(45) NOT NULL,
  `level_depth` TINYINT NOT NULL,
  `position` TINYINT NOT NULL,
  `active` TINYINT NOT NULL,
  `date_add` DATETIME NOT NULL,
  `date_upd` DATETIME NOT NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`cart` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`cart` (
  `id_cart` INT NOT NULL AUTO_INCREMENT,
  `id_carrier` VARCHAR(45) NULL,
  `id_address_delivery` VARCHAR(45) NULL,
  `id_address_invoice` VARCHAR(45) NULL,
  `currcncy` VARCHAR(45) NULL,
  `id_customer` VARCHAR(45) NULL,
  `delivery_option` VARCHAR(45) NULL,
  `giff` VARCHAR(45) NULL,
  `date_add` VARCHAR(45) NULL,
  `date_upd` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cart`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`cart_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`cart_product` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`cart_product` (
  `id_cart_product` INT NOT NULL AUTO_INCREMENT,
  `id_product` VARCHAR(45) NULL,
  `id_product_attribute` VARCHAR(45) NULL,
  `id_address_delivery` VARCHAR(45) NULL,
  `quantity` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cart_product`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`carrier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`carrier` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`carrier` (
  `id_carrier` INT NOT NULL,
  `carrier_name` VARCHAR(45) NULL,
  `url` VARCHAR(45) NULL,
  `delay` VARCHAR(45) NULL,
  `service_charge` VARCHAR(45) NULL,
  `active` VARCHAR(45) NULL,
  `date_add` VARCHAR(45) NULL,
  `date_upd` VARCHAR(45) NULL,
  PRIMARY KEY (`id_carrier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`product_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`product_category` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`product_category` (
  `id_category_product` INT NOT NULL AUTO_INCREMENT,
  `id_product` INT NOT NULL,
  `id_category` INT NOT NULL,
  PRIMARY KEY (`id_category_product`),
  INDEX `fk_category_product_product1_idx` (`id_product` ASC),
  CONSTRAINT `fk_category_product_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `nabebox`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`store` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`store` (
  `id_store` INT NOT NULL AUTO_INCREMENT,
  `id_group` TINYINT NULL,
  `company` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `secure_key` VARCHAR(45) NULL,
  `birthday` DATE NULL,
  `active` TINYINT NOT NULL,
  `date_add` DATETIME NOT NULL,
  `date_upd` DATETIME NOT NULL,
  PRIMARY KEY (`id_store`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`product_attribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`product_attribute` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`product_attribute` (
  `id_product_attribute` INT NOT NULL AUTO_INCREMENT,
  `id_product_combination` INT NOT NULL,
  `id_attribute_detail` INT NOT NULL,
  PRIMARY KEY (`id_product_attribute`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`product_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`product_image` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`product_image` (
  `id_product_image` INT NOT NULL AUTO_INCREMENT,
  `id_product` INT NOT NULL,
  `level_image` INT NOT NULL,
  `image_type` VARCHAR(15) NOT NULL,
  `image_url_small` VARCHAR(255) NOT NULL,
  `image_url_medium` VARCHAR(255) NOT NULL,
  `image_url_large` VARCHAR(255) NOT NULL,
  `is_default` INT NOT NULL,
  PRIMARY KEY (`id_product_image`),
  INDEX `fk_product_image_product1_idx` (`id_product` ASC),
  CONSTRAINT `fk_product_image_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `nabebox`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nabebox`.`product_combination_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nabebox`.`product_combination_image` ;

CREATE TABLE IF NOT EXISTS `nabebox`.`product_combination_image` (
  `id_product_combination_image` INT NOT NULL AUTO_INCREMENT,
  `id_product_combination` INT NOT NULL,
  `id_product_image` INT NOT NULL,
  `is_default` INT NOT NULL,
  PRIMARY KEY (`id_product_combination_image`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
