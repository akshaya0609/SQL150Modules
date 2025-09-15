DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id     INT PRIMARY KEY,
  customer_id  INT,
  order_amount DECIMAL(10,2),
  order_date   DATE
);
INSERT INTO orders (order_id, customer_id, order_amount, order_date) VALUES
(1,  101, 100.00, '2023-01-04'),
(2,  101, 200.00, '2023-01-05'),
(3,  101,  80.00, '2023-01-06'),
(4,  101, 110.00, '2023-01-07'),
(5,  101,  90.00, '2023-01-08'),
(6,  101, 130.00, '2023-01-14'),
(7,  101, 150.00, '2023-01-15'),
(8,  101, 100.00, '2023-01-21'),
(9,  101, 120.00, '2023-01-22'),
(10, 101,  90.00, '2023-01-28'),
(11, 102, 110.00, '2023-01-29');

-- select weekday(order_date) from orders; -> returns indexes of week from Monday-sunday(0-6)
-- select dayofweek(order_date) from orders; -> returns indexes of week from 1-7 (sunday-saturday)
select customer_id,
round(AVG(CASE WHEN DAYOFWEEK(order_date) IN (1,7) THEN order_amount END),2)as weekday_amount,
round(AVG(CASE WHEN DAYOFWEEK(order_date) NOT IN (1,7) THEN order_amount END),2)as weekend_amount,
round(100*(Avg(CASE WHEN DAYOFWEEK(order_date) IN (1,7) THEN order_amount END)-
  AVG(CASE WHEN DAYOFWEEK(order_date) NOT IN (1,7) THEN order_amount END))/
  AVG(CASE WHEN DAYOFWEEK(order_date) NOT IN (1,7) THEN order_amount END),2) as percentage
from orders
group by customer_id
having sum(case when DAYOFWEEK(order_date) IN (1,7) THEN order_amount END)>=3 and
sum(case when  DAYOFWEEK(order_date) NOT IN (1,7) THEN order_amount END)>=3 and 
weekend_amount>=1.20 * weekday_amount
order by percentage desc;