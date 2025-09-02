DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    emp_id     INT PRIMARY KEY,
    salary     INT NOT NULL,
    department VARCHAR(15) NOT NULL
);
INSERT INTO employee (emp_id, salary, department) VALUES
(100, 40000, 'Analytics'),
(101, 30000, 'Analytics'),
(102, 50000, 'Analytics'),
(109, 42000, 'Analytics'),
(103, 45000, 'Engineering'),
(104, 48000, 'Engineering'),
(105, 51000, 'Engineering'),
(110, 55000, 'Engineering'),
(106, 46000, 'Science'),
(107, 38000, 'Science'),
(108, 37000, 'Science');

SELECT e.emp_id, e.salary
FROM employee e
WHERE e.salary >
  ( SELECT AVG(salary)
    FROM employee x
    WHERE x.department <> e.department )
ORDER BY e.emp_id ASC;