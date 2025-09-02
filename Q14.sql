DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    emp_id INT,
    login DATETIME,
    logout DATETIME
);
INSERT INTO employees (emp_id, login, logout) VALUES
(100, '2024-02-19 09:15:00', '2024-02-19 18:20:00'),
(100, '2024-02-20 09:05:00', '2024-02-20 17:00:00'),
(100, '2024-02-21 09:00:00', '2024-02-21 17:10:00'),
(100, '2024-02-22 09:00:00', '2024-02-22 16:55:00'),
(100, '2024-02-23 10:30:00', '2024-02-23 19:15:00'),
(200, '2024-02-19 08:00:00', '2024-02-19 18:20:00'),
(200, '2024-02-20 09:00:00', '2024-02-20 16:30:00');

select emp_id, sum(case when hour(timediff(login,logout))>8 then 1 else 0 end) as c1,
sum(case when hour(timediff(login,logout))>10 then 1 else 0 end) as'c2',
 case 
 when sum(case when hour(timediff(login,logout))>8 then 1 else 0 end)>=3 then 'c1' 
 when sum(case when hour(timediff(login,logout))>10 then 1 else 0 end)>=2 then 'c2'
 when sum(case when hour(timediff(login,logout))>8 then 1 else 0 end)>=3 and 
 sum(case when hour(timediff(login,logout))>10 then 1 else 0 end)>=2 then 'Both'
 else 'None' end as Criteria
 from employees
 group by emp_id
order by emp_id;