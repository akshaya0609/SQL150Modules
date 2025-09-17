DROP TABLE IF EXISTS user_sessions;
CREATE TABLE user_sessions (
  user_id INT,
  login_timestamp DATETIME
);
INSERT INTO user_sessions (user_id, login_timestamp) VALUES
-- User 1: Consistent (logins every day from June 6 to June 13)
(1, '2025-06-06 00:01:05'),
(1, '2025-06-07 00:01:05'),
(1, '2025-06-08 00:01:05'),
(1, '2025-06-09 00:01:05'),
(1, '2025-06-10 00:01:05'),
(1, '2025-06-11 00:01:05'),
(1, '2025-06-12 00:01:05'),
(1, '2025-06-13 00:01:05'),
-- User 2: Not consistent (missed June 7 and June 9)
(2, '2025-06-06 00:01:05'),
(2, '2025-06-08 00:01:05'),
(2, '2025-06-10 00:01:05'),
-- User 3: Consistent (logins from June 5 to June 7)
(3, '2025-06-05 00:01:05'),
(3, '2025-06-06 00:01:05'),
(3, '2025-06-07 00:01:05');

WITH logins AS (
SELECT user_id, MIN(DATE(login_timestamp)) AS first_login,
MAX(DATE(login_timestamp)) AS last_login,
COUNT(DISTINCT DATE(login_timestamp)) AS actual_days
FROM user_sessions
GROUP BY user_id
)
SELECT user_id
FROM logins
WHERE DATEDIFF(last_login, first_login) + 1 = actual_days;