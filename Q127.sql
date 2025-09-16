DROP TABLE IF EXISTS packages;
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS stud;

-- Students
CREATE TABLE stud (
  id   INT PRIMARY KEY,
  name VARCHAR(20) NOT NULL
);
INSERT INTO stud (id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana'),
(5, 'Eve');

-- Friends (best friends; a student can have multiple)
CREATE TABLE friends (
  id        INT NOT NULL,   -- student id
  friend_id INT NOT NULL
);
INSERT INTO friends (id, friend_id) VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 1),
(3, 2),
(4, 5),
(5, 1);

-- Packages (offers)
CREATE TABLE packages (
  id     INT PRIMARY KEY,   -- student id
  salary INT NOT NULL
);
INSERT INTO packages (id, salary) VALUES
(1, 50000),
(2, 60000),
(3, 70000),
(4, 40000),
(5, 30000);

select s.name,avg(pf.salary)-p.salary as diff 
from stud s
join friends f using (id)
join packages p using (id)
join packages pf on pf.id=f.friend_id
group by s.name,p.salary
having min(pf.salary) > p.salary;
