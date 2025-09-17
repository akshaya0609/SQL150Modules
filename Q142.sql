DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  id         INT PRIMARY KEY,
  name       VARCHAR(30),
  department VARCHAR(30),
  salary     INT
);
INSERT INTO employees (id, name, department, salary) VALUES
(1 , 'Alice',   'Marketing',  80000),
(2 , 'Bob',     'Marketing',  60000),
(3 , 'Charlie', 'Marketing',  80000),
(4 , 'David',   'Marketing',  60000),
(5 , 'Eve',     'Engineering', 90000),
(6 , 'Frank',   'Engineering', 85000),
(7 , 'Grace',   'Engineering', 90000),
(8 , 'Hank',    'Engineering', 70000),
(9 , 'Ivy',     'HR',        50000),
(10, 'Jack',    'Finance',   95000),
(11, 'Kathy',   'Finance',   95000),
(12, 'Leo',     'Finance',   95000);

SELECT department,
CASE WHEN COUNT(DISTINCT salary) < 2 THEN NULL 
ELSE MAX(salary)-(SELECT MAX(s2.salary) FROM employees s2 WHERE s2.department = e.department
                  AND s2.salary < (SELECT MAX(s3.salary) FROM employees s3 WHERE s3.department = e.department))
END AS salary_diff
FROM employees e
GROUP BY department
ORDER BY department;
