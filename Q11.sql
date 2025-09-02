DROP TABLE IF EXISTS students;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(20) NOT NULL,
    class_id  INT
);
DROP TABLE IF EXISTS grades;
CREATE TABLE grades (
    student_id INT NOT NULL,
    subject    VARCHAR(20) NOT NULL,
    grade      INT,
    PRIMARY KEY (student_id, subject),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
INSERT INTO students (student_id, student_name, class_id) VALUES
(1,  'John Doe',      1),
(2,  'Jane Smith',    2),
(3,  'Alice Johnson', 1),
(4,  'Bob Brown',     3),
(5,  'Emily Clark',   2),
(6,  'Michael Lee',   1),
(7,  'Sarah Taylor',  2),
(8,  'David Wilson',  3),
(9,  'Olivia Martin', 1),
(10, 'Daniel Harris', 2);
INSERT INTO grades (student_id, subject, grade) VALUES
(1,  'Math', 85),
(2,  'Math', 78),
(3,  'Math', 92),
(4,  'Math', 79),
(5,  'Math', 88),
(6,  'Math', 95),
(7,  'Math', 83),
(8,  'Math', 76),
(9,  'Math', 90),
(10, 'Math', 81);

SELECT student_name, g.grade from students s join grades g
on s.student_id=g.student_id
where g.subject='Math' and g.grade> (select avg(grade) from grades) 
order by g.grade desc;
