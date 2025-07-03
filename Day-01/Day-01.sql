
-- Step 1: Create the Customer Table
CREATE TABLE customer (
   customer_id SERIAL PRIMARY KEY, -- Auto-incrementing ID
   first_name VARCHAR(100) NOT NULL, -- Customer's first name
   last_name VARCHAR(100) NOT NULL, -- Customer's last name
   email VARCHAR(255) UNIQUE NOT NULL, -- Unique email
   created_date TIMESTAMPTZ NOT NULL DEFAULT NOW(), -- Record creation timestamp
   updated_date TIMESTAMPTZ -- Optional update timestamp
);
-- Step 2: Select All Customers
SELECT * FROM customer; 

-- Step 3: Drop the Customer Table If Exists
DROP TABLE IF EXISTS customer;

-- Step 4: Add a New Column to Customer
ALTER TABLE customer ADD COLUMN active BOOLEAN; 

-- Step 5: Drop the Newly Added Column
ALTER TABLE customer DROP COLUMN active; 

-- Step 6: Rename Columns
ALTER TABLE customer RENAME COLUMN email TO email_address;
ALTER TABLE customer RENAME COLUMN email_address TO email;

-- Step 7: Rename Table
ALTER TABLE customer RENAME TO users; 
ALTER TABLE users RENAME TO customer; 

select * from customer;


-- Step 8: Create Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customer(customer_id),
    order_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    order_number VARCHAR(50) NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL
);

-- Step 9: Insert Multiple Customer Records

INSERT INTO customer (first_name, last_name, email, created_date, updated_date, active) VALUES
  ('Aarav', 'Sharma', 'aarav.sharma@example.com', NOW(), NOW(), true),
  ('Diya', 'Verma', 'diya.verma@example.com', NOW(), NULL, true),
  ('Rohan', 'Mehta', 'rohan.mehta@example.com', NOW(), NOW(), false),
  ('Ananya', 'Iyer', 'ananya.iyer@example.com', NOW(), NULL, true),
  ('Vivaan', 'Desai', 'vivaan.desai@example.com', NOW(), NULL, true),
  ('Kavya', 'Reddy', 'kavya.reddy@example.com', NOW(), NOW(), false),
  ('Aditya', 'Kapoor', 'aditya.kapoor@example.com', NOW(), NULL, true),
  ('Sneha', 'Malhotra', 'sneha.malhotra@example.com', NOW(), NOW(), true),
  ('Yash', 'Patel', 'yash.patel@example.com', NOW(), NULL, false),
  ('Ishita', 'Joshi', 'ishita.joshi@example.com', NOW(), NULL, true),
  ('Raj', 'Singh', 'raj.singh@example.com', NOW(), NOW(), true),
  ('Meera', 'Chopra', 'meera.chopra@example.com', NOW(), NULL, true),
  ('Nikhil', 'Naik', 'nikhil.naik@example.com', NOW(), NOW(), false),
  ('Priya', 'Kumar', 'priya.kumar@example.com', NOW(), NULL, true);


-- Step 10: Insert Orders


INSERT INTO orders (customer_id, order_date, order_number, order_amount) VALUES
  (1, '2024-03-01', 'ORD001', 59.99),
  (2, '2024-03-02', 'ORD002', 42.50),
  (3, '2024-03-03', 'ORD003', 75.25),
  (4, '2024-03-04', 'ORD004', 33.00),
  (5, '2024-03-05', 'ORD005', 120.00),
  (6, '2024-03-06', 'ORD006', 89.95),
  (7, '2024-03-07', 'ORD007', 55.60),
  (8, '2024-03-08', 'ORD008', 64.75),
  (9, '2024-03-09', 'ORD009', 38.40),
  (10, '2024-03-10', 'ORD010', 99.00),
  (11, '2024-03-11', 'ORD011', 78.35),
  (12, '2024-03-12', 'ORD012', 46.20),
  (13, '2024-03-13', 'ORD013', 85.00),
  (14, '2024-03-14', 'ORD014', 61.90);


select * from orders;


-- Step 11: Basic Select Queries

SELECT first_name FROM customer;

SELECT first_name, last_name, email FROM customer;



SELECT * FROM customer;
  

-- Step 12: Order By Queries

SELECT first_name, last_name FROM customer ORDER BY first_name ASC;

SELECT first_name, last_name FROM customer ORDER BY last_name DESC;

SELECT customer_id, first_name, last_name FROM customer ORDER BY first_name ASC, last_name DESC;

-- Step 13: WHERE Clause

SELECT last_name, first_name FROM customer WHERE first_name = 'Aarav';

SELECT customer_id, first_name, last_name FROM customer WHERE first_name = 'Aarav' AND last_name = 'Sharma';

SELECT customer_id, first_name, last_name FROM customer WHERE first_name IN ('Aarav', 'Ananya', 'Aditya');

SELECT first_name, last_name FROM customer WHERE first_name LIKE '%A%'; 

SELECT first_name, last_name FROM customer WHERE first_name ILIKE '%r%'; 


-- Step 14: Join Examples
  SELECT * FROM orders AS o INNER JOIN customer AS c ON o.customer_id = c.customer_id;

  SELECT * FROM customer AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

-- Step 15: Aggregation with GROUP BY
SELECT c.customer_id, c.first_name, c.last_name, c.email,
       COUNT(o.order_id) AS NoOrders,
       SUM(o.order_amount) AS Total
FROM customer AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id; 

-- Step 16: GROUP BY with HAVING
SELECT c.customer_id, c.first_name, c.last_name, c.email,
       COUNT(o.order_id) AS No_Orders,
       SUM(o.order_amount) AS Total
FROM customer AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) = 1;


-- Step 17: Subqueries


SELECT * FROM orders WHERE customer_id IN (
  SELECT customer_id FROM customer WHERE active = true
);


SELECT customer_id, first_name, last_name, email
FROM customer
WHERE EXISTS (
  SELECT 1 FROM orders WHERE orders.customer_id = customer.customer_id
);

-- Step 18: Update Statement
UPDATE customer
SET first_name = 'Diya', last_name = 'Verma', email = 'diya.verma@example.com'
WHERE customer_id = 2;

-- Step 19: Delete Statement
DELETE FROM customer WHERE customer_id = 11;
