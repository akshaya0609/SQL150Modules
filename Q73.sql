DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    category VARCHAR(15),
    products VARCHAR(30)
);
INSERT INTO categories (category, products) VALUES
('Electronics', 'TV, Radio, Laptop'),
('Furniture',   'Chair'),
('Clothing',    'Shirt, Pants, Jacket, Shoes'),
('Groceries',   'Rice, Sugar');

select category, LENGTH(products) - LENGTH(REPLACE(products, ',', '')) + 1 as productnos
/* 1 item → Chair → 0 commas
2 items → TV, Radio → 1 comma
3 items → TV, Radio, Laptop → 2 commas
General rule: n items → n − 1 commas ⇒ n = commas + 1. */ -- reason to add +1 
from categories
order by productnos;
