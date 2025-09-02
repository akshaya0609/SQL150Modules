DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    emp_id       INT PRIMARY KEY,
    emp_name     VARCHAR(10) NOT NULL,
    joining_date DATE        NOT NULL,
    salary       INT         NOT NULL,
    manager_id   INT         NULL   -- refers to emp_id in same table (no FK for easy loading)
);
INSERT INTO employee (emp_id, emp_name, joining_date, salary, manager_id) VALUES
(1,  'Ankit',  '2021-01-01', 10000, 4),
(2,  'Mohit',  '2022-05-01', 15000, 5),
(3,  'Vikas',  '2023-06-01', 10000, 4),
(4,  'Rohit',  '2022-02-01',  5000, 2),
(5,  'Mudit',  '2021-03-01', 12000, 6),
(6,  'Agam',   '2024-02-01', 12000, 2),
(7,  'Sanjay', '2024-02-21',  9000, 2),
(8,  'Ashish', '2023-01-05',  5000, 2),
(9,  'Mukesh', '2024-03-01',  6000, 1),
(10, 'Rakesh', '2022-08-01',  7000, 6);

SELECT e.emp_name, e.salary,e.joining_date,m.salary as mngr_salary,m.joining_date as mngr_join
from employee e
join employee m on e.manager_id=m.emp_id
where e.joining_date>m.joining_date and e.salary>m.salary
order by emp_name;
