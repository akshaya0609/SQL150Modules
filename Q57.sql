DROP TABLE IF EXISTS dashboard_visit;
CREATE TABLE dashboard_visit (
  user_id    VARCHAR(10),
  visit_time DATETIME
);
INSERT INTO dashboard_visit (user_id, visit_time) VALUES
('Alice',  '2021-12-04 10:44:56'),
('Alice',  '2021-12-04 10:55:56'),
('Alice',  '2021-12-04 12:56:56'),
('Bob',    '2021-12-05 12:05:50'),
('Bob',    '2021-12-06 14:55:50'),
('Charlie','2021-11-06 17:53:50'),
('Charlie','2021-11-06 17:57:50'),
('David',  '2021-11-29 13:53:50'),
('David',  '2021-12-01 10:53:50'),
('David',  '2021-12-06 23:53:50'),
('David',  '2021-12-07 00:20:50');

with cte1 as (
select user_id, visit_time,
lag(visit_time) over (partition by user_id order by visit_time) as prev_visit
from dashboard_visit),
cte2 as (
select user_id, visit_time,
case when prev_visit is null or timestampdiff(second, prev_visit, visit_time)>=3600 then 1 else 0 end
-- case when prev_visit is null or timestampdiff(minute, prev_visit, visit_time)>=60 then 1 else 0 end
as new_visit from cte1)
select user_id, sum(new_visit) as no_of_visits,
count(distinct date(visit_time)) as distinct_days
from cte2
group by user_id order by user_id;

-- OR

WITH previous_visits AS
(
SELECT
user_id,
visit_time,
LAG(visit_time) OVER (PARTITION BY user_id ORDER BY visit_time) AS previous_visit_time
FROM
dashboard_visit
)
, visit_flag as
(
select user_id, previous_visit_time,visit_time
, CASE WHEN previous_visit_time IS NULL THEN 1
WHEN TIMESTAMPDIFF(second, previous_visit_time, visit_time) / 3600 > 1 THEN 1
ELSE 0
END AS new_visit_flag
from previous_visits
)
select user_id, sum(new_visit_flag) as no_of_visits, count(distinct CAST(visit_time as DATE)) as visit_days
from visit_flag
group by user_id
ORDER BY user_id ASC;
