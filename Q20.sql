DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_month VARCHAR(6),
    product_id  VARCHAR(5),
    sales       INT
);
INSERT INTO orders (order_month, product_id, sales) VALUES
('202301','p1',100),
('202301','p2',500),
('202302','p1',700),
('202302','p2',300),
('202303','p1',900),
('202303','p2',700),
('202304','p1',2000),
('202304','p2',1100),
('202305','p1',1500),
('202305','p2',1300),
('202306','p1',1700);
select order_month, product_id
from (select order_month, product_id, sales, 
lag(sales,1) over (partition by product_id order by order_month)as mon1,
lag(sales,2) over ( partition by product_id order by order_month) as mon2 from orders) c
where mon1 is not null and mon2 is not null and sales > (mon1+mon2)
order by order_month;
