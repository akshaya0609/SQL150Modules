CREATE TABLE emp_2020 (
  emp_id INT,
  designation VARCHAR(50)
);
INSERT INTO emp_2020 VALUES
(1, 'Trainee'),
(2, 'Developer'),
(3, 'Developer'),
(4, 'Manager'),
(5, 'Trainee'),
(6, 'Developer');
-- Employees in 2021
CREATE TABLE emp_2021 (
  emp_id INT,
  designation VARCHAR(50)
);
INSERT INTO emp_2021 VALUES
(1, 'Developer'),
(2, 'Developer'),
(3, 'Manager'),
(5, 'Trainee'),
(6, 'Developer'),
(7, 'Manager');


SELECT 
    e20.emp_id,
    e20.designation AS designation_2020,
    e21.designation AS designation_2021,
    CASE WHEN e21.emp_id IS NULL THEN 'Resigned'
        WHEN e20.designation <> e21.designation THEN 'Promoted'
        ELSE 'No Change'
    END AS status
FROM emp_2020 e20
LEFT JOIN emp_2021 e21 
    ON e20.emp_id = e21.emp_id
UNION
SELECT 
    e21.emp_id,
    e20.designation AS designation_2020,
    e21.designation AS designation_2021,
    'New Hire' AS status
FROM emp_2020 e20
RIGHT JOIN emp_2021 e21 
    ON e20.emp_id = e21.emp_id
WHERE e20.emp_id IS NULL
ORDER BY emp_id;
