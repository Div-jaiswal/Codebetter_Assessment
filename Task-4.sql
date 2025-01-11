create database HR

-- Create Tables
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    HireDate DATE,
    DepartmentID INT,
    ManagerID INT,
    Salary DECIMAL(10, 2),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewDate DATE,
    PerformanceScore VARCHAR(20),
    Comments TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY,
    EmployeeID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(20),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES
(1, 'HR', 1),
(2, 'Finance', 2),
(3, 'IT', 3),
(4, 'Marketing', 6),
(5, 'Sales', 7),
(6, 'Operations', 8),
(7, 'Legal', 9),
(8, 'R&D', 10),
(9, 'Customer Support', 4),
(10, 'Procurement', 5);

-- Insert data into Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Phone, HireDate, DepartmentID, ManagerID, Salary) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '2022-01-15', 1, NULL, 75000),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '1234567891', '2021-11-10', 2, 1, 70000),
(3, 'Mike', 'Brown', 'mike.brown@example.com', '1234567892', '2020-03-05', 3, 1, 65000),
(4, 'Emma', 'Wilson', 'emma.wilson@example.com', '1234567893', '2023-06-20', 9, 1, 60000),
(5, 'Lucas', 'Taylor', 'lucas.taylor@example.com', '1234567894', '2019-09-15', 10, 2, 72000),
(6, 'Sophia', 'Davis', 'sophia.davis@example.com', '1234567895', '2022-12-01', 4, 2, 50000),
(7, 'James', 'Martin', 'james.martin@example.com', '1234567896', '2021-04-11', 5, 3, 55000),
(8, 'Isabella', 'Garcia', 'isabella.garcia@example.com', '1234567897', '2020-08-25', 6, 3, 58000),
(9, 'Oliver', 'Clark', 'oliver.clark@example.com', '1234567898', '2018-07-30', 7, 4, 80000),
(10, 'Amelia', 'Walker', 'amelia.walker@example.com', '1234567899', '2022-03-17', 8, 5, 65000);

-- Insert data into PerformanceReviews
INSERT INTO PerformanceReviews (ReviewID, EmployeeID, ReviewDate, PerformanceScore, Comments) VALUES
(1, 1, '2023-12-01', 'Excellent', 'Outstanding performance.'),
(2, 2, '2023-11-15', 'Good', 'Consistent work.'),
(3, 3, '2023-10-10', 'Average', 'Needs improvement in meeting deadlines.'),
(4, 4, '2023-09-05', 'Excellent', 'Great team player.'),
(5, 5, '2023-08-20', 'Good', 'Reliable and diligent.'),
(6, 6, '2023-07-01', 'Poor', 'Requires significant improvement.'),
(7, 7, '2023-06-15', 'Good', 'Solid performer with potential.'),
(8, 8, '2023-05-25', 'Average', 'Room for improvement.'),
(9, 9, '2023-04-10', 'Excellent', 'Exceptional leadership skills.'),
(10, 10, '2023-03-30', 'Good', 'Works well under pressure.');

-- Insert data into Payroll
INSERT INTO Payroll (PayrollID, EmployeeID, PaymentDate, Amount, PaymentMethod) VALUES
(1, 1, '2024-01-01', 7500, 'Bank Transfer'),
(2, 2, '2024-01-01', 7000, 'Check'),
(3, 3, '2024-01-01', 6500, 'Bank Transfer'),
(4, 4, '2024-01-01', 6000, 'Check'),
(5, 5, '2024-01-01', 7200, 'Bank Transfer'),
(6, 6, '2024-01-01', 5000, 'Check'),
(7, 7, '2024-01-01', 5500, 'Bank Transfer'),
(8, 8, '2024-01-01', 5800, 'Check'),
(9, 9, '2024-01-01', 8000, 'Bank Transfer'),
(10, 10, '2024-01-01', 6500, 'Check');


-- 1. Retrieve the names and contact details of employees hired after January 1, 2023
select firstname,lastname,phone from employees where hiredate > '2023-01-01'

-- 2. Find the total payroll amount paid to each department.
select e.departmentid,sum(p.amount) as totalAmount from payroll p join employees e on p.employeeid = e.employeeid group by e.departmentid
	
-- 3. List all employees who have not been assigned a manager
select * from employees where managerid is null

-- 4. Retrieve the highest salary in each department along with the employee’s name.
select e.firstname,e.lastname,d.departmentname,e.salary from employees e join departments d on e.departmentid = d.departmentid
 where e.salary=(select max(salary)from employees where departmentid = e.departmentid)order by e.salary desc

-- 5. Find the most recent performance review for each employee.


-- 6. Count the number of employees in each department.
select e.departmentid,d.departmentname,count(e.employeeid) as employees from employees e join departments d on e.departmentid = d.departmentid group by e.departmentid 

-- 7. List all employees who have received a performance score of "Excellent."
select e.firstname,e.lastname,pr.PerformanceScore from employees e join PerformanceReviews pr on e.employeeid = pr.employeeid where pr.PerformanceScore = 'Excellent'

-- 8. Retrieve the top 5 highest-paid employees along with their departments
select e.firstname,e.lastname,e.salary,d.departmentname from employees e join departments d on e.departmentid = d.departmentid order by e.salary desc limit 5

-- 9. Show details of all employees who report directly to a specific manager (e.g.,ManagerID = 101).
select e.firstname as employeename,m.firstname as managername from employees e join employees m on e.managerid= m.employeeid

-- 10 Identify the most frequently used payment method in payroll.
select paymentmethod,count(paymentmethod)as paymentmethod from payroll group by paymentmethod