DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  Name       VARCHAR(20),
  JoinDate   DATE,
  JobTitle   VARCHAR(20)
);

INSERT INTO Employees (EmployeeID, Name, JoinDate, JobTitle) VALUES
(1,  'John Doe',        '2022-02-15', 'Software Engineer'),
(2,  'Jane Smith',      '2022-03-20', 'Software Developer'),
(3,  'Alice Johnson',   '2022-10-11', 'Software Engineer'),
(4,  'Bob Anderson',    '2021-01-05', 'Project Manager'),
(5,  'Ella Williams',   '2022-04-25', 'Software Engineer'),
(6,  'Michael Brown',   '2022-03-10', 'Data Analyst'),
(7,  'Sophia Garcia',   '2022-02-18', 'Software Engineer'),
(8,  'James Martinez',  '2021-03-20', 'Project Manager'),
(9,  'Olivia Robinson', '2022-04-05', 'Software Engineer'),
(10, 'Liam Clark',      '2022-02-11', 'Software Engineer'),
(11, 'Noah Thompson',   '2022-05-10', 'Data Scientist');

SELECT
  sum(JobTitle LIKE 'Software%') AS software_engineers,
  sum(JobTitle LIKE 'Data%') AS data_professionals,
  sum(JobTitle LIKE '%Manager%') AS managers from Employees;

select count(case when JobTitle LIKE 'Software%' then JobTitle end) AS software_engineers,
       count(case when JobTitle LIKE 'Data%' then JobTitle end) AS data_professionals,
       count(case when JobTitle LIKE '%Manager%' then JobTitle end) AS managers from Employees;
