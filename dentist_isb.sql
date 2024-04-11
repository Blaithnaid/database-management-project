DROP DATABASE IF EXISTS dentist_isb;
CREATE DATABASE dentist_isb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dentist_isb;



CREATE TABLE `patient` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `date_of_birth` DATE NOT NULL,
    `gender` ENUM ('M', 'F', 'O', 'N/A'),
    `address` TEXT NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(15)
) AUTO_INCREMENT = 1000;
INSERT INTO `patient` (`name`, `gender`, `date_of_birth`, `address`, `email`, `phone`) VALUES
('Iarla Burke', 'M', '2002-10-18', '123 Main St, Dublin', 'iarla@test.com', '1234567890'),
('Tom Cruise', 'M', '1962-07-03', '456 Elm St, Los Angeles', 'tom@gmail.com', '0987654321'),
('Michael Shannon', 'M', '1974-08-07', '789 Oak St, Chicago', 'mike@hotmail.com', '1357924680'),
('Ayo Edebiri', 'F', '1997-08-27', '321 Pine St, New York', 'ayo@protonmail.com', '2468135790'),
('David Lynch', 'M', '1946-01-20', '654 Cedar St, Los Angeles', 'david@davidlynch.com', '9876543210'),
('Greta Gerwig', 'F', '1983-08-04', '987 Birch St, New York', 'greta@yahoo.com', '3692581470'), 
('Stephen Rea', 'M', '1946-10-31', '147 Maple St, Dublin', 'stephen@yahoo.ie', '2581473690');



CREATE TABLE `staff` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `license_number` VARBINARY(255) NOT NULL,
    `name` VARCHAR(255),
    `age` TINYINT UNSIGNED NOT NULL,
    `gender` ENUM ('M', 'F'),
    `position` ENUM ('Dentist', 'Hygienist', 'Receptionist', 'Assistant')
) AUTO_INCREMENT = 2000;
INSERT INTO `staff` (`name`, `license_number`, `age`, `gender`, `position`) VALUES 
('Dr. John Doe', AES_ENCRYPT('123456', 'password'), 35, 'M', 'Dentist'),
('Dr. Jane Smith', AES_ENCRYPT('654321', 'password'), 40, 'F', 'Dentist'),
('Dr. Michael Johnson', AES_ENCRYPT('456789', 'password'), 45, 'M', 'Dentist'),
('Dr. Sarah Williams', AES_ENCRYPT('987654', 'password'), 30, 'F', 'Dentist'),
('Dr. David Brown', AES_ENCRYPT('789456', 'password'), 50, 'M', 'Dentist'),
('Dr. Emily Davis', AES_ENCRYPT('321654', 'password'), 25, 'F', 'Dentist'),
('Dr. Robert Wilson', AES_ENCRYPT('654987', 'password'), 55, 'M', 'Dentist'),
('Dr. Laura Martinez', AES_ENCRYPT('987321', 'password'), 28, 'F', 'Dentist'),
('Dr. James Taylor', AES_ENCRYPT('456123', 'password'), 60, 'M', 'Dentist'),
('Dr. Maria Garcia', AES_ENCRYPT('123789', 'password'), 33, 'F', 'Dentist');



CREATE TABLE `dental_report` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `patient_id` INT UNSIGNED NOT NULL,
    `staff_id` INT UNSIGNED NOT NULL,
    `datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `diagnosis` VARCHAR(255),
    `treatment` VARCHAR(255),
    `xray_image` MEDIUMBLOB,
    FOREIGN KEY (`patient_id`) REFERENCES `patient`(`id`),
    FOREIGN KEY (`staff_id`) REFERENCES `staff`(`id`)
) AUTO_INCREMENT = 3000;
INSERT INTO `dental_report` (`patient_id`, `staff_id`, `datetime`, `diagnosis`, `treatment`, `xray_image`) VALUES
(1000, 2000, '2022-01-01 09:30:00', 'Cavity', 'Filling', LOAD_FILE('/Applications/XAMPP/xamppfiles/htdocs/dentist-isb/xray/xray1.jpeg')),
(1001, 2001, '2022-01-02 10:30:00', 'Gum disease', 'Deep cleaning', LOAD_FILE('/Applications/XAMPP/xamppfiles/htdocs/dentist-isb/xray/xray2.jpeg')),
(1002, 2002, '2022-01-03 11:30:00', 'Tooth decay', 'Extraction', LOAD_FILE('/Applications/XAMPP/xamppfiles/htdocs/dentist-isb/xray/xray3.jpeg')),
(1003, 2003, '2022-01-04 12:30:00', 'Toothache', 'Root canal', LOAD_FILE('/Applications/XAMPP/xamppfiles/htdocs/dentist-isb/xray/xray4.jpeg')),
(1004, 2004, '2022-01-05 13:30:00', 'Cracked tooth', 'Crown', LOAD_FILE('/Applications/XAMPP/xamppfiles/htdocs/dentist-isb/xray/xray5.jpeg')),
(1005, 2005, '2022-01-06 14:30:00', 'Abscess', 'Drainage', LOAD_FILE('/Applications/XAMPP/xamppfiles/htdocs/dentist-isb/xray/xray6.jpeg'));



CREATE TABLE `appointment` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `booking_type` ENUM ('Phone', 'In-Person', 'Online', 'Postal'),
    `patient_id` INT UNSIGNED NOT NULL,
    `staff_id` INT UNSIGNED NOT NULL,
    `appt_datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `duration` INT DEFAULT 60,
    `reason` VARCHAR(255),
    FOREIGN KEY (`patient_id`) REFERENCES `patient`(`id`),
    FOREIGN KEY (`staff_id`) REFERENCES `staff`(`id`)
) AUTO_INCREMENT = 4000;
INSERT INTO `appointment` (`booking_type`, `patient_id`, `staff_id`, `appt_datetime`, `duration`, `reason`) VALUES 
('Phone', 1000, 2000, '2022-01-01 09:00:00', 30, 'Check-up'),
('In-Person', 1001, 2001, '2022-01-02 10:00:00', 60, 'Cleaning'),
('Online', 1002, 2002, '2022-01-03 11:00:00', 40, 'Extraction'),
('Postal', 1003, 2003, '2022-01-04 12:00:00', 30, 'Consultation'),
('Phone', 1004, 2004, '2022-01-05 13:00:00', 60, 'Filling'),
('In-Person', 1005, 2005, '2022-01-06 14:00:00', 60, 'Root Canal'),
('Online', 1006, 2006, '2022-01-07 15:00:00', 30, 'X-ray');



CREATE TABLE `billing` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `patient_id` INT UNSIGNED NOT NULL,
    `date` DATE,
    `amount` DECIMAL(10, 2),
    `payment_method` ENUM ('Cash', 'Credit Card', 'Debit Card', 'Cheque', 'Bank Transfer'),
    FOREIGN KEY (`patient_id`) REFERENCES `patient`(`id`)
) AUTO_INCREMENT = 5000;
INSERT INTO `billing` (`patient_id`, `date`, `amount`, `payment_method`) VALUES
(1000, '2022-01-01', 100.00, 'Cash'),
(1001, '2022-01-02', 200.00, 'Credit Card'),
(1003, '2022-01-03', 300.00, 'Debit Card'),
(1002, '2022-01-04', 400.00, 'Cheque'),
(1004, '2022-01-05', 500.00, 'Bank Transfer'),
(1005, '2022-01-06', 600.00, 'Cash'),
(1004, '2022-01-07', 700.00, 'Credit Card'),
(1006, '2022-01-08', 800.00, 'Debit Card'),
(1001, '2022-01-09', 900.00, 'Cheque'),
(1002, '2022-01-10', 1000.00, 'Bank Transfer');