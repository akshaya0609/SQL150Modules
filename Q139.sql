DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    id INT,
    product_id INT,
    sale_date DATE,
    sale_amount INT
);
INSERT INTO sales (id, product_id, sale_date, sale_amount) VALUES
(1, 101, '2025-03-05', 500),
(2, 101, '2025-03-13', 600),
(3, 101, '2025-03-15', 700),
(4, 101, '2025-04-04', 400),
(5, 101, '2025-04-14', 300),
(6, 101, '2025-04-16', 200),
(7, 101, '2025-05-24', 950),
(8, 101, '2025-05-25', 700),
(9, 101, '2025-05-30', 950),
(10, 101, '2025-06-06', 1100),
(11, 101, '2025-06-08', 1200),
(12, 102, '2025-03-15', 850);

WITH date_bounds AS (
SELECT CURDATE() AS today, 
MAKEDATE(YEAR(CURDATE()),1) +INTERVAL QUARTER(CURDATE())*3 - 3 MONTH AS curr_q_start, -- start of current quarter
MAKEDATE(YEAR(CURDATE()), 1) + INTERVAL QUARTER(CURDATE())*3 - 6 MONTH AS last_q_start -- start of last quarter
)
SELECT s.product_id,
SUM(CASE WHEN s.sale_date >= db.last_q_start AND s.sale_date < db.curr_q_start 
THEN s.sale_amount ELSE 0 END) AS last_quarter_sales,
SUM(CASE WHEN s.sale_date >= db.curr_q_start AND s.sale_date <= db.today
THEN s.sale_amount ELSE 0 END) AS qtd_sales
FROM sales s
CROSS JOIN date_bounds db
GROUP BY s.product_id
ORDER BY s.product_id;
