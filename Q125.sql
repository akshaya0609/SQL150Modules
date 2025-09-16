-- Employees
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  id INT,
  name VARCHAR(50),
  salary INT
);
INSERT INTO employees VALUES
(1,'Alice',100000),
(2,'Bob',120000),
(3,'Charlie',90000),
(4,'David',110000),
(5,'Eva',95000),
(6,'Frank',105000),
(7,'Grace',98000),
(8,'Helen',115000);

-- Projects
DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
  id INT,
  title VARCHAR(100),
  start_date DATE,
  end_date DATE,
  budget INT
);
INSERT INTO projects VALUES
(1,'Website Redesign','2024-01-15','2024-07-15',50000),
(2,'App Development','2024-02-01','2024-05-31',100000),
(3,'Cloud Migration','2024-03-01','2024-04-30',20000),
(4,'Analytics Platform','2024-05-05','2024-08-05',80000);

-- Project Employees
DROP TABLE IF EXISTS project_employees;
CREATE TABLE project_employees (
  project_id INT,
  employee_id INT
);
INSERT INTO project_employees VALUES
(1,1),
(2,2),(2,3),(2,4),
(3,5),(3,6),(3,7),(3,8),
(4,6),(4,7);


SELECT p.title,p.budget,
ROUND(SUM(e.salary / 365.0 * (DATEDIFF(p.end_date, p.start_date) + 1)),2) AS forecast_cost,
-- DATEDIFF(end_date, start_date) gives the difference in days, but it excludes the start date itself.
-- Example:SELECT DATEDIFF('2024-01-15', '2024-01-15');  -- returns 0
-- Even though the project runs for 1 day, DATEDIFF says 0. ""SO ADD 1 TO DATEDIFF""
CASE WHEN SUM(e.salary / 365.0 * (DATEDIFF(p.end_date, p.start_date) + 1)) > p.budget THEN 'overbudget' 
ELSE 'within budget' END AS budget_status
FROM projects p
JOIN project_employees pe ON p.id = pe.project_id
JOIN employees e ON e.id = pe.employee_id
GROUP BY p.id, p.title, p.budget, p.start_date, p.end_date
ORDER BY p.title;

