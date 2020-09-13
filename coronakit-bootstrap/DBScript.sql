CREATE TABLE `coronakitdb`.`productmaster` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(45) NOT NULL,
  `cost` VARCHAR(45) NOT NULL,
  `productdescription` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);
  
INSERT INTO `coronakitdb`.`productmaster` (`productName`, `cost`, `productdescription`) VALUES ('Face Mask', '5.00', 'Face Mask');
INSERT INTO `coronakitdb`.`productmaster` (`productName`, `cost`, `productdescription`) VALUES ('Home Sanitizer', '80.00', 'To sanitize your hands');
INSERT INTO `coronakitdb`.`productmaster` (`productName`, `cost`, `productdescription`) VALUES ('Vitamin-C Tab', '50.00', 'Vit-C tablets to boost immunity');
INSERT INTO `coronakitdb`.`productmaster` (`productName`, `cost`, `productdescription`) VALUES ('Dolo-650mg', '50.00', 'Fever tablets');
INSERT INTO `coronakitdb`.`productmaster` (`productName`, `cost`, `productdescription`) VALUES ('Azitrhromicine', '100.00', 'Antibiotic medicine');


CREATE TABLE `coronakitdb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `personname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `contactnumber` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `contactnumber_UNIQUE` (`contactnumber` ASC) VISIBLE);
  
ALTER TABLE `coronakitdb`.`users` 
ADD COLUMN `deliveryaddress` VARCHAR(45) NULL AFTER `contactnumber`,
ADD COLUMN `totalamount` INT NULL AFTER `deliveryaddress`,
ADD COLUMN `orderdate` VARCHAR(45) NULL AFTER `totalamount`,
ADD COLUMN `orderfinalized` TINYINT NULL AFTER `orderdate`, RENAME TO  `coronakitdb`.`coronakitinfo` ;
  
CREATE TABLE `coronakitdb`.`kitdetails` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productname` VARCHAR(45) NOT NULL,
  `coronakitid` INT NOT NULL,
  `productid` INT NOT NULL,
  `quantity` INT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`id`));
  
