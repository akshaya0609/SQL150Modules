DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id   INT,
  emp_name VARCHAR(20),
  dept_id  INT
);
INSERT INTO employees VALUES
(1,'Alice',1),
(2,'Bob',2),
(3,'Carol',1),
(4,'Dan',3),
(5,'Eve',2);
-- Department hourly rates
DROP TABLE IF EXISTS dept;
CREATE TABLE dept (
  dept_id     INT,
  hourly_rate INT
);
-- choose reasonable rates
INSERT INTO dept VALUES
(1,10),   -- e.g., Dev
(2,12),   -- e.g., Data
(3,11);   -- e.g., QA
-- Daily time punches (from image)
DROP TABLE IF EXISTS daily_time;
CREATE TABLE daily_time (
  emp_id     INT,
  entry_time DATETIME,
  exit_time  DATETIME
);
INSERT INTO daily_time VALUES
(1,'2023-01-01 09:00:00','2023-01-01 17:00:00'),  -- 8h
(2,'2023-01-01 08:00:00','2023-01-01 15:00:00'),  -- 7h
(3,'2023-01-01 08:30:00','2023-01-01 18:30:00'),  -- 10h
(4,'2023-01-01 09:00:00','2023-01-01 16:00:00'),  -- 7h
(5,'2023-01-01 08:00:00','2023-01-01 18:00:00');  -- 10h

select e.emp_name, hours,
round(sum(case when hours<=8 then hours*hourly_rate
else 8*hourly_rate + 1.5*hourly_rate*(hours-8) end),2) as payout
from (select emp_id,timestampdiff(minute, entry_time, exit_time)/60.0 as hours from daily_time) as t
join employees e on t.emp_id=e.emp_id
join dept d using (dept_id)
group by emp_name
order by payout desc;