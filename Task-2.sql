create database OLA

CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    VehicleType VARCHAR(20),
    Rating FLOAT
);

INSERT INTO Drivers (DriverID, FirstName, LastName, Phone, City, VehicleType, Rating) VALUES
(1, 'John', 'Doe', '1234567890', 'New York', 'Sedan', 4.5),
(2, 'Jane', 'Smith', '1234567891', 'Los Angeles', 'SUV', 4.7),
(3, 'Mike', 'Johnson', '1234567892', 'Chicago', 'Hatchback', 4.3),
(4, 'Emily', 'Davis', '1234567893', 'Houston', 'Sedan', 4.8),
(5, 'James', 'Brown', '1234567894', 'Phoenix', 'SUV', 4.6),
(6, 'Olivia', 'Taylor', '1234567895', 'Philadelphia', 'Hatchback', 4.4),
(7, 'William', 'Anderson', '1234567896', 'San Antonio', 'Sedan', 4.2),
(8, 'Sophia', 'Thomas', '1234567897', 'San Diego', 'SUV', 4.9),
(9, 'Liam', 'Jackson', '1234567898', 'Dallas', 'Hatchback', 4.1),
(10, 'Isabella', 'White', '1234567899', 'San Jose', 'Sedan', 4.3);


CREATE TABLE Riders (
    RiderID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(15),
    City VARCHAR(50),
    JoinDate DATE
);

INSERT INTO Riders (RiderID, FirstName, LastName, Phone, City, JoinDate) VALUES
(1, 'Chris', 'Evans', '9876543210', 'New York', '2023-01-10'),
(2, 'Scarlett', 'Johansson', '9876543211', 'Los Angeles', '2023-02-15'),
(3, 'Robert', 'Downey', '9876543212', 'Chicago', '2023-03-20'),
(4, 'Mark', 'Ruffalo', '9876543213', 'Houston', '2023-04-25'),
(5, 'Chris', 'Hemsworth', '9876543214', 'Phoenix', '2023-05-05'),
(6, 'Natalie', 'Portman', '9876543215', 'Philadelphia', '2023-06-10'),
(7, 'Tom', 'Holland', '9876543216', 'San Antonio', '2023-07-15'),
(8, 'Zendaya', 'Coleman', '9876543217', 'San Diego', '2023-08-20'),
(9, 'Benedict', 'Cumberbatch', '9876543218', 'Dallas', '2023-09-25'),
(10, 'Gal', 'Gadot', '9876543219', 'San Jose', '2023-10-30');

CREATE TABLE Rides (
    RideID INT PRIMARY KEY,
    RiderID INT,
    DriverID INT,
    RideDate DATETIME,
    PickupLocation VARCHAR(100),
    DropLocation VARCHAR(100),
    Distance FLOAT,
    Fare FLOAT,
    RideStatus VARCHAR(20),
    FOREIGN KEY (RiderID) REFERENCES Riders(RiderID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

INSERT INTO Rides (RideID, RiderID, DriverID, RideDate, PickupLocation, DropLocation, Distance, Fare, RideStatus) VALUES
(1, 1, 1, '2023-11-01 10:00:00', 'Central Park', 'Times Square', 5.0, 15.0, 'Completed'),
(2, 2, 2, '2023-11-02 11:30:00', 'Hollywood', 'Santa Monica', 12.0, 25.0, 'Completed'),
(3, 3, 3, '2023-11-03 09:45:00', 'Downtown', 'Museum Campus', 8.0, 20.0, 'Completed'),
(4, 4, 4, '2023-11-04 14:20:00', 'Midtown', 'Medical Center', 6.5, 18.0, 'Cancelled'),
(5, 5, 5, '2023-11-05 13:15:00', 'Desert Ridge', 'Camelback', 10.0, 22.0, 'Completed'),
(6, 6, 6, '2023-11-06 15:10:00', 'Old City', 'Art Museum', 4.0, 12.0, 'Ongoing'),
(7, 7, 7, '2023-11-07 12:50:00', 'Alamo', 'Market Square', 3.5, 10.0, 'Completed'),
(8, 8, 8, '2023-11-08 16:30:00', 'Gaslamp Quarter', 'Balboa Park', 7.0, 17.0, 'Completed'),
(9, 9, 9, '2023-11-09 08:40:00', 'Uptown', 'Reunion Tower', 9.0, 24.0, 'Cancelled'),
(10, 10, 10, '2023-11-10 18:20:00', 'Winchester', 'Santana Row', 5.5, 16.0, 'Completed');

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    RideID INT,
    PaymentMethod VARCHAR(20),
    Amount FLOAT,
    PaymentDate DATETIME,
    FOREIGN KEY (RideID) REFERENCES Rides(RideID)
);

INSERT INTO Payments (PaymentID, RideID, PaymentMethod, Amount, PaymentDate) VALUES
(1, 1, 'Card', 15.0, '2023-11-01 10:10:00'),
(2, 2, 'Wallet', 25.0, '2023-11-02 11:40:00'),
(3, 3, 'Cash', 20.0, '2023-11-03 09:55:00'),
(4, 5, 'Card', 22.0, '2023-11-05 13:25:00'),
(5, 7, 'Wallet', 10.0, '2023-11-07 13:00:00'),
(6, 8, 'Cash', 17.0, '2023-11-08 16:40:00'),
(7, 10, 'Card', 16.0, '2023-11-10 18:30:00'),
(8, 6, 'Wallet', 12.0, '2023-11-06 15:20:00'),
(9, 4, 'Cash', 0.0, '2023-11-04 14:30:00'),
(10, 9, 'Card', 0.0, '2023-11-09 08:50:00');


-- 1 Retrieve the names and contact details of all drivers with a rating of 4.5 or higher
select firstname,lastname,phone from drivers where rating>=4.5

-- 2. Find the total number of rides completed by each driver.
select driverid,count(rideid) from rides where ridestatus = "Completed" group by driverid

-- 3. List all riders who have never booked a ride
select * from rides where ridestatus = "Cancelled"

-- 4. Calculate the total earnings of each driver from completed rides
select driverid,sum(fare) as earning from rides where ridestatus = "Completed" group by driverid

-- 5. Retrieve the most recent ride for each rider.

-- 6 Count the number of rides taken in each city
select d.city,count(r.rideid) as rides from rides r join drivers d on r.driverid = d.driverid group by d.city

-- 7. List all rides where the distance was greater than 20 km.
select * from rides where distance >20

-- 8. Identify the most preferred payment method.
select paymentmethod,count(paymentid)as method from payments group by paymentmethod order by method desc 

-- 9. Find the top 3 highest-earning drivers
select driverid,sum(fare) as earning from rides group by driverid order by earning desc limit 3
