CREATE TABLE events (
  user_id     INT,
  event_type  VARCHAR(10),
  event_time  TIMESTAMP
);

-- user 1
INSERT INTO events VALUES
(1,'click' , '2023-09-10 09:00:00'),
(1,'click' , '2023-09-10 10:00:00'),
(1,'scroll', '2023-09-10 10:20:00'),
(1,'click' , '2023-09-10 10:50:00'),
(1,'scroll', '2023-09-10 11:40:00'),
(1,'click' , '2023-09-10 12:40:00'),
(1,'scroll', '2023-09-10 12:50:00');

-- user 2
INSERT INTO events VALUES
(2,'click' , '2023-09-10 09:00:00'),
(2,'scroll', '2023-09-10 09:20:00'),
(2,'click' , '2023-09-10 10:30:00');

WITH ordered AS (
  SELECT e.*, LAG(event_time) OVER (PARTITION BY user_id ORDER BY event_time) AS prev_time
  FROM events e
),
flags AS (SELECT *,
         CASE
           WHEN prev_time IS NULL
             OR TIMESTAMPDIFF(MINUTE, prev_time, event_time) > 30
           THEN 1 ELSE 0
         END AS new_session
  FROM ordered
),
num AS (
  SELECT *, SUM(new_session) OVER (PARTITION BY user_id ORDER BY event_time) AS sess_no
  FROM flags
)
SELECT
  user_id,
  CONCAT(user_id,'-',sess_no)                AS session_id,
  MIN(event_time)                            AS session_start_time,
  MAX(event_time)                            AS session_end_time,
  TIMESTAMPDIFF(MINUTE,
                MIN(event_time),
                MAX(event_time))             AS session_duration_minutes,
  COUNT(*)                                   AS event_count
FROM num
GROUP BY user_id, sess_no
ORDER BY user_id, session_start_time;