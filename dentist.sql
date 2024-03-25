DROP DATABASE IF EXISTS dentist;
CREATE DATABASE dentist;
USE dentist;

CREATE TABLE patient (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    gender ENUM ('M', 'F', 'O'),
    age TINYINT UNSIGNED NOT NULL,
    address VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(15)
) AUTO_INCREMENT = 100;
INSERT INTO patient (name, gender, age, address, email, phone) VALUES
('Iarla Burke', 'M', 21, '123 Main St', 'iarla@example.com', '123-456-7890'),
('Tom Cruise', 'M', 61, '456 Oak Ave', 'tomcruise@example.com', '987-654-3210'),
('Sydney Sweeney', 'F', 26, '789 Pine Rd', 'sydney@example.com', '456-789-0123'),
('Emma Watson', 'F', 31, '321 Elm St', 'emma@example.com', '654-321-9870'),
('Robert Downey Jr.', 'M', 56, '654 Maple Ave', 'robert@example.com', '321-987-6540'),
('Scarlett Johansson', 'F', 37, '987 Birch Rd', 'scarlett@example.com', '789-012-3456'),
('Chris Hemsworth', 'M', 38, '345 Cedar Ln', 'chris@example.com', '012-345-6789');

CREATE TABLE dental_report (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    staff_id INT,
    datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    diagnosis VARCHAR(255),
    treatment VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (staff_id) REFERENCES staff(id)
);

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

