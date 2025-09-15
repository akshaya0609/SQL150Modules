CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(20),
    category VARCHAR(10),
    price INT
);
INSERT INTO products (id, name, category, price) VALUES
(1, 'Cripps Pink', 'apple', 10),
(2, 'Navel Orange', 'orange', 12),
(3, 'Golden Delicious', 'apple', 6),
(4, 'Clementine', 'orange', 14),
(5, 'Pinot Noir', 'grape', 20),
(6, 'Bing Cherries', 'cherry', 36),
(7, 'Sweet Cherries', 'cherry', 40);

-- purchases table
CREATE TABLE purchases (
    id INT PRIMARY KEY,
    product_id INT,
    stars INT,
    FOREIGN KEY (product_id) REFERENCES products(id)
);
INSERT INTO purchases (id, product_id, stars) VALUES
(1, 1, 2),
(2, 3, 3),
(3, 2, 2),
(4, 4, 4),
(5, 6, 5),
(6, 6, 4),
(7, 7, 5);

 
SELECT pr.category,
CASE WHEN MIN(CASE WHEN p.stars >= 4 THEN pr.price END) IS NULL
	THEN 0 
	ELSE MIN(CASE WHEN p.stars >= 4 THEN pr.price END)
END AS low_price
from products pr
left join purchases p on pr.id=p.id
group by category
order by category;

