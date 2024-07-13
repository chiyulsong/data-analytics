-- Example of a complex DML operation

-- 1. Insert multiple rows into Customers table
INSERT INTO Customers (customer_id, first_name, last_name, email)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com'),
(2, 'Jane', 'Smith', 'jane.smith@example.com');

-- 2. Insert multiple rows into Products table
INSERT INTO Products (product_id, product_name, price)
VALUES
(1, 'Laptop', 999.99),
(2, 'Smartphone', 499.99),
(3, 'Tablet', 299.99);

-- 3. Insert an order into Orders table and related order details into OrderDetails table within a transaction
BEGIN TRANSACTION;

-- Insert a new order
INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
(1, 1, '2023-07-12');

-- Insert order details
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 1, 999.99),
(2, 1, 2, 2, 499.99);

-- Commit the transaction
COMMIT;

-- 4. Update product prices using a subquery
UPDATE Products
SET price = price * 1.1
WHERE product_id IN (
    SELECT product_id
    FROM OrderDetails
    WHERE order_id = 1
);

-- 5. Delete an order and related order details using a transaction
BEGIN TRANSACTION;

-- Delete order details first due to foreign key constraint
DELETE FROM OrderDetails
WHERE order_id = 1;

-- Delete the order
DELETE FROM Orders
WHERE order_id = 1;

-- Commit the transaction
COMMIT;

-- 6. Select customers who have ordered products worth more than $500
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(od.quantity * od.unit_price) AS total_spent
FROM
    Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    SUM(od.quantity * od.unit_price) > 500;

-- 7. Use a window function to rank products by total sales
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity * od.unit_price) AS total_sales,
    RANK() OVER (ORDER BY SUM(od.quantity * od.unit_price) DESC) AS sales_rank
FROM
    Products p
    JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY
    p.product_id, p.product_name;
