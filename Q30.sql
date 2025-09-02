DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
  employee_id   INT PRIMARY KEY,
  employee_name VARCHAR(20),
  salary        INT
);
INSERT INTO Employees (employee_id, employee_name, salary) VALUES
(1,  'John Doe',         45000),
(2,  'Jane Smith',       60000),
(3,  'Michael Johnson', 100000),
(4,  'Emily Brown',      75000),
(5,  'Christopher Lee',  48000),
(6,  'Amanda Wilson',    90000),
(7,  'Ankit Bansal',    110000),
(8,  'Sarah Davis',      50000),
(9,  'David Martinez',   65000),
(10, 'James Anderson',   95000),
(11, 'Patricia Thomas',  80000);

select case when salary<50000 then 'Low'
when salary between 50000 and 100000 then 'Medium'
when salary>100000 then 'High' end as Salary_level , round(avg(salary)) as average
-- ,group_concat(employee_name)
from Employees
group by salary_level
order by salary;