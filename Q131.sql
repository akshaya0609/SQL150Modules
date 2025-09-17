DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id INT,
  year INT,
  designation VARCHAR(50)
);
INSERT INTO employees VALUES
(1, 2020, 'Trainee'),
(2, 2020, 'Developer'),
(3, 2020, 'Developer'),
(4, 2020, 'Manager'),
(5, 2020, 'Trainee'),
(6, 2020, 'Developer'),
(1, 2021, 'Developer'),
(2, 2021, 'Developer'),
(3, 2021, 'Manager'),
(5, 2021, 'Trainee'),
(6, 2021, 'Developer'),
(7, 2021, 'Manager');

SELECT 
   e20.emp_id,
   e20.designation AS designation_2020,
   e21.designation AS designation_2021,
   CASE 
      WHEN e21.emp_id IS NULL THEN 'Resigned'
      WHEN e20.designation <> e21.designation THEN 'Promoted'
      ELSE 'No Change'
   END AS status
FROM emp_2020 e20
LEFT JOIN emp_2021 e21 ON e20.emp_id = e21.emp_id
UNION ALL
SELECT 
   e21.emp_id,
   NULL AS designation_2020,
   e21.designation AS designation_2021,
   'New Hire' AS status
FROM emp_2021 e21
LEFT JOIN emp_2020 e20 ON e21.emp_id = e20.emp_id
WHERE e20.emp_id IS NULL;