DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    product_id INT,
    category VARCHAR(20),
    amount INT
);
INSERT INTO orders (order_id, order_date, product_id, category, amount) VALUES
(1, '2024-01-01', 1,  'Furniture',       100),
(2, '2024-01-02', 6,  'Technology',      150),
(3, '2024-01-03', 11, 'Home Appliances', 120),
(4, '2024-01-04', 4,  'Furniture',       200),
(5, '2024-01-05', 7,  'Technology',      180),
(6, '2024-01-06', 1,  'Furniture',       110),
(7, '2024-01-07', 8,  'Technology',      220),
(8, '2024-01-08', 12, 'Home Appliances', 130),
(9, '2024-01-09', 3,  'Furniture',       190),
(10,'2024-01-10', 9,  'Technology',      240),
(11,'2024-01-11', 2,  'Furniture',       140);

WITH category_sales AS (
    SELECT category, SUM(amount) AS total_sales
    FROM orders
    GROUP BY category
    ORDER BY total_sales DESC
    LIMIT 1
),
product_sales AS (
    SELECT o.product_id, o.category, SUM(o.amount) AS product_total
    FROM orders o
    JOIN category_sales cs ON o.category = cs.category
    GROUP BY o.product_id, o.category
)
SELECT product_id, category, product_total
FROM product_sales
ORDER BY product_total DESC
LIMIT 3;