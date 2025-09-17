DROP TABLE IF EXISTS promotions;
DROP TABLE IF EXISTS employees;
-- Employees
CREATE TABLE employees (
  id   INT PRIMARY KEY,
  name VARCHAR(30) NOT NULL
);
INSERT INTO employees (id, name) VALUES
(1,'Alice'),
(2,'Bob'),
(3,'Charlie'),
(4,'David'),
(5,'Eva'),
(6,'Frank'),
(7,'Grace'),
(8,'Hank'),
(9,'Ivy'),
(10,'Jack'),
(11,'Lily'),
(12,'Megan');
-- Promotions (historical)
CREATE TABLE promotions (
  emp_id        INT NOT NULL,
  promotion_date DATE NOT NULL
  -- (emp_id references employees(id))
);
INSERT INTO promotions (emp_id, promotion_date) VALUES
(1, '2025-04-13'),
(2, '2025-01-13'),
(3, '2024-07-13'),
(4, '2023-12-13'),
(5, '2023-10-13'),
(6, '2023-06-13'),
(6, '2024-12-13'),
(7, '2023-08-13'),
(7, '2022-12-13'),
(8, '2022-12-13'),
(9, '2024-04-13');

select e.id,e.name, max(p.promotion_date) as latest
from employees e
left join promotions p on e.id=p.emp_id
-- where (p.promotion_date is null) or max(p.promotion_date)<(date_sub(curdate(),interval 1 year))
group by e.id,e.name
having max(p.promotion_date is null) or max(p.promotion_date)<(date_sub(curdate(),interval 1 year))
order by e.id;
