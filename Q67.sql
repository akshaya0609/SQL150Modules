DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id               INT,
  restaurant_id          INT,
  order_time             TIME,
  expected_delivery_time TIME,
  actual_delivery_time   TIME,
  rider_delivery_mins    INT
);
-- order_id, rest_id, order_time, expected_delivery, actual_delivery, rider_mins
INSERT INTO orders VALUES
(1,101,'12:00:00','12:30:00','12:45:00',20),  -- total 45 → prep 25
(2,102,'12:15:00','12:45:00','12:55:00',22),  -- total 40 → prep 18
(3,103,'12:30:00','13:00:00','13:10:00',18),  -- total 40 → prep 22
(4,101,'12:45:00','13:15:00','13:21:00',15),  -- total 36 → prep 21
(5,102,'13:00:00','13:30:00','13:36:00',20),  -- total 36 → prep 16
(6,103,'13:05:00','13:45:00','13:58:00',25),  -- total 53 → prep 28
(7,101,'13:30:00','14:00:00','14:12:00',18);  -- total 42 → prep 24

SELECT restaurant_id, 
ROUND(AVG(CASE WHEN TIMESTAMPDIFF(SECOND, order_time, actual_delivery_time) / 60.0 >= rider_delivery_mins
        THEN TIMESTAMPDIFF(SECOND, order_time, actual_delivery_time) / 60.0 - rider_delivery_mins
        ELSE 0
      END),2) AS avg_prep_mins
FROM orders
GROUP BY restaurant_id
ORDER BY avg_prep_mins ASC;
