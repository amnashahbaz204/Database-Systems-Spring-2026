DROP DATABASE IF EXISTS RetailDB;
CREATE DATABASE RetailDB;
USE RetailDB;

CREATE TABLE Customers
(customer_id INT PRIMARY KEY UNIQUE NOT NULL, 
customer_name VARCHAR(30) NOT NULL,
email VARCHAR(30) UNIQUE NOT NULL,
city VARCHAR(20),
gender CHAR(1) CHECK (gender IN ('M','F')), 
registration_date DATE NOT NULL DEFAULT (CURDATE()));

CREATE TABLE Suppliers
(supplier_id INT PRIMARY KEY UNIQUE NOT NULL,
supplier_name VARCHAR(30) NOT NULL,
contact_email VARCHAR(30) UNIQUE,
city VARCHAR(20),
phone_number VARCHAR(15),
registration_date DATE NOT NULL DEFAULT (CURDATE()));

CREATE TABLE Products
(product_id INT PRIMARY KEY UNIQUE NOT NULL,
product_name VARCHAR(30) NOT NULL,
category VARCHAR(30) NOT NULL,
price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
is_active BOOLEAN NOT NULL DEFAULT 1,
supplier_id INT NOT NULL,
FOREIGN KEY(supplier_id) REFERENCES Suppliers(supplier_id));

CREATE TABLE Sales
(sale_id INT PRIMARY KEY UNIQUE NOT NULL,
customer_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL CHECK(quantity >= 0),
sale_date DATE NOT NULL DEFAULT (CURDATE()),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id));

INSERT INTO Customers (customer_id, customer_name, email, city, gender, registration_date) VALUES 
(1, 'Eman Kanwal', 'eman.kanwal@email.com', 'Lahore', 'F', '2024-11-15'),
(2, 'Arooba Mumtaz', 'arooba.mumtaz@email.com', 'Karachi', 'F', '2024-12-01'),
(3, 'Saher Nadeem', 'saher.nadeem@email.com', 'Islamabad', 'F', '2022-12-10'),
(4, 'Aaleen Mehndi', 'aaleen.mehndi@email.com', 'Lahore', 'F', '2024-12-20'),
(5, 'Zainab Sohail', 'zainab.sohail@email.com', 'Multan', 'F', '2025-01-05'),
(6, 'Tarib Fatima', 'tarib.fatima@email.com', 'Faisalabad', 'F', '2023-01-10'),
(7, 'Samra Saif', 'samra.saif@email.com', 'Karachi', 'F', '2025-01-15'),
(8, 'Ayesha Siddique', 'ayesha.siddique@email.com', 'Lahore', 'F', '2025-01-20'),
(9, 'Kashaf Ch', 'kashaf.ch@email.com', 'Islamabad', 'F', '2025-01-25'),
(10, 'Syeda Rabbia', 'syeda.rabbia@email.com', 'Peshawar', 'F', '2025-02-01'),
(11, 'Fajal Mehndi', 'fajal.mehndi@email.com', 'Lahore', 'F', '2020-02-05'),
(12, 'Adil Shahbaz', 'adil.shahbaz@email.com', 'Karachi', 'M', '2025-02-08'),
(13, 'Hassan Mushtaq', 'hassan.mushtaq@email.com', 'Multan', 'M', '2025-02-10'),
(14, 'Tahira Sandhu', 'tahira.sandhu@email.com', 'Faisalabad', 'F', '2021-02-12'),
(15, 'Fatima Shahbaz', 'fatima.shahbaz@email.com', 'Islamabad', 'F', '2025-02-15'),
(16, 'Ahsan Sandhu', 'ahsan.sandhu@email.com', 'Lahore', 'M', '2025-02-18');

INSERT INTO Suppliers (supplier_id, supplier_name, contact_email, city, phone_number, registration_date) VALUES
(1, 'Tech Solutions Ltd', 'info@techsolutions.com', 'Lahore', '03001234567', '2024-01-15'),
(2, 'Khaadi', 'info@khaadi.com', 'Karachi', '03211234567', '2024-02-10'),
(3, 'Home Appliances', 'sales@homeappliances.com', 'Islamabad', '03331234567', '2024-03-05'),
(4, 'Electronics Hub', 'info@electronichub.com', 'Lahore', '03451234567', '2024-04-12'),
(5, 'Grocery Mart', 'support@grocerymart.com', 'Faisalabad', '03121234567', '2024-05-20'),
(6, 'Nestle Pakistan', 'contact.pk@nestle.com', 'Karachi', '03561234567', '2024-06-15'),
(7, 'Sapphire', 'info@sapphiretextiles.com', 'Islamabad', '03671234567', '2024-07-10'),
(8, 'Furniture Plus', 'sales@furnitureplus.com', 'Lahore', '03781234567', '2024-08-05'),
(9, 'Samsung Pakistan', 'samsung.pk@support.com', 'Karachi', '03891234567', '2024-09-01'),
(10, 'Beauty Care', 'info@beautycare.com', 'Multan', '03011234568', '2024-10-15'),
(11, 'Auto Parts Ltd', 'contact@autoparts.com', 'Lahore', '03211234568', '2024-11-20'),
(12, 'Kitchen Essentials', 'sales@kitchenessentials.com', 'Islamabad', '03331234568', '2024-12-10'),
(13, 'Haier Pakistan', 'care@haierpakistan.com', 'Karachi', '03451234568', '2025-01-05'),
(14, 'Office Supplies', 'support@officesupplies.com', 'Faisalabad', '03561234568', '2025-01-20'),
(15, 'Unilever Pakistan', 'contact@unileverpak.com', 'Lahore', '03671234568', '2025-02-01');

INSERT INTO Products (product_id, product_name, category, price, stock_quantity, is_active, supplier_id) VALUES
(1, 'Samsung Galaxy Note 22', 'Electronics', 149999.00, 15, TRUE, 1),
(2, 'iPhone 11 Pro', 'Electronics', 299999.00, 10, TRUE, 1),
(3, 'Dell Laptop CORE i5', 'Electronics', 189999.00, 8, TRUE, 4),
(4, 'Sony Headphones EP-100W', 'Electronics', 34999.00, 25, TRUE, 4),
(5, 'Cotton Lawn Shirt', 'Clothing', 2499.00, 50, TRUE, 2),
(6, 'Denim Jeans', 'Clothing', 3999.00, 40, TRUE, 2),
(7, 'Winter Jacket', 'Clothing', 5999.00, 30, TRUE, 2),
(8, 'Basmati Rice 5kg', 'Grocery', 1200.00, 100, TRUE, 5),
(9, 'Cooking Oil 5L', 'Grocery', 2500.00, 80, TRUE, 5),
(10, 'Tea Pack 500g', 'Grocery', 450.00, 120, TRUE, 5),
(11, 'LG Refrigerator', 'Electronics', 85000.00, 12, TRUE, 3),
(12, 'Microwave Oven', 'Electronics', 15999.00, 20, TRUE, 3),
(13, 'Skechers Running Shoes', 'Sports', 8999.00, 35, TRUE, 6),
(14, 'Pink Vaseline', 'Grocery', 450.00, 25, TRUE, 6),
(15, 'Office Chair Premium', 'Furniture', 12500.00, 18, TRUE, 8);

INSERT INTO Sales (sale_id, customer_id, product_id, quantity, sale_date) VALUES
(1, 1, 5, 2, '2025-01-15'),
(2, 2, 1, 1, '2025-01-18'),
(3, 3, 11, 1, '2025-01-20'),
(4, 4, 8, 3, '2025-01-22'),
(5, 5, 13, 2, '2025-01-25'),
(6, 1, 10, 4, '2025-02-01'),
(7, 6, 2, 1, '2025-02-03'),
(8, 7, 6, 2, '2025-02-05'),
(9, 8, 15, 1, '2025-02-08'),
(10, 9, 4, 2, '2025-02-10'),
(11, 10, 3, 1, '2025-02-12'),
(12, 11, 9, 3, '2025-02-14'),
(13, 2, 12, 2, '2025-02-16'),
(14, 12, 14, 1, '2025-02-18'),
(15, 13, 7, 2, '2025-02-20');

-- Q1(Distinct Customer Cities Gender)
SELECT DISTINCT city, gender
FROM Customers 
WHERE city IS NOT NULL AND gender IS NOT NULL
ORDER BY city ASC, gender ASC;

-- Q2(Active Products Price Discount)
SELECT product_name, price AS original_price,
price * 0.90 AS discounted_price
FROM Products WHERE is_active = 1 AND price > 1000
ORDER BY discounted_price DESC;

-- Q3(Weekday Sales Quantity Filter)
SELECT * FROM Sales WHERE quantity > 1
AND DAYNAME(sale_date) IN ('Monday', 'Tuesday', 'Wednesday')
ORDER BY sale_date DESC, quantity ASC;

-- Q4(Total Products Per Category)
SELECT category, 
COUNT(*) AS total_products,
SUM(stock_quantity) AS total_stock
FROM Products GROUP BY category
HAVING COUNT(*) > 2
ORDER BY total_products desc;

-- Q5(Average Maximum Price Category)
SELECT category, AVG(price) AS average_price,
MAX(price) AS max_price
FROM Products GROUP BY category
HAVING (average_price) > 1000
ORDER BY average_price DESC;

-- Q6(Total Quantity Per Customer)
SELECT customer_id,
SUM(quantity) AS total_quantity,
COUNT(*) AS number_of_orders
FROM Sales WHERE quantity>0 GROUP BY customer_id
ORDER BY total_quantity DESC;

-- Q7(Minimum Maximum Average Price)
SELECT category,
MIN(price) AS min_price,
MAX(price) aS max_price,
AVG(price) AS average_price
FROM Products GROUP BY category
Having MIN(price) < 5000
ORDER BY average_price DESC;

-- Q8(High Selling Products Count)
SELECT product_id,
SUM(quantity) AS total_quantity,
COUNT(DISTINCT customer_id) AS distinct_customers
FROM Sales GROUP BY product_id HAVING total_quantity>2
ORDER BY total_quantity DESC;

-- Q9(Total Units Average Quantity)
SELECT product_id,
SUM(quantity) AS total_units_sold,
AVG(quantity) AS average_quantity
FROM Sales GROUP BY product_id HAVING total_units_sold>1
ORDER BY total_units_sold DESC, average_quantity ASC;

-- Q10(Sales Date Quantity Filter)
SELECT * FROM Sales
WHERE quantity > 1 
AND sale_date BETWEEN '2025-01-01' AND '2025-03-01'
AND sale_id % 2 = 0
ORDER BY sale_date DESC, quantity ASC;

-- Q11(Categories with Stock > 20)
SELECT category, 
COUNT(*) AS total_products,
SUM(stock_quantity) AS total_stock
FROM Products GROUP BY category HAVING SUM(stock_quantity) > 20
ORDER BY total_stock deSC;

-- Q12(Formatted Customer Names and Registration Month-Year)
SELECT customer_name, registration_date,
CONCAT(UPPER(SUBSTRING(customer_name, 1, 1)),
LOWER(SUBSTRING(customer_name, 2))) AS formatted_name,
DATE_FORMAT(registration_date, '%M-%Y') As reg_date
FROM Customers WHERE registration_date < CURDATE()
ORDER BY registration_date DESC;




