DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id      INT,
  rider_id      INT,
  pickup_time   DATETIME,
  delivery_time DATETIME
);
INSERT INTO orders VALUES
(1,101,'2024-01-01 10:00:00','2024-01-01 10:30:00'),
(2,102,'2024-01-01 23:50:00','2024-01-02 00:10:00'),
(3,103,'2024-01-01 13:45:00','2024-01-01 14:15:00'),
(4,101,'2024-01-01 23:45:00','2024-01-02 00:15:00'),
(5,102,'2024-01-02 01:30:00','2024-01-02 02:00:00'),
(6,103,'2024-01-02 23:59:00','2024-01-03 00:31:00'),
(7,101,'2024-01-03 09:00:00','2024-01-03 09:30:00');

select rider_id, date(pickup_time) as ride_date,
sum(timestampdiff(minute,pickup_time, delivery_time)) as duration
from orders
group by rider_id, ride_date
order by rider_id, ride_date;