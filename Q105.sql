DROP TABLE IF EXISTS student_courses;
CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    major_flag VARCHAR(1)
);
INSERT INTO student_courses (student_id, course_id, major_flag) VALUES
(1, 101, 'N'),
(2, 101, 'Y'),
(2, 102, 'N'),
(3, 103, 'Y'),
(4, 102, 'N'),
(4, 103, 'Y'),
(4, 104, 'N'),
(5, 104, 'N');

select student_id, course_id from student_courses
where major_flag='Y' or student_id in 
(select student_id from student_courses group by student_id having count(*)=1) 
order by student_id;
