DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    employee_name VARCHAR(10),
    project_completion_date DATE
);
INSERT INTO projects (project_id, employee_name, project_completion_date) VALUES
(100, 'Ankit',  '2022-12-15'),
(101, 'Shilpa', '2023-01-03'),
(102, 'Shilpa', '2023-01-15'),
(103, 'Shilpa', '2023-01-22'),
(104, 'Rahul',  '2023-01-05'),
(105, 'Rahul',  '2023-01-12'),
(106, 'Mukesh', '2023-01-23'),
(108, 'Mukesh', '2023-02-04');

select employee_name, count(*) as no_of_proj, date_format(project_completion_date,'%Y-%m') AS month
from projects 
group by employee_name, month
having count(*)= (select max(cnt) from (select employee_name,
date_format(project_completion_date,'%Y-%m') as monthh,count(*) as cnt from projects 
group by employee_name,monthh) as c WHERE month=monthh)
order by no_of_proj desc;
-- this gives only one employee with high no.of projects from the entire table values
