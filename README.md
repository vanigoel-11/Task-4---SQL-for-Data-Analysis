# 🗃️ SQL Data Analysis Project - Customer, Orders & Address (Chinook DB)

This project demonstrates how to manage and analyze relational data using SQL. It features a simulation of customer records, address data, and orders — ideal for practicing advanced SQL queries like JOINs, subqueries, views, and indexing.

---

## 📦 Project Contents

- ✅ `customer_new`: Existing table from Chinook database.
- 🏙️ `address`: Manually created table to simulate customer locations.
- 💳 `orders`: Table containing customer purchase records.

---

## 🛠️ SQL Features Demonstrated

### 1. Create Tables

```sql
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);
```

### 2. Insert Sample Data

```sql
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
```

---

## 🔍 Queries for Analysis

### ✅ Simple SELECT with WHERE
```sql
SELECT first_name, last_name, email
FROM customer_new
WHERE last_name = 'Smith';
```

### ✅ ORDER BY
```sql
SELECT * FROM customer_new
ORDER BY last_name ASC;
```

### ✅ Aggregation with GROUP BY
```sql
SELECT customer_id, COUNT(*) AS order_count, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC;
```

### ✅ INNER JOIN
```sql
SELECT c.first_name, c.last_name, a.city, a.country
FROM customer_new c
INNER JOIN address a ON c.address_id = a.address_id;
```

### ✅ LEFT JOIN
```sql
SELECT c.first_name, c.last_name, a.city
FROM customer_new c
LEFT JOIN address a ON c.address_id = a.address_id;
```

### ✅ Subquery
```sql
SELECT * FROM customer_new
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE total_amount > 100
);
```

---

## 👁️ Create and Use Views

```sql
CREATE OR REPLACE VIEW customer_new_orders_summary AS
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(o.total_amount) AS total_spent
FROM customer_new c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- View data
SELECT * FROM customer_new_orders_summary;
```

---

## 🚀 Index Optimization

```sql
-- Remove existing index if needed
DROP INDEX idx_customer_address_id ON customer_new;

-- Create index to speed up joins
CREATE INDEX idx_customer_address_id ON customer_new(address_id);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- Check indexes
SHOW INDEXES FROM customer_new;
SHOW INDEXES FROM orders;
```

---

## 🧪 How to Run

You can run these queries in:

- MySQL Workbench
- DB Fiddle: https://www.db-fiddle.com/
- XAMPP / phpMyAdmin
- SQLite / DBeaver (with syntax adjustments)

---
