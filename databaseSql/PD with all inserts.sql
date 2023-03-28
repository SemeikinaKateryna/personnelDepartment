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
  `geo_link` VARCHAR(80) NOT NULL,
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
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`, `geo_link`) VALUES (1, 'USA', 'South San Francisco', 'Airport Blvd', 'https://goo.gl/maps/DmNBh2ovR6YE2jnE8');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`,`geo_link`) VALUES (2, 'Ukraine', 'Kiev', 'Shevchenko St', 'https://goo.gl/maps/EndZV7tycJgLDVDK9');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`,`geo_link`) VALUES (3, 'Ukraine', 'Kiev', 'Ivan Franko St', 'https://goo.gl/maps/h4Pg6HyxWyMTJkQW7');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`, `geo_link`) VALUES (4, 'Ukraine', 'Dnipro', 'Independence St', 'https://goo.gl/maps/EpqHcEsnQQQHfh7q7');
INSERT INTO `personnelDepartment`.`Location` (`id_location`, `country`, `city`, `local_address`, `geo_link`) VALUES (5, 'Ukraine', 'Kharkiv', 'Gagarin Av', 'https://goo.gl/maps/Aj4ufAe5iX1VtYAJ8');

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

-- ---------------------------------------------------------------------------------------------
-- Data for table `personnelDepartment`.`Employee` and table `personnelDepartment`.`Department`
-- ---------------------------------------------------------------------------------------------
START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (1, 'Flatcher', 'Simon', 43, '2020-05-05', 1, 4000, null, 'sFlatcher@gmail.com', '1992894690', null);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Department` (id_department, department_name, id_manager, id_location) VALUES (1, 'Main', 1, 1);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
UPDATE `Employee`
SET id_department = 1
WHERE id_employee = 1;
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (2, 'Tulchinsky', 'Egor', 41, '2020-05-05', 2, 3800, 1, 'tulchinsky@gmail.com', '9763803520', 1);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (3, 'Grigoreva', 'Nina', 38, '2020-07-27', 12, 2900, 1, 'ninaGr@gmail.com', '2662534678', 2);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (4, 'Pushkarev', 'Danil', 36, '2020-07-27', 3, 3500, null, 'dan.push@gmail.com', '2959809139', 2);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Department` (id_department, department_name, id_manager, id_location)
VALUES (2, 'Management', 4, 2);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
UPDATE `Employee`
SET id_department = 2
WHERE id_employee = 4;
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (5, 'Solovyova', 'Yaroslava', 33, '2020-08-03', 4, 3300, 2, 'yaroslvAslv@gmail.com', '2145798250', 4);
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (6, 'Sinichkina', 'Evgeniya', 28, '2021-01-04', 5, 3400, 2, 'evgeniyaSinch@gmail.com', '0194059338', 4);
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (7, 'Danilenko', 'Vlad', 32, '2020-09-07', 12, 2800, 2, 'danilenKovld@gmail.com', '3553462502', 4);
COMMIT ;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (8, 'Sokolova', 'Sofia', 27, '2020-05-05', 3, 3500, null, 'sokolsofia@gmail.com', '3639542896', 2);
COMMIT ;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Department` (id_department, department_name, id_manager, id_location)
VALUES (3, 'HR', 8, 3);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
UPDATE `Employee`
SET id_department = 3
WHERE id_employee = 8;
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (9, 'Tokareva', 'Stephania', 30, '2020-09-07', 6, 3200, 3, 'tok.Step@gmail.com', '8525903254', 8);
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (10, 'Maslyakov', 'Misha', 28, '2021-03-01', 12, 3100, 3, 'maslMish@gmail.com', '8997859220', 8);
COMMIT ;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (11, 'Shukin', 'Dmitry', 36, '2020-05-05', 3, 3700, null, 'shukinDm@gmail.com', '2916378240', 2);
COMMIT ;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Department` (id_department, department_name, id_manager, id_location)
VALUES (4, 'IT', 11, 4);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
UPDATE `Employee`
SET id_department = 4
WHERE id_employee = 11;
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (12, 'Voytilov', 'Evgen', 31, '2020-05-05', 7, 3500, 4, 'voyTevG@gmail.com', '8444619624', 11);
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (13, 'Semenko', 'Sergey', 28, '2020-05-05', 9, 3200, 4, 'sergSem@gmail.com ', '2501506083', 11);
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (14, 'Sereda', 'Anton', 36, '2020-05-05', 10, 3400, 4, 'sereda.Anton@gmail.com', '4888222717', 11);
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (15, 'Sereda', 'Alexandra', 28, '2020-05-25', 11, 2800, 4, 'sereda.Alexndra@gmail.com ', '5097589393', 11);
COMMIT ;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (16, 'Akinshina', 'Katerina', 35, '2020-06-01', 3, 3400, null, 'akkKaterinaSh@gmail.com', '6189523712', 2);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Department` (id_department, department_name, id_manager, id_location)
VALUES (5, 'Information Security', 16, 5);
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
UPDATE `Employee`
SET id_department = 5
WHERE id_employee = 16;
COMMIT;

START TRANSACTION;
USE `personnelDepartment`;
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (17, 'Grabets', 'Oleg', 36, '2020-09-01', 8, 3000, 5, 'oleg_grabts@gmail.com ', '9512614656', 16);
INSERT INTO `personnelDepartment`.`Employee` (id_employee, surname, name, age, hire_date, id_position, salary, id_department, email, phone_number, id_manager)
VALUES (18, 'Malinikova', 'Ulyana', 28, '2021-03-01', 8, 2900, 5, 'ulyana.malin@gmail.com', '0398255635', 16);
COMMIT;

-- -----------------------------------------------------
-- Data for table `personnelDepartment`.`History`
-- -----------------------------------------------------
START TRANSACTION;
USE `personnelDepartment`;

INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (1, 1, '2020-05-05', null, 1, 1);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (2, 2, '2020-05-05', '2020-09-01', 12, 1);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (3, 2, '2020-09-01', null, 2, 1);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (4, 3, '2020-07-27', null, 12, 1);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (5, 4, '2020-07-27', '2020-12-07', 5, 2);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (6, 4, '2021-01-04', null, 3, 2);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (7, 5, '2020-08-03', null, 4, 2);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (8, 6, '2021-01-04', null, 5, 2);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (9, 7, '2020-09-07', null, 12, 2);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (10, 8, '2020-05-05', null, 3, 3);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (11, 9, '2020-09-07', null, 6, 3);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (12, 10, '2021-03-01', '2021-07-05', 6, 3);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (13, 10, '2021-07-05', null, 12, 3);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (14, 11, '2020-05-05', '2021-05-03', 3, 2);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (15, 11, '2021-05-03', null, 3, 4);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (16, 12, '2020-05-05', null, 7, 4);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (17, 13, '2020-05-05', null, 9, 4);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (18, 14, '2020-05-05', null, 10, 4);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (19, 15, '2020-05-25', null, 11, 4);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (20, 16, '2020-06-01', '2021-06-07', 8, 5);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (21, 16, '2021-06-07', null, 3, 5);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (22, 17, '2020-09-01', null, 8, 5);
INSERT INTO `personnelDepartment`.`History` (id_history, id_employee, start_date, end_date, id_position, id_department) VALUES (23, 18, '2021-03-01', null, 8, 5);

COMMIT;