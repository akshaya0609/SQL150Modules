DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id      INT PRIMARY KEY,
  order_date    DATE,
  customer_id   INT,
  delivery_date DATE,
  cancel_date   DATE
);
INSERT INTO orders (order_id, customer_id, order_date, delivery_date, cancel_date) VALUES
(1, 101, '2023-01-05', '2023-01-10', NULL),        -- delivered
(2, 102, '2023-01-10', '2023-01-15', '2023-01-16'),-- delivered then returned
(3, 103, '2023-01-15', NULL, '2023-01-20'),-- cancelled before delivery
(4, 104, '2023-01-23', '2023-01-30',  NULL),        -- delivered
(5, 105, '2023-01-13', '2023-01-17',  '2023-01-19'),-- delivered then returned
(6, 106, '2023-02-15', '2023-02-20',  NULL),        -- delivered
(7, 107, '2023-02-05', '2023-02-05',  '2023-02-08'),-- delivered then returned
(8, 108, '2023-02-10', NULL, '2023-02-15');-- cancelled before delivery

select s.yr,s.mnth, 
round(100*cancel/(total-returnd),2) as cancel_rate,
round(100*returnd/(total-cancel),2) as return_rate from
(select year(order_date) as yr, month(order_date) as mnth,
sum(case when cancel_date is not null and delivery_date is null
      then 1 else 0 end) as cancel,
sum(case when cancel_date is not null and delivery_date is not null and cancel_date>delivery_date
      then 1 else 0 end) as returnd,
count(*) as total
from orders
group by yr, mnth) s
order by s.yr,s.mnth;

-- cte
with cte as(
select year(order_date) as yr, month(order_date) as mnth,
sum(case when cancel_date is not null and delivery_date is null
      then 1 else 0 end) as cancel,
sum(case when cancel_date is not null and delivery_date is not null and cancel_date>delivery_date
      then 1 else 0 end) as returnd,
count(*) as total
from orders
group by yr, mnth)
select yr, mnth,
round(100*cancel/(total-returnd),2) as cancel_rate,
round(100*returnd/(total-cancel),2) as return_rate from cte
order by yr, mnth;
