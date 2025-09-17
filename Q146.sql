DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id VARCHAR(10),
    registration_date DATE
);
INSERT INTO users (user_id, registration_date) VALUES
('aaa', '2019-01-03'),
('bbb', '2019-01-02'),
('ccc', '2019-01-15'),
('ddd', '2019-02-07'),
('eee', '2019-02-08');
DROP TABLE IF EXISTS usaage;
CREATE TABLE usaage (
    user_id VARCHAR(10),
    usage_date DATE,
    location VARCHAR(20),
    time_spent INT
);
INSERT INTO usaage (user_id, usage_date, location, time_spent) VALUES
('aaa', '2019-01-03', 'US', 38),
('aaa', '2019-02-01', 'US', 12),
('aaa', '2019-03-04', 'US', 30),
('bbb', '2019-01-03', 'US', 20),
('bbb', '2019-02-04', 'Canada', 31),
('ccc', '2019-01-16', 'US', 40),
('ddd', '2019-02-08', 'US', 45),
('eee', '2019-02-10', 'US', 20),
('eee', '2019-02-20', 'Canada', 12),
('eee', '2019-03-15', 'US', 21),
('eee', '2019-04-25', 'US', 12);

WITH cte AS (
SELECT u.user_id,DATE_FORMAT(u.registration_date, '%Y-%m') AS registration_month,
TIMESTAMPDIFF(MONTH, u.registration_date, usage_date) + 1 AS month_num,
SUM(time_spent) AS total_time
FROM users u
JOIN usaage us ON u.user_id = us.user_id
GROUP BY u.user_id, registration_month, month_num),
cte2 AS (
SELECT user_id, registration_month, month_num FROM cte
WHERE total_time >= 30
)
SELECT registration_month, 
COUNT(DISTINCT u.user_id) AS total_users,
ROUND(100.0*COUNT(DISTINCT CASE WHEN e.month_num = 1 THEN e.user_id END)/COUNT(DISTINCT u.user_id), 2) AS m1_retention,
ROUND(100.0*COUNT(DISTINCT CASE WHEN e.month_num = 2 THEN e.user_id END)/COUNT(DISTINCT u.user_id), 2) AS m2_retention,
ROUND(100.0*COUNT(DISTINCT CASE WHEN e.month_num = 3 THEN e.user_id END)/COUNT(DISTINCT u.user_id), 2) AS m3_retention
FROM users u
JOIN cte2 e ON u.user_id = e.user_id
AND DATE_FORMAT(u.registration_date, '%Y-%m') = e.registration_month
GROUP BY registration_month
ORDER BY registration_month;