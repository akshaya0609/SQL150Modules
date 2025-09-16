CREATE TABLE reel(
  reel_id          INT,
  record_date      DATE,
  state            VARCHAR(20),
  cumulative_views INT
);
INSERT INTO reel VALUES
-- California (reel 1)
(1,'2024-08-01','california',1000),
(1,'2024-08-02','california',1500),
(1,'2024-08-03','california',2000),
(1,'2024-08-04','california',2500),
(1,'2024-08-05','california',3000),
-- Nevada (reel 1)
(1,'2024-08-01','nevada', 800),
(1,'2024-08-02','nevada',1200),
(1,'2024-08-03','nevada',1600),
(1,'2024-08-04','nevada',2000),
(1,'2024-08-05','nevada',2400),
(1,'2024-08-06','nevada',2800),
(1,'2024-08-07','nevada',3200);

SELECT reel_id, state, ROUND(AVG(daily_views), 2) AS avg_daily_views FROM (
SELECT reel_id, state, record_date, cumulative_views - COALESCE(LAG(cumulative_views) OVER 
(PARTITION BY reel_id, state ORDER BY record_date), 0) AS daily_views
    FROM reel
) d
GROUP BY reel_id, state
ORDER BY avg_daily_views DESC;