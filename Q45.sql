DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    customer_name VARCHAR(20),
    order_value INT
);
INSERT INTO orders (order_id, order_date, customer_name, order_value) VALUES
(1, '2023-01-13 12:30:00', 'Rahul', 250),
(2, '2023-01-13 08:30:00', 'Rahul', 350),
(3, '2023-01-13 09:00:00', 'Mudit', 230),
(4, '2023-01-13 08:30:00', 'Rahul', 150),
(5, '2023-01-14 12:03:00', 'Suresh', 130),
(6, '2023-01-15 09:34:00', 'Mudit', 250),
(7, '2023-01-15 12:10:00', 'Mudit', 300),
(8, '2023-01-15 09:34:00', 'Rahul', 250),
(9, '2023-01-15 12:35:00', 'Rahul', 300),
(10, '2023-01-15 12:03:00', 'Suresh', 130);

with cte as
(
select
customer_name,
CAST(order_date as DATE) as order_day,
count(*) as no_of_orders
from orders
group by customer_name,CAST(order_date as DATE)
having count(*)>1
)
select
orders.customer_name,
sum(orders.order_value) as total_order_value,
sum(case when cte.customer_name is not null then orders.order_value end) as order_value
from orders
left join cte on orders.customer_name=cte.customer_name and
CAST(orders.order_date as DATE) =cte.order_day
where orders.customer_name in (select distinct customer_name from cte)
group by orders.customer_name
ORDER BY total_order_value;
