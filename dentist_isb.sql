DROP DATABASE IF EXISTS dentist_isb;
CREATE DATABASE dentist_isb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE dentist_isb;



CREATE TABLE `patient` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
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
('Greta Gerwig', 'F', '1983-08-04', '987 Birch St, New York', 'greta@yahoo.com', '3692581470');



CREATE TABLE staff (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    age TINYINT UNSIGNED NOT NULL,
    gender ENUM ('M', 'F'),
    position ENUM ('Dentist', 'Hygienist', 'Receptionist', 'Assistant')
);
INSERT INTO staff (name, age, gender, position) VALUES
('Dr. Brown', 45, 'M', 'Dentist'),
('Dr. Green', 40, 'F', 'Dentist'),
('Ms. White', 30, 'F', 'Hygienist'),
('Mr. Black', 35, 'M', 'Receptionist'),
('Ms. Blue', 25, 'F', 'Hygienist'),
('Mr. Red', 50, 'M', 'Assistant'),
('Ms. Yellow', 28, 'F', 'Assistant');



CREATE TABLE dental_report (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    staff_id INT,
    datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    diagnosis VARCHAR(255),
    treatment VARCHAR(255),
    xray_image BLOB,
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (staff_id) REFERENCES staff(id)
) AUTO_INCREMENT = 2000;
INSERT INTO dental_report (patient_id, staff_id, datetime, diagnosis, treatment, xray_image) VALUES
(1000, 1, '2022-01-01 09:30:00', 'Cavity', 'Filling', LOAD_FILE('C:/xampp/htdocs/dentist_isb/xray/xray1.png')),
(1001, 2, '2022-01-02 10:30:00', 'Gum disease', 'Deep cleaning', LOAD_FILE('C:/xampp/htdocs/dentist_isb/xray/xray2.png')),
(1002, 3, '2022-01-03 11:30:00', 'Tooth decay', 'Extraction', LOAD_FILE('C:/xampp/htdocs/dentist_isb/xray/xray3.png')),
(1003, 4, '2022-01-04 12:30:00', 'Toothache', 'Root canal', LOAD_FILE('C:/xampp/htdocs/dentist_isb/xray/xray4.png')),
(1004, 5, '2022-01-05 13:30:00', 'Cracked tooth', 'Crown', LOAD_FILE('C:/xampp/htdocs/dentist_isb/xray/xray5.png')),
(1005, 6, '2022-01-06 14:30:00', 'Abscess', 'Drainage', LOAD_FILE('C:/xampp/htdocs/dentist_isb/xray/xray6.png'))



CREATE TABLE appointment (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    booking_type ENUM ('Phone', 'In-Person', 'Online', 'Postal'),
    patient_id INT NOT NULL,
    staff_id INT NOT NULL,
    datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    duration INT DEFAULT 60,
    reason VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (staff_id) REFERENCES staff(id)
);
INSERT INTO appointment (booking_type, patient_id, staff_id, datetime, duration, reason) VALUES 
('Phone', 100, 1, '2022-01-01 09:00:00', 30, 'Check-up'),
('In-Person', 101, 2, '2022-01-02 10:00:00', 60, 'Cleaning'),
('Online', 102, 3, '2022-01-03 11:00:00', 40, 'Extraction'),
('Postal', 103, 4, '2022-01-04 12:00:00', 30, 'Consultation'),
('Phone', 104, 5, '2022-01-05 13:00:00', 60, 'Filling'),
('In-Person', 105, 6, '2022-01-06 14:00:00', 60, 'Root Canal'),
('Online', 106, 7, '2022-01-07 15:00:00', 30, 'X-ray');

CREATE TABLE billing (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    patient_id INT UNSIGNED NOT NULL,
    date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

