DROP TABLE IF EXISTS employee_record;
CREATE TABLE employee_record (
    emp_id INT,
    action VARCHAR(3),
    created_at DATETIME
);
INSERT INTO employee_record (emp_id, action, created_at) VALUES
(1, 'in',  '2019-04-01 12:00:00'),
(1, 'out', '2019-04-01 15:00:00'),
(1, 'in',  '2019-04-01 17:00:00'),
(1, 'out', '2019-04-01 21:00:00'),
(2, 'in',  '2019-04-01 10:00:00'),
(2, 'out', '2019-04-01 16:00:00'),
(3, 'in',  '2019-04-01 19:00:00'),
(3, 'out', '2019-04-02 05:00:00'),
(4, 'in',  '2019-04-01 10:00:00'),
(4, 'out', '2019-04-01 20:00:00');

with cte as (
select *
, lead(created_at) over(partition by emp_id order by created_at) as next_created_at
from employee_record )
select count(*) as no_of_emp_inside
from cte
where action='in'
and '2019-04-01 19:05:00' between created_at and next_created_at;