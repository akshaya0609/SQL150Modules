DROP TABLE IF EXISTS train_schedule;
CREATE TABLE train_schedule (
  station_id     INT,
  train_id       INT,
  arrival_time   TIME,
  departure_time TIME
);
-- Station 100
INSERT INTO train_schedule VALUES
(100, 1, '08:00:00', '08:15:00'),
(100, 2, '08:05:00', '08:10:00'),
(100, 3, '08:10:00', '08:20:00'),
(100, 4, '08:15:00', '08:25:00'),
(100, 5, '11:00:00', '11:20:00'),
(100, 6, '12:15:00', '12:30:00'),
(100, 7, '12:20:00', '12:25:00'),
(100, 8, '12:25:00', '12:30:00');
-- Station 200
INSERT INTO train_schedule VALUES
(200, 9,  '09:00:00', '09:10:00'),
(200, 10, '09:05:00', '09:15:00'),
(200, 11, '09:12:00', '09:20:00'),
(200, 12, '10:00:00', '10:05:00'),
(200, 13, '10:03:00', '10:08:00'),
(200, 14, '10:07:00', '10:15:00');
-- Station 300
INSERT INTO train_schedule VALUES
(300, 15, '14:00:00', '14:30:00'),
(300, 16, '14:05:00', '14:15:00'),
(300, 17, '14:20:00', '14:25:00'),
(300, 18, '14:28:00', '14:40:00'),
(300, 19, '14:35:00', '14:50:00');

WITH events AS (
  SELECT station_id, arrival_time AS event_time, 1 AS chge
  FROM train_schedule
  UNION ALL
  SELECT station_id, departure_time AS event_time, -1 AS chge
  FROM train_schedule
)
SELECT station_id,MAX(running_total) AS min_platforms FROM (
SELECT station_id, event_time,
SUM(chge) OVER (PARTITION BY station_id ORDER BY event_time, chge DESC) AS running_total
FROM events
) t
GROUP BY station_id
ORDER BY station_id;