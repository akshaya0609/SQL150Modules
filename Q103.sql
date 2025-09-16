DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id INT,
    name VARCHAR(10),
    mentor_id INT
);
INSERT INTO employees (id, name, mentor_id) VALUES
(1, 'Arjun',  NULL),
(2, 'Sneha',  1),
(3, 'Vikram', NULL),
(4, 'Rahul',  3),
(5, 'Priya',  2),
(6, 'Neha',   3),
(7, 'Rohan',  1),
(8, 'Amit',   4);

select name from employees where mentor_id!=3 or mentor_id is null;