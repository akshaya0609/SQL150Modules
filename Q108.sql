drop table if exists elec_prods;
CREATE TABLE elec_prods (
    product_id INT,
    product_name VARCHAR(12)
);
INSERT INTO elec_prods VALUES
(1, 'Laptop'),
(2, 'Smartphone'),
(3, 'Tablet'),
(4, 'Headphones'),
(5, 'Smartwatch');

-- Create cities table
drop table if exists cities;
CREATE TABLE cities (
    city_id INT,
    city_name VARCHAR(10)
);
INSERT INTO cities VALUES
(1, 'Mumbai'),
(2, 'Delhi'),
(3, 'Bangalore'),
(4, 'Chennai'),
(5, 'Hyderabad');

-- Create sales table
drop table if exists sales;
CREATE TABLE sales (
    sale_id INT,
    product_id INT,
    city_id INT,
    sale_date VARCHAR(12),
    quantity INT
);
INSERT INTO sales VALUES
(1, 1, 1, '2024-01-01', 30),
(2, 1, 1, '2024-01-02', 40),
(3, 1, 2, '2024-01-03', 25),
(4, 1, 2, '2024-01-04', 35),
(5, 1, 3, '2024-01-05', 50),
(6, 1, 3, '2024-01-06', 60),
(7, 1, 4, '2024-01-07', 45),
(8, 1, 4, '2024-01-08', 55),
(9, 1, 5, '2024-01-09', 30),
(10,1, 5, '2024-01-10', 40),
(11,2, 1, '2024-01-11', 20);

select product_name from elec_prods join sales using(product_id)
group by product_name
having count(city_id)>=2;
