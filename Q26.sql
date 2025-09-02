DROP TABLE IF EXISTS prdct;
DROP TABLE IF EXISTS orders;
CREATE TABLE prdct (
    product_id INT,
    price_date DATE,
    price INT
);
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    product_id INT
);
INSERT INTO prdct (product_id, price_date, price) VALUES
(100, '2024-01-01', 150),
(100, '2024-01-21', 170),
(100, '2024-02-01', 190),
(101, '2024-01-01', 1000),
(101, '2024-01-27', 1200),
(101, '2024-02-05', 1250);
INSERT INTO orders (order_id, order_date, product_id) VALUES
(1, '2024-01-05', 100),
(2, '2024-01-21', 100),
(3, '2024-02-20', 100),
(4, '2024-01-07', 101),
(5, '2024-02-04', 101),
(6, '2024-02-05', 101),
(7, '2024-02-10', 101);
select o.product_id,sum(p.price)
from prdct p
join orders o on p.product_id=o.product_id and p.price_date=(select max(p2.price_date) from prdct p2
where p2.price_date<=o.order_date and p2.product_id = o.product_id)
group by product_id
order by product_id;