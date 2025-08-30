DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT NOT NULL,
    order_date   DATE NOT NULL,
    order_amount INT
);
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES
(1,  1001, '2025-06-01', 120),  -- first purchase for 1001 (new)
(2,  1002, '2025-06-01', 200),  -- first purchase for 1002 (new)
(3,  1003, '2025-06-02',  80),  -- new
(4,  1002, '2025-06-02', 150),  -- repeat
(5,  1004, '2025-06-02', 220),  -- new
(6,  1001, '2025-06-03', 130),  -- repeat
(7,  1005, '2025-06-03',  90),  -- new
(8,  1006, '2025-06-04', 250),  -- new
(9,  1003, '2025-06-04', 110),  -- repeat
(10, 1007, '2025-06-05', 180),  -- new
(11, 1008, '2025-06-05', 160),  -- new
(12, 1004, '2025-06-05', 140),  -- repeat
(13, 1008, '2025-06-06', 200),  -- repeat
(14, 1009, '2025-06-06',  95),  -- new
(15, 1006, '2025-06-06', 175);  -- repeat

select order_date, count(distinct case when o.order_date = f.fdate then o.customer_id end) as newc, 
count(distinct case when o.order_date>f.fdate then o.customer_id end) as repeatc 
from customer_orders o
join (select customer_id,min(order_date) as fdate from customer_orders group by customer_id) as f
on f.customer_id=o.customer_id
group by o.order_date
order by repeatc, order_date; 

select o.order_date, count(if(o.order_date=c.fdate, o.customer_id,null)) as newc, 
count(if(o.order_date>c.fdate, o.customer_id,null)) as repeatc from customer_orders o
join (select customer_id, min(order_date) as fdate from customer_orders group by customer_id) as c
 using (customer_id)
group by order_date
order by repeatc, order_date;
