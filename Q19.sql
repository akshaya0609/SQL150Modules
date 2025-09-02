DROP TABLE IF EXISTS prds;
CREATE TABLE prds (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(10),
    available_quantity INT
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    order_date DATE,
    quantity_requested INT,
    FOREIGN KEY (product_id) REFERENCES prds(product_id)
);
INSERT INTO prds (product_id, product_name, available_quantity) VALUES
(1, 'Product A', 10),
(2, 'Product B', 20),
(3, 'Product C', 15),
(4, 'Product D', 10);
INSERT INTO orders (order_id, product_id, order_date, quantity_requested) VALUES
(1, 1, '2024-01-01', 5),
(2, 1, '2024-01-02', 7),
(3, 2, '2024-01-03', 10),
(4, 2, '2024-01-04', 10),
(5, 2, '2024-01-05', 5),
(6, 3, '2024-01-06', 4),
(7, 3, '2024-01-07', 5),
(8, 4, '2024-01-08', 4),
(9, 4, '2024-01-09', 5),
(10, 4, '2024-01-10', 8);

select o.order_id, p.product_name, o.quantity_requested, 
case when sum(o.quantity_requested) 
  over(partition by o.product_id order by o.order_date,o.order_id)<=p.available_quantity then o.quantity_requested
     when sum(o.quantity_requested) 
  over(partition by o.product_id order by o.order_date,o.order_id)-o.quantity_requested >= p.available_quantity then 0
ELSE p.available_quantity - (SUM(o.quantity_requested) OVER (PARTITION BY o.product_id ORDER BY o.order_date, o.order_id) - o.quantity_requested)
end as quantity_fulfilled ,
case when sum(o.quantity_requested) 
  over(partition by o.product_id order by o.order_date,o.order_id)<=p.available_quantity then 'Fulfilled Order'
when sum(o.quantity_requested) 
  over(partition by o.product_id order by o.order_date,o.order_id)-o.quantity_requested >= p.available_quantity 
  then 'No order'
else 'Partial Order'
end as comments
from orders o join prds p on o.product_id=p.product_id
order by o.order_id;