DROP TABLE IF EXISTS logs;
CREATE TABLE logs (log_id INT);

INSERT INTO logs (log_id) VALUES
(1),(2),(3),(7),(8),(10),(12),(13),(14),(15),(16);

WITH cte AS (                     
  SELECT DISTINCT log_id FROM logs
),
cte2 AS (
  SELECT
    log_id,
    log_id - ROW_NUMBER() OVER (ORDER BY log_id) AS g 
  FROM cte
)
SELECT
  MIN(log_id) AS start_id,
  MAX(log_id) AS end_id,
  COUNT(*)    AS length
FROM cte2
GROUP BY g
ORDER BY start_id;