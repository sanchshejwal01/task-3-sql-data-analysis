CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10,2)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers (name, email) VALUES 
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');

INSERT INTO products (name, price) VALUES 
('Laptop', 1000.00),
('Phone', 500.00),
('Tablet', 300.00);

INSERT INTO orders (customer_id, product_id, order_date, amount) VALUES 
(1, 1, '2024-01-01', 1000.00),
(2, 2, '2024-01-02', 500.00),
(3, 3, '2024-01-03', 300.00),
(1, 2, '2024-01-04', 500.00),
(2, 1, '2024-01-05', 1000.00);

SELECT * FROM orders WHERE amount > 500 ORDER BY amount DESC;

SELECT o.order_id, c.name AS customer_name, p.name AS product_name, o.amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

SELECT customer_id, COUNT(*) AS total_orders, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT name FROM customers
WHERE customer_id IN (
  SELECT customer_id FROM orders WHERE amount > 900
);

CREATE VIEW customer_summary AS
SELECT c.name, COUNT(o.order_id) AS total_orders, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

CREATE INDEX idx_customer_id ON orders(customer_id);

