DROP TABLE IF EXISTS Q2;
CREATE TABLE Q2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(20),
    price INT
);
INSERT INTO Q2 (product_id, product_name, price) VALUES
(1, 'Pen', 50),
(2, 'Notebook', 120),
(3, 'Bag', 450),
(4, 'Shoes', 600),
(5, 'Watch', 80),
(6, 'Headphones', 300),
(7, 'Laptop', 1200),
(8, 'Bottle', 90),
(9, 'Chair', 200),
(10, 'Table', 700);

select (case when price<100 then 'Low Price'
        when price >=100 and price <=500 then 'Medium Price'
        when price>500 then 'High Price' end) as products , count(*) as prod_count from Q2
group by products
order by count(*);
