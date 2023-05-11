CREATE TABLE IF NOT EXISTS `optical_store`.`CLIENTS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(35) NOT NULL,
  `address` VARCHAR(75) NOT NULL,
  `phone_number` INT NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `date_registered` DATE NOT NULL,
  `referred_by` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `referred_by_idx` (`referred_by` ASC) VISIBLE,
  CONSTRAINT `referred_by`
    FOREIGN KEY (`referred_by`)
    REFERENCES `optical_store`.`CLIENTS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
CREATE TABLE IF NOT EXISTS `optical_store`.`SUPPLIERS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(75) NOT NULL,
  `phone_number` INT NOT NULL,
  `fax` INT NOT NULL,
  `nif` CHAR(4) NOT NULL,
  PRIMARY KEY (`id`));
  CREATE TABLE IF NOT EXISTS `optical_store`.`FRAMES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
CREATE TABLE IF NOT EXISTS `optical_store`.`GLASSES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `supplier` INT NOT NULL,
  `brand` VARCHAR(20) NOT NULL,
  `perscription_left` FLOAT NOT NULL,
  `perscription_right` FLOAT NOT NULL,
  `frame_color` VARCHAR(15) NOT NULL,
  `lens_color_left` VARCHAR(15) NOT NULL,
  `lens_color_right` VARCHAR(15) NOT NULL,
  `price` FLOAT NOT NULL,
  `frame` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `frame_idx` (`frame` ASC) VISIBLE,
  INDEX `supplier_idx` (`supplier` ASC) VISIBLE,
  CONSTRAINT `frame`
    FOREIGN KEY (`frame`)
    REFERENCES `optical_store`.`FRAMES` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `supplier`
    FOREIGN KEY (`supplier`)
    REFERENCES `optical_store`.`SUPPLIERS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    CREATE TABLE IF NOT EXISTS `optical_store`.`EMPLOYEES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  CREATE TABLE IF NOT EXISTS `optical_store`.`SALES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `glasses` INT NOT NULL,
  `buyer` INT NOT NULL,
  `sales_person` INT NOT NULL,
  `sale_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `glasses_idx` (`glasses` ASC) VISIBLE,
  INDEX `buyer_idx` (`buyer` ASC) VISIBLE,
  INDEX `sales_person_idx` (`sales_person` ASC) VISIBLE,
  CONSTRAINT `glasses`
    FOREIGN KEY (`glasses`)
    REFERENCES `optical_store`.`GLASSES` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `buyer`
    FOREIGN KEY (`buyer`)
    REFERENCES `optical_store`.`CLIENTS` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `sales_person`
    FOREIGN KEY (`sales_person`)
    REFERENCES `optical_store`.`EMPLOYEES` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
