DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id    INT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date  DATE NOT NULL
);
INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1 , 101, '2023-12-01'),
(2 , 102, '2023-12-02'),
(3 , 103, '2023-12-13'),
(4 , 104, '2024-01-05'),
(5 , 101, '2024-01-06'),
(6 , 102, '2024-01-08'),
(7 , 102, '2024-01-10'),
(8 , 104, '2024-02-15'),
(9 , 105, '2024-02-20'),
(10, 102, '2024-02-25');


WITH cte AS (
SELECT DISTINCT
YEAR(order_date) AS year,
MONTH(order_date) AS month,
customer_id
FROM orders
)
SELECT
c.year AS current_year,
c.month AS current_month,
f.year AS future_year,
f.month AS future_month,
COUNT(DISTINCT c.customer_id) AS total_customers,
COUNT(DISTINCT CASE WHEN f.customer_id = c.customer_id THEN f.customer_id END) AS retained_customers
FROM cte c
INNER JOIN cte f
ON (f.year > c.year OR (f.year = c.year AND f.month > c.month))
GROUP BY c.year, c.month, f.year, f.month
ORDER BY c.year, c.month, f.year, f.month; 
