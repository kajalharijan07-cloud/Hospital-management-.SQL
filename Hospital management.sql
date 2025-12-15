


-- Hospital Management System - Complete SQL Script
-- Database: MySQL 8+


DROP DATABASE IF EXISTS hospital_management;
CREATE DATABASE hospital_management;
USE hospital_management;


-- 1. TABLES


CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    registration_date DATE
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    available_days VARCHAR(50),
    consultation_fee DECIMAL(10,2),
    years_of_experience INT
);

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Medical_Records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis VARCHAR(255),
    prescription VARCHAR(255),
    treatment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


CREATE TABLE Billing (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);


CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100)
);


CREATE TABLE Doctor_Department (
    doctor_id INT,
    department_id INT,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);


-- 2. SAMPLE DATA


INSERT INTO Patients (name, dob, gender, phone_number, email, address, registration_date) VALUES
('Rahul Sharma','1990-05-10','Male','9876543210','rahul@gmail.com','Delhi','2024-01-10'),
('Anita Verma','1988-08-22','Female',NULL,'anita@gmail.com','Mumbai','2023-06-15'),
('Suresh Kumar','1975-02-14','Male','9123456789','suresh@gmail.com','Chennai','2022-03-20');



INSERT INTO Doctors (name, specialization, phone_number, email, available_days, consultation_fee, years_of_experience) VALUES
('Dr. Mehta','Cardiology','9000000001','mehta@hosp.com','Mon-Fri',1500,18),
('Dr. Singh','Neurology','9000000002','singh@hosp.com','Tue-Sat',1200,10),
('Dr. Patel','Dermatology','9000000003','patel@hosp.com','Mon-Thu',800,4);



INSERT INTO Departments (department_name) VALUES
('Cardiology'),('Neurology'),('Dermatology');

INSERT INTO Doctor_Department VALUES
(1,1),(2,2),(3,3);


INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1,1,'2024-02-01','Completed'),
(2,2,'2024-02-05','Scheduled'),
(3,3,'2024-01-20','Completed');

INSERT INTO Medical_Records (patient_id, doctor_id, diagnosis, prescription, treatment_date) VALUES
(1,1,'Heart Issue','Medicine A','2024-02-01'),
(1,1,'BP Issue','Medicine B','2024-03-01'),
(3,3,'Skin Allergy','Cream X','2024-01-20');

INSERT INTO Billing (patient_id, appointment_id, amount, payment_status, payment_date) VALUES
(1,1,1500,'Paid','2024-02-01'),
(3,3,800,'Paid','2024-01-20');


-- 3. CRUD OPERATIONS


UPDATE Patients SET address='New Delhi' WHERE patient_id=1;


DELETE FROM Appointments WHERE status='Cancelled' AND appointment_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


-- 4. WHERE / HAVING / LIMIT


SELECT * FROM Patients WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

SELECT patient_id, SUM(amount) total_paid
FROM Billing GROUP BY patient_id
ORDER BY total_paid DESC LIMIT 5;

SELECT * FROM Doctors WHERE consultation_fee > 1000;


-- 5. AND / OR / NOT


SELECT * FROM Appointments WHERE status='Scheduled' AND doctor_id=2;


SELECT * FROM Doctors WHERE specialization='Cardiology' OR specialization='Neurology';

SELECT * FROM Patients
WHERE patient_id NOT IN (
    SELECT DISTINCT patient_id FROM Appointments
    WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);


-- 6. ORDER BY / GROUP BY


SELECT * FROM Doctors ORDER BY specialization;

SELECT doctor_id, COUNT(*) total_patients
FROM Appointments GROUP BY doctor_id;

SELECT d.department_name, SUM(b.amount) total_revenue
FROM Billing b
JOIN Appointments a ON b.appointment_id=a.appointment_id
JOIN Doctors doc ON a.doctor_id=doc.doctor_id
JOIN Doctor_Department dd ON doc.doctor_id=dd.doctor_id
JOIN Departments d ON dd.department_id=d.department_id
GROUP BY d.department_name;


-- 7. AGGREGATE FUNCTIONS


SELECT SUM(amount) AS total_revenue FROM Billing;

SELECT doctor_id, COUNT(*) visits
FROM Appointments GROUP BY doctor_id
ORDER BY visits DESC LIMIT 1;

SELECT AVG(consultation_fee) avg_fee FROM Doctors;


-- 8. JOINS


SELECT doc.name, d.department_name
FROM Doctors doc
INNER JOIN Doctor_Department dd ON doc.doctor_id=dd.doctor_id
INNER JOIN Departments d ON dd.department_id=d.department_id;

SELECT p.*
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id=a.patient_id
WHERE a.status='Completed';

SELECT a.*
FROM Appointments a
LEFT JOIN Billing b ON a.appointment_id=b.appointment_id
WHERE b.invoice_id IS NULL;


-- 9. SUBQUERIES


SELECT * FROM Doctors
WHERE doctor_id IN (
    SELECT doctor_id FROM Appointments
    GROUP BY doctor_id HAVING COUNT(*) > 1
);

SELECT * FROM Patients
WHERE patient_id = (
    SELECT patient_id FROM Billing
    GROUP BY patient_id ORDER BY SUM(amount) DESC LIMIT 1
);

SELECT * FROM Appointments
WHERE doctor_id IN (
    SELECT doctor_id FROM Doctors WHERE specialization='Dermatology'
);


-- 10. DATE FUNCTIONS


SELECT MONTH(appointment_date) month, COUNT(*) visits
FROM Appointments GROUP BY MONTH(appointment_date);

SELECT DATE_FORMAT(treatment_date,'%d-%m-%Y') FROM Medical_Records;


-- 11. STRING FUNCTIONS


SELECT UPPER(name) FROM Patients;
SELECT TRIM(name) FROM Doctors;
SELECT IFNULL(phone_number,'Not Available') FROM Patients;


-- 12. WINDOW FUNCTIONS


SELECT doctor_id, COUNT(*) total,
RANK() OVER (ORDER BY COUNT(*) DESC) rnk
FROM Appointments GROUP BY doctor_id;

SELECT DATE_FORMAT(payment_date,'%Y-%m') month,
SUM(amount) AS monthly_revenue,
SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date,'%Y-%m')) cumulative_revenue
FROM Billing GROUP BY month;


-- 13. CASE EXPRESSIONS


SELECT patient_id,
CASE
 WHEN COUNT(record_id) > 5 THEN 'High'
 WHEN COUNT(record_id) BETWEEN 3 AND 5 THEN 'Medium'
 ELSE 'Low'
END AS Patient_Risk_Level
FROM Medical_Records GROUP BY patient_id;


SELECT name,
CASE
 WHEN years_of_experience > 15 THEN 'Senior'
 WHEN years_of_experience BETWEEN 5 AND 15 THEN 'Mid-Level'
 ELSE 'Junior'
END AS Doctor_Level
FROM Doctors;
