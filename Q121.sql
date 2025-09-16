DROP TABLE IF EXISTS items;
CREATE TABLE items (
  id     INT PRIMARY KEY,
  weight INT NOT NULL
);
INSERT INTO items (id, weight) VALUES
(1,1),(2,3),(3,5),(4,3),(5,2),(6,1),
(7,4),(8,1),(9,2),(10,5),(11,1),(12,3);

SELECT id, weight,
SUM(CASE WHEN running_sum + weight > 5 THEN 1 ELSE 0 END) 
OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) + 1 AS box_no
FROM (
SELECT id, weight, 
SUM(weight) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS running_sum
FROM items) t;
