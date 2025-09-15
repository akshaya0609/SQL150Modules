DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id      INT PRIMARY KEY,
  order_date    DATE,
  customer_name VARCHAR(10),
  product_name  VARCHAR(10),
  sales         INT
);
INSERT INTO orders VALUES
(1,'2023-01-01','Alexa' , 'iphone',100),
(2,'2023-01-02','Alexa' , 'boAt' ,300),
(3,'2023-01-03','Alexa' , 'Rolex',400),
(4,'2023-01-01','Ramesh','Titan',200),
(5,'2023-01-02','Ramesh','Shirt',300),
(6,'2023-01-03','Neha'  ,'Dress',100);

select order_id, order_date, customer_name, product_name, sales from (
select o.* , count(*) over (partition by customer_name) as cnt,
row_number() over (partition by customer_name order by order_date desc) as rn
from orders o ) t
where (cnt=1 and rn=1) or (cnt>1 and rn=2)
order by customer_name;