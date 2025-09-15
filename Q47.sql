DROP TABLE IF EXISTS employee_record;
CREATE TABLE employee_record (
  emp_id     INT,
  action     VARCHAR(3),   -- 'in' or 'out'
  created_at DATETIME
);
INSERT INTO employee_record VALUES
-- Emp 1
(1,'in' , '2019-04-01 13:00:00'),
(1,'out', '2019-04-01 15:00:00'),
(1,'in' , '2019-04-01 23:00:00'),
(1,'out', '2019-04-02 09:30:00'),
-- Emp 2
(2,'in' , '2019-04-01 08:00:00'),
(2,'out', '2019-04-01 16:00:00'),
-- Emp 3
(3,'in' , '2019-04-02 09:30:00'),
(3,'out', '2019-04-02 12:00:00');

with cte as (
select *
, lead(created_at) over(partition by emp_id order by created_at) as next_created_at
from employee_record )
select count(*) as no_of_emp_inside
from cte
where action='in'
and created_at>='2019-04-01 14:00:00' and next_created_at<'2019-04-02 10:00:00';