DROP TABLE IF EXISTS candidates;
CREATE TABLE candidates (
    emp_id INT,
    experience VARCHAR(6),
    salary INT
);
-- Insert values
INSERT INTO candidates VALUES
(1, 'Junior', 10000),
(2, 'Junior', 15000),
(3, 'Junior', 40000),
(4, 'Senior', 16000),
(5, 'Senior', 20000),
(6, 'Senior', 50000);

with total_sal as(
select *,
sum(salary) over(partition by experience order by salary rows between unbounded preceding and
current row) as running_sal
from candidates
),
seniors as
(select *
from total_sal
where experience='Senior' and running_sal <= 70000
)
select emp_id, experience, salary from seniors
union all
select emp_id, experience, salary from total_sal
where experience='Junior'
and running_sal <= 70000-(select sum(salary) from seniors)
order by salary desc;
