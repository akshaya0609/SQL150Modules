DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS promotions;
CREATE TABLE employees (
    id INT,
    name VARCHAR(50),
    joining_salary INT
);
INSERT INTO employees (id, name, joining_salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 70000),
(4, 'David', 55000),
(5, 'Eva', 65000),
(6, 'Frank', 48000),
(7, 'Grace', 72000),
(8, 'Henry', 51000);

CREATE TABLE promotions (
    emp_id INT,
    promotion_date DATE,
    percent_increase INT
);
INSERT INTO promotions (emp_id, promotion_date, percent_increase) VALUES
(1, '2021-01-15', 10),
(1, '2022-03-20', 20),
(2, '2023-01-01', 5),
(2, '2024-01-01', 10),
(3, '2022-05-10', 5),
(3, '2023-07-01', 10),
(3, '2024-10-10', 5),
(4, '2019-09-21', 15),
(4, '2022-09-25', 15),
(4, '2023-09-01', 15),
(4, '2024-09-30', 15);

SELECT e.id, e.name,
ROUND(e.joining_salary * COALESCE(EXP(SUM(LN(1 + p.percent_increase/100.0))), 1),2) AS current_salary
FROM employees e
LEFT JOIN promotions p ON e.id = p.emp_id
GROUP BY e.id, e.name, e.joining_salary
ORDER BY e.id;
