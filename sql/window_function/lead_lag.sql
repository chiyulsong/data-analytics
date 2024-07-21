-- Create the Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    department_id INT,
    sale_date DATE,
    sales_amount DECIMAL(10, 2)
);

-- Insert example data into the Sales table
INSERT INTO Sales (sale_id, department_id, sale_date, sales_amount) VALUES
(1, 1, '2023-01-01', 1000.00),
(2, 1, '2023-02-01', 1500.00),
(3, 1, '2023-03-01', 1200.00),
(4, 1, '2023-04-01', 1800.00),
(5, 2, '2023-01-01', 1600.00),
(6, 2, '2023-02-01', 1700.00),
(7, 2, '2023-03-01', 1300.00),
(8, 2, '2023-04-01', 1900.00);

-- Use LAG() and LEAD() with different offsets
SELECT
    sale_id,
    department_id,
    sale_date,
    sales_amount,
    LAG(sales_amount, 1, 0) OVER (PARTITION BY department_id ORDER BY sale_date) AS prev_month_sales,
    LAG(sales_amount, 2, 0) OVER (PARTITION BY department_id ORDER BY sale_date) AS prev_2_month_sales,
    LEAD(sales_amount, 1, 0) OVER (PARTITION BY department_id ORDER BY sale_date) AS next_month_sales,
    LEAD(sales_amount, 2, 0) OVER (PARTITION BY department_id ORDER BY sale_date) AS next_2_month_sales
FROM
    Sales;
un

-- | sale_id | department_id | sale_date  | sales_amount | prev_month_sales | prev_2_month_sales | next_month_sales | next_2_month_sales |
-- |---------|---------------|------------|--------------|------------------|--------------------|------------------|--------------------|
-- | 1       | 1             | 2023-01-01 | 1000.00      | 0.00             | 0.00               | 1500.00          | 1200.00            |
-- | 2       | 1             | 2023-02-01 | 1500.00      | 1000.00          | 0.00               | 1200.00          | 1800.00            |
-- | 3       | 1             | 2023-03-01 | 1200.00      | 1500.00          | 1000.00            | 1800.00          | 0.00               |
-- | 4       | 1             | 2023-04-01 | 1800.00      | 1200.00          | 1500.00            | 0.00             | 0.00               |
-- | 5       | 2             | 2023-01-01 | 1600.00      | 0.00             | 0.00               | 1700.00          | 1300.00            |
-- | 6       | 2             | 2023-02-01 | 1700.00      | 1600.00          | 0.00               | 1300.00          | 1900.00            |
-- | 7       | 2             | 2023-03-01 | 1300.00      | 1700.00          | 1600.00            | 1900.00          | 0.00               |
-- | 8       | 2             | 2023-04-01 | 1900.00      | 1300.00          | 1700.00            | 0.00             | 0.00               |
