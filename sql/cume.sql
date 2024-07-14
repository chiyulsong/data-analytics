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

-- Use CUME_DIST() and PERCENT_RANK() to calculate the cumulative distribution and percent rank within each department
SELECT
    sale_id,
    department_id,
    sale_date,
    sales_amount,
    CUME_DIST() OVER (PARTITION BY department_id ORDER BY sales_amount) AS cume_dist,
    PERCENT_RANK() OVER (PARTITION BY department_id ORDER BY sales_amount) AS percent_rank
FROM
    Sales;


-- | sale_id | department_id | sale_date  | sales_amount | cume_dist | percent_rank |
-- |---------|---------------|------------|--------------|-----------|--------------|
-- | 1       | 1             | 2023-01-01 | 1000.00      | 0.25      | 0.00         |
-- | 3       | 1             | 2023-03-01 | 1200.00      | 0.50      | 0.33         |
-- | 2       | 1             | 2023-02-01 | 1500.00      | 0.75      | 0.67         |
-- | 4       | 1             | 2023-04-01 | 1800.00      | 1.00      | 1.00         |
-- | 7       | 2             | 2023-03-01 | 1300.00      | 0.25      | 0.00         |
-- | 5       | 2             | 2023-01-01 | 1600.00      | 0.50      | 0.33         |
-- | 6       | 2             | 2023-02-01 | 1700.00      | 0.75      | 0.67         |
-- | 8       | 2             | 2023-04-01 | 1900.00      | 1.00      | 1.00         |
