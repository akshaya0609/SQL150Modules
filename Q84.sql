CREATE TABLE trips (
  trip_id    INT,
  driver_id  INT,
  fare       INT,
  rating     DECIMAL(3,2)
);

INSERT INTO trips VALUES
(1,101,1500,4.50),
(2,101,2000,4.20),
(3,101,2500,5.00),
(4,101,3000,4.70),
(5,101,3500,4.40),
(6,101,4000,4.90),
(7,101,4500,4.60),
(8,101,5000,4.30),
(9,101,5500,4.10),
(10,101,6000,4.70);

WITH trip_comm AS (
  SELECT
      t.*,
      /* Average rating of the last 3 trips BEFORE the current one */
      AVG(rating)  OVER (
          PARTITION BY driver_id
          ORDER BY trip_id
          ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
      ) AS prev3_avg,
      /* How many previous trips are available (to detect first 3) */
      COUNT(*) OVER (
          PARTITION BY driver_id
          ORDER BY trip_id
          ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
      ) AS prev_cnt
  FROM trips t
),
per_trip AS (
  SELECT
      driver_id,
      fare,
      CASE
        WHEN prev_cnt < 3                     THEN 0.24
        WHEN prev3_avg BETWEEN 4.7 AND 5.0    THEN 0.20
        WHEN prev3_avg BETWEEN 4.5 AND 4.7    THEN 0.23
        ELSE 0.24
      END AS commission
  FROM trip_comm
)
SELECT
    driver_id,
    ROUND(SUM(fare * (1 - commission)), 2) AS total_earnings
FROM per_trip
GROUP BY driver_id
ORDER BY driver_id;