-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema new_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `new_schema` DEFAULT CHARACTER SET latin1 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Patient_id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone_number` INT NULL,
  `Date_of_birth` DATE NULL,
  PRIMARY KEY (`Patient_id`),
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE,
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `new_schema`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`Specialist` (
  `ID` INT NOT NULL,
  `Field_area` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `new_schema`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`Doctor` (
  `Doctor_id` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Date_of_birth` DATE NULL DEFAULT NULL,
  `Address` VARCHAR(45) NULL DEFAULT NULL,
  `Phone_number` INT(11) NULL DEFAULT NULL,
  `Salary` INT(11) NULL DEFAULT NULL,
  `Specialist_ID` INT NOT NULL,
  PRIMARY KEY (`Doctor_id`),
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `Phone_number_UNIQUE` (`Phone_number` ASC) VISIBLE,
  UNIQUE INDEX `Specialist_ID_UNIQUE` (`Specialist_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_1`
    FOREIGN KEY (`Specialist_ID`)
    REFERENCES `new_schema`.`Specialist` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = macce;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `ID` VARCHAR(45) NOT NULL,
  `Patient_id` INT NOT NULL,
  `Doctor_id` INT NOT NULL,
  `Date` DATE NULL,
  `Time` TIME NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Appointment_2_idx` (`Doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_1`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`Patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_2`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `new_schema`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Payment_id` INT NOT NULL,
  `Details` BLOB NULL,
  `Method` ENUM('Card', 'Cash') NULL,
  PRIMARY KEY (`Payment_id`),
  UNIQUE INDEX `Payment_id_UNIQUE` (`Payment_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Bill_id` INT NOT NULL,
  `Total` INT NULL,
  `Patient_id` INT NOT NULL,
  PRIMARY KEY (`Bill_id`),
  UNIQUE INDEX `Bill_id_UNIQUE` (`Bill_id` ASC) VISIBLE,
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_1`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`Patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill_has_payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill_has_payment` (
  `Bill_id` INT NOT NULL,
  `Payment_id` INT NOT NULL,
  PRIMARY KEY (`Bill_id`, `Payment_id`),
  UNIQUE INDEX `Bill_id_UNIQUE` (`Bill_id` ASC) VISIBLE,
  UNIQUE INDEX `Payment_id_UNIQUE` (`Payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_has_payment_1`
    FOREIGN KEY (`Bill_id`)
    REFERENCES `mydb`.`Bill` (`Bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_payment_2`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `mydb`.`Payment` (`Payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `new_schema` ;

-- -----------------------------------------------------
-- Table `new_schema`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_schema`.`Medical` (
  `ID` INT NOT NULL,
  `Doctor_id` INT NOT NULL,
  `Overtime_rate` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Medical_1`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `new_schema`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
