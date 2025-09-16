DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    customer_id INT NOT NULL,
    order_id    INT PRIMARY KEY,
    order_date  DATE NOT NULL
);
INSERT INTO orders (customer_id, order_id, order_date) VALUES
-- customer 1: three different months
(1, 101, '2023-01-15'),
(1, 102, '2023-02-10'),
(1, 103, '2023-03-12'),
-- customer 2: three different months
(2, 201, '2023-01-20'),
(2, 202, '2023-02-25'),
(2, 203, '2023-03-23'),
-- customer 3: four orders; two in Jan (same month), others in Mar & May
(3, 301, '2023-01-01'),
(3, 302, '2023-01-18'),
(3, 303, '2023-03-01'),
(3, 304, '2023-05-01'),
-- customer 4: three different months (Jan, Feb, Apr)
(4, 401, '2023-01-05'),
(4, 402, '2023-02-05'),
(4, 403, '2023-04-25');

select customer_id, count(*) as no_of_orders
from orders
group by customer_id
having count(distinct month(order_date))>=3 
-- having count(distinct year(order_date), month(order_date))>=3 -- if the data have multiple years
order by customer_id;