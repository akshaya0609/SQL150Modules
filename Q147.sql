DROP TABLE IF EXISTS stds;
CREATE TABLE stds (
    student_id INT,
    skill VARCHAR(50)
);
INSERT INTO stds (student_id, skill) VALUES
(1, 'SQL'),
(1, 'Python'),
(1, 'SQL'),
(3, 'Python'),
(4, 'SQL'),
(4, 'Excel'),
(5, 'SQL'),
(6, 'SQL'),
(6, 'Python'),
(7, 'Excel'),
(8, 'sql'),
(9, 'Excel');

select student_id from stds 
group by student_id
having count(skill)=1 and group_concat(skill)='sql';
-- having count(skill)=1 and min(skill)='sql';