DROP TABLE IF EXISTS stu_course;
CREATE TABLE stu_course (
  student_id  INT,
  course_name VARCHAR(10),
  score       INT
);
INSERT INTO stu_course (student_id, course_name, score) VALUES
(1, 'Math',    85),
(1, 'Science', 65),
(2, 'Math',    90),
(2, 'Science', 75),
(3, 'Math',    60),
(3, 'Science', 70),
(4, 'Math',    95),
(4, 'Science', 85),
(5, 'Math',    50),
(5, 'Science', 80),
(6, 'English', 80);

select student_id,course_name, avg(score) as avrg from stu_course
where student_id in (select student_id from stu_course where score<70)
group by student_id,course_name
having avrg>70
order by avrg desc;