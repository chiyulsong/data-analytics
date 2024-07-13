-- Create the Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert example data into the Employees table
INSERT INTO Employees (employee_id, first_name, last_name, salary) VALUES
(1, 'John', 'Doe', 50000.00),
(2, 'Jane', 'Smith', 60000.00),
(3, 'Emily', 'Jones', 70000.00),
(4, 'Michael', 'Brown', 80000.00),
(5, 'Chris', 'Davis', 90000.00),
(6, 'Pat', 'Wilson', 100000.00),
(7, 'Sam', 'Miller', 110000.00),
(8, 'Alex', 'Taylor', 120000.00);

-- Use NTILE() to divide employees into 4 groups based on their salary
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
FROM
    Employees;


-- | employee_id | first_name | last_name | salary   | salary_quartile |
-- |-------------|------------|-----------|----------|-----------------|
-- | 8           | Alex       | Taylor    | 120000.00| 1               |
-- | 7           | Sam        | Miller    | 110000.00| 1               |
-- | 6           | Pat        | Wilson    | 100000.00| 2               |
-- | 5           | Chris      | Davis     | 90000.00 | 2               |
-- | 4           | Michael    | Brown     | 80000.00 | 3               |
-- | 3           | Emily      | Jones     | 70000.00 | 3               |
-- | 2           | Jane       | Smith     | 60000.00 | 4               |
-- | 1           | John       | Doe       | 50000.00 | 4               |