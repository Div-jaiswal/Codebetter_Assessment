create database Appointment_System

-- Creating tables
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Specialties (
    specialty_id INT PRIMARY KEY,
    specialty_name VARCHAR(100)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    department_id INT,
    specialty_id INT,
    joining_date DATE,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (specialty_id) REFERENCES Specialties(specialty_id)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    date_of_birth DATE,
    gender VARCHAR(10),
    address TEXT
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    appointment_date DATETIME,
    reason TEXT,
    status VARCHAR(20),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    appointment_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Inserting data
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Dermatology'),
(5, 'Pediatrics'),
(6, 'General Surgery'),
(7, 'Gastroenterology'),
(8, 'Endocrinology'),
(9, 'Oncology'),
(10, 'Radiology');

INSERT INTO Specialties (specialty_id, specialty_name) VALUES
(1, 'Heart Surgery'),
(2, 'Brain Disorders'),
(3, 'Bone Fractures'),
(4, 'Skin Issues'),
(5, 'Child Health'),
(6, 'Abdominal Surgery'),
(7, 'Digestive System'),
(8, 'Hormonal Issues'),
(9, 'Cancer Treatment'),
(10, 'Medical Imaging');

INSERT INTO Doctors (doctor_id, first_name, last_name, email, phone, department_id, specialty_id, joining_date) VALUES
(101, 'John', 'Doe', 'john.doe@example.com', '1234567890', 1, 1, '2015-06-15'),
(102, 'Alice', 'Smith', 'alice.smith@example.com', '1234567891', 2, 2, '2017-03-10'),
(103, 'Bob', 'Johnson', 'bob.johnson@example.com', '1234567892', 3, 3, '2018-09-20'),
(104, 'Charlie', 'Brown', 'charlie.brown@example.com', '1234567893', 4, 4, '2016-01-25'),
(105, 'Emma', 'Taylor', 'emma.taylor@example.com', '1234567894', 5, 5, '2020-11-05'),
(106, 'Liam', 'Walker', 'liam.walker@example.com', '1234567895', 6, 6, '2014-08-10'),
(107, 'Olivia', 'Martinez', 'olivia.martinez@example.com', '1234567896', 7, 7, '2019-04-22'),
(108, 'William', 'Lee', 'william.lee@example.com', '1234567897', 8, 8, '2021-01-15'),
(109, 'Sophia', 'Davis', 'sophia.davis@example.com', '1234567898', 9, 9, '2013-11-30'),
(110, 'James', 'Anderson', 'james.anderson@example.com', '1234567899', 10, 10, '2016-07-19');

INSERT INTO Patients (patient_id, first_name, last_name, email, phone, date_of_birth, gender, address) VALUES
(201, 'Michael', 'Green', 'michael.green@example.com', '9876543210', '1990-05-22', 'Male', '123 Elm St, Springfield'),
(202, 'Sarah', 'Connor', 'sarah.connor@example.com', '9876543211', '1985-07-14', 'Female', '456 Oak St, Springfield'),
(203, 'David', 'Lee', 'david.lee@example.com', '9876543212', '1995-03-10', 'Male', '789 Pine St, Springfield'),
(204, 'Sophia', 'Williams', 'sophia.williams@example.com', '9876543213', '2000-01-08', 'Female', '321 Maple St, Springfield'),
(205, 'James', 'Brown', 'james.brown@example.com', '9876543214', '1988-11-30', 'Male', '654 Birch St, Springfield'),
(206, 'Emily', 'Clark', 'emily.clark@example.com', '9876543215', '1992-09-19', 'Female', '987 Cedar St, Springfield'),
(207, 'Daniel', 'Garcia', 'daniel.garcia@example.com', '9876543216', '1991-12-12', 'Male', '543 Walnut St, Springfield'),
(208, 'Isabella', 'Harris', 'isabella.harris@example.com', '9876543217', '1998-06-05', 'Female', '678 Poplar St, Springfield'),
(209, 'Ethan', 'Martin', 'ethan.martin@example.com', '9876543218', '1993-04-21', 'Male', '432 Chestnut St, Springfield'),
(210, 'Grace', 'Young', 'grace.young@example.com', '9876543219', '1997-07-08', 'Female', '876 Sycamore St, Springfield');

INSERT INTO Appointments (appointment_id, doctor_id, patient_id, appointment_date, reason, status) VALUES
(301, 101, 201, '2025-01-01 10:30:00', 'Routine heart checkup', 'Scheduled'),
(302, 102, 202, '2025-01-02 11:00:00', 'Headache evaluation', 'Scheduled'),
(303, 103, 203, '2025-01-03 09:30:00', 'Knee pain', 'Completed'),
(304, 104, 204, '2025-01-04 14:00:00', 'Skin rash', 'Cancelled'),
(305, 105, 205, '2025-01-05 16:00:00', 'Child vaccination', 'Scheduled'),
(306, 106, 206, '2025-01-06 08:30:00', 'Abdominal pain', 'Scheduled'),
(307, 107, 207, '2025-01-07 10:00:00', 'Digestive issues', 'Scheduled'),
(308, 108, 208, '2025-01-08 13:30:00', 'Hormonal imbalance', 'Scheduled'),
(309, 109, 209, '2025-01-09 15:00:00', 'Cancer consultation', 'Scheduled'),
(310, 110, 210, '2025-01-10 09:00:00', 'MRI scan', 'Scheduled');

INSERT INTO Payments (payment_id, appointment_id, payment_date, payment_amount, payment_method) VALUES
(401, 301, '2025-01-01', 200.00, 'Credit Card'),
(402, 302, '2025-01-02', 150.00, 'Cash'),
(403, 303, '2025-01-03', 300.00, 'Insurance'),
(404, 304, '2025-01-04', 100.00, 'Credit Card'),
(405, 305, '2025-01-05', 250.00, 'Cash'),
(406, 306, '2025-01-06', 180.00, 'Credit Card'),
(407, 307, '2025-01-07', 220.00, 'Insurance'),
(408, 308, '2025-01-08', 190.00, 'Credit Card'),
(409, 309, '2025-01-09', 400.00, 'Insurance'),
(410, 310, '2025-01-10', 350.00, 'Credit Card');

-- 1. Find the Total Number of Appointments for Each Doctor

-- 2. List All Patients Who Have an Appointment with a Specific Doctor (e.g., Dr. John Smith)
 select p.first_name as patient,d.first_name as doctor from appointments a join patients p on a.patient_id = p.patient_id join doctors d on a.doctor_id = d.doctor_id

-- 3. Find the Number of Appointments Scheduled in a Specific Department
select dm.department_id,dm.department_name,count(a.appointment_id) as appointment from departments dm join doctors d on dm.department_id = d.department_id join appointments a on d.doctor_id = a.doctor_id 
group by dm.department_id

-- 4. Find the Most Popular Specialty Based on Number of Appointments


-- 5. Get the Total Payment Amount for All Completed Appointments
select a.reason,a.status,sum(p.payment_amount)as PaymentAmount from appointments a join payments p on a.appointment_id = p.appointment_id where a.status = 'Completed' group by a.reason

-- 6. Find the Number of Patients Seen by Each Doctor

-- 7. List All Patients Who Have Missed Their Appointments (Status 'Cancelled')
select p.patient_id,p.first_name,a.status from patients p join appointments a on p.patient_id = a.patient_id where a.status = 'Cancelled'

-- 8. Find the Total Number of Appointments for Each Status (Scheduled, Completed, Cancelled)
select status,count(status)as NumberOfAppointments from appointments group by status 

-- 9. Get the Average Payment Amount for Completed Appointments
select a.status,round(avg(p.payment_amount),2)as AverageAmount from appointments a join payments p on a.appointment_id = p.appointment_id where status = 'Completed'group by a.status

-- 10. Find the Doctor with the Highest Number of Appointments
select d.doctor_id,d.first_name as DoctorName, count(a.appointment_id) as Appointments from doctors d join appointments a on d.doctor_id = a.doctor_id group by d.doctor_id

