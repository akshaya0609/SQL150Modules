DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS events;
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  name    VARCHAR(15)
);
CREATE TABLE events (
  user_id     INT,
  type        VARCHAR(15),   -- e.g., 'Prime', 'Amazon Music', 'Amazon Video', 'Amazon Pay'
  access_date DATE
);
INSERT INTO users VALUES
(1,'Saurabh'),
(2,'Amit'),
(3,'Ankit');
INSERT INTO events VALUES
(1,'Amazon Music','2024-01-05'),
(1,'Amazon Video','2024-01-07'),
(1,'Prime','2024-01-08'),
(1,'Amazon Video','2024-01-09'),
(2,'Amazon Pay','2024-01-08'),
(2,'Prime','2024-01-09'),
(3,'Amazon Pay','2024-01-07'),
(3,'Amazon Music','2024-01-09');

with prime_users as(
select user_id, min(access_date) as prime_date from events
where type='prime'
group by user_id
),
last_service_before_prime as (
select e.user_id, e.type, e.access_date, p.prime_date
from events e left join prime_users p on e.user_id=p.user_id
where p.prime_date is null or p.prime_date>e.access_date ),
last_before as (
select user_id, type as last_service, access_date as last_service_date,
row_number() over (partition by user_id order by access_date desc) as rn
from last_service_before_prime )
select u.user_id, u.name, p.prime_date, lb.last_service, lb.last_service_date
from users u left join prime_users p using (user_id)
join last_before lb on lb.user_id=u.user_id and rn=1
order by lb.last_service_date;