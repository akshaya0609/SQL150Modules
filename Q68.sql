DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id               INT,
  restaurant_id          INT,
  order_time             TIME,
  expected_delivery_time TIME,
  actual_delivery_time   TIME,
  rider_delivery_mins    INT
);

INSERT INTO orders
(order_id, restaurant_id, order_time, expected_delivery_time, actual_delivery_time, rider_delivery_mins) VALUES
-- qualifies (late; rider > half; kitchen <= half)
(1 ,101,'12:00:00','12:30:00','12:34:00',20),  -- exp=30, act=34, rider=20, prep=14
(2 ,102,'12:15:00','12:45:00','12:52:00',25),  -- exp=30, act=37, rider=25, prep=12
(3 ,103,'12:30:00','13:05:00','13:10:00',24),  -- exp=35, act=40, rider=24, prep=16
(4 ,101,'12:45:00','13:12:00','13:21:00',26),  -- exp=27, act=36, rider=26, prep=10
(5 ,102,'13:00:00','13:30:00','13:36:00',22),  -- exp=30, act=36, rider=22, prep=14
(6 ,103,'13:45:00','14:20:00','14:22:00',20),  -- exp=35, act=37, rider=20, prep=17
-- non-qualifiers (for sanity)
(7 ,101,'13:30:00','14:00:00','14:00:00',30),  -- on time
(8 ,102,'13:50:00','14:20:00','14:35:00',10);  -- late due to kitchen

with cte as (
select *,
timestampdiff(minute, order_time, expected_delivery_time) as expected_delivery_mins,
timestampdiff(minute, order_time, actual_delivery_time) as actual_delivery_mins,
timestampdiff(minute, order_time, actual_delivery_time)-rider_delivery_mins as food_prep 
from orders )
select order_id, expected_delivery_mins, rider_delivery_mins, food_prep
from cte
where actual_delivery_mins> expected_delivery_mins and 
/* there is equal time allocated to restaurant for food preparation and rider to deliver the order.”
Because we only know the total expected time (expected_delivery_time – order_time), 
the only way to decide whether the rider alone caused the delay is to assume their expected share is half of 
that window, and the restaurant’s expected share is the other half. */
rider_delivery_mins > expected_delivery_mins/2 and
food_prep <= expected_delivery_mins/2
order by order_id;

