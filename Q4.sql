-- premier customers whose no.of orders > avg( all orders of cust), no.of orders placed by each
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(20),
    sales INT
);
INSERT INTO orders (order_id, order_date, customer_name, sales) VALUES
(1, '2025-07-01', 'Alice',   200),
(2, '2025-07-05', 'Alice',   150),
(3, '2025-07-08', 'Alice',   180),
(4, '2025-07-02', 'Bob',     300),
(5, '2025-07-10', 'Bob',     250),
(6, '2025-07-03', 'Charlie', 400),
(7, '2025-07-07', 'Charlie', 350),
(8, '2025-07-12', 'Charlie', 500),
(9, '2025-07-15', 'Charlie', 450),
(10, '2025-07-04', 'David',  500),
(11, '2025-07-06', 'Eva',    300),
(12, '2025-07-09', 'Eva',    200),
(13, '2025-07-13', 'Eva',    250);

SELECT customer_name, count(*) as total from orders
group by customer_name
-- having count(*) > (select avg(order_id) from orders where order_id=count(order_id) group by customer_name)
having count(*)> (select avg(ord) from (select count(*) as ord from orders group by customer_name) as avrg)
order by total desc;
