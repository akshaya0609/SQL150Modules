CREATE TABLE sales (
    id INT,
    product_id INT,
    category VARCHAR(12),
    amount INT,
    order_date DATE
);

INSERT INTO sales (id, product_id, category, amount, order_date) VALUES
(1, 101, 'Electronics', 1500, '2022-02-05'),
(2, 102, 'Electronics', 2000, '2022-02-10'),
(3, 103, 'Clothing', 500, '2022-02-15'),
(4, 104, 'Clothing', 800, '2022-02-20'),
(5, 105, 'Books', 300, '2022-02-25'),
(6, 106, 'Electronics', 1800, '2022-03-08'),
(7, 107, 'Clothing', 600, '2022-03-15'),
(8, 108, 'Books', 400, '2022-03-20'),
(9, 109, 'Electronics', 2200, '2022-04-05'),
(10, 110, 'Clothing', 700, '2022-04-10'),
(11, 111, 'Books', 500, '2022-04-15'),
(12, 112, 'Electronics', 2500, '2022-05-05');

select category, sum(amount) from sales 
where month(order_date)='02' and dayofweek(order_date) between 0 and 6 
group by category 
order by sum(amount);
