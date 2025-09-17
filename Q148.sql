DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  name        VARCHAR(30) NOT NULL,
  manager_id  INT NULL
);
INSERT INTO employees (employee_id, name, manager_id) VALUES
(1,  'Alice',   NULL),
(2,  'Bob',     1),
(3,  'Charlie', 10),
(4,  'David',   2),
(5,  'Eva',     12),
(6,  'Frank',   3),
(7,  'Grace',   2),
(8,  'Hank',    3),
(9,  'Ivy',     1),
(10, 'Jack',    4),
(11, 'Lily',    4),
(12, 'Megan',   15);

select e.employee_id, e.name
from employees e
left join employees m on m.manager_id=e.employee_id
where m.employee_id is null
order by e.employee_id;