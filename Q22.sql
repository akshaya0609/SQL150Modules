DROP TABLE IF EXISTS survey;
CREATE TABLE survey (
    name             VARCHAR(10),
    job_satisfaction INT,
    country          VARCHAR(20)
);
INSERT INTO survey (name, job_satisfaction, country) VALUES
('Alex',    4, 'USA'),
('Saurabh', 5, 'US'),
('Mark',    1, 'United States'),
('Shane',   4, 'USA'),
('Kim',     5, 'United States'),
('Joe',     5, 'USA'),
('Mira',    5, 'United States'),
('John',    5, 'USA'),
('Jane',    3, 'United States'),
('Sam',     3, 'US'),
('Sara',    4, 'USA');

with cte as (
select country, job_satisfaction, count(*) as res,
row_number() over (partition by job_satisfaction order by count(*) desc, country asc) as rn
from survey
group by country, job_satisfaction)
select c.job_satisfaction, sum(c.res) as respondents,
max(case when rn=1 then country end) as country_format
from cte c
group by c.job_satisfaction
order by c.job_satisfaction;

/*cnt = 1 can still get rn = 1
For job_satisfaction = 1:
Only one country (United States, count=1).
Since it’s the only option, it’s ranked #1 → correct.
For job_satisfaction = 3:
United States = 1, US = 1.
Both tied at 1.
ROW_NUMBER() forces a unique order → sorts alphabetically → United States comes before US.
So United States = rn=1, US = rn=2.
For job_satisfaction = 4:
USA = 3 → highest → rn=1.
For job_satisfaction = 5:
United States = 2, USA = 2, US = 1.
Tie between 2 & 2.
Alphabetical order → United States = rn=1, USA = rn=2. */