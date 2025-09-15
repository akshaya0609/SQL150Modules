DROP TABLE IF EXISTS saleproducts;
CREATE TABLE saleproducts (
  product_id   INT PRIMARY KEY,
  product_name VARCHAR(10),
  price        INT
);

INSERT INTO saleproducts (product_id, product_name, price) VALUES
(1, 'Laptop',      800),
(2, 'Smartphone',  600),
(3, 'Headphones',   50),
(4, 'Tablet',      400);
-- Sales
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
  sale_id    INT PRIMARY KEY,
  product_id INT,
  quantity   INT,
  sale_date  DATE,
  FOREIGN KEY (product_id) REFERENCES saleproducts(product_id)
);
INSERT INTO sales (sale_id, product_id, quantity, sale_date) VALUES
(1,  1, 3, '2023-05-15'),
(2,  2, 2, '2023-05-16'),
(3,  3, 5, '2023-05-17'),
(4,  1, 2, '2023-05-18'),
(5,  4, 1, '2023-05-19'),
(6,  2, 3, '2023-05-20'),
(7,  3, 4, '2023-05-21'),
(8,  1, 1, '2023-05-22'),
(9,  2, 4, '2023-05-23'),
(10, 4, 2, '2023-05-24');

select product_name, sum(price*quantity) as total_sales from saleproducts p
join sales s using (product_id)
group by product_name
order by product_name;
