DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT NOT NULL,
    restaurant_id INT,
    delivery_time INT,   -- minutes
    total_cost    INT    -- currency units
);
INSERT INTO orders (order_id, customer_id, restaurant_id, delivery_time, total_cost) VALUES
(1, 101, 201, 30, 2550),
(2, 102, 202, 40, 3000),
(3, 101, 203, 25, 1575),
(4, 103, 201, 50, 2200),
(5, 104, 202, 45, 1850),
(6, 105, 204, 35, 2725),
(7, 106, 203, 20, 1600);

-- customer and total expense by each
SELECT customer_id, SUM(total_cost) AS total
FROM orders
GROUP BY customer_id
HAVING SUM(total_cost) = (SELECT MAX(total) from (SELECT SUM(total_cost) AS total
    FROM orders
    GROUP BY customer_id
   ) AS t
 );

SELECT customer_id, SUM(total_cost) AS total
FROM orders
GROUP BY customer_id
order by total desc
limit 1;
