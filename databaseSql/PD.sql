-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema personnelDepartment
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `personnelDepartment` ;

-- -----------------------------------------------------
-- Schema personnelDepartment
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `personnelDepartment` DEFAULT CHARACTER SET utf8 ;
USE `personnelDepartment` ;

-- -----------------------------------------------------
-- Table `personnelDepartment`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `personnelDepartment`.`Location` (
  `id_location` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `local_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_location`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `personnelDepartment`.`Department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `personnelDepartment`.`Department` (
  `id_department` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  `id_manager` INT NOT NULL,
  `id_location` INT NOT NULL,
  PRIMARY KEY (`id_department`),
  INDEX `fk_dept_mgr_idx` (`id_manager` ASC) VISIBLE,
  INDEX `fk_dept_loc_idx` (`id_location` ASC) VISIBLE,
  CONSTRAINT `fk_dept_mgr`
    FOREIGN KEY (`id_manager`)
    REFERENCES `personnelDepartment`.`Employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dept_loc`
    FOREIGN KEY (`id_location`)
    REFERENCES `personnelDepartment`.`Location` (`id_location`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `personnelDepartment`.`Position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `personnelDepartment`.`Position` (
  `id_position` INT NOT NULL AUTO_INCREMENT,
  `position_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_position`),
  UNIQUE INDEX `position_name_UNIQUE` (`position_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `personnelDepartment`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `personnelDepartment`.`Employee` (
  `id_employee` INT NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NOT NULL,
  `hire_date` DATE NOT NULL,
  `id_position` INT NOT NULL,
  `salary` INT NOT NULL,
  `id_department` INT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL DEFAULT '0000000000',
  `id_manager` INT NULL,
  PRIMARY KEY (`id_employee`),
  INDEX `fk_emp_dept_idx` (`id_department` ASC) VISIBLE,
  INDEX `fk_emp_pos_idx` (`id_position` ASC) INVISIBLE,
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_emp_mgr_idx` (`id_manager` ASC) VISIBLE,
  CONSTRAINT `fk_emp_dept`
    FOREIGN KEY (`id_department`)
    REFERENCES `personnelDepartment`.`Department` (`id_department`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_pos`
    FOREIGN KEY (`id_position`)
    REFERENCES `personnelDepartment`.`Position` (`id_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emp_mgr`
    FOREIGN KEY (`id_manager`)
    REFERENCES `personnelDepartment`.`Employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `personnelDepartment`.`History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `personnelDepartment`.`History` (
  `id_history` INT NOT NULL AUTO_INCREMENT,
  `id_employee` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `id_position` INT NOT NULL,
  `id_department` INT NOT NULL,
  PRIMARY KEY (`id_history`),
  INDEX `fk_his_emp_idx` (`id_employee` ASC) VISIBLE,
  INDEX `fk_his_pos_idx` (`id_position` ASC) VISIBLE,
  INDEX `fk_gis_dept_idx` (`id_department` ASC) VISIBLE,
  CONSTRAINT `fk_his_emp`
    FOREIGN KEY (`id_employee`)
    REFERENCES `personnelDepartment`.`Employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_his_pos`
    FOREIGN KEY (`id_position`)
    REFERENCES `personnelDepartment`.`Position` (`id_position`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gis_dept`
    FOREIGN KEY (`id_department`)
    REFERENCES `personnelDepartment`.`Department` (`id_department`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `personnelDepartment`.`Location`
-- -----------------------------------------------------
START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`) VALUES (1, 'USA', 'South San Francisco', 'Interiors Blvd');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`) VALUES (2, 'Ukraine', 'Kiev', 'Shevchenko St');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`) VALUES (3, 'Ukraine', 'Kiev', 'Ivan Franko St');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`) VALUES (4, 'Ukraine', 'Dnipro', 'Independence St');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`) VALUES (5, 'Ukraine', 'Kharkiv', 'Gagarin Av');

COMMIT;



-- -----------------------------------------------------
-- Data for table `personnelDepartment`.`Position`
-- -----------------------------------------------------
START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (1, 'Director');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (2, 'Deputy Director');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (3, 'Head of department');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (4, 'Sales Manager');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (5, 'Finance Manager');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (6, 'HR Manager');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (7, 'Team Lead');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (8, 'Information Security Specialist');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (9, 'Web-designer');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (10, 'Programmer');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (11, 'Tester');
INSERT INTO `personnelDepartment`.`Position` (`id_position`, `position_name`) VALUES (12, 'Assistant');

COMMIT;
