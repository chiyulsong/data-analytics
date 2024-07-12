
### 데이터셋의 처음 몇 행을 주석으로 포함하기
```sql
-- create_database_and_tables.sql


-- | employee_id | department_id | salary | hire_date  |
-- |-------------|---------------|--------|------------|
-- | 1           | 10            | 50000  | 2020-01-15 |
-- | 2           | 20            | 60000  | 2019-02-20 |
-- | 3           | 10            | 55000  | 2021-03-10 |
-- | 4           | 30            | 70000  | 2018-04-25 |
-- | 5           | 20            | 65000  | 2022-05-30 |

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    department_id INTEGER,
    salary INTEGER,
    hire_date TEXT
);

INSERT INTO employees (employee_id, department_id, salary, hire_date) VALUES
(1, 10, 50000, '2020-01-15'),
(2, 20, 60000, '2019-02-20'),
(3, 10, 55000, '2021-03-10'),
(4, 30, 70000, '2018-04-25'),
(5, 20, 65000, '2022-05-30');
