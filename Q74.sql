DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
  emp_id    INT PRIMARY KEY,
  emp_name  VARCHAR(20),
  job_title VARCHAR(20)
);
INSERT INTO employee VALUES
(1,'John Doe','Software Engineer'),
(2,'Jane Smith','Software Engineer'),
(3,'Michael Johnson','Software Engineer'),
(4,'Emily Brown','Software Engineer'),
(5,'David Lee','Software Engineer'),
(6,'Sarah Jones','Software Engineer'),
(7,'Kevin Davis','Software Engineer'),
(8,'Emma Wilson','Software Engineer'),
(9,'Matthew Taylor','Software Engineer'),
(10,'Olivia Martinez','Software Engineer'),
(11,'Liam Miller','Data Scientist');
CREATE TABLE salary (
  emp_id       INT PRIMARY KEY,
  base_pay     INT,
  other_pay    INT,
  overtime_pay INT
);
INSERT INTO salary VALUES
(1 , 90000, 10000, 10000),   -- 110000
(2 ,100000, 10000, 10000),   -- 120000
(3 , 80000, 10000,  5000),   --  95000
(4 ,105000, 15000, 10000),   -- 130000
(5 , 90000, 15000, 10000),   -- 115000
(6 ,110000, 15000, 15000),   -- 140000
(7 , 70000, 10000,  5000),   --  85000
(8 ,100000, 15000, 10000),   -- 125000
(9 , 85000, 10000,  5000),   -- 100000
(10,110000, 15000, 10000),   -- 135000
(11,120000, 15000, 15000);   -- 150000 (single DS → won’t qualify)

with cte as (
select e.emp_id,e.emp_name, e.job_title, s.base_pay,s.other_pay, s.overtime_pay, 
(s.base_pay+s.other_pay+ s.overtime_pay) as total_salary from employee e
join salary s on e.emp_id=s.emp_id
),
cte2 as (
select c.*, avg(total_salary) over (partition by job_title) as average,
row_number() over (partition by job_title order by total_salary desc) as rn
from cte c )
select emp_id, emp_name, job_title from cte2
where total_salary> average and rn>3
order by total_salary desc;
