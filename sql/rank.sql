-- Create the Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2)
);

-- Insert example data into the Employees table
INSERT INTO Employees (employee_id, first_name, last_name, department_id, salary) VALUES
(1, 'John', 'Doe', 1, 50000.00),
(2, 'Jane', 'Smith', 1, 60000.00),
(3, 'Emily', 'Jones', 2, 70000.00),
(4, 'Michael', 'Brown', 2, 80000.00),
(5, 'Chris', 'Davis', 2, 90000.00),
(6, 'Pat', 'Wilson', 1, 100000.00),
(7, 'Sam', 'Miller', 3, 110000.00),
(8, 'Alex', 'Taylor', 3, 120000.00);

-- Use ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE() in a single query
SELECT
    employee_id,
    first_name,
    last_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_rank,
    NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
FROM
    Employees;

-- | employee_id | first_name | last_name | department_id | salary   | row_num | rank | dense_rank | salary_quartile |
-- |-------------|------------|-----------|---------------|----------|---------|------|------------|-----------------|
-- | 6           | Pat        | Wilson    | 1             | 100000.00| 1       | 1    | 1          | 2               |
-- | 2           | Jane       | Smith     | 1             | 60000.00 | 2       | 2    | 2          | 4               |
-- | 1           | John       | Doe       | 1             | 50000.00 | 3       | 3    | 3          | 4               |
-- | 5           | Chris      | Davis     | 2             | 90000.00 | 1       | 1    | 1          | 2               |
-- | 4           | Michael    | Brown     | 2             | 80000.00 | 2       | 2    | 2          | 3               |
-- | 3           | Emily      | Jones     | 2             | 70000.00 | 3       | 3    | 3          | 3               |
-- | 8           | Alex       | Taylor    | 3             | 120000.00| 1       | 1    | 1          | 1               |
-- | 7           | Sam        | Miller    | 3             | 110000.00| 2       | 2    | 2          | 1               |
