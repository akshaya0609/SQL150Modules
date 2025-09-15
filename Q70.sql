DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
  employeeid INT,
  fullname   VARCHAR(50)
);
INSERT INTO employee VALUES
(1,'Doe,John Michael'),
(2,'Smith,Alice'),
(3,'Johnson,Robert Lee'),
(4,'Alex'),
(5,'White,Sarah');

SELECT
  employeeid,
  SUBSTRING_INDEX(TRIM(SUBSTRING_INDEX(fullname, ',', -1)), ' ', 1) AS first_name,
  -- trim() remove outer spaces from the word
  CASE
    WHEN INSTR(TRIM(SUBSTRING_INDEX(fullname, ',', -1)), ' ') > 0 
    -- Returns the 1-based position of the first occurrence of substr in str, or 0 if not found. 
    -- Example: INSTR('John Michael',' ') = 5 (position of spacing is 5)
      THEN SUBSTRING_INDEX(TRIM(SUBSTRING_INDEX(fullname, ',', -1)), ' ', -1)
    ELSE NULL
  END AS middle_name,
  CASE
    WHEN INSTR(fullname, ',') > 0
      THEN SUBSTRING_INDEX(fullname, ',', 1)
    ELSE NULL
  END AS last_name
FROM employee
ORDER BY employeeid;

