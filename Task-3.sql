create database Store 

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    join_date DATE
);

INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, join_date) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm St', '2024-01-01'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Oak St', '2024-01-02'),
(3, 'Alice', 'Brown', 'alice.brown@example.com', '5556667777', '789 Pine St', '2024-01-03'),
(4, 'Bob', 'Johnson', 'bob.johnson@example.com', '4445556666', '321 Maple St', '2024-01-04'),
(5, 'Charlie', 'White', 'charlie.white@example.com', '3334445555', '654 Birch St', '2024-01-05'),
(6, 'David', 'Lee', 'david.lee@example.com', '2223334444', '987 Cedar St', '2024-01-06'),
(7, 'Emily', 'Clark', 'emily.clark@example.com', '1112223333', '321 Spruce St', '2024-01-07'),
(8, 'Frank', 'Harris', 'frank.harris@example.com', '8889990000', '654 Fir St', '2024-01-08'),
(9, 'Grace', 'Walker', 'grace.walker@example.com', '7778889999', '987 Palm St', '2024-01-09'),
(10, 'Hannah', 'Moore', 'hannah.moore@example.com', '6667778888', '123 Willow St', '2024-01-10');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

INSERT INTO Products (product_id, product_name, category, price, stock_quantity) VALUES
(1, 'Laptop', 'Electronics', 800.00, 50),
(2, 'Smartphone', 'Electronics', 500.00, 100),
(3, 'Headphones', 'Accessories', 50.00, 200),
(4, 'Desk Chair', 'Furniture', 150.00, 30),
(5, 'Notebook', 'Stationery', 5.00, 500),
(6, 'Pen', 'Stationery', 2.00, 1000),
(7, 'Coffee Maker', 'Appliances', 80.00, 40),
(8, 'Blender', 'Appliances', 60.00, 60),
(9, 'Backpack', 'Accessories', 40.00, 70),
(10, 'Shoes', 'Footwear', 100.00, 120);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount, order_status) VALUES
(1, 1, '2024-01-10', 800.00, 'Shipped'),
(2, 2, '2024-01-11', 550.00, 'Pending'),
(3, 3, '2024-01-12', 100.00, 'Shipped'),
(4, 4, '2024-01-13', 150.00, 'Pending'),
(5, 5, '2024-01-14', 7.00, 'Shipped'),
(6, 6, '2024-01-15', 82.00, 'Pending'),
(7, 7, '2024-01-16', 100.00, 'Shipped'),
(8, 8, '2024-01-17', 80.00, 'Pending'),
(9, 9, '2024-01-18', 140.00, 'Shipped'),
(10, 10, '2024-01-19', 60.00, 'Pending');

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 800.00),
(2, 2, 2, 1, 500.00),
(3, 2, 3, 1, 50.00),
(4, 3, 3, 2, 100.00),
(5, 4, 4, 1, 150.00),
(6, 5, 5, 1, 5.00),
(7, 5, 6, 1, 2.00),
(8, 6, 7, 1, 80.00),
(9, 7, 9, 1, 40.00),
(10, 7, 10, 1, 100.00);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Payments (payment_id, order_id, payment_date, payment_amount, payment_method) VALUES
(1, 1, '2024-01-11', 800.00, 'Credit Card'),
(2, 2, '2024-01-12', 550.00, 'PayPal'),
(3, 3, '2024-01-13', 100.00, 'Debit Card'),
(4, 4, '2024-01-14', 150.00, 'Credit Card'),
(5, 5, '2024-01-15', 7.00, 'Cash'),
(6, 6, '2024-01-16', 82.00, 'PayPal'),
(7, 7, '2024-01-17', 100.00, 'Credit Card'),
(8, 8, '2024-01-18', 80.00, 'Debit Card'),
(9, 9, '2024-01-19', 140.00, 'Credit Card'),
(10, 10, '2024-01-20', 60.00, 'Cash');

-- 1. Find the Total Number of Orders for Each Customer
select customer_id,count(order_id) as TotalOrder from orders where order_status = "Shipped" group by customer_id

-- 2. Find the Total Sales Amount for Each Product (Revenue per Product)
select product_id,sum(unit_price*quantity)from orderdetails group by product_id

-- 3 Find the Most Expensive Product Sold
select product_id,max(unit_price)from orderdetails group by product_id 
select product_id,unit_price from orderdetails where unit_price = (select max(unit_price)from orderdetails)

-- 4 Get the List of Customers Who Have Placed Orders in the Last 30 Days
select customer_id from orders where order_date > curdate() - 30

-- 5. Calculate the Total Amount Paid by Each Customer
select o.customer_id,sum(p.payment_amount) as totalpayment from payments p join orders o on p.order_id=o.order_id  group by o.customer_id

-- 6. Get the Number of Products Sold by Category
select category,count(product_id)as productquantity from products group by category 

-- 7. List All Orders That Are Pending (i.e., Orders that haven't been shipped yet)
select order_id from orders where order_status = "Pending"

-- 8. Find the Average Order Value (Total Order Amount / Number of Orders)
select o.order_id,SUM(od.unit_price * od.quantity) / COUNT(od.order_detail_id)from orders o join order_id od on o.order_id=od.order_id group by o.order_id

-- 9 List the Top 5 Customers Who Have Spent the Most Money




