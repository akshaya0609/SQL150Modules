DROP TABLE IF EXISTS service_status;
CREATE TABLE service_status (
    service_name VARCHAR(4),
    updated_time DATETIME,
    status VARCHAR(4)
);
INSERT INTO service_status (service_name, updated_time, status) VALUES
('hdfs', '2024-03-06 10:01:00', 'up'),
('hdfs', '2024-03-06 10:02:00', 'down'),
('hdfs', '2024-03-06 10:03:00', 'down'),
('hdfs', '2024-03-06 10:04:00', 'down'),
('hdfs', '2024-03-06 10:05:00', 'down'),
('hdfs', '2024-03-06 10:06:00', 'down'),
('hdfs', '2024-03-06 10:07:00', 'down');

WITH down_times AS (
    SELECT
        service_name,
        updated_time,
        status,
        ROW_NUMBER() OVER (PARTITION BY service_name ORDER BY updated_time) -
        ROW_NUMBER() OVER (PARTITION BY service_name, status ORDER BY updated_time) AS grp
    FROM service_status
    WHERE status = 'down'
),
grouped AS (
    SELECT
        service_name,
        MIN(updated_time) AS start_time,
        MAX(updated_time) AS end_time,
        COUNT(*) AS minutes_down
    FROM down_times
    GROUP BY service_name, grp
    HAVING COUNT(*) >= 5   -- ✅ move filter here instead of WHERE
)
SELECT
    service_name,
    TIMESTAMPDIFF(MINUTE, start_time, end_time) + 1 AS down_minutes
FROM grouped
ORDER BY down_minutes DESC;