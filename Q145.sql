DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT,
    name VARCHAR(50),
    platform VARCHAR(20)
);
INSERT INTO users (user_id, name, platform) VALUES
(1, 'Alice', 'LinkedIn'),
(1, 'Alice', 'Meta'),
(2, 'Bob', 'LinkedIn'),
(2, 'Bob', 'Instagram'),
(3, 'Charlie', 'Meta'),
(3, 'Charlie', 'Instagram'),
(4, 'David', 'Meta'),
(4, 'David', 'LinkedIn'),
(5, 'Eve', 'Instagram'),
(5, 'Eve', 'LinkedIn'),
(6, 'Frank', 'Instagram'),
(6, 'Frank', 'Meta');
DROP TABLE IF EXISTS events;
CREATE TABLE events (
    event_id INT,
    user_id INT,
    action VARCHAR(20),
    platform VARCHAR(20),
    created_at DATETIME
);
INSERT INTO events (event_id, user_id, action, platform, created_at) VALUES
(101, 1, 'like', 'LinkedIn', '2024-03-20 10:00:00'),
(102, 1, 'comment', 'Meta', '2024-03-21 11:00:00'),
(103, 2, 'post', 'LinkedIn', '2024-03-22 12:00:00'),
(104, 2, 'post', 'Instagram', '2024-03-22 13:00:00'),
(105, 3, 'like', 'Meta', '2024-03-23 13:00:00'),
(106, 3, 'comment', 'Instagram', '2024-03-24 14:00:00'),
(107, 4, 'post', 'Meta', '2024-03-25 15:00:00'),
(108, 4, 'like', 'LinkedIn', '2024-03-26 16:00:00'),
(109, 5, 'post', 'Instagram', '2024-03-27 17:00:00'),
(110, 5, 'like', 'LinkedIn', '2024-03-28 18:00:00'),
(111, 6, 'comment', 'Instagram', '2024-03-29 19:00:00');

SELECT u.platform,
ROUND((SUM(CASE WHEN e.user_id IS NULL THEN 1 ELSE 0 END)/COUNT(DISTINCT u.user_id)) * 100,2) AS percentage_no_liked_or_commented
FROM users u
LEFT JOIN (SELECT DISTINCT user_id, platform FROM events WHERE action IN ('like', 'comment')) e
ON u.user_id = e.user_id AND u.platform = e.platform
GROUP BY u.platform
ORDER BY u.platform;

