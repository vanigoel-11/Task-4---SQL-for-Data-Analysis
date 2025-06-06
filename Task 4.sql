SELECT * FROM chinook.customer_new;
USE CHINOOK
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO address (address_id, city, state, country) VALUES
(5, 'New York', 'NY', 'USA'),
(6, 'Los Angeles', 'CA', 'USA'),
(7, 'Chicago', 'IL', 'USA'),
(8, 'Houston', 'TX', 'USA'),
(9, 'Phoenix', 'AZ', 'USA'),
(10, 'Philadelphia', 'PA', 'USA'),
(11, 'San Antonio', 'TX', 'USA'),
(12, 'San Diego', 'CA', 'USA'),
(13, 'Dallas', 'TX', 'USA'),
(14, 'San Jose', 'CA', 'USA'),
(15, 'Austin', 'TX', 'USA'),
(16, 'Jacksonville', 'FL', 'USA'),
(17, 'Fort Worth', 'TX', 'USA'),
(18, 'Columbus', 'OH', 'USA'),
(19, 'Charlotte', 'NC', 'USA');

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(101, 1, '2024-01-10', 120.50),
(102, 2, '2024-01-11', 200.00),
(103, 3, '2024-01-12', 75.25),
(104, 1, '2024-01-13', 180.00),
(105, 4, '2024-01-14', 90.00),
(106, 5, '2024-01-15', 210.75),
(107, 2, '2024-01-16', 50.00),
(108, 6, '2024-01-17', 300.00),
(109, 7, '2024-01-18', 85.00),
(110, 8, '2024-01-19', 125.25),
(111, 9, '2024-01-20', 99.99),
(112, 10, '2024-01-21', 400.00),
(113, 11, '2024-01-22', 150.00),
(114, 12, '2024-01-23', 275.00),
(115, 13, '2024-01-24', 310.45);

SELECT first_name, last_name, email
FROM customer_new
WHERE last_name = 'Smith';
SELECT * FROM customer_new
ORDER BY last_name ASC;
SELECT customer_id, COUNT(*) AS order_count, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;
SELECT c.first_name, c.last_name, a.city, a.country
FROM customer_new c
INNER JOIN address a ON c.address_id = a.address_id;
SELECT c.first_name, c.last_name, a.city
FROM customer_new c
LEFT JOIN address a ON c.address_id = a.address_id;

SELECT * FROM customer_new
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > 100
);

CREATE OR REPLACE VIEW customer_new_orders_summary AS
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(o.total_amount) AS total_spent
FROM customer_new c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
SELECT * FROM customer_new_orders_summary;

DROP INDEX idx_customer_address_id ON customer_new;
CREATE INDEX idx_customer_address_id ON customer_new(address_id);
SHOW INDEXES FROM customer_new;
SHOW INDEXES FROM orders;