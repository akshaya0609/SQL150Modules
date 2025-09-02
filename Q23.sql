DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id VARCHAR(2),
    PRIMARY KEY (order_id, product_id)  -- since an order cannot have duplicate product entries
);
INSERT INTO orders (order_id, customer_id, product_id) VALUES
(1, 1, 'p1'),
(1, 1, 'p2'),
(1, 1, 'p3'),
(2, 2, 'p1'),
(2, 2, 'p2'),
(2, 2, 'p4'),
(3, 1, 'p6'),
(4, 3, 'p1'),
(4, 3, 'p3'),
(4, 3, 'p5');


select o1.product_id as prod1, o2.product_id as prod2 ,count(*)
from orders o1 join orders o2 on o1.order_id=o2.order_id
where o1.product_id>o2.product_id
group by prod1,prod2
order by count(*) desc;
