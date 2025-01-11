create database University

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    enrollment_date DATE NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Students (student_id, first_name, last_name, email, phone, date_of_birth, enrollment_date, department_id) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '2000-01-15', '2022-08-01', 1),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '1234567891', '1999-02-20', '2022-08-01', 2),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', '1234567892', '1998-03-25', '2021-08-01', 1),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '1234567893', '2000-04-30', '2022-08-01', 3),
(5, 'James', 'Brown', 'james.brown@example.com', '1234567894', '1997-05-10', '2021-08-01', 2),
(6, 'Olivia', 'Williams', 'olivia.williams@example.com', '1234567895', '1998-06-15', '2022-08-01', 1),
(7, 'William', 'Taylor', 'william.taylor@example.com', '1234567896', '2001-07-25', '2023-01-01', 2),
(8, 'Sophia', 'Anderson', 'sophia.anderson@example.com', '1234567897', '2002-08-30', '2023-01-01', 3),
(9, 'Liam', 'Thomas', 'liam.thomas@example.com', '1234567898', '1999-09-05', '2021-08-01', 1),
(10, 'Isabella', 'Jackson', 'isabella.jackson@example.com', '1234567899', '2000-10-10', '2022-08-01', 2);

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);

INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Computer Science'),
(2, 'Electrical Engineering'),
(3, 'Mechanical Engineering'),
(4, 'Civil Engineering'),
(5, 'Chemical Engineering'),
(6, 'Mathematics'),
(7, 'Physics'),
(8, 'Chemistry'),
(9, 'Biology'),
(10, 'Business Administration');


CREATE TABLE Professors (
    professor_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

INSERT INTO Professors (professor_id, first_name, last_name, email, phone) VALUES
(1, 'Dr. William', 'Harris', 'william.harris@example.com', '9876543210'),
(2, 'Dr. Olivia', 'Martinez', 'olivia.martinez@example.com', '9876543211'),
(3, 'Dr. James', 'Clark', 'james.clark@example.com', '9876543212'),
(4, 'Dr. Sophia', 'Lopez', 'sophia.lopez@example.com', '9876543213'),
(5, 'Dr. John', 'Walker', 'john.walker@example.com', '9876543214'),
(6, 'Dr. Emma', 'Young', 'emma.young@example.com', '9876543215'),
(7, 'Dr. Daniel', 'King', 'daniel.king@example.com', '9876543216'),
(8, 'Dr. Emily', 'Scott', 'emily.scott@example.com', '9876543217'),
(9, 'Dr. Robert', 'Adams', 'robert.adams@example.com', '9876543218'),
(10, 'Dr. Isabella', 'Nelson', 'isabella.nelson@example.com', '9876543219');


CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT,
    professor_id INT,
    credits INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (professor_id) REFERENCES Professors(professor_id)
);

INSERT INTO Courses (course_id, course_name, department_id, professor_id, credits) VALUES
(1, 'Introduction to Programming', 1, 1, 4),
(2, 'Data Structures and Algorithms', 1, 2, 4),
(3, 'Digital Circuits', 2, 3, 3),
(4, 'Fluid Mechanics', 3, 4, 3),
(5, 'Linear Algebra', 6, 5, 3),
(6, 'Quantum Mechanics', 7, 6, 4),
(7, 'Organic Chemistry', 8, 7, 3),
(8, 'Microbiology', 9, 8, 4),
(9, 'Business Management', 10, 9, 3),
(10, 'Advanced Physics', 7, 10, 4);


CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
(1, 1, 1, '2022-08-01', 'A'),
(2, 2, 2, '2022-08-01', 'B'),
(3, 3, 3, '2021-08-01', 'C'),
(4, 4, 4, '2022-08-01', 'A'),
(5, 5, 5, '2021-08-01', 'B'),
(6, 6, 6, '2022-08-01', 'A'),
(7, 7, 7, '2023-01-01', 'C'),
(8, 8, 8, '2023-01-01', 'B'),
(9, 9, 9, '2021-08-01', 'A'),
(10, 10, 10, '2022-08-01', 'A');

 -- 1. Find the Total Number of Students in Each Department
 select department_id,count(student_id) as TotalStudent from students group by department_id

-- 2. List All Courses Taught by a Specific Professor
select professor_id,count(course_name) from courses group by professor_id

select professor_id,course_name from courses

-- 3 Find the Average Grade of Students in Each Course
select course_id,avg(CASE 
               WHEN grade = 'A' THEN 4
               WHEN grade = 'B' THEN 3
               WHEN grade = 'C' THEN 2
               WHEN grade = 'D' THEN 1
               WHEN grade = 'F' THEN 0 end) as Average
               from enrollments group by course_id
               
               
-- 4 List All Students Who Have Not Enrolled in Any Courses

-- 5. Find the Number of Courses Offered by Each Department
select department_id,count(course_name) as courses from courses group by department_id

-- 6 List All Students Who Have Taken a Specific Course (e.g., 'Database Systems')


-- 7 Find the Most Popular Course Based on Enrollment Numbers
    
-- 8 Find the Average Number of Credits Per Student in a Department

-- 9 List All Professors Who Teach in More Than One Department

-- 10 Get the Highest and Lowest Grade in a Specific Course (e.g., 'Operating Systems')

