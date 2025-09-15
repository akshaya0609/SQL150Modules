DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    product_id INT,
    sales INT
);
INSERT INTO orders (order_id, customer_id, order_date, product_id, sales) VALUES
-- Product 1 (January sales increase 2022→2023→2024)
(1, 101, '2022-01-10', 1, 100),
(2, 102, '2023-01-12', 1, 150),
(3, 103, '2024-01-15', 1, 200),
-- Product 1 (February sales increase)
(4, 104, '2022-02-10', 1, 80),
(5, 105, '2023-02-12', 1, 120),
(6, 106, '2024-02-14', 1, 160),
-- Product 2 (January sales increase)
(7, 107, '2022-01-05', 2, 90),
(8, 108, '2023-01-07', 2, 120),
(9, 109, '2024-01-09', 2, 150),
-- Product 2 (February sales decrease → should be excluded later)
(10, 110, '2022-02-05', 2, 200),
(11, 111, '2023-02-07', 2, 180),
(12, 112, '2024-02-09', 2, 170),
-- Product 3 (March sales increase)
(13, 113, '2022-03-15', 3, 50),
(14, 114, '2023-03-16', 3, 75),
(15, 115, '2024-03-18', 3, 120),
-- Product 4 (only 2 years → should be excluded later)
(16, 116, '2022-01-20', 4, 300),
(17, 117, '2023-01-22', 4, 400);


with cte as (
select product_id, MONTH(order_date) AS order_month
,YEAR(order_date) AS order_year
,SUM(sales) AS sales
from orders
group by product_id,MONTH(order_date) ,YEAR(order_date)
)
,cte2 as (
select product_id,order_month
, sum(case when order_year='2022' then sales else 0 end) as sales_2022
, sum(case when order_year='2023' then sales else 0 end) as sales_2023
, sum(case when order_year='2024' then sales else 0 end) as sales_2024
from cte
group by product_id,order_month
)
select *
from cte2
where sales_2024>sales_2023 and sales_2023>sales_2022
ORDER BY product_id;
