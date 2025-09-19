USE modules;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS leave_requests;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(20),
    leave_balance_from_2023 INT
);
INSERT INTO employees (employee_id, name, leave_balance_from_2023) VALUES
(1, 'John Doe', 5),
(2, 'Jane Smith', 6),
(3, 'Alice Johnson', 4);
CREATE TABLE leave_requests (
    request_id INT PRIMARY KEY,
    employee_id INT,
    leave_start_date DATE,
    leave_end_date DATE
);
INSERT INTO leave_requests (request_id, employee_id, leave_start_date, leave_end_date) VALUES
(1, 1, '2024-01-05', '2024-01-15'),
(2, 1, '2024-01-21', '2024-01-27'),
(3, 1, '2024-02-12', '2024-02-17'),
(4, 1, '2024-07-03', '2024-07-12'),
(5, 2, '2024-01-20', '2024-01-25'),
(6, 2, '2024-03-20', '2024-03-30'),
(7, 2, '2024-10-05', '2024-10-12');

WITH monthly_balance AS (
    SELECT 
        e.employee_id,
        e.name,
        e.leave_balance_from_2023,
        -- Add 1.5 leaves for each month
        (e.leave_balance_from_2023 + (MONTH(l.leave_start_date) - 1) * 1.5) AS available_balance,
        l.request_id,
        l.leave_start_date,
        l.leave_end_date,
        DATEDIFF(l.leave_end_date, l.leave_start_date) + 1 AS leave_days
    FROM employees e
    JOIN leave_requests l 
      ON e.employee_id = l.employee_id
)
SELECT 
    request_id,
    employee_id,
    name,
    leave_start_date,
    leave_end_date,
    leave_days,
    available_balance,
    CASE 
        WHEN available_balance >= leave_days THEN 'Approved'
        ELSE 'Rejected'
    END AS status
FROM monthly_balance
ORDER BY request_id;