# Hospital Management System (MySQL Project)

## 📌 Project Title
Hospital Management System

## 🎯 Objective
The objective of this project is to design and implement a **Hospital Management System using MySQL**.  
It helps hospital administrators efficiently manage patients, doctors, appointments, medical records, billing, and departments while applying advanced SQL concepts.

---

## 🧩 Problem Statement
The Hospital Management System enables the hospital administration to:

1. Manage Patients & Doctors (Add, Update, Delete, Search)
2. Schedule Appointments between patients and doctors
3. Handle Medical Records (diagnosis, prescriptions, treatments)
4. Manage Billing & Payments
5. Analyze Hospital Performance (revenue, doctor visits, patient history)

---

## 🗄️ Database Schema

### Tables Used

#### 1. Patients
- patient_id (Primary Key)
- name
- dob
- gender
- phone_number
- email
- address
- registration_date

#### 2. Doctors
- doctor_id (Primary Key)
- name
- specialization
- phone_number
- email
- available_days
- consultation_fee
- years_of_experience

#### 3. Appointments
- appointment_id (Primary Key)
- patient_id (Foreign Key)
- doctor_id (Foreign Key)
- appointment_date
- status (Scheduled, Completed, Cancelled)

#### 4. Medical_Records
- record_id (Primary Key)
- patient_id (Foreign Key)
- doctor_id (Foreign Key)
- diagnosis
- prescription
- treatment_date

#### 5. Billing
- invoice_id (Primary Key)
- patient_id (Foreign Key)
- appointment_id (Foreign Key)
- amount
- payment_status (Paid, Pending, Cancelled)
- payment_date

#### 6. Departments
- department_id (Primary Key)
- department_name

#### 7. Doctor_Department
- doctor_id (Foreign Key)
- department_id (Foreign Key)

---

## ⚙️ Functionalities Implemented

### ✔ CRUD Operations
- Insert, update, delete patient, doctor, and appointment data

### ✔ SQL Clauses
- WHERE
- HAVING
- LIMIT

### ✔ SQL Operators
- AND
- OR
- NOT

### ✔ Sorting & Grouping
- ORDER BY
- GROUP BY

### ✔ Aggregate Functions
- SUM
- AVG
- COUNT
- MAX
- MIN

### ✔ Joins
- INNER JOIN
- LEFT JOIN

### ✔ Subqueries
- Doctor and patient performance analysis

### ✔ Date & Time Functions
- MONTH()
- DATE_FORMAT()
- CURDATE()

### ✔ String Functions
- UPPER()
- TRIM()
- IFNULL()

### ✔ Window Functions
- RANK()
- Running totals
- Cumulative revenue

### ✔ CASE Expressions
- Patient risk level classification
- Doctor experience level categorization

---

## 📊 Sample Analysis
- Total hospital revenue
- Most visited doctor
- Average consultation fee
- Department-wise revenue
- Patient risk levels

---

## 🚀 How to Run the Project
1. Open **MySQL Workbench / phpMyAdmin**
2. Create a new SQL file
3. Import or paste `hospital_management.sql`
4. Execute the script
5. Run queries to view results

---

## 📁 Project Files
- hospital_management.sql → Complete SQL script
- README.md → Project documentation

---

## 🎓 Academic Use
This project is suitable for:
- DBMS Mini Project
- SQL Practical Exams
- College Assignments
- GitHub Portfolio

---

## ✨ Conclusion
This Hospital Management System demonstrates strong command over **MySQL database design and advanced SQL queries**, making it ideal for academic and practical learning.

---

**Quality is our Motto**
