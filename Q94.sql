DROP TABLE IF EXISTS gap_sales;
CREATE TABLE gap_sales (
    sale_id INT,
    store_id INT,
    sale_date DATE,
    category VARCHAR(10),
    total_sales INT
);
-- Insert values
INSERT INTO gap_sales (sale_id, store_id, sale_date, category, total_sales) VALUES
(1, 101, '2023-01-01', 'Clothing', 6000),
(2, 101, '2023-05-01', 'Outerwear', 2000),
(3, 101, '2023-05-02', 'Clothing', 4000),
(4, 101, '2023-05-02', 'Outerwear', 1500),
(5, 101, '2023-05-03', 'Clothing', 3500),
(6, 101, '2023-05-03', 'Outerwear', 2500),
(7, 102, '2023-05-01', 'Clothing', 7000),
(8, 102, '2023-06-01', 'Outerwear', 6000),
(9, 102, '2023-05-02', 'Clothing', 5000),
(10, 102, '2023-05-02', 'Outerwear', 2500),
(11, 102, '2023-05-03', 'Clothing', 4000);

select store_id, category, sum(total_sales) as total from gap_sales
where month(sale_date) between '03' and '07'
group by store_id,category
order by total;
