DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(20)
);
INSERT INTO Departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(20),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
INSERT INTO Employees (employee_id, employee_name, salary, department_id) VALUES
(1, 'John Doe', 50000, 1),
(2, 'Jane Smith', 60000, 1),
(3, 'Alice Johnson', 70000, 2),
(4, 'Bob Brown', 55000, 2),
(5, 'Emily Clark', 48000, 1),
(6, 'Michael Lee', 62000, 3),
(7, 'Sarah Taylor', 53000, 3),
(8, 'David Martinez', 58000, 1),
(9, 'Laura White', 65000, 1),
(10, 'Chris Wilson', 56000, 3);

select department_id,count(*) as cnt from employees 
group by department_id
having cnt>2;

select department_name, round(avg(salary),2) as avrg from departments 
join employees using (department_id)
group by department_name
having count(employee_id)>2 order by avrg desc;
