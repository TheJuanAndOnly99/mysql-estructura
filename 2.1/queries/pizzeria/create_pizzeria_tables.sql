-- MySQL Script generated by MySQL Workbench
-- Wed May 10 11:18:16 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`CLIENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`CLIENTS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `zipcode` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `phone_number` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `address_UNIQUE` (`address` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`STORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`STORES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NOT NULL,
  `zipcode` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `address_UNIQUE` (`address` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`ROLE_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`ROLE_TYPE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `role_name_UNIQUE` (`role_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`EMPLOYEES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`EMPLOYEES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `store` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `phone_number` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `employee_store_idx` (`store` ASC) VISIBLE,
  INDEX `role_idx` (`role` ASC) VISIBLE,
  CONSTRAINT `employee_store`
    FOREIGN KEY (`store`)
    REFERENCES `pizzeria`.`STORES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `role`
    FOREIGN KEY (`role`)
    REFERENCES `pizzeria`.`ROLE_TYPE` (`role_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`ORDER_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`ORDER_TYPE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `order_type_UNIQUE` (`order_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`ORDERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`ORDERS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client` INT NOT NULL,
  `store` INT NOT NULL,
  `date/time` DATETIME NOT NULL,
  `order_type` INT NOT NULL,
  `total_price` FLOAT NOT NULL,
  `delivered_by` INT NULL,
  `date/time_delivered` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `date/time_UNIQUE` (`date/time` ASC) VISIBLE,
  INDEX `clients_idx` (`client` ASC) VISIBLE,
  INDEX `store_idx` (`store` ASC) VISIBLE,
  INDEX `delivered_by_idx` (`delivered_by` ASC) VISIBLE,
  INDEX `order_type_idx` (`order_type` ASC) VISIBLE,
  CONSTRAINT `clients`
    FOREIGN KEY (`client`)
    REFERENCES `pizzeria`.`CLIENTS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `store`
    FOREIGN KEY (`store`)
    REFERENCES `pizzeria`.`STORES` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `delivered_by`
    FOREIGN KEY (`delivered_by`)
    REFERENCES `pizzeria`.`EMPLOYEES` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `order_type`
    FOREIGN KEY (`order_type`)
    REFERENCES `pizzeria`.`ORDER_TYPE` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`CATEGORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`CATEGORY` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`PRODUCT_TYPE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`PRODUCT_TYPE` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`PRODUCTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`PRODUCTS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `image` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `category` INT NOT NULL,
  `type` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `category_idx` (`category` ASC) VISIBLE,
  INDEX `type_idx` (`type` ASC) VISIBLE,
  CONSTRAINT `category`
    FOREIGN KEY (`category`)
    REFERENCES `pizzeria`.`CATEGORY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `type`
    FOREIGN KEY (`type`)
    REFERENCES `pizzeria`.`PRODUCT_TYPE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`PRODUCTS_ORDERED`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`PRODUCTS_ORDERED` (
  `order` INT NOT NULL,
  `product` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `product_idx` (`product` ASC) VISIBLE,
  INDEX `order_idx` (`order` ASC) VISIBLE,
  CONSTRAINT `product`
    FOREIGN KEY (`product`)
    REFERENCES `pizzeria`.`PRODUCTS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `order`
    FOREIGN KEY (`order`)
    REFERENCES `pizzeria`.`ORDERS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
