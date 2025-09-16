DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    customer_id  INT NOT NULL,
    order_id     INT PRIMARY KEY,
    product_name VARCHAR(20) NOT NULL
);
INSERT INTO orders (customer_id, order_id, product_name) VALUES
(1, 101, 'Laptop'),
(1, 102, 'Mouse'),
(1, 103, 'Phone Case'),
(2, 104, 'Headphones'),
(2, 105, 'Laptop'),
(3, 106, 'Mouse'),
(4, 108, 'Mouse'),
(5, 110, 'Laptop'),
(5, 111, 'Phone Case'),
(6, 112, 'Mouse'),
-- extras so some customers qualify for the final query
(6, 114, 'Laptop'),
(6, 113, 'Keyboard'),
(7, 115, 'Laptop'),
(7, 116, 'Mouse'),
(8, 117, 'Mouse'),
(8, 118, 'Phone Case'),
(9, 119, 'Laptop'),
(9, 120, 'Mouse'),
(9, 121, 'Charger');

select customer_id, count(distinct product_name) as no_of_products
from orders
group by customer_id
having sum(product_name='Laptop')>0 and sum(product_name='Mouse')>0 and sum(product_name='Phose Case')=0
order by customer_id;
