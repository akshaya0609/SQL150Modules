DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    customer_name VARCHAR(10),
    order_date DATE,
    order_id INT PRIMARY KEY,
    sales INT
);
DROP TABLE IF EXISTS returns;
CREATE TABLE returns (
    order_id INT PRIMARY KEY,
    return_date DATE
);
INSERT INTO orders (customer_name, order_date, order_id, sales) VALUES
('Alice','2025-07-01', 101, 200),
('Alice','2025-07-05', 102, 150),
('Alice','2025-07-10', 103, 100),
('Bob','2025-07-02', 104, 300),
('Bob','2025-07-08', 105, 250),
('Charlie', '2025-07-03', 106, 180),
('Charlie', '2025-07-06', 107, 120),
('Charlie', '2025-07-09', 108, 150),
('Charlie', '2025-07-12', 109, 200),
('David','2025-07-04', 110, 400),
('David','2025-07-07', 111, 350);
INSERT INTO returns (order_id, return_date) VALUES
(101, '2025-07-15'),
(103, '2025-07-16'),
(104, '2025-07-17'),
(106, '2025-07-18'),
(107, '2025-07-19'),
(109, '2025-07-20');
-- CUSTOMER NAME, RETURN>50%
-- SELECT 100*COUNT(distinct r.order_id)/COUNT(o.order_id) from orders o left join returns r on o.order_id=r.order_id;
SELECT o.customer_name, ROUND(100*COUNT(distinct r.order_id)/COUNT(o.order_id),2) as perc from orders o
left join returns r on o.order_id=r.order_id
group by customer_name
having perc > 50;
