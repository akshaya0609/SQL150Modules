DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id     INT,
  product_id   VARCHAR(5),
  order_date   DATE,
  amount       INT
);
INSERT INTO orders VALUES
-- product A
(1,'A','2024-01-01',100),
(2,'A','2024-01-03', 50),
(3,'A','2024-01-05', 70),
-- product B
(4,'B','2024-01-02',200),
(5,'B','2024-01-03',100),
(6,'B','2024-01-06', 80);


-- Calendar (all dates in Jan-2024)
DROP TABLE IF EXISTS calender_dim;
CREATE TABLE calendar_dim (
    cal_date DATE
);
SELECT * 
FROM calendar_dim 
WHERE cal_date BETWEEN '2024-01-01' AND '2024-01-31';

WITH RECURSIVE cte AS (
    SELECT DATE('2024-01-01') AS cal_date
    UNION ALL
    SELECT DATE_ADD(cal_date, INTERVAL 1 DAY)
    FROM cte
    WHERE cal_date < '2024-01-31'
)
SELECT cal_date 
FROM cte;

INSERT INTO calendar_dim (cal_date)
SELECT cal_date 
FROM (
    WITH RECURSIVE cte AS (
        SELECT DATE('2024-01-01') AS cal_date
        UNION ALL
        SELECT DATE_ADD(cal_date, INTERVAL 1 DAY)
        FROM cte
        WHERE cal_date < '2024-01-31'
    )
    SELECT cal_date FROM cte
) t;

WITH all_dates_products AS (
    SELECT DISTINCT c.cal_date, o.product_id
    FROM calendar_dim c
    CROSS JOIN (SELECT DISTINCT product_id FROM orders) o
    WHERE c.cal_date BETWEEN '2024-01-01' AND '2024-01-31'
),
daily_sales AS (
    SELECT 
        ad.cal_date,
        ad.product_id,
        COALESCE(SUM(o.amount), 0) AS daily_amount
    FROM all_dates_products ad
    LEFT JOIN orders o
        ON ad.cal_date = o.order_date
       AND ad.product_id = o.product_id
    GROUP BY ad.cal_date, ad.product_id
)
SELECT 
    product_id,
    cal_date,
    daily_amount,
    SUM(daily_amount) OVER (
        PARTITION BY product_id 
        ORDER BY cal_date 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_sum
FROM daily_sales
ORDER BY product_id, cal_date;
