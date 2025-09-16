CREATE TABLE rating_table(
  trip_time  DATETIME,
  driver_id  VARCHAR(5),
  trip_id    INT,
  rating     INT
);

INSERT INTO rating_table VALUES
('2023-04-24 10:15:00','a',0, 4),
('2023-04-24 15:20:27','a',1, 5),
('2023-04-24 22:32:27','a',2, 5),
('2023-04-25 08:00:00','a',3, 3),
('2023-04-25 12:00:00','a',4, 4),
('2023-04-25 12:05:00','a',5, 1),
('2023-04-24 09:15:00','b',6, 5),
('2023-04-24 12:36:00','b',7, 4),
('2023-04-25 09:45:00','b',8, 4),
('2023-04-25 11:30:00','b',9, 4),
('2023-04-25 14:00:00','b',10,5),
('2023-04-24 08:30:00','c',11,5);

WITH s AS (
SELECT driver_id, trip_time, rating,
      CASE WHEN rating >= 4 THEN 1 ELSE 0 END AS pos,
      ROW_NUMBER() OVER (PARTITION BY driver_id ORDER BY trip_time) AS rn1,
      ROW_NUMBER() OVER (PARTITION BY driver_id, CASE WHEN rating >= 4 THEN 1 ELSE 0 END
        ORDER BY trip_time) AS rn2 FROM rating_table),
runs AS (                          
  SELECT driver_id, (rn1 - rn2) AS grp
  FROM s
  WHERE pos = 1
),
cnt AS (
  SELECT driver_id, grp, COUNT(*) AS len
  FROM runs
  GROUP BY driver_id, grp)
SELECT driver_id, MAX(len - 1) AS max_streak
FROM cnt
GROUP BY driver_id
HAVING MAX(len) >= 2             
ORDER BY max_streak DESC, driver_id DESC;