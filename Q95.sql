CREATE TABLE electronic_items (
    item_id INT,
    item_name VARCHAR(20),
    category VARCHAR(15),
    price DECIMAL(7,2),
    quantity INT,
    warranty_months INT
);
INSERT INTO electronic_items (item_id, item_name, category, price, quantity, warranty_months) VALUES
(1, 'Laptop A',   'Laptops',     800.0,  10, 24),
(2, 'Laptop B',   'Laptops',     950.0,  15, 18),
(3, 'Laptop C',   'Laptops',     700.0,   5, 12),
(4, 'Phone A',    'Smartphones', 400.0,  30, 12),
(5, 'Phone B',    'Smartphones', 450.0,  25,  6),   -- excluded (warranty < 12)
(6, 'Phone C',    'Smartphones', 550.0,  20, 12),
(7, 'TV A',       'Television', 1200.0,   8, 24),
(8, 'TV B',       'Television', 1500.0,  12, 24),
(9, 'TV C',       'Television', 1000.0,   5, 24),
(10,'Speaker A',  'Speakers',    200.0,  25, 12),
(11,'Speaker B',  'Speakers',    250.0,  10, 12),
(12,'Speaker C',  'Speakers',    300.0,   5,  6);   -- excluded (warranty < 12)

SELECT category, round(avg(price),2) as avrg from electronic_items
where warranty_months>=12
group by category 
having avrg>500 and sum(quantity)>=20 
order by avrg desc;